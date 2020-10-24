let files = filter(globpath(&rtp, 'ftplugin/dockerfile.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dockerfile') == -1

" Vim filetype plugin
" Language:	Dockerfile
" Maintainer:   Honza Pokorny <http://honza.ca>
" Last Change:	2014 Aug 29

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

let b:undo_ftplugin = "setl commentstring<"

setlocal commentstring=#\ %s

endif
