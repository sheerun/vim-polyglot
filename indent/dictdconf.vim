let files = filter(globpath(&rtp, 'indent/dictdconf.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dictdconf') == -1

" Vim indent file
" Language:             dictd(8) configuration file
" Previous Maintainer:  Nikolai Weibull <now@bitwi.se>
" Latest Revision:      2006-12-20

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentkeys=0{,0},!^F,o,O cinwords= autoindent smartindent
setlocal nosmartindent
inoremap <buffer> # X#

endif
