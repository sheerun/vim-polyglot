if polyglot#init#is_disabled(expand('<sfile>:p'), 'julia', 'autoload/LaTeXtoUnicode.vim')
  finish
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Support for LaTex-to-Unicode conversion as in the Julia REPL "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:L2U_Setup()

  call s:L2U_SetupGlobal()

  " Keep track of whether LaTeX-to-Unicode is activated
  " (used when filetype changes)
  let b:l2u_enabled = get(b:, "l2u_enabled", 0)
  let b:l2u_autodetect_enable = get(b:, "l2u_autodetect_enable", 1)

  " Did we install the L2U tab/as-you-type/keymap... mappings?
  let b:l2u_tab_set = get(b:, "l2u_tab_set", 0)
  let b:l2u_cmdtab_set = get(b:, "l2u_cmdtab_set", 0)
  let b:l2u_autosub_set = get(b:, "l2u_autosub_set", 0)
  let b:l2u_keymap_set = get(b:, "l2u_keymap_set", 0)

  " Following are some flags used to pass information between the function which
  " attempts the LaTeX-to-Unicode completion and the fallback function

  " Was a (possibly partial) completion found?
  let b:l2u_found_completion = 0
  " Is the cursor just after a single backslash
  let b:l2u_singlebslash = 0
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
      let g:latex_to_unicode_tab = "off"
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

  " Forcibly get out of completion mode: feed
  " this string with feedkeys(s:l2u_esc_sequence, 'n')
  let s:l2u_esc_sequence = " \b"

  " Trigger for the previous mapping of <Tab>
  let s:l2u_fallback_trigger = "\u0091L2UFallbackTab"

  " Trigger for the previous mapping of <CR>
  let s:l2u_fallback_trigger_cr = "\u0091L2UFallbackCR"

endfunction

" Each time the filetype changes, we may need to enable or
" disable the LaTeX-to-Unicode functionality
function! LaTeXtoUnicode#Refresh()
  call s:L2U_Setup()

  " skip if manually overridden
  if !b:l2u_autodetect_enable
    return ''
  endif

  " by default, LaTeX-to-Unicode is only active on julia files
  let file_types = s:L2U_file_type_regex(get(g:, "latex_to_unicode_file_types", "julia"))
  let file_types_blacklist = s:L2U_file_type_regex(get(g:, "latex_to_unicode_file_types_blacklist", "$^"))

  if match(&filetype, file_types) < 0 || match(&filetype, file_types_blacklist) >= 0
    if b:l2u_enabled
      call LaTeXtoUnicode#Disable(1)
    else
      return ''
    endif
  elseif !b:l2u_enabled
    call LaTeXtoUnicode#Enable(1)
  endif
endfunction

function! LaTeXtoUnicode#Enable(...)
  let auto_set = a:0 > 0 ? a:1 : 0

  if b:l2u_enabled
    return ''
  end

  call s:L2U_ResetLastCompletionInfo()

  let b:l2u_enabled = 1
  let b:l2u_autodetect_enable = auto_set

  " If we're editing the first file upon opening vim, this will only init the
  " command line mode mapping, and the full initialization will be performed by
  " the autocmd triggered by InsertEnter, defined in /ftdetect.vim.
  " Otherwise, if we're opening a file from within a running vim session, this
  " will actually initialize all the LaTeX-to-Unicode substitutions.
  call LaTeXtoUnicode#Init()
  return ''
endfunction

function! LaTeXtoUnicode#Disable(...)
  let auto_set = a:0 > 0 ? a:1 : 0
  if !b:l2u_enabled
    return ''
  endif
  let b:l2u_enabled = 0
  let b:l2u_autodetect_enable = auto_set
  call LaTeXtoUnicode#Init()
  return ''
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

  if has_key(g:, "latex_to_unicode_tab")
    if g:latex_to_unicode_tab is# 1
      let g:latex_to_unicode_tab = "on"
    elseif g:latex_to_unicode_tab is# 0
      let g:latex_to_unicode_tab = "off"
    endif
  endif
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
  let base = l[col0:col1-2]
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

