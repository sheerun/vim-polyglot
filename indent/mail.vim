let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/mail.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'mail') == -1

" Vim indent file
" Language:	Mail
" Maintainer:	Bram Moolenaar
" Last Change:	2009 Jun 03

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" What works best is auto-indenting, disable other indenting.
" For formatting see the ftplugin.
setlocal autoindent nosmartindent nocindent indentexpr=

endif
