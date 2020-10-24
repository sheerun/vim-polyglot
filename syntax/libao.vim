let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/libao.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'libao') == -1

" Vim syntax file
" Language:             libao.conf(5) configuration file
" Previous Maintainer:  Nikolai Weibull <now@bitwi.se>
" Latest Revision:      2006-04-19

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn keyword libaoTodo     contained TODO FIXME XXX NOTE

syn region  libaoComment  display oneline start='^\s*#' end='$'
                          \ contains=libaoTodo,@Spell

syn keyword libaoKeyword  default_driver

hi def link libaoTodo     Todo
hi def link libaoComment  Comment
hi def link libaoKeyword  Keyword

let b:current_syntax = "libao"

let &cpo = s:cpo_save
unlet s:cpo_save

endif
