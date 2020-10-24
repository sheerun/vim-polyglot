let files = filter(globpath(&rtp, 'compiler/credo.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elixir') == -1

if exists('current_compiler')
    finish
endif
let current_compiler = 'credo'

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet errorformat=%f:%l:%c:\ %t:\ %m,%f:%l:\ %t:\ %m
CompilerSet makeprg=mix\ credo\ suggest\ --format=flycheck

endif
