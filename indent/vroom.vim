let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/vroom.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vroom') == -1

" Vim indent file
" Language:	Vroom (vim testing and executable documentation)
" Maintainer:	David Barnett (https://github.com/google/vim-ft-vroom)
" Last Change:	2014 Jul 23

if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

let s:cpo_save = &cpo
set cpo-=C


let b:undo_indent = 'setlocal autoindent<'

setlocal autoindent


let &cpo = s:cpo_save
unlet s:cpo_save

endif
