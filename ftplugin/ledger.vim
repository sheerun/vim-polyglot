if polyglot#init#is_disabled(expand('<sfile>:p'), 'ledger', 'ftplugin/ledger.vim')
  finish
endif

" Vim filetype plugin file
" filetype: ledger
" by Johann Klähn; Use according to the terms of the GPL>=2.
" vim:ts=2:sw=2:sts=2:foldmethod=marker

scriptencoding utf-8

if exists('b:did_ftplugin')
  finish
endif

let b:did_ftplugin = 1

let b:undo_ftplugin = 'setlocal '.
                    \ 'foldtext< '.
                    \ 'include< comments< commentstring< omnifunc< formatprg<'

setl foldtext=LedgerFoldText()
setl include=^!\\?include
setl comments=b:;
setl commentstring=;%s
setl omnifunc=LedgerComplete
setl formatexpr=ledger#align_formatexpr(v:lnum,v:count)

if !exists('g:ledger_main')
  let g:ledger_main = '%'
endif

if exists('g:ledger_no_bin') && g:ledger_no_bin
	unlet! g:ledger_bin
elseif !exists('g:ledger_bin') || empty(g:ledger_bin)
  if executable('hledger')
    let g:ledger_bin = 'hledger'
  elseif executable('ledger')
    let g:ledger_bin = 'ledger'
  else
    unlet! g:ledger_bin
    echohl WarningMsg
    echomsg 'No ledger command detected, set g:ledger_bin to enable more vim-ledger features.'
    echohl None
  endif
elseif !executable(g:ledger_bin)
	unlet! g:ledger_bin
	echohl WarningMsg
	echomsg 'Command set in g:ledger_bin is not executable, fix to to enable more vim-ledger features.'
	echohl None
endif

if exists('g:ledger_bin') && !exists('g:ledger_is_hledger')
  let g:ledger_is_hledger = g:ledger_bin =~# '.*hledger'
endif

if exists('g:ledger_bin')
  exe 'setl formatprg='.substitute(g:ledger_bin, ' ', '\\ ', 'g').'\ -f\ -\ print'
endif

if !exists('g:ledger_extra_options')
  let g:ledger_extra_options = ''
endif

if !exists('g:ledger_date_format')
  let g:ledger_date_format = '%Y/%m/%d'
endif

" You can set a maximal number of columns the fold text (excluding amount)
" will use by overriding g:ledger_maxwidth in your .vimrc.
" When maxwidth is zero, the amount will be displayed at the far right side
" of the screen.
if !exists('g:ledger_maxwidth')
  let g:ledger_maxwidth = 0
endif

if !exists('g:ledger_fillstring')
  let g:ledger_fillstring = ' '
endif

if !exists('g:ledger_accounts_cmd')
  if exists('g:ledger_bin')
    let g:ledger_accounts_cmd = g:ledger_bin . ' -f ' . shellescape(expand(g:ledger_main)) . ' accounts'
  endif
endif

if !exists('g:ledger_descriptions_cmd')
  if exists('g:ledger_bin')
    if g:ledger_is_hledger
      let g:ledger_descriptions_cmd = g:ledger_bin . ' -f ' . shellescape(expand(g:ledger_main)) . ' descriptions'
    else
      let g:ledger_descriptions_cmd = g:ledger_bin . ' -f ' . shellescape(expand(g:ledger_main)) . ' payees'
    endif
  endif
endif

if !exists('g:ledger_decimal_sep')
  let g:ledger_decimal_sep = '.'
endif

if !exists('g:ledger_align_last')
  let g:ledger_align_last = v:false
endif

if !exists('g:ledger_align_at')
  let g:ledger_align_at = 60
endif

if !exists('g:ledger_align_commodity')
  let g:ledger_align_commodity = 0
endif

if !exists('g:ledger_default_commodity')
  let g:ledger_default_commodity = ''
endif

if !exists('g:ledger_commodity_before')
  let g:ledger_commodity_before = 1
endif

if !exists('g:ledger_commodity_sep')
  let g:ledger_commodity_sep = ''
endif

" If enabled this will list the most detailed matches at the top {{{
" of the completion list.
" For example when you have some accounts like this:
"   A:Ba:Bu
"   A:Bu:Bu
" and you complete on A:B:B normal behaviour may be the following
"   A:B:B
"   A:Bu:Bu
"   A:Bu
"   A:Ba:Bu
"   A:Ba
"   A
" with this option turned on it will be
"   A:B:B
"   A:Bu:Bu
"   A:Ba:Bu
"   A:Bu
"   A:Ba
"   A
" }}}
if !exists('g:ledger_detailed_first')
  let g:ledger_detailed_first = 1
