let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/proto.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'protobuf') == -1

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

endif
