let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/lisp.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'lisp') == -1

" Vim indent file
" Language:	Lisp
" Maintainer:    Sergey Khorev <sergey.khorev@gmail.com>
" URL:		 http://sites.google.com/site/khorser/opensource/vim
" Last Change:	2012 Jan 10

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

setlocal ai nosi

let b:undo_indent = "setl ai< si<"

endif
