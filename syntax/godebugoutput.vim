let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/godebugoutput.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'go') == -1

if exists("b:current_syntax")
  finish
endif

syn match godebugOutputErr '^ERR:.*'
syn match godebugOutputOut '^OUT:.*'

let b:current_syntax = "godebugoutput"

hi def link godebugOutputErr Comment
hi def link godebugOutputOut Normal

" vim: sw=2 ts=2 et

endif
