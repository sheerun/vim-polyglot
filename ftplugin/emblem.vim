let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/emblem.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'emblem') == -1

" Language:    emblem
" Maintainer:  Yulij Andreevich Lesov <yalesov@gmail.com>
" URL:         http://github.com/yalesov/vim-emblem
" Version:     2.0.1
" Last Change: 2016 Jul 6
" License:     ISC

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal smarttab
setlocal expandtab
setlocal smartindent

setlocal formatoptions=q
setlocal comments=:/
setlocal commentstring=/\ %s

endif