" Completion function. Besides the usual two-stage completefunc behaviour,
" it has the following peculiar features:
"  *) keeps track of the previous completion attempt
"  *) sets some info to be used by the fallback function
"  *) either returns a list of completions if a partial match is found, or a
"     Unicode char if an exact match is found
"  *) forces its way out of completion mode through a hack in some cases
function! LaTeXtoUnicode#completefunc(findstart, base)
  if a:findstart
    " first stage
    " avoid infinite loop if the fallback happens to call completion
    if b:l2u_in_fallback
      let b:l2u_in_fallback = 0
      return -3
    endif
    " make sure that the options are still set
    " (it may happen that <C-X><C-U> itself triggers the fallback before
    " restarting, thus reseetting them; this happens when the prompt is
    " waiting for ^U^N^P during a partial completion)
    call s:L2U_SetCompleteopt()
    " setup the cleanup/fallback operations when we're done
    call s:L2U_InsertCompleteDoneAutocommand()
    call s:L2U_InsertInsertLeaveAutocommand()
    " set info for the callback
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

function! LaTeXtoUnicode#PutLiteralCR()
  call feedkeys('', 'ni')
  return ''
endfunction

" Function which saves the current insert-mode mapping of a key sequence `s`
" and associates it with another key sequence `k` (e.g. stores the current
" <Tab> mapping into the Fallback trigger).
" It returns the previous maparg dictionary, so that the previous mapping can
" be reinstated if needed.
function! s:L2U_SetFallbackMapping(s, k)
  let mmdict = maparg(a:s, 'i', 0, 1)
  if empty(mmdict)
    exe 'inoremap <buffer> ' . a:k . ' ' . a:s
    return mmdict
  endif
  let rhs = mmdict["rhs"]
  if rhs =~# '^<Plug>L2U'
    return mmdict
  endif
  let pre = '<buffer>'
  let pre = pre . (mmdict["silent"] ? '<silent>' : '')
  let pre = pre . (mmdict["expr"] ? '<expr>' : '')
  if mmdict["noremap"]
    let cmd = 'inoremap '
  else
    let cmd = 'imap '
    " This is a nasty hack used to prevent infinite recursion. It's not a
    " general solution. Also, it doesn't work with <CR> since that stops
    " parsing of the <C-R>=... expression, so we need to special-case it.
    " Also, if the original mapping was intended to be recursive, this
    " will break it.
    if a:s != "<CR>"
      let rhs = substitute(rhs, '\c' . a:s, "\<C-R>=LaTeXtoUnicode#PutLiteral('" . a:s . "')\<CR>", 'g')
    else
      let rhs = substitute(rhs, '\c' . a:s, "\<C-R>=LaTeXtoUnicode#PutLiteralCR()\<CR>", 'g')
    endif
    " Make the mapping silent even if it wasn't originally
    if !mmdict["silent"]
      let pre = pre . '<silent>'
    endif
  endif
  exe cmd . pre . ' ' . a:k . ' ' . rhs
  return mmdict
endfunction

" Reinstate a mapping from the maparg dict returned by SetFallbackMapping
" (only if buffer-local, since otherwise it should still be available)
function! s:L2U_ReinstateMapping(mmdict)
  if empty(a:mmdict) || !a:mmdict["buffer"]
    return ''
  endif
  let lhs = a:mmdict["lhs"]
  let rhs = a:mmdict["rhs"]
  if rhs =~# '^<Plug>L2U'
    return ''
  endif
  let pre = '<buffer>'
  let pre = pre . (a:mmdict["silent"] ? '<silent>' : '')
  let pre = pre . (a:mmdict["expr"] ? '<expr>' : '')
  let cmd = a:mmdict["noremap"] ? 'inoremap ' : 'imap '
  exe cmd . pre . ' ' . lhs . ' ' . rhs
endfunction

" This is the function which is mapped to <Tab>
function! LaTeXtoUnicode#Tab()
  " the <Tab> is passed through to the fallback mapping if the completion
  " menu is present, and it hasn't been raised by the L2U tab, and there
  " isn't an exact match before the cursor
  if pumvisible() && !b:l2u_tab_completing && !s:L2U_ismatch()
    call feedkeys(s:l2u_fallback_trigger)
    return ''
  endif
  " ensure that we start completion with some reasonable options
  call s:L2U_SetCompleteopt()
  " reset the in_fallback info
  let b:l2u_in_fallback = 0
  let b:l2u_tab_completing = 1
  " invoke completion; failure to perform LaTeX-to-Unicode completion is
  " handled by the CompleteDone autocommand.
  call feedkeys("\<C-X>\<C-U>", 'n')
  return ""
endfunction

