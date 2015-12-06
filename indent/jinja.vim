if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jinja') == -1
  
" Vim indent file
" Language:	Jinja HTML template
" Maintainer:	Evan Hammer <evan@evanhammer.com>
" Last Change:	2013 Jan 26

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif

" Use HTML formatting rules.
runtime! indent/html.vim

endif
