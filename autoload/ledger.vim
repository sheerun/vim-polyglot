if polyglot#init#is_disabled(expand('<sfile>:p'), 'ledger', 'autoload/ledger.vim')
  finish
endif

scriptencoding utf-8
" vim:ts=2:sw=2:sts=2:foldmethod=marker
function! ledger#transaction_state_toggle(lnum, ...) abort
  if a:0 == 1
    let chars = a:1
  else
    let chars = ' *'
  endif
  let trans = s:transaction.from_lnum(a:lnum)
  if empty(trans) || has_key(trans, 'expr')
    return
  endif

  let old = has_key(trans, 'state') ? trans['state'] : ' '
  let i = stridx(chars, old) + 1
  let new = chars[i >= len(chars) ? 0 : i]

  call trans.set_state(new)

  call setline(trans['head'], trans.format_head())
endf

function! ledger#transaction_state_set(lnum, char) abort
  " modifies or sets the state of the transaction at the cursor,
  " removing the state altogether if a:char is empty
  let trans = s:transaction.from_lnum(a:lnum)
  if empty(trans) || has_key(trans, 'expr')
    return
  endif

  call trans.set_state(a:char)

  call setline(trans['head'], trans.format_head())
endf

function! ledger#transaction_date_set(lnum, type, ...) abort
  let time = a:0 == 1 ? a:1 : localtime()
  let trans = s:transaction.from_lnum(a:lnum)
  if empty(trans) || has_key(trans, 'expr')
    return
  endif

  let formatted = strftime(g:ledger_date_format, time)
  if has_key(trans, 'date') && ! empty(trans['date'])
    let date = split(trans['date'], '=')
  else
    let date = [formatted]
  endif

  if a:type =~? 'effective\|actual'
    echoerr 'actual/effective arguments were replaced by primary/auxiliary'
    return
  endif

  if a:type ==? 'primary'
    let date[0] = formatted
  elseif a:type ==? 'auxiliary'
    if time < 0
      " remove auxiliary date
      let date = [date[0]]
    else
      " set auxiliary date
      if len(date) >= 2
        let date[1] = formatted
      else
        call add(date, formatted)
      endif
    endif
  elseif a:type ==? 'unshift'
    let date = [formatted, date[0]]
  endif

  let trans['date'] = join(date[0:1], '=')

  call setline(trans['head'], trans.format_head())
endf

function! ledger#transaction_post_state_get(lnum) abort
  " safe view / position
  let view = winsaveview()
  call cursor(a:lnum, 0)

  let line = getline('.')
  if line[0] !~# '[ \t]'
    " not a post
    let state = ''
  else
    let m = matchlist(line, '^[ \t]\+\([*?!]\)')
    if len(m) > 1
      let state = m[1]
    else
      let state = ' '
    endif
  endif

  call winrestview(view)
  return state
endf

function! ledger#transaction_post_state_toggle(lnum, ...) abort
  if a:0 == 1
    let chars = a:1
  else
    let chars = ' *'
  endif

  let old = ledger#transaction_post_state_get(a:lnum)
  if old ==# ''
    " not a post, probably at the first line of transaction
    call ledger#transaction_state_toggle(a:lnum, chars)
    return
  endif
  let i = stridx(chars, old) + 1
  let new = chars[i >= len(chars) ? 0 : i]

  call ledger#transaction_post_state_set(a:lnum, new)
endf