endif

" only display exact matches (no parent accounts etc.)
if !exists('g:ledger_exact_only')
  let g:ledger_exact_only = 0
endif

" display original text / account name as completion
if !exists('g:ledger_include_original')
  let g:ledger_include_original = 0
endif

" Settings for Ledger reports {{{
if !exists('g:ledger_winpos')
  let g:ledger_winpos = 'B'  " Window position (see s:winpos_map)
endif

if !exists('g:ledger_use_location_list')
  let g:ledger_use_location_list = 0  " Use quickfix list by default
endif

if !exists('g:ledger_cleared_string')
  let g:ledger_cleared_string = 'Cleared: '
endif

if !exists('g:ledger_pending_string')
  let g:ledger_pending_string = 'Cleared or pending: '
endif

if !exists('g:ledger_target_string')
  let g:ledger_target_string = 'Difference from target: '
endif
" }}}

" Settings for the quickfix window {{{
if !exists('g:ledger_qf_register_format')
  let g:ledger_qf_register_format =
				\ '%(date) %(justify(payee, 50)) '.
				\	'%(justify(account, 30)) %(justify(amount, 15, -1, true)) '.
				\	'%(justify(total, 15, -1, true))\n'
endif

if !exists('g:ledger_qf_reconcile_format')
  let g:ledger_qf_reconcile_format =
				\ '%(date) %(justify(code, 4)) '.
				\ '%(justify(payee, 50)) %(justify(account, 30)) '.
				\ '%(justify(amount, 15, -1, true))\n'
endif

if !exists('g:ledger_qf_size')
  let g:ledger_qf_size = 10  " Size of the quickfix window
endif

if !exists('g:ledger_qf_vertical')
  let g:ledger_qf_vertical = 0
endif

if !exists('g:ledger_qf_hide_file')
  let g:ledger_qf_hide_file = 1
endif
" }}}

if !exists('current_compiler')
  compiler ledger
endif

" Highlight groups for Ledger reports {{{
hi link LedgerNumber Number
hi link LedgerNegativeNumber Special
hi link LedgerCleared Constant
hi link LedgerPending Todo
hi link LedgerTarget Statement
hi link LedgerImproperPerc Special
" }}}

let s:rx_amount = '\('.
                \   '\%([0-9]\+\)'.
                \   '\%([,.][0-9]\+\)*'.
                \ '\|'.
                \   '[,.][0-9]\+'.
                \ '\)'.
                \ '\s*\%([[:alpha:]¢$€£]\+\s*\)\?'.
                \ '\%(\s*;.*\)\?$'

function! LedgerFoldText() "{{{1
  " find amount
  let amount = ''
  let lnum = v:foldstart + 1
  while lnum <= v:foldend
    let line = getline(lnum)

    " Skip metadata/leading comment
    if line !~# '^\%(\s\+;\|\d\)'
      " No comment, look for amount...
      let groups = matchlist(line, s:rx_amount)
      if ! empty(groups)
        let amount = groups[1]
        break
      endif
    endif
    let lnum += 1
  endwhile

  " strip whitespace at beginning and end of line
  let foldtext = substitute(getline(v:foldstart),
                          \ '\(^\s\+\|\s\+$\)', '', 'g')

  " number of columns foldtext can use
  let columns = s:get_columns()
  if g:ledger_maxwidth
    let columns = min([columns, g:ledger_maxwidth])
  endif

  let amount = printf(' %s ', amount)
  " left cut-off if window is too narrow to display the amount
  while columns < strdisplaywidth(amount)
    let amount = substitute(amount, '^.', '', '')
  endwhile
  let columns -= strdisplaywidth(amount)

  if columns <= 0
    return amount
  endif

  " right cut-off if there is not sufficient space to display the description
  while columns < strdisplaywidth(foldtext)
    let foldtext = substitute(foldtext, '.$', '', '')
  endwhile
  let columns -= strdisplaywidth(foldtext)

  if columns <= 0
    return foldtext . amount
  endif

  " fill in the fillstring
  if strlen(g:ledger_fillstring)
    let fillstring = g:ledger_fillstring
  else
    let fillstring = ' '
  endif
  let fillstrlen = strdisplaywidth(fillstring)

  let foldtext .= ' '
  let columns -= 1
  while columns >= fillstrlen
    let foldtext .= fillstring
    let columns -= fillstrlen
  endwhile

  while columns < strdisplaywidth(fillstring)
    let fillstring = substitute(fillstring, '.$', '', '')
  endwhile
  let foldtext .= fillstring

  return foldtext . amount
