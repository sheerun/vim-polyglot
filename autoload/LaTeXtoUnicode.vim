if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'julia') == -1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Support for LaTex-to-Unicode conversion as in the Julia REPL "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:L2U_Setup()

  call s:L2U_SetupGlobal()

  " Keep track of whether LaTeX-to-Unicode is activated
  " (used when filetype changes)
  if !has_key(b:, "l2u_enabled")
    let b:l2u_enabled = 0
  endif

  " Did we install the L2U tab mappings?
  if !has_key(b:, "l2u_tab_set")
    let b:l2u_tab_set = 0
  endif
  if !has_key(b:, "l2u_cmdtab_set")
    let b:l2u_cmdtab_set = 0
  endif
  if !has_key(b:, "l2u_keymap_set")
    let b:l2u_keymap_set = 0
  endif

  " Did we activate the L2U as-you-type substitutions?
  if !has_key(b:, "l2u_autosub_set")
    let b:l2u_autosub_set = 0
  endif

  " Following are some flags used to pass information between the function which
  " attempts the LaTeX-to-Unicode completion and the fallback function

  " Was a (possibly partial) completion found?
  let b:l2u_found_completion = 0
  " Is the cursor just after a single backslash
  let b:l2u_singlebslash = 0
  " Backup value of the completeopt settings
  " (since we temporarily add the 'longest' setting while
  "  attempting LaTeX-to-Unicode)
  let b:l2u_backup_commpleteopt = &completeopt
  " Are we in the middle of a L2U tab completion?
  let b:l2u_tab_completing = 0
  " Are we calling the tab fallback?
  let b:l2u_in_fallback = 0

endfunction

function! s:L2U_SetupGlobal()

  " Initialization of global and script-local variables
  " is only performed once
  if get(g:, "l2u_did_global_setup", 0)
    return
  endif

  let g:l2u_did_global_setup = 1

  let g:l2u_symbols_dict = julia_latex_symbols#get_dict()

  call s:L2U_deprecated_options()

  if v:version < 704
      let g:latex_to_unicode_tab = 0
      let g:latex_to_unicode_auto = 0
  endif

  " YouCompleteMe and neocomplcache/neocomplete/deoplete plug-ins do not work well
  " with LaTeX symbols suggestions
  if exists("g:loaded_youcompleteme") ||
        \ exists("g:loaded_neocomplcache") ||
        \ exists("g:loaded_neocomplete") ||
        \ exists("g:loaded_deoplete")
    let g:latex_to_unicode_suggestions = 0
  endif

  " A hack to forcibly get out of completion mode: feed
  " this string with feedkeys()
  if has("win32") || has("win64")
    let s:l2u_esc_sequence = "\u0006"
  else
    let s:l2u_esc_sequence = "\u0091\b"
  end

  " Trigger for the previous mapping of <Tab>
  let s:l2u_fallback_trigger = "\u0091L2UFallbackTab"

endfunction

" Each time the filetype changes, we may need to enable or
" disable the LaTeX-to-Unicode functionality
function! LaTeXtoUnicode#Refresh()

  call s:L2U_Setup()

  " by default, LaTeX-to-Unicode is only active on julia files
  let file_types = s:L2U_file_type_regex(get(g:, "latex_to_unicode_file_types", "julia"))
  let file_types_blacklist = s:L2U_file_type_regex(get(g:, "latex_to_unicode_file_types_blacklist", "$^"))

  if match(&filetype, file_types) < 0 || match(&filetype, file_types_blacklist) >= 0
    if b:l2u_enabled
      call LaTeXtoUnicode#Disable()
    else
      return
    endif
  elseif !b:l2u_enabled
    call LaTeXtoUnicode#Enable()
  endif

endfunction

