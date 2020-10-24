let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'compiler/fish.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'fish') == -1

if exists('current_compiler')
    finish
endif
let current_compiler = 'fish'

CompilerSet makeprg=fish\ --no-execute\ %
execute 'CompilerSet errorformat='.escape(fish#errorformat(), ' ')

endif
