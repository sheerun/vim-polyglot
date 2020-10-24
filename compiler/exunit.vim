let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'compiler/exunit.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elixir') == -1

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
CompilerSet errorformat=
  \%E\ \ %n)\ %m,
  \%+G\ \ \ \ \ **\ %m,
  \%+G\ \ \ \ \ stacktrace:,
  \%C\ \ \ \ \ %f:%l,
  \%+G\ \ \ \ \ \ \ (%\\w%\\+)\ %f:%l:\ %m,
  \%+G\ \ \ \ \ \ \ %f:%l:\ %.%#,
  \**\ (%\\w%\\+)\ %f:%l:\ %m

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8:

endif
