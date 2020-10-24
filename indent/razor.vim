let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/razor.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'razor') == -1

" Vim indent file
" Language:	    Razor
" Maintainer:	Adam Clark <adamclerk@gmail.com>
" Last Change:	2013 Jan 24

if exists("b:did_indent")
  finish
endif
runtime! indent/html.vim
runtime! indent/javscript.vim

endif
