if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nim') == -1

if exists("current_compiler")
  finish
endif

let current_compiler = "nim"

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=nim\ c\ --verbosity:0\ --listfullpaths\ $*\ %:p

CompilerSet errorformat=
  \%-GHint:\ %m,
  \%E%f(%l\\,\ %c)\ Error:\ %m,
  \%W%f(%l\\,\ %c)\ Hint:\ %m

let &cpo = s:cpo_save
unlet s:cpo_save

let g:syntastic_nim_checkers = ['nim']


endif