" This function is called at every CompleteDone event, and is meant to handle
" the failures of LaTeX-to-Unicode completion by calling a fallback
function! LaTeXtoUnicode#FallbackCallback()
  call s:L2U_RemoveCompleteDoneAutocommand()
  call s:L2U_RestoreCompleteopt()
  if !b:l2u_tab_completing
    " completion was not initiated by L2U, nothing to do
    return
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
function! LaTeXtoUnicode#CmdTab(trigger)
  " first stage
  " analyse command line
  let col1 = getcmdpos() - 1
  let l = getcmdline()
  let col0 = match(l[0:col1-1], '\\[^[:space:]\\]\+$')
  let b:l2u_singlebslash = (match(l[0:col1-1], '\\$') >= 0)
  " completion not found
  if col0 == -1
    if a:trigger == &wildchar
      call feedkeys(nr2char(a:trigger), 'nt') " fall-back to the default wildchar
    elseif a:trigger == char2nr("\<S-Tab>")
      call feedkeys("\<S-Tab>", 'nt') " fall-back to the default <S-Tab>
    endif
    return ''
  endif
  let base = l[col0 : col1-1]
  " search for matches
  let partmatches = []
  let exact_match = 0
  for k in keys(g:l2u_symbols_dict)
    if k ==# base
      let exact_match = 1
      break
    elseif len(k) >= len(base) && k[0 : len(base)-1] ==# base
      call add(partmatches, k)
    endif
  endfor
  if !exact_match && len(partmatches) == 0
    " no matches, call fallbacks
    if a:trigger == &wildchar
      call feedkeys(nr2char(a:trigger), 'nt') " fall-back to the default wildchar
    elseif a:trigger == char2nr("\<S-Tab>")
      call feedkeys("\<S-Tab>", 'nt') " fall-back to the default <S-Tab>
    endif
  elseif exact_match
    " exact matches are replaced with Unicode
    let unicode = g:l2u_symbols_dict[base]
    call feedkeys(repeat("\b", len(base)) . unicode, 'nt')
  else
    " no exact match: complete with the longest common prefix
    let common = s:L2U_longest_common_prefix(partmatches)
    call feedkeys(common[len(base):], 'nt')
  endif
  return ''
endfunction

function! s:L2U_SetCompleteopt()
  " temporary change completeopt to use settings which make sense
  " for L2U
  let backup_new = 0
  if !exists('b:l2u_backup_completeopt')
    let b:l2u_backup_completeopt = &completeopt
    let backup_new = 1
  endif
  noautocmd set completeopt+=longest
  noautocmd set completeopt-=noinsert
  noautocmd set completeopt-=noselect
  noautocmd set completeopt-=menuone
  if backup_new
    let b:l2u_modified_completeopt = &completeopt
  endif
endfunction

function! s:L2U_RestoreCompleteopt()
  " restore completeopt, but only if nothing else has
  " messed with it in the meanwhile
  if exists('b:l2u_backup_completeopt')
    if exists('b:l2u_modified_completeopt')
      if &completeopt ==# b:l2u_modified_completeopt
        noautocmd let &completeopt = b:l2u_backup_completeopt
      endif
      unlet b:l2u_modified_completeopt
    endif
    unlet b:l2u_backup_completeopt
  endif
endfunction

function! s:L2U_InsertCompleteDoneAutocommand()
  augroup L2UCompleteDone
    autocmd! * <buffer>
    " Every time a L2U completion finishes, the fallback may be invoked
    autocmd CompleteDone <buffer> call LaTeXtoUnicode#FallbackCallback()
  augroup END
endfunction

function! s:L2U_RemoveCompleteDoneAutocommand()
  augroup L2UCompleteDone
    autocmd! * <buffer>
  augroup END
endfunction

function s:L2U_InsertLeaveClenup()
    call s:L2U_ResetLastCompletionInfo()
    augroup L2UInsertLeave
      autocmd! * <buffer>
    augroup END
endfunction

function! s:L2U_InsertInsertLeaveAutocommand()
  augroup L2UInsertLeave
    autocmd! * <buffer>
    autocmd InsertLeave <buffer> call s:L2U_InsertLeaveClenup()
  augroup END
endfunction

