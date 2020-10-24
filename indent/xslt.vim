let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/xslt.vim', 1, 1), Filter)
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
