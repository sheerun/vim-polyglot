if !exists('g:polyglot_disabled') || !(index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'jsx') != -1)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim indent file
"
" Language: typescript.jsx
" Maintainer: MaxMellon <maxmellon1994@gmail.com>
" Depends: leafgarland/typescript-vim
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
setlocal indentkeys=0{,0},0),0],0\,,!^F,o,O,e,*<Return>,<>>,<<>,/

function! GetJsxIndent()
  return jsx_pretty#indent#get(function('GetTypescriptIndent'))
endfunction

let &cpo = s:keepcpo
unlet s:keepcpo

endif