endfunction "}}}

function! LedgerComplete(findstart, base) "{{{1
  if a:findstart
    let lnum = line('.')
    let line = getline('.')
    let b:compl_context = ''
    if line =~# '^\s\+[^[:blank:];]' "{{{2 (account)
      " only allow completion when in or at end of account name
      if matchend(line, '^\s\+\%(\S \S\|\S\)\+') >= col('.') - 1
        " the start of the first non-blank character
        " (excluding virtual-transaction and 'cleared' marks)
        " is the beginning of the account name
        let b:compl_context = 'account'
        return matchend(line, '^\s\+[*!]\?\s*[\[(]\?')
      endif
    elseif line =~# '^\d' "{{{2 (description)
      let pre = matchend(line, '^\d\S\+\%(([^)]*)\|[*?!]\|\s\)\+')
      if pre < col('.') - 1
        let b:compl_context = 'description'
        return pre
      endif
    elseif line =~# '^$' "{{{2 (new line)
      let b:compl_context = 'new'
    endif "}}}
    return -1
  else
    if ! exists('b:compl_cache')
      let b:compl_cache = s:collect_completion_data()
      let b:compl_cache['#'] = changenr()
    endif
    let update_cache = 0

    let results = []
    if b:compl_context ==# 'account' "{{{2 (account)
      let hierarchy = split(a:base, ':')
      if a:base =~# ':$'
        call add(hierarchy, '')
      endif

      let results = ledger#find_in_tree(b:compl_cache.accounts, hierarchy)
      let exacts = filter(copy(results), 'v:val[1]')

      if len(exacts) < 1
        " update cache if we have no exact matches
        let update_cache = 1
      endif

      if g:ledger_exact_only
        let results = exacts
      endif

      call map(results, 'v:val[0]')

      if g:ledger_detailed_first
        let results = reverse(sort(results, 's:sort_accounts_by_depth'))
      else
        let results = sort(results)
      endif
    elseif b:compl_context ==# 'description' "{{{2 (description)
      let results = ledger#filter_items(b:compl_cache.descriptions, a:base)

      if len(results) < 1
        let update_cache = 1
      endif
    elseif b:compl_context ==# 'new' "{{{2 (new line)
      return [strftime(g:ledger_date_format)]
    endif "}}}


    if g:ledger_include_original
      call insert(results, a:base)
    endif

    " no completion (apart from a:base) found. update cache if file has changed
    if update_cache && b:compl_cache['#'] != changenr()
      unlet b:compl_cache
      return LedgerComplete(a:findstart, a:base)
    else
      unlet! b:compl_context
      return results
    endif
  endif
endf "}}}

" Deprecated functions {{{1
let s:deprecated = {
  \ 'LedgerToggleTransactionState': 'ledger#transaction_state_toggle',
  \ 'LedgerSetTransactionState': 'ledger#transaction_state_set',
  \ 'LedgerSetDate': 'ledger#transaction_date_set'
  \ }

for [s:old, s:new] in items(s:deprecated)
  let s:fun = "function! {s:old}(...)\nechohl WarningMsg\necho '" . s:old .
            \ ' is deprecated. Use '.s:new." instead!'\nechohl None\n" .
            \ "call call('" . s:new . "', a:000)\nendf"
  exe s:fun
endfor
unlet s:old s:new s:fun
" }}}1

