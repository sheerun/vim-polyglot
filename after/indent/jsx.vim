if has_key(g:polyglot_is_disabled, 'jsx')
  finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim indent file
"
" Language: javascript.jsx
" Maintainer: MaxMellon <maxmellon1994@gmail.com>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists('b:did_indent')
  let s:did_indent = b:did_indent
  unlet b:did_indent
endif

let s:keepcpo = &cpo
set cpo&vim

if exists('s:did_indent')
  let b:did_indent = s:did_indent
endif

setlocal indentexpr=GetJsxIndent()
setlocal indentkeys=0.,0{,0},0),0],0?,0\*,0\,,!^F,:,<:>,o,O,e,<>>,=*/

function! GetJsxIndent()
  return jsx_pretty#indent#get(function('GetJavascriptIndent'))
endfunction

let &cpo = s:keepcpo
unlet s:keepcpo
