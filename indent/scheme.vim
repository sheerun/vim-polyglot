let files = filter(globpath(&rtp, 'indent/scheme.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
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
