if polyglot#init#is_disabled(expand('<sfile>:p'), 'puppet', 'compiler/puppet-lint.vim')
  finish
endif

" Vim compiler file
" Compiler:	puppet-lint
" Maintainer:	Doug Kearns <dougkearns@gmail.com>

if exists("current_compiler")
  finish
endif
let current_compiler = "puppet-lint"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=puppet-lint\ --with-filename
CompilerSet errorformat=%f\ -\ %tRROR:\ %m\ on\ line\ %l,
		       \%f\ -\ %tARNING:\ %m\ on\ line\ %l,
		       \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
