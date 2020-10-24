let files = filter(globpath(&rtp, 'indent/xslt.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'xslt') == -1

" Vim indent file
" Language:    XSLT .xslt files
" Maintainer:  David Fishburn <fishburn@ianywhere.com>
" Last Change: Wed May 14 2003 8:48:41 PM

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif

" Use XML formatting rules
runtime! indent/xml.vim


endif
