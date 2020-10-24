let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/text.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'text') == -1

" Vim filetype plugin
" Language:		Text
" Maintainer:		David Barnett <daviebdawg+vim@gmail.com>
" Last Change:		2019 Jan 10

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = 'setlocal comments< commentstring<'

" We intentionally don't set formatoptions-=t since text should wrap as text.

" Pseudo comment leaders to indent bulleted lists with '-' and '*'.  And allow
" for Mail quoted text with '>'.
setlocal comments=fb:-,fb:*,n:>
setlocal commentstring=

endif
