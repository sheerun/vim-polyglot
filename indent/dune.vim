let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/dune.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ocaml') == -1

" Vim indent file
" Language: dune

if exists("b:did_indent")
 finish
endif
let b:did_indent = 1

" dune format-dune-file uses 1 space to indent
set softtabstop=1 shiftwidth=1 expandtab

endif
