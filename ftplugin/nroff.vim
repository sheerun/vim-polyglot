let files = filter(globpath(&rtp, 'ftplugin/nroff.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nroff') == -1

" Vim filetype plugin
" Language:	roff(7)
" Maintainer:	Chris Spiegel <cspiegel@gmail.com>
" Last Change:	2019 Apr 24

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal commentstring=.\\\"%s

endif
