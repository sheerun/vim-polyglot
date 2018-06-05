if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elixir') == -1
  
if exists('current_compiler')
    finish
endif
let current_compiler = 'mix'

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet errorformat=%A%t%*[^:]:\ %m,%C%f:%l:\ %m,%C%f:%l,%Z
CompilerSet makeprg=mix

endif
