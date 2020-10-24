let files = filter(globpath(&rtp, 'ftplugin/gdb.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'gdb') == -1

" Vim filetype plugin file
" Language:	gdb
" Maintainer:	Michaël Peeters <NOSPAMm.vim@noekeon.org>
" Last Changed: 26 Oct 2017

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

setlocal commentstring=#%s

" Undo the stuff we changed.
let b:undo_ftplugin = "setlocal cms<"

endif
