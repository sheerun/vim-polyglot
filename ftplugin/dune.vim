let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/dune.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ocaml') == -1

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin=1

set lisp

" Comment string
setl commentstring=;\ %s
setl comments=:;

endif
