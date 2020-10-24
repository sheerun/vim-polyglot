let files = filter(globpath(&rtp, 'syntax/godebugstacktrace.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'go') == -1

if exists("b:current_syntax")
  finish
endif

syn match godebugStacktrace '^\S\+'

let b:current_syntax = "godebugoutput"

hi def link godebugStacktrace SpecialKey

" vim: sw=2 ts=2 et

endif
