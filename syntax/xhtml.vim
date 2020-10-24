let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/xhtml.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'xhtml') == -1

" Vim syntax file
" Language:	XHTML
" Maintainer:	noone
" Last Change:	2003 Feb 04

" Load the HTML syntax for now.
runtime! syntax/html.vim

let b:current_syntax = "xhtml"

" vim: ts=8

endif
