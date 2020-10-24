let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/tt2html.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'perl') == -1

" Language:      TT2 embedded with HTML
" Maintainer:    vim-perl <vim-perl@googlegroups.com>
" Author:        Moriki, Atsushi <4woods+vim@gmail.com>
" Homepage:      http://github.com/vim-perl/vim-perl
" Bugs/requests: http://github.com/vim-perl/vim-perl/issues
" Last Change:   {{LAST_CHANGE}}

if exists("b:current_syntax")
    finish
endif

runtime! syntax/html.vim
unlet b:current_syntax

runtime! syntax/tt2.vim
unlet b:current_syntax

syn cluster htmlPreProc add=@tt2_top_cluster

let b:current_syntax = "tt2html"

endif