function! LaTeXtoUnicode#Enable()

  if b:l2u_enabled
    return
  end

  call s:L2U_ResetLastCompletionInfo()

  let b:l2u_enabled = 1

  " If we're editing the first file upon opening vim, this will only init the
  " command line mode mapping, and the full initialization will be performed by
  " the autocmd triggered by InsertEnter, defined in /ftdetect.vim.
  " Otherwise, if we're opening a file from within a running vim session, this
  " will actually initialize all the LaTeX-to-Unicode substitutions.
  call LaTeXtoUnicode#Init()

  return

endfunction

function! LaTeXtoUnicode#Disable()
  if !b:l2u_enabled
    return
  endif
  let b:l2u_enabled = 0
  call LaTeXtoUnicode#Init()
  return
endfunction

" Translate old options to their new equivalents
function! s:L2U_deprecated_options()
  for [new, old] in [["latex_to_unicode_tab",         "julia_latex_to_unicode"],
                 \   ["latex_to_unicode_auto",        "julia_auto_latex_to_unicode"],
                 \   ["latex_to_unicode_suggestions", "julia_latex_suggestions_enabled"],
                 \   ["latex_to_unicode_eager",       "julia_latex_to_unicode_eager"]]
    if !has_key(g:, new) && has_key(g:, old)
      exec "let g:" . new . " = g:" . old
    endif
  endfor
endfunction

function! s:L2U_file_type_regex(ft)
  if type(a:ft) == 3
    let file_types = "\\%(" . join(a:ft, "\\|") . "\\)"
  elseif type(a:ft) == 1
    let file_types = a:ft
  else
    echoerr "invalid file_type specification"
  endif
  return "^" . file_types . "$"
endfunction

" Some data used to keep track of the previous completion attempt.
" Used to detect
" 1) if we just attempted the same completion, or
" 2) if backspace was just pressed while completing
" This function initializes and resets the required info

function! s:L2U_ResetLastCompletionInfo()
  let b:l2u_completed_once = 0
  let b:l2u_bs_while_completing = 0
  let b:l2u_last_compl = {
        \ 'line': '',
        \ 'col0': -1,
        \ 'col1': -1,
        \ }
endfunction

" This function only detects whether an exact match is found for a LaTeX
" symbol in front of the cursor
function! s:L2U_ismatch()
  let col1 = col('.')
  let l = getline('.')
  let col0 = match(l[0:col1-2], '\\[^[:space:]\\]\+$')
  if col0 == -1
    return 0
  endif
  let base = l[col0 : col1-1]
  return has_key(g:l2u_symbols_dict, base)
endfunction

" Helper function to sort suggestion entries
function! s:L2U_partmatches_sort(p1, p2)
  return a:p1.word > a:p2.word ? 1 : a:p1.word < a:p2.word ? -1 : 0
endfunction

" Helper function to fix display of Unicode compose characters
" in the suggestions menu (they are displayed on top of '◌')
function! s:L2U_fix_compose_chars(uni)
  let u = matchstr(a:uni, '^.')
  let isc = ("\u0300" <= u && u <= "\u036F") ||
          \ ("\u1DC0" <= u && u <= "\u1DFF") ||
          \ ("\u20D0" <= u && u <= "\u20FF") ||
          \ ("\uFE20" <= u && u <= "\uFE2F")
  return isc ? "\u25CC" . a:uni : a:uni
endfunction

" Helper function to find the longest common prefix among
" partial completion matches (used when suggestions are disabled
" and in command line mode)
function! s:L2U_longest_common_prefix(partmatches)
  let common = a:partmatches[0]
  for i in range(1, len(a:partmatches)-1)
    let p = a:partmatches[i]
    if len(p) < len(common)
      let common = common[0 : len(p)-1]
    endif
    for j in range(1, len(common)-1)
      if p[j] != common[j]
        let common = common[0 : j-1]
        break
      endif
    endfor
  endfor
  return common
endfunction