function! s:collect_completion_data() "{{{1
  let transactions = ledger#transactions()
  let cache = {'descriptions': [], 'tags': {}, 'accounts': {}}
  if exists('g:ledger_accounts_cmd')
    let accounts = systemlist(g:ledger_accounts_cmd)
  else
    let accounts = ledger#declared_accounts()
  endif
  if exists('g:ledger_descriptions_cmd')
    let cache.descriptions = systemlist(g:ledger_descriptions_cmd)
  endif
  for xact in transactions
    if !exists('g:ledger_descriptions_cmd')
      " collect descriptions
      if has_key(xact, 'description') && index(cache.descriptions, xact['description']) < 0
        call add(cache.descriptions, xact['description'])
      endif
    endif
    let [t, postings] = xact.parse_body()
    let tagdicts = [t]

		" collect account names
    if !exists('g:ledger_accounts_cmd')
      for posting in postings
        if has_key(posting, 'tags')
          call add(tagdicts, posting.tags)
        endif
        " remove virtual-transaction-marks
        let name = substitute(posting.account, '\%(^\s*[\[(]\?\|[\])]\?\s*$\)', '', 'g')
        if index(accounts, name) < 0
          call add(accounts, name)
        endif
      endfor
    endif

    " collect tags
    for tags in tagdicts | for [tag, val] in items(tags)
      let values = get(cache.tags, tag, [])
      if index(values, val) < 0
        call add(values, val)
      endif
      let cache.tags[tag] = values
    endfor | endfor
  endfor

  for account in accounts
    let last = cache.accounts
    for part in split(account, ':')
      let last[part] = get(last, part, {})
      let last = last[part]
    endfor
  endfor

  return cache
endf "}}}

" Helper functions {{{1

" return length of string with fix for multibyte characters
function! s:multibyte_strlen(text) "{{{2
   return strlen(substitute(a:text, '.', 'x', 'g'))
endfunction "}}}

" get # of visible/usable columns in current window
function! s:get_columns() " {{{2
  " As long as vim doesn't provide a command natively,
  " we have to compute the available columns.
  " see :help todo.txt -> /Add argument to winwidth()/

  let columns = (winwidth(0) == 0 ? 80 : winwidth(0)) - &foldcolumn
  if &number
    " line('w$') is the line number of the last line
    let columns -= max([len(line('w$'))+1, &numberwidth])
  endif

  " are there any signs/is the sign column displayed?
  redir => signs
  silent execute 'sign place buffer='.string(bufnr('%'))
  redir END
  if signs =~# 'id='
    let columns -= 2
  endif

  return columns
endf "}}}

function! s:sort_accounts_by_depth(name1, name2) "{{{2
  let depth1 = s:count_expression(a:name1, ':')
  let depth2 = s:count_expression(a:name2, ':')
  return depth1 == depth2 ? 0 : depth1 > depth2 ? 1 : -1
endf "}}}

function! s:count_expression(text, expression) "{{{2
  return len(split(a:text, a:expression, 1))-1
endf "}}}

function! s:autocomplete_account_or_payee(argLead, cmdLine, cursorPos) "{{{2
  return (a:argLead =~# '^@') ?
        \ map(filter(systemlist(g:ledger_bin . ' -f ' . shellescape(expand(g:ledger_main)) . ' payees'),
        \ "v:val =~? '" . strpart(a:argLead, 1) . "' && v:val !~? '^Warning: '"), '"@" . escape(v:val, " ")')
        \ :
        \ map(filter(systemlist(g:ledger_bin . ' -f ' . shellescape(expand(g:ledger_main)) . ' accounts'),
        \ "v:val =~? '" . a:argLead . "' && v:val !~? '^Warning: '"), 'escape(v:val, " ")')
endf "}}}

function! s:reconcile(file, account) "{{{2
  " call inputsave()
  let l:amount = input('Target amount' . (empty(g:ledger_default_commodity) ? ': ' : ' (' . g:ledger_default_commodity . '): '))
  " call inputrestore()
  call ledger#reconcile(a:file, a:account, str2float(l:amount))
endf "}}}

" Commands {{{1
command! -buffer -nargs=? -complete=customlist,s:autocomplete_account_or_payee
      \ Balance call ledger#show_balance(g:ledger_main, <q-args>)

command! -buffer -nargs=+ -complete=customlist,s:autocomplete_account_or_payee
      \ Ledger call ledger#output(ledger#report(g:ledger_main, <q-args>))

command! -buffer -range LedgerAlign <line1>,<line2>call ledger#align_commodity()

command! -buffer LedgerAlignBuffer call ledger#align_commodity_buffer()

command! -buffer -nargs=1 -complete=customlist,s:autocomplete_account_or_payee
      \ Reconcile call <sid>reconcile(g:ledger_main, <q-args>)

command! -buffer -complete=customlist,s:autocomplete_account_or_payee -nargs=*
      \ Register call ledger#register(g:ledger_main, <q-args>)
" }}}

