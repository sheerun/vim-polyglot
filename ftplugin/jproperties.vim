let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/jproperties.vim', 1, 1), Filter)
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
