let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/chaskell.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'chaskell') == -1

" Vim syntax file
" Language:	Haskell supporting c2hs binding hooks
" Maintainer:	Armin Sander <armin@mindwalker.org>
" Last Change:	2001 November 1
"
" 2001 November 1: Changed commands for sourcing haskell.vim

" Enable binding hooks
let b:hs_chs=1

" Include standard Haskell highlighting
runtime! syntax/haskell.vim

" vim: ts=8

endif
