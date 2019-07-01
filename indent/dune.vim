if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'ocaml') != -1
  finish
endif

" Vim indent file
" Language: dune

if exists("b:did_indent")
 finish
endif
let b:did_indent = 1

" dune format-dune-file uses 1 space to indent
set softtabstop=1 shiftwidth=1 expandtab
