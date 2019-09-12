if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elixir') == -1

if exists('current_compiler')
    finish
endif
let current_compiler = 'mix'

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=mix\ compile
CompilerSet errorformat=
            \%Wwarning:\ %m,
            \%C%f:%l,%Z,
            \%E==\ Compilation\ error\ in\ file\ %f\ ==,
            \%C**\ (%\\w%\\+)\ %f:%l:\ %m,%Z


endif
