let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/sexplib.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ocaml') == -1

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

endif
