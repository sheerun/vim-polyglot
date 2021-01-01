if polyglot#init#is_disabled(expand('<sfile>:p'), 'razor', 'indent/razor.vim')
  finish
endif

" Vim indent file
" Language:	    Razor
" Maintainer:	Adam Clark <adamclerk@gmail.com>
" Last Change:	2013 Jan 24

if exists("b:did_indent")
  finish
endif
runtime! indent/html.vim
runtime! indent/javscript.vim
