if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'meson') == -1
  
" Vim filetype plugin file
" Language:	meson
" Original Author:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
" Last Change:		2018 Nov 27

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1
let s:keepcpo= &cpo
set cpo&vim

setlocal shiftwidth=2
setlocal softtabstop=2

let &cpo = s:keepcpo
unlet s:keepcpo

endif
