let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/xsd.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'xsd') == -1

" Vim indent file
" Language: 	.xsd files (XML Schema)
" Maintainer:	Nobody
" Last Change:	2005 Jun 09

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif

" Use XML formatting rules
runtime! indent/xml.vim


endif
