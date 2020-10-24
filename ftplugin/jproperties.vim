let files = filter(globpath(&rtp, 'ftplugin/jproperties.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jproperties') == -1

" Vim filetype plugin
" Language:	Java properties file
" Maintainer:	None
" Last Change:	2019 Dec 01

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal formatoptions-=t
setlocal comments=:#,:!
setlocal commentstring=#\ %s

let b:undo_ftplugin = "setl cms< com< fo<"

endif