" Omnicompletion function. Besides the usual two-stage omnifunc behaviour,
" it has the following peculiar features:
"  *) keeps track of the previous completion attempt
"  *) sets some info to be used by the fallback function
"  *) either returns a list of completions if a partial match is found, or a
"     Unicode char if an exact match is found
"  *) forces its way out of completion mode through a hack in some cases
function! LaTeXtoUnicode#omnifunc(findstart, base)
  if a:findstart
    " first stage
    " avoid infinite loop if the fallback happens to call omnicompletion
    if b:l2u_in_fallback
      let b:l2u_in_fallback = 0
      return -3
    endif
    let b:l2u_in_fallback = 0
    " set info for the callback
    let b:l2u_tab_completing = 1
    let b:l2u_found_completion = 1
    " analyse current line
    let col1 = col('.')
    let l = getline('.')
    let col0 = match(l[0:col1-2], '\\[^[:space:]\\]\+$')
    " compare with previous completion attempt
    let b:l2u_bs_while_completing = 0
    let b:l2u_completed_once = 0
    if col0 == b:l2u_last_compl['col0']
      let prevl = b:l2u_last_compl['line']
      if col1 == b:l2u_last_compl['col1'] && l ==# prevl
        let b:l2u_completed_once = 1
      elseif col1 == b:l2u_last_compl['col1'] - 1 && l ==# prevl[0 : col1-2] . prevl[col1 : -1]
        let b:l2u_bs_while_completing = 1
      endif
    endif
    " store completion info for next attempt
    let b:l2u_last_compl['col0'] = col0
    let b:l2u_last_compl['col1'] = col1
    let b:l2u_last_compl['line'] = l
    " is the cursor right after a backslash?
    let b:l2u_singlebslash = (match(l[0:col1-2], '\\$') >= 0)
    " completion not found
    if col0 == -1
      let b:l2u_found_completion = 0
      call feedkeys(s:l2u_esc_sequence, 'n')
      let col0 = -2
    endif
    return col0
  else
    " read settings (eager mode is implicit when suggestions are disabled)
    let suggestions = get(g:, "latex_to_unicode_suggestions", 1)
    let eager = get(g:, "latex_to_unicode_eager", 1) || !suggestions
    " search for matches
    let partmatches = []
    let exact_match = 0
    for k in keys(g:l2u_symbols_dict)
      if k ==# a:base
        let exact_match = 1
      endif
      if len(k) >= len(a:base) && k[0 : len(a:base)-1] ==# a:base
        let menu = s:L2U_fix_compose_chars(g:l2u_symbols_dict[k])
        if suggestions
          call add(partmatches, {'word': k, 'menu': menu})
        else
          call add(partmatches, k)
        endif
      endif
    endfor
    " exact matches are replaced with Unicode
    " exceptions:
    "  *) we reached an exact match by pressing backspace while completing
    "  *) the exact match is one among many, and the eager setting is
    "     disabled, and it's the first time this completion is attempted
    if exact_match && !b:l2u_bs_while_completing && (len(partmatches) == 1 || eager || b:l2u_completed_once)
      " the completion is successful: reset the last completion info...
      call s:L2U_ResetLastCompletionInfo()
      " ...force our way out of completion mode...
      call feedkeys(s:l2u_esc_sequence, 'n')
      " ...return the Unicode symbol
      return [g:l2u_symbols_dict[a:base]]
    endif
    if !empty(partmatches)
      " here, only partial matches were found; either keep just the longest
      " common prefix, or pass them on
      if !suggestions
        let partmatches = [s:L2U_longest_common_prefix(partmatches)]
      else
        call sort(partmatches, "s:L2U_partmatches_sort")
      endif
    endif
    if empty(partmatches)
      call feedkeys(s:l2u_esc_sequence, 'n')
      let b:l2u_found_completion = 0
    endif
    return partmatches
  endif
endfunction

function! LaTeXtoUnicode#PutLiteral(k)
  call feedkeys(a:k, 'ni')
  return ''
endfunction

