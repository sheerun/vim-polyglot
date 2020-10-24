let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'compiler/nix-build.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nix') == -1

if exists('current_compiler')
    finish
endif
let current_compiler = 'nix-build'

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet errorformat=error:\ %m\ at\ %f:%l:%c,builder\ for\ \'%m\'\ failed\ with\ exit\ code\ %n,fixed-output\ derivation\ produced\ path\ \'%s\'\ with\ %m
CompilerSet makeprg=nix-build

endif
