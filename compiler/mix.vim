let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'compiler/mix.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
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
