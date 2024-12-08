if polyglot#init#is_disabled(expand('<sfile>:p'), 'jq', 'ftplugin/jq.vim')
  finish
endif

" Vim compiler file
" Language:	jq
" Maintainer:	Vito <vito.blog@gmail.com>
" Last Change:	2024 Apr 17
" Upstream: https://github.com/vito-c/jq.vim

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = 'setl inc< commentstring<'

setlocal include=^\\s*\\%(import\\\|include\\)
setlocal commentstring=#%s
compiler jq
