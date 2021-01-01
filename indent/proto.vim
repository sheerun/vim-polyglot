if polyglot#init#is_disabled(expand('<sfile>:p'), 'protobuf', 'indent/proto.vim')
  finish
endif

" Vim indent file
" Language:	Protobuf
" Maintainer:	Johannes Zellner <johannes@zellner.org>
" Last Change:	Fri, 15 Mar 2002 07:53:54 CET

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

" Protobuf is like indenting C
setlocal cindent
setlocal expandtab
setlocal shiftwidth=2

let b:undo_indent = "setl cin<"
