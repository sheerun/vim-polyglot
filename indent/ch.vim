let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/ch.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ch') == -1

" Vim indent file
" Language:	Ch
" Maintainer:	SoftIntegration, Inc. <info@softintegration.com>
" URL:		http://www.softintegration.com/download/vim/indent/ch.vim
" Last change:	2006 Apr 30
"		Created based on cpp.vim
"
" Ch is a C/C++ interpreter with many high level extensions


" Only load this indent file when no other was loaded.
if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

" Ch indenting is built-in, thus this is very simple
setlocal cindent

endif