function! ledger#transaction_post_state_set(lnum, char) abort
  let state = ledger#transaction_post_state_get(a:lnum)
  if state ==# ''
    " not a post, probably at the first line of transaction
    call ledger#transaction_state_set(a:lnum, a:char)
    return
  elseif state == a:char || (state ==# ' ' && a:char ==# '')
    return
  endif

  let line = getline('.')
  if a:char =~# '^\s*$'
    let newline = substitute(line, '\V' . state . '\m[ \t]', '', '')
  elseif state ==# ' '
    let m = matchlist(line, '^\([ \t]\+\)\(.*\)')
    let newline = m[1] . a:char . ' ' . m[2]
  else
    let newline = substitute(line, '\V' . state, a:char, '')
  endif
  call setline(a:lnum, newline)
endf

" == get transactions ==

function! ledger#transaction_from_lnum(lnum) abort
  return s:transaction.from_lnum(a:lnum)
endf

function! ledger#transactions(...) abort
  if a:0 == 2
    let lnum = a:1
    let end = a:2
  elseif a:0 == 0
    let lnum = 1
    let end = line('$')
  else
    throw 'wrong number of arguments for get_transactions()'
    return []
  endif

  " safe view / position
  let view = winsaveview()
  let fe = &foldenable
  set nofoldenable

  let transactions = []
  call cursor(lnum, 0)
  while lnum && lnum < end
    let trans = s:transaction.from_lnum(lnum)
    if ! empty(trans)
      call add(transactions, trans)
      call cursor(trans['tail'], 0)
    endif
    let lnum = search('^[~=[:digit:]]', 'cW')
  endw

  " restore view / position
  let &foldenable = fe
  call winrestview(view)

  return transactions
endf

" == transaction object implementation ==

let s:transaction = {} "{{{1
function! s:transaction.new() abort dict
  return copy(s:transaction)
endf

function! s:transaction.from_lnum(lnum) abort dict "{{{2
  let [head, tail] = s:get_transaction_extents(a:lnum)
  if ! head
    return {}
  endif

  let trans = copy(s:transaction)
  let trans['head'] = head
  let trans['tail'] = tail

  " split off eventual comments at the end of line
  let line = split(getline(head), '\ze\s*\%(\t\|  \);', 1)
  if len(line) > 1
    let trans['appendix'] = join(line[1:], '')
  endif

  " parse rest of line
  " FIXME (minor): will not preserve spacing (see 'join(parts)')
  let parts = split(line[0], '\s\+')
  if parts[0] ==# '~'
    let trans['expr'] = join(parts[1:])
    return trans
  elseif parts[0] ==# '='
    let trans['auto'] = join(parts[1:])
    return trans
  elseif parts[0] !~# '^\d'
    " this case is avoided in s:get_transaction_extents(),
    " but we'll check anyway.
    return {}
  endif

  for part in parts
    if     ! has_key(trans, 'date')  && part =~# '^\d'
      let trans['date'] = part
    elseif ! has_key(trans, 'code')  && part =~# '^([^)]*)$'
      let trans['code'] = part[1:-2]
    elseif ! has_key(trans, 'state') && part =~# '^[[:punct:]]$'
      " the first character by itself is assumed to be the state of the transaction.
      let trans['state'] = part
    else
      " everything after date/code or state belongs to the description
      break
    endif
    call remove(parts, 0)
  endfor

  let trans['description'] = join(parts)
  return trans
endf "}}}

function! s:transaction.set_state(char) abort dict "{{{2
  if a:char =~# '^\s*$'
    if has_key(self, 'state')
      call remove(self, 'state')
    endif
  else
    let self['state'] = a:char
  endif
endf "}}}

function! s:transaction.parse_body(...) abort dict "{{{2
  if a:0 == 2
    let head = a:1
    let tail = a:2
  elseif a:0 == 0
    let head = self['head']
    let tail = self['tail']
  else
    throw 'wrong number of arguments for parse_body()'
    return []
  endif

  if ! head || tail <= head
    return []
  endif

  let lnum = head
  let tags = {}
  let postings = []
  while lnum <= tail
    let line = split(getline(lnum), '\s*\%(\t\|  \);', 1)

    if line[0] =~# '^\s\+[^[:blank:];]'
      " posting
      let [state, rest] = matchlist(line[0], '^\s\+\([*!]\?\)\s*\(.*\)$')[1:2]
      if rest =~# '\t\|  '
        let [account, amount] = matchlist(rest, '^\(.\{-}\)\%(\t\|  \)\s*\(.\{-}\)\s*$')[1:2]
      else
        let amount = ''
        let account = matchstr(rest, '^\s*\zs.\{-}\ze\s*$')
      endif
      call add(postings, {'account': account, 'amount': amount, 'state': state})
    end

    " where are tags to be stored?
    if empty(postings)
      " they belong to the transaction
      let tag_container = tags
    else
      " they belong to last posting
      if ! has_key(postings[-1], 'tags')
        let postings[-1]['tags'] = {}
      endif
      let tag_container = postings[-1]['tags']
    endif

    let comment = join(line[1:], '  ;')
    if comment =~# '^\s*:'
      " tags without values
      for t in s:findall(comment, ':\zs[^:[:blank:]]\([^:]*[^:[:blank:]]\)\?\ze:')
        let tag_container[t] = ''
      endfor
    elseif comment =~# '^\s*[^:[:blank:]][^:]\+:'
      " tag with value
      let key = matchstr(comment, '^\s*\zs[^:]\+\ze:')
      if ! empty(key)
        let val = matchstr(comment, ':\s*\zs.*\ze\s*$')
        let tag_container[key] = val
      endif
    endif
    let lnum += 1
  endw
  return [tags, postings]
endf "}}}

function! s:transaction.format_head() abort dict "{{{2
  if has_key(self, 'expr')
    return '~ '.self['expr']
  elseif has_key(self, 'auto')
    return '= '.self['auto']
  endif

  let parts = []
  if has_key(self, 'date') | call add(parts, self['date']) | endif
  if has_key(self, 'state') | call add(parts, self['state']) | endif
  if has_key(self, 'code') | call add(parts, '('.self['code'].')') | endif
  if has_key(self, 'description') | call add(parts, self['description']) | endif

  let line = join(parts)
  if has_key(self, 'appendix') | let line .= self['appendix'] | endif

  return line
endf "}}}
"}}}

" == helper functions ==

" get a list of declared accounts in the buffer
function! ledger#declared_accounts(...) abort
  if a:0 == 2
    let lnum = a:1
    let lend = a:2
  elseif a:0 == 0
    let lnum = 1
    let lend = line('$')
  else
    throw 'wrong number of arguments for ledger#declared_accounts()'
    return []
  endif

  " save view / position
  let view = winsaveview()
  let fe = &foldenable
  set nofoldenable

  let accounts = []
  call cursor(lnum, 0)
  while 1
    let lnum = search('^account\s', 'cW', lend)
    if !lnum || lnum > lend
      break
    endif

    " remove comments at the end and "account" at the front
    let line = split(getline(lnum), '\s\+;')[0]
    let line = matchlist(line, 'account\s\+\(.\+\)')[1]

    if len(line) > 1
      call add(accounts, line)
    endif

    call cursor(lnum+1,0)
  endw

  " restore view / position
  let &foldenable = fe
  call winrestview(view)

  return accounts
endf

function! s:get_transaction_extents(lnum) abort
  if ! (indent(a:lnum) || getline(a:lnum) =~# '^[~=[:digit:]]')
    " only do something if lnum is in a transaction
    return [0, 0]
  endif

  " safe view / position
  let view = winsaveview()
  let fe = &foldenable
  set nofoldenable

  call cursor(a:lnum, 0)
  let head = search('^[~=[:digit:]]', 'bcnW')
  let tail = search('^[^;[:blank:]]\S\+', 'nW')
  let tail = tail > head ? tail - 1 : line('$')

  " restore view / position
  let &foldenable = fe
  call winrestview(view)

  return head ? [head, tail] : [0, 0]
endf

function! ledger#find_in_tree(tree, levels) abort
  if empty(a:levels)
    return []
  endif
  let results = []
  let currentlvl = a:levels[0]
  let nextlvls = a:levels[1:]
  let branches = ledger#filter_items(keys(a:tree), currentlvl)
  for branch in branches
    let exact = empty(nextlvls)
    call add(results, [branch, exact])
    if ! empty(nextlvls)
      for [result, exact] in ledger#find_in_tree(a:tree[branch], nextlvls)
        call add(results, [branch.':'.result, exact])
      endfor
    endif
  endfor
  return results
endf

function! ledger#filter_items(list, keyword) abort
  " return only those items that start with a specified keyword
  return filter(copy(a:list), 'v:val =~ ''^\V'.substitute(a:keyword, '\\', '\\\\', 'g').'''')
endf

function! s:findall(text, rx) abort
  " returns all the matches in a string,
  " there will be overlapping matches according to :help match()
  let matches = []

  while 1
    let m = matchstr(a:text, a:rx, 0, len(matches)+1)
    if empty(m)
      break
    endif

    call add(matches, m)
  endw

  return matches
endf

" Move the cursor to the specified column, filling the line with spaces if necessary.
" Ensure that at least min_spaces are added, and go to the end of the line if
" the line is already too long
function! s:goto_col(pos, min_spaces) abort
  exec 'normal!' '$'
  let diff = max([a:min_spaces, a:pos - virtcol('.')])
  if diff > 0 | exec 'normal!' diff . 'a ' | endif
endf

" Return character position of decimal separator (multibyte safe)
function! s:decimalpos(expr) abort
  let pos = match(a:expr, '\V' . g:ledger_decimal_sep)
  if pos > 0
    let pos = strchars(a:expr[:pos]) - 1
  endif
  return pos
endf

" Align the amount expression after an account name at the decimal point.
"
" This function moves the amount expression of a posting so that the decimal
" separator is aligned at the column specified by g:ledger_align_at.
"
" For example, after selecting:
"
"   2015/05/09 Some Payee
"     Expenses:Other    $120,23  ; Tags here
"     Expenses:Something  $-4,99
"     Expenses:More                 ($12,34 + $16,32)
"
"  :'<,'>call ledger#align_commodity() produces:
"
"   2015/05/09 Some Payee
"      Expenses:Other                                    $120,23  ; Tags here
"      Expenses:Something                                 $-4,99
"      Expenses:More                                     ($12,34 + $16,32)
"
function! ledger#align_commodity() abort
  " Extract the part of the line after the account name (excluding spaces):
  let l:line = getline('.')
  let rhs = matchstr(l:line, '\m^\s\+[^;[:space:]].\{-}\(\t\|  \)\s*\zs.*$')
  if rhs !=# ''
    " Remove everything after the account name (including spaces):
    call setline('.', substitute(l:line, '\m^\s\+[^[:space:]].\{-}\zs\(\t\|  \).*$', '', ''))
    let pos = -1
    if g:ledger_align_commodity == 1
      let pos = 0
    elseif g:ledger_decimal_sep !=# ''
      " Find the position of the first decimal separator:
      let pos = s:decimalpos(rhs)
    endif
    if pos < 0
      " Find the position after the first digits
      let pos = matchend(rhs, '\m\d[^[:space:]]*')
    endif
    " Go to the column that allows us to align the decimal separator at g:ledger_align_at:
    if pos >= 0
      call s:goto_col(g:ledger_align_at - pos - 1, 2)
    else
      call s:goto_col(g:ledger_align_at - strdisplaywidth(rhs) - 2, 2)
    endif " Append the part of the line that was previously removed:
    exe 'normal! a' . rhs
  endif
endf

" Align the commodity on the entire buffer
function! ledger#align_commodity_buffer() abort
  " Store the viewport position
  let view = winsaveview()

  " Call ledger#align_commodity for every line
  %call ledger#align_commodity()

  " Restore the viewport position
  call winrestview(view)
  unlet view
endf

" Align the amount under the cursor and append/prepend the default currency.
function! ledger#align_amount_at_cursor() abort
  " Select and cut text:
  normal! viWd
  " Find the position of the decimal separator
  let pos = s:decimalpos(@") " Returns zero when the separator is the empty string
  if pos <= 0
    let pos = len(@")
  endif
  " Paste text at the correct column and append/prepend default commodity:
  if g:ledger_commodity_before
    call s:goto_col(g:ledger_align_at - pos - len(g:ledger_default_commodity) - len(g:ledger_commodity_sep) - 1, 2)
    exe 'normal! a' . g:ledger_default_commodity . g:ledger_commodity_sep
    normal! p
  else
    call s:goto_col(g:ledger_align_at - pos - 1, 2)
    exe 'normal! pa' . g:ledger_commodity_sep . g:ledger_default_commodity
  endif
endf

" Report generation {{{1

" Helper functions and variables {{{2
" Position of report windows
let s:winpos_map = {
      \ 'T': 'to new',  't': 'abo new', 'B': 'bo new',  'b': 'bel new',
      \ 'L': 'to vnew', 'l': 'abo vnew', 'R': 'bo vnew', 'r': 'bel vnew'
      \ }

function! s:error_message(msg) abort
  redraw  " See h:echo-redraw
  echohl ErrorMsg
  echo "\r"
  echomsg a:msg
  echohl NONE
endf

function! s:warning_message(msg) abort
  redraw  " See h:echo-redraw
  echohl WarningMsg
  echo "\r"
  echomsg a:msg
  echohl NONE
endf

" Open the quickfix/location window when it is not empty,
" closes it if it is empty.
"
" Optional parameters:
" a:1  Quickfix window title.
" a:2  Message to show when the window is empty.
"
" Returns 0 if the quickfix window is empty, 1 otherwise.
function! s:quickfix_toggle(...) abort
  if g:ledger_use_location_list
    let l:list = 'l'
    let l:open = (len(getloclist(winnr())) > 0)
  else
    let l:list = 'c'
    let l:open = (len(getqflist()) > 0)
  endif

  if l:open
    execute (g:ledger_qf_vertical ? 'vert' : 'botright') l:list.'open' g:ledger_qf_size
    " Set local mappings to quit the quickfix window  or lose focus.
    nnoremap <silent> <buffer> <tab> <c-w><c-w>
    execute 'nnoremap <silent> <buffer> q :' l:list.'close<CR>'
    " Note that the following settings do not persist (e.g., when you close and re-open the quickfix window).
    " See: https://superuser.com/questions/356912/how-do-i-change-the-quickix-title-status-bar-in-vim
    if g:ledger_qf_hide_file
      setl conceallevel=2
      setl concealcursor=nc
      syntax match qfFile /^[^|]*/ transparent conceal
    endif
    if a:0 > 0
      let w:quickfix_title = a:1
    endif
    return 1
  endif

  execute l:list.'close'
  call s:warning_message((a:0 > 1) ? a:2 : 'No results')
  return 0
endf

" Populate a quickfix/location window with data. The argument must be a String
" or a List.
function! s:quickfix_populate(data) abort
  " Note that cexpr/lexpr always uses the global value of errorformat
  let l:efm = &errorformat  " Save global errorformat
  set errorformat=%EWhile\ parsing\ file\ \"%f\"\\,\ line\ %l:,%ZError:\ %m,%-C%.%#
  set errorformat+=%tarning:\ \"%f\"\\,\ line\ %l:\ %m
  " Format to parse command-line errors:
  set errorformat+=Error:\ %m
  " Format to parse reports:
  set errorformat+=%f:%l\ %m
  set errorformat+=%-G%.%#
  execute (g:ledger_use_location_list ? 'l' : 'c').'getexpr' 'a:data'
  let &errorformat = l:efm  " Restore global errorformat
  return
endf

" Build a ledger command to process the given file.
function! s:ledger_cmd(file, args) abort
  let l:options = g:ledger_extra_options
  if len(g:ledger_date_format) > 0 && !g:ledger_is_hledger
    let l:options = join([l:options, '--date-format', g:ledger_date_format,
      \ '--input-date-format', g:ledger_date_format])
  endif
  return join([g:ledger_bin, l:options, '-f', shellescape(expand(a:file)), a:args])
endf
" }}}

function! ledger#autocomplete_and_align() abort
  if pumvisible()
    return "\<c-n>"
  endif
  " Align an amount only if there is a digit immediately before the cursor and
  " such digit is preceded by at least one space (the latter condition is
  " necessary to avoid situations where a date starting at the first column is
  " confused with a commodity to be aligned).
  if match(getline('.'), '\s.*\d\%'.col('.').'c') > -1
    normal! h
    call ledger#align_amount_at_cursor()
    return "\<c-o>A"
  endif
  return "\<c-x>\<c-o>"
endf

" Use current line as input to ledger entry and replace with output. If there
" are errors, they are echoed instead.
function! ledger#entry() abort
  let l:output = systemlist(s:ledger_cmd(g:ledger_main, join(['entry', getline('.')])))
  " Filter out warnings
  let l:output = filter(l:output, "v:val !~? '^Warning: '")
  " Errors may occur
  if v:shell_error
    echomsg join(l:output)
    return
  endif
  " Append output so we insert instead of overwrite, then delete line
  call append('.', l:output)
  normal! "_dd
endfunc

" Run an arbitrary ledger command and show the output in a new buffer. If
" there are errors, no new buffer is opened: the errors are displayed in a
" quickfix window instead.
"
" Parameters:
" file  The file to be processed.
" args  A string of Ledger command-line arguments.
"
" Returns:
" Ledger's output as a String.
function! ledger#report(file, args) abort
  let l:output = systemlist(s:ledger_cmd(a:file, a:args))
  if v:shell_error  " If there are errors, show them in a quickfix/location list.
    call s:quickfix_populate(l:output)
    call s:quickfix_toggle('Errors', 'Unable to parse errors')
  endif
  return l:output
endf

" Open the output of a Ledger's command in a new buffer.
"
" Parameters:
" report  A String containing the output of a Ledger's command.
"
" Returns:
" 1 if a new buffer is created; 0 otherwise.
function! ledger#output(report) abort
  if empty(a:report)
    call s:warning_message('No results')
    return 0
  endif
  " Open a new buffer to show Ledger's output.
  execute get(s:winpos_map, g:ledger_winpos, 'bo new')
  setlocal buftype=nofile bufhidden=wipe modifiable nobuflisted noswapfile nowrap
  call append(0, a:report)
  setlocal nomodifiable
  " Set local mappings to quit window or lose focus.
  nnoremap <silent> <buffer> <tab> <c-w><c-p>
  nnoremap <silent> <buffer> q <c-w><c-p>@=winnr('#')<cr><c-w>c
  " Add some coloring to the report
  syntax match LedgerNumber /-\@1<!\d\+\([,.]\d\+\)*/
  syntax match LedgerNegativeNumber /-\d\+\([,.]\d\+\)*/
  syntax match LedgerImproperPerc /\d\d\d\+%/
  return 1
endf

" Show an arbitrary register report in a quickfix list.
"
" Parameters:
" file  The file to be processed
" args  A string of Ledger command-line arguments.
function! ledger#register(file, args) abort
  let l:cmd = s:ledger_cmd(a:file, join([
        \ 'register',
        \ "--format='" . g:ledger_qf_register_format . "'",
        \ "--prepend-format='%(filename):%(beg_line) '",
        \ a:args
        \ ]))
  call s:quickfix_populate(systemlist(l:cmd))
  call s:quickfix_toggle('Register report')
endf

" Reconcile the given account.
" This function accepts a file path as a third optional argument.
" The default is to use the value of g:ledger_main.
"
" Parameters:
" file  The file to be processed
" account  An account name (String)
" target_amount The target amount (Float)
function! ledger#reconcile(file, account, target_amount) abort
  let l:cmd = s:ledger_cmd(a:file, join([
        \ 'register',
        \ '--uncleared',
        \ "--format='" . g:ledger_qf_reconcile_format . "'",
        \ "--prepend-format='%(filename):%(beg_line) %(pending ? \"P\" : \"U\") '",
        \ shellescape(a:account)
        \ ]))
  let l:file = expand(a:file) " Needed for #show_balance() later
  call s:quickfix_populate(systemlist(l:cmd))
  if s:quickfix_toggle('Reconcile ' . a:account, 'Nothing to reconcile')
    let g:ledger_target_amount = a:target_amount
    " Show updated account balance upon saving, as long as the quickfix window is open
    augroup reconcile
      autocmd!
      execute "autocmd BufWritePost *.ldg,*.ledger call ledger#show_balance('" . l:file . "','" . a:account . "')"
      autocmd BufWipeout <buffer> call <sid>finish_reconciling()
    augroup END
    " Add refresh shortcut
    execute "nnoremap <silent> <buffer> <c-l> :<c-u>call ledger#reconcile('"
          \ . l:file . "','" . a:account . "'," . string(a:target_amount) . ')<cr>'
    call ledger#show_balance(l:file, a:account)
  endif
endf

function! s:finish_reconciling() abort
  unlet g:ledger_target_amount
  augroup reconcile
    autocmd!
  augroup END
  augroup! reconcile
endf

" Show the pending/cleared balance of an account.
" This function has an optional parameter:
"
" a:1  An account name
"
" If no account if given, the account in the current line is used.
function! ledger#show_balance(file, ...) abort
  let l:account = a:0 > 0 && !empty(a:1) ? a:1 : matchstr(getline('.'), '\m\(  \|\t\)\zs\S.\{-}\ze\(  \|\t\|$\)')
  if empty(l:account)
    call s:error_message('No account found')
    return
  endif
  let l:cmd = s:ledger_cmd(a:file, join([
        \ 'cleared',
        \ shellescape(l:account),
        \ '--empty',
        \ '--collapse',
        \ "--format='%(scrub(get_at(display_total, 0)))|%(scrub(get_at(display_total, 1)))|%(quantity(scrub(get_at(display_total, 1))))'",
        \ (empty(g:ledger_default_commodity) ? '' : '-X ' . shellescape(g:ledger_default_commodity))
        \ ]))
  let l:output = systemlist(l:cmd)
  " Errors may occur, for example,  when the account has multiple commodities
  " and g:ledger_default_commodity is empty.
  if v:shell_error
    call s:quickfix_populate(l:output)
    call s:quickfix_toggle('Errors', 'Unable to parse errors')
    return
  endif
  let l:amounts = split(l:output[-1], '|')
  redraw  " Necessary in some cases to overwrite previous messages. See :h echo-redraw
  if len(l:amounts) < 3
    call s:error_message('Could not determine balance. Did you use a valid account?')
    return
  endif
  echo g:ledger_pending_string
  echohl LedgerPending
  echon l:amounts[0]
  echohl NONE
  echon ' ' g:ledger_cleared_string
  echohl LedgerCleared
  echon l:amounts[1]
  echohl NONE
  if exists('g:ledger_target_amount')
    echon ' ' g:ledger_target_string
    echohl LedgerTarget
    echon printf('%.2f', (g:ledger_target_amount - str2float(l:amounts[2])))
    echohl NONE
  endif
endf
" }}}
