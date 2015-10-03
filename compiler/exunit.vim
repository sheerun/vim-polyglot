" Vim compiler file
" Language:     ExUnit
" Maintainer:   Rein Henrichs <rein.henrichs@gmail.com>
" URL:          https://github.com/elixir-lang/vim-elixir

if exists("current_compiler")
  finish
endif
let current_compiler = "exunit"

if exists(":CompilerSet") != 2    " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=mix\ test
CompilerSet errorformat=%A\ \ %.)\ %m(%.%#),%C\ \ \ \ \ **%m,%C\ \ \ \ \ \ \ %m,%Z\ \ \ \ \ at\ %f:%l,%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8:
