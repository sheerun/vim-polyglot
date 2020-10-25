if !polyglot#util#IsEnabled('ocaml', expand('<sfile>:p'))
  finish
endif

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin=1

set lisp

" Comment string
setl commentstring=;\ %s
setl comments=:;
