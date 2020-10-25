if has_key(g:polyglot_is_disabled, 'razor')
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
