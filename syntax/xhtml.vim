if polyglot#init#is_disabled(expand('<sfile>:p'), 'xhtml', 'syntax/xhtml.vim')
  finish
endif

" Vim syntax file
" Language:	XHTML
" Maintainer:	noone
" Last Change:	2003 Feb 04

" Load the HTML syntax for now.
runtime! syntax/html.vim

let b:current_syntax = "xhtml"

" vim: ts=8
