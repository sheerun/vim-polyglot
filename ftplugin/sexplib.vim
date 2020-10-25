if has_key(g:polyglot_is_disabled, 'ocaml')
  finish
endif

" Language:    Sexplib
" Maintainer:  Markus Mottl        <markus.mottl@gmail.com>
" URL:         http://www.ocaml.info/vim/ftplugin/sexplib.vim
" Last Change:
"              2017 Apr 12 - First version (MM)

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin=1

" Comment string
setl commentstring=;\ %s
setl comments=:;