" Function which saves the current insert-mode mapping of a key sequence `s`
" and associates it with another key sequence `k` (e.g. stores the current
" <Tab> mapping into the Fallback trigger)
function! s:L2U_SetFallbackMapping(s, k)
  let mmdict = maparg(a:s, 'i', 0, 1)
  if empty(mmdict)
    exe 'inoremap <buffer> ' . a:k . ' ' . a:s
    return
  endif
  let rhs = mmdict["rhs"]
  if rhs =~# '^<Plug>L2U'
    return
  endif
  let pre = '<buffer>'
  if mmdict["silent"]
    let pre = pre . '<silent>'
  endif
  if mmdict["expr"]
    let pre = pre . '<expr>'
  endif
  if mmdict["noremap"]
    let cmd = 'inoremap '
  else
    let cmd = 'imap '
    " This is a nasty hack used to prevent infinite recursion. It's not a
    " general solution.
    if mmdict["expr"]
      let rhs = substitute(rhs, '\c' . a:s, "\<C-R>=LaTeXtoUnicode#PutLiteral('" . a:s . "')\<CR>", 'g')
    endif
  endif
  exe cmd . pre . ' ' . a:k . ' ' . rhs
endfunction

" This is the function which is mapped to <Tab>
function! LaTeXtoUnicode#Tab()
  " the <Tab> is passed through to the fallback mapping if the completion
  " menu is present, and it hasn't been raised by the L2U tab, and there
  " isn't an exact match before the cursor when suggestions are disabled
  if pumvisible() && !b:l2u_tab_completing && (get(g:, "latex_to_unicode_suggestions", 1) || !s:L2U_ismatch())
    call feedkeys(s:l2u_fallback_trigger)
    return ''
  endif
  " reset the in_fallback info
  let b:l2u_in_fallback = 0
  " temporary change to completeopt to use the `longest` setting, which is
  " probably the only one which makes sense given that the goal of the
  " completion is to substitute the final string
  let b:l2u_backup_commpleteopt = &completeopt
  set completeopt+=longest
  set completeopt-=noinsert
  " invoke omnicompletion; failure to perform LaTeX-to-Unicode completion is
  " handled by the CompleteDone autocommand.
  return "\<C-X>\<C-O>"
endfunction

" This function is called at every CompleteDone event, and is meant to handle
" the failures of LaTeX-to-Unicode completion by calling a fallback
function! LaTeXtoUnicode#FallbackCallback()
  if !b:l2u_tab_completing
    " completion was not initiated by L2U, nothing to do
    return
  else
    " completion was initiated by L2U, restore completeopt
    let &completeopt = b:l2u_backup_commpleteopt
  endif
  " at this point L2U tab completion is over
  let b:l2u_tab_completing = 0
  " if the completion was successful do nothing
  if b:l2u_found_completion == 1 || b:l2u_singlebslash == 1
    return
  endif
  " fallback
  let b:l2u_in_fallback = 1
  call feedkeys(s:l2u_fallback_trigger)
  return
endfunction

" This is the function that performs the substitution in command-line mode
function! LaTeXtoUnicode#CmdTab(triggeredbytab)
  " first stage
  " analyse command line
  let col1 = getcmdpos() - 1
  let l = getcmdline()
  let col0 = match(l[0:col1-1], '\\[^[:space:]\\]\+$')
  let b:l2u_singlebslash = (match(l[0:col1-1], '\\$') >= 0)
  " completion not found
  if col0 == -1
    if a:triggeredbytab
      call feedkeys("\<Tab>", 'nt') " fall-back to the default <Tab>
    endif
    return l
  endif
  let base = l[col0 : col1-1]
  " search for matches
  let partmatches = []
  let exact_match = 0
  for k in keys(g:l2u_symbols_dict)
    if k ==# base
      let exact_match = 1
    endif
    if len(k) >= len(base) && k[0 : len(base)-1] ==# base
      call add(partmatches, k)
    endif
  endfor
  if len(partmatches) == 0
    if a:triggeredbytab
      call feedkeys("\<Tab>", 'nt') " fall-back to the default <Tab>
    endif
    return l
  endif
  " exact matches are replaced with Unicode
  if exact_match
    let unicode = g:l2u_symbols_dict[base]
    if col0 > 0
      let pre = l[0 : col0 - 1]
    else
      let pre = ''
    endif
    let posdiff = col1-col0 - len(unicode)
    call setcmdpos(col1 - posdiff + 1)
    return pre . unicode . l[col1 : -1]
  endif
  " no exact match: complete with the longest common prefix
  let common = s:L2U_longest_common_prefix(partmatches)
  if col0 > 0
    let pre = l[0 : col0 - 1]
  else
    let pre = ''
  endif
  let posdiff = col1-col0 - len(common)
  call setcmdpos(col1 - posdiff + 1)
  return pre . common . l[col1 : -1]
