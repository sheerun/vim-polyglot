if has_key(g:polyglot_is_disabled, 'ocaml')
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
