let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/logtalk.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'logtalk') == -1

" Logtalk filetype plugin file
" Language:         Logtalk
" Maintainer:       Paulo Moura <pmoura@logtalk.org>
" Latest Revision:  2018-08-03

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = "setl ts< sw< fdm< fdc< ai< dict<"

setlocal ts=4
setlocal sw=4
setlocal fdm=syntax
setlocal fdn=10
setlocal fdc=2
setlocal autoindent
setlocal dict=$VIMRUNTIME/ftplugin/logtalk.dict

endif