endfunction

" Setup the L2U tab mapping
function! s:L2U_SetTab(wait_insert_enter)
  if !b:l2u_cmdtab_set && get(g:, "latex_to_unicode_tab", 1) && b:l2u_enabled
    let b:l2u_cmdtab_keys = get(g:, "latex_to_unicode_cmd_mapping", ['<Tab>','<S-Tab>'])
    if type(b:l2u_cmdtab_keys) != type([]) " avoid using v:t_list for backward compatibility
      let b:l2u_cmdtab_keys = [b:l2u_cmdtab_keys]
    endif
    for k in b:l2u_cmdtab_keys
      exec 'cnoremap <buffer> '.k.' <C-\>eLaTeXtoUnicode#CmdTab('.(k ==? '<Tab>').')<CR>'
    endfor
    let b:l2u_cmdtab_set = 1
  endif
  if b:l2u_tab_set
    return
  endif
  " g:did_insert_enter is set from an autocommand in ftdetect
  if a:wait_insert_enter && !get(g:, "did_insert_enter", 0)
    return
  endif
  if !get(g:, "latex_to_unicode_tab", 1) || !b:l2u_enabled
    return
  endif

  " Backup the previous omnifunc (the check is probably not really needed)
  if get(b:, "prev_omnifunc", "") != "LaTeXtoUnicode#omnifunc"
    let b:prev_omnifunc = &omnifunc
  endif
  setlocal omnifunc=LaTeXtoUnicode#omnifunc

  call s:L2U_SetFallbackMapping('<Tab>', s:l2u_fallback_trigger)
  imap <buffer> <Tab> <Plug>L2UTab
  inoremap <buffer><expr> <Plug>L2UTab LaTeXtoUnicode#Tab()

  augroup L2UTab
    autocmd! * <buffer>
    " Every time a completion finishes, the fallback may be invoked
    autocmd CompleteDone <buffer> call LaTeXtoUnicode#FallbackCallback()
  augroup END

  let b:l2u_tab_set = 1
endfunction

" Revert the LaTeX-to-Unicode tab mapping settings
function! s:L2U_UnsetTab()
  if b:l2u_cmdtab_set
    for k in b:l2u_cmdtab_keys
      exec 'cunmap <buffer> '.k
    endfor
    let b:l2u_cmdtab_set = 0
  endif
  if !b:l2u_tab_set
    return
  endif
  exec "setlocal omnifunc=" . get(b:, "prev_omnifunc", "")
  iunmap <buffer> <Tab>
  if empty(maparg("<Tab>", "i"))
    call s:L2U_SetFallbackMapping(s:l2u_fallback_trigger, '<Tab>')
  endif
  iunmap <buffer> <Plug>L2UTab
  exe 'iunmap <buffer> ' . s:l2u_fallback_trigger
  augroup L2UTab
    autocmd! * <buffer>
  augroup END
  let b:l2u_tab_set = 0
endfunction

