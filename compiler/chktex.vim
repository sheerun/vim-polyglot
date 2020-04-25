if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'latex') == -1

if exists('current_compiler') | finish | endif
let current_compiler = 'chktex'

" Older Vim always used :setlocal
if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=chktex\ --localrc\ --inputfiles\ --quiet\ -v6\ %:S
CompilerSet errorformat="%f",\ line\ %l.%c:\ %m

let &cpo = s:cpo_save
unlet s:cpo_save

endif
