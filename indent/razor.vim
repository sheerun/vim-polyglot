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
