let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/bzl.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'bzl') == -1

" Vim syntax file
" Language:	Bazel (http://bazel.io)
" Maintainer:	David Barnett (https://github.com/google/vim-ft-bzl)
" Last Change:	2015 Aug 11

if exists('b:current_syntax')
  finish
endif


runtime! syntax/python.vim

let b:current_syntax = 'bzl'

syn region bzlRule start='^\w\+($' end='^)\n*' transparent fold
syn region bzlList start='\[' end='\]' transparent fold

endif
