if polyglot#init#is_disabled(expand('<sfile>:p'), 'jsx', 'after/indent/tsx.vim')
  finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim indent file
"
" Language: typescript.jsx
" Maintainer: MaxMellon <maxmellon1994@gmail.com>
" Depends: leafgarland/typescript-vim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if get(g:, 'vim_jsx_pretty_disable_tsx', 0)
  finish
endif

if exists('b:did_indent')
  let s:did_indent = b:did_indent
  unlet b:did_indent
endif

let s:keepcpo = &cpo
set cpo&vim

if exists('s:did_indent')
  let b:did_indent = s:did_indent
endif

runtime! indent/typescript.vim

setlocal indentexpr=GetJsxIndent()
setlocal indentkeys=0.,0{,0},0),0],0?,0\*,0\,,!^F,:,<:>,o,O,e,<>>,=*/

function! GetJsxIndent()
  return jsx_pretty#indent#get(function('GetTypescriptIndent'))
endfunction

let &cpo = s:keepcpo
unlet s:keepcpo
