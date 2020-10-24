let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/scheme.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'scheme') == -1

" Vim indent file
" Language: Scheme
" Last Change: 2018 Jan 31
" Maintainer: Evan Hanson <evhan@foldling.org>
" Previous Maintainer: Sergey Khorev <sergey.khorev@gmail.com>
" URL: https://foldling.org/vim/indent/scheme.vim

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif

" Use the Lisp indenting
runtime! indent/lisp.vim

endif
