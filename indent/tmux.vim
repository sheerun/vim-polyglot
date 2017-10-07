if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'tmux') == -1
  
if exists("b:did_indent")
    finish
endif
let b:did_indent = 1
let b:current_indent = "tmux"

setlocal nosmartindent

setlocal indentexpr=GetTmuxIndent()

setlocal indentkeys=o

" Only define the function once.
if exists("*GetTmuxIndent")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

function! s:highlight_group(line, col)
  return synIDattr(synID(a:line, a:col, 1), "name")
endfunction

function! s:prev_line_ends_with_open_string(lnum)
  if a:lnum > 1
    let prev_line_len = len(getline(a:lnum - 1))
    if s:highlight_group(a:lnum - 1, prev_line_len) ==# 'tmuxString'
      return 1
    endif
  endif
  return 0
endfunction

function! GetTmuxIndent()
  " If the string is not closed and was previously indented, then keep the
  " indentation.
  if s:prev_line_ends_with_open_string(v:lnum)
    return indent('.')
  else
    return 0
  endif
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2 ts=8 et:

endif
