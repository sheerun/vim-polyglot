if polyglot#init#is_disabled(expand('<sfile>:p'), 'basic', 'indent/basic.vim')
  finish
endif

" Vim indent file
" Language:	BASIC (QuickBASIC 4.5)
" Maintainer:	Doug Kearns <dougkearns@gmail.com>
" Last Change:	2022 Jan 24

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif

runtime! indent/vb.vim
