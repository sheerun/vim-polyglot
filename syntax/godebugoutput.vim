let files = filter(globpath(&rtp, 'syntax/godebugoutput.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
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