" Setup the L2U tab mapping
function! s:L2U_SetTab(wait_insert_enter)
  let opt_do_cmdtab = index(["on", "command", "cmd"], get(g:, "latex_to_unicode_tab", "on")) != -1
  let opt_do_instab = index(["on", "insert", "ins"], get(g:, "latex_to_unicode_tab", "on")) != -1
  if !b:l2u_cmdtab_set && opt_do_cmdtab && b:l2u_enabled
    let b:l2u_cmdtab_keys = get(g:, "latex_to_unicode_cmd_mapping", ['<Tab>','<S-Tab>'])
    if type(b:l2u_cmdtab_keys) != type([]) " avoid using v:t_list for backward compatibility
      let b:l2u_cmdtab_keys = [b:l2u_cmdtab_keys]
    endif
    for k in b:l2u_cmdtab_keys
      exec 'let trigger = char2nr("'.(k[0] == '<' ? '\' : '').k.'")'
      exec 'cnoremap <buffer><expr> '.k.' LaTeXtoUnicode#CmdTab('.trigger.')'
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
  if !opt_do_instab || !b:l2u_enabled
    return
  endif

  " Backup the previous completefunc (the check is probably not really needed)
  if get(b:, "l2u_prev_completefunc", "") != "LaTeXtoUnicode#completefunc"
    let b:l2u_prev_completefunc = &completefunc
  endif
  setlocal completefunc=LaTeXtoUnicode#completefunc

  let b:l2u_prev_map_tab = s:L2U_SetFallbackMapping('<Tab>', s:l2u_fallback_trigger)
  imap <buffer> <Tab> <Plug>L2UTab
  inoremap <buffer><expr> <Plug>L2UTab LaTeXtoUnicode#Tab()

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
  exec "setlocal completefunc=" . get(b:, "l2u_prev_completefunc", "")
  iunmap <buffer> <Tab>
  if empty(maparg("<Tab>", "i"))
    call s:L2U_ReinstateMapping(b:l2u_prev_map_tab)
  endif
  iunmap <buffer> <Plug>L2UTab
  exe 'iunmap <buffer> ' . s:l2u_fallback_trigger
  let b:l2u_tab_set = 0
endfunction

" Function which looks for viable LaTeX-to-Unicode supstitutions as you type
function! LaTeXtoUnicode#AutoSub(...)
  " avoid recursive calls
  if get(b:, "l2u_in_autosub", 0)
    return ''
  endif
  let vc = a:0 == 0 ? v:char : a:1
  " for some reason function keys seem to be passed as characters 149 (F1-F12)
  " or 186 (F13-F37, these are entered with shift/ctrl). In such cases, we
  " can't really do any better than giving up.
  if char2nr(vc) == 149 || char2nr(vc) == 186
    return ''
  endif
  let b:l2u_in_autosub = 1
  let col1 = col('.')
  let lnum = line('.')
  if col1 == 1
    if a:0 > 1
      call feedkeys(a:2, 'mi')
    endif
    let b:l2u_in_autosub = 0
    return ''
  endif
  let bs = (vc != "\n")
  let l = getline(lnum)[0 : col1-1-bs] . v:char
  let col0 = match(l, '\\\%([_^]\?[A-Za-z]\+\%' . col1 . 'c\%([^A-Za-z]\|$\)\|[_^]\%([0-9()=+-]\)\%' . col1 .'c\%(.\|$\)\)')
  if col0 == -1
    if a:0 > 1
      call feedkeys(a:2, 'mi')
    endif
    let b:l2u_in_autosub = 0
    return ''
  endif
  let base = l[col0 : col1-1-bs]
  let unicode = get(g:l2u_symbols_dict, base, '')
  if empty(unicode)
    if a:0 > 1
      call feedkeys(a:2, 'mi')
    endif
    let b:l2u_in_autosub = 0
    return ''
  endif

  " perform the substitution, wrapping it in undo breakpoints so that
  " we can revert it as a whole
  " at the end, reset the l2u_in_autosub variable without leaving insert mode
  " the 'i' mode is the only one that works correctly when executing macros
  " the 'n' mode is to avoid user-defined mappings of \b, <C-G> and <C-\><C-O>
  call feedkeys("\<C-G>u" .
             \  repeat("\b", len(base) + bs) . unicode . vc . s:l2u_esc_sequence .
             \  "\<C-G>u" .
             \  "\<C-\>\<C-O>:let b:l2u_in_autosub = 0\<CR>",
             \  'ni')
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

  let b:l2u_prev_map_cr = s:L2U_SetFallbackMapping('<CR>', s:l2u_fallback_trigger_cr)
  imap <buffer> <CR> <Plug>L2UAutoSub
  exec 'inoremap <buffer><expr> <Plug>L2UAutoSub LaTeXtoUnicode#AutoSub("\n", "' . s:l2u_fallback_trigger_cr . '")'

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
  if empty(maparg("<CR>", "i"))
    call s:L2U_ReinstateMapping(b:l2u_prev_map_cr)
  endif
  iunmap <buffer> <Plug>L2UAutoSub
  exe 'iunmap <buffer> ' . s:l2u_fallback_trigger_cr
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
  return ''
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
  return ''
endfunction
