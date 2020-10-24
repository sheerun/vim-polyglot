let files = filter(globpath(&rtp, 'ftplugin/kotlin.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'kotlin') == -1

if exists('b:did_ftplugin') | finish | endif
let b:did_ftplugin = 1

setlocal comments=://
setlocal commentstring=//\ %s

endif
