let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/bsdl.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'bsdl') == -1

" Vim syntax file
" Language:	Boundary Scan Description Language (BSDL)
" Maintainer:	Daniel Kho <daniel.kho@logik.haus>
" Last Changed:	2020 Mar 19 by Daniel Kho

" quit when a syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

" Read in VHDL syntax files
runtime! syntax/vhdl.vim
unlet b:current_syntax

let b:current_syntax = "bsdl"

" vim: ts=8

endif
