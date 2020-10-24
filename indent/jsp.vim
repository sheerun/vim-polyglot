let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/jsp.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jsp') == -1

" Vim filetype indent file
" Language:    JSP files
" Maintainer:  David Fishburn <fishburn@ianywhere.com>
" Version:     1.0
" Last Change: Wed Nov 08 2006 11:08:05 AM

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
    finish
endif

" If there has been no specific JSP indent script created, 
" use the default html indent script which will handle
" html, javascript and most of the JSP constructs.
runtime! indent/html.vim



endif
