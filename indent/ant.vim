let files = filter(globpath(&rtp, 'indent/ant.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ant') == -1

" Vim indent file
" Language:    ANT files
" Maintainer:  David Fishburn <fishburn@ianywhere.com>
" Last Change: Thu May 15 2003 10:02:54 PM

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif

" Use XML formatting rules
runtime! indent/xml.vim

endif