" Function which looks for viable LaTeX-to-Unicode supstitutions as you type
function! LaTeXtoUnicode#AutoSub(...)
  let vc = a:0 == 0 ? v:char : a:1
  let col1 = col('.')
  let lnum = line('.')
  if col1 == 1
    if a:0 > 1
      call feedkeys(a:2, 'n')
    endif
    return ''
  endif
  let bs = (vc != "\n")
  let l = getline(lnum)[0 : col1-1-bs] . v:char
  let col0 = match(l, '\\\%([_^]\?[A-Za-z]\+\%' . col1 . 'c\%([^A-Za-z]\|$\)\|[_^]\%([0-9()=+-]\)\%' . col1 .'c\%(.\|$\)\)')
  if col0 == -1
    if a:0 > 1
      call feedkeys(a:2, 'n')
    endif
    return ''
  endif
  let base = l[col0 : -1-bs]
  let unicode = get(g:l2u_symbols_dict, base, '')
  if empty(unicode)
    if a:0 > 1
      call feedkeys(a:2, 'n')
    endif
    return ''
  endif
  call feedkeys("\<C-G>u", 'n')
  call feedkeys(repeat("\b", len(base) + bs) . unicode . vc . s:l2u_esc_sequence, 'nt')
  call feedkeys("\<C-G>u", 'n')
  return ''
endfunction

" Setup the auto as-you-type LaTeX-to-Unicode substitution
function! s:L2U_SetAutoSub(wait_insert_enter)
  if b:l2u_autosub_set
    return
  endif
  " g:did_insert_enter is set from an autocommand in ftdetect
  if a:wait_insert_enter && !get(g:, "did_insert_enter", 0)
    return
  endif
  if !get(g:, "latex_to_unicode_auto", 0) || !b:l2u_enabled
    return
  endif
  " Viable substitutions are searched at every character insertion via the
  " autocmd InsertCharPre. The <Enter> key does not seem to be catched in
  " this way though, so we use a mapping for that case.
  imap <buffer> <CR> <Plug>L2UAutoSub
  inoremap <buffer><expr> <Plug>L2UAutoSub LaTeXtoUnicode#AutoSub("\n", "\<CR>")

  augroup L2UAutoSub
    autocmd! * <buffer>
    autocmd InsertCharPre <buffer> call LaTeXtoUnicode#AutoSub()
  augroup END

  let b:l2u_autosub_set = 1
endfunction

" Revert the auto LaTeX-to-Unicode settings
function! s:L2U_UnsetAutoSub()
  if !b:l2u_autosub_set
    return
  endif

  iunmap <buffer> <CR>
  iunmap <buffer> <Plug>L2UAutoSub
  augroup L2UAutoSub
    autocmd! * <buffer>
  augroup END
  let b:l2u_autosub_set = 0
endfunction

function! s:L2U_SetKeymap()
  if !b:l2u_keymap_set && get(g:, "latex_to_unicode_keymap", 0) && b:l2u_enabled
    setlocal keymap=latex2unicode
    let b:l2u_keymap_set = 1
  endif
endfunction

function! s:L2U_UnsetKeymap()
  if !b:l2u_keymap_set
    return
  endif
  setlocal keymap=
  let b:l2u_keymap_set = 0
endfunction

" Initialization. Can be used to re-init when global settings have changed.
function! LaTeXtoUnicode#Init(...)
  let wait_insert_enter = a:0 > 0 ? a:1 : 1

  if !wait_insert_enter
    augroup L2UInit
      autocmd!
    augroup END
  endif

  call s:L2U_UnsetTab()
  call s:L2U_UnsetAutoSub()
  call s:L2U_UnsetKeymap()

  call s:L2U_SetTab(wait_insert_enter)
  call s:L2U_SetAutoSub(wait_insert_enter)
  call s:L2U_SetKeymap()
endfunction

function! LaTeXtoUnicode#Toggle()
  call s:L2U_Setup()
  if b:l2u_enabled
    call LaTeXtoUnicode#Disable()
    echo "LaTeX-to-Unicode disabled"
  else
    call LaTeXtoUnicode#Enable()
    echo "LaTeX-to-Unicode enabled"
  endif
  return
endfunction

endif
