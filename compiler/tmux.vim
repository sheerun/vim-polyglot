if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'tmux') == -1
  
if exists("current_compiler")
  finish
endif
let current_compiler = "tmux"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=tmux\ source-file\ %:p

CompilerSet errorformat=
    \%f:%l:%m,
    \%+Gunknown\ command:\ %s

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8:

endif
