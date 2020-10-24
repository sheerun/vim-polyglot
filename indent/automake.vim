let files = filter(globpath(&rtp, 'indent/automake.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'automake') == -1

" Vim indent file
" Language:    	    automake
" Previous Maintainer:  Nikolai Weibull <now@bitwi.se>
" Latest Revision:      2006-04-19

if exists("b:did_indent")
  finish
endif

" same as makefile indenting for now.
runtime! indent/make.vim

endif
