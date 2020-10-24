let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/abap.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'abap') == -1

" Vim filetype plugin file
" Language:	ABAP
" Author:	Steven Oliver <oliver.steven@gmail.com>
" Copyright:	Copyright (c) 2013 Steven Oliver
" License:	You may redistribute this under the same terms as Vim itself
" --------------------------------------------------------------------------

" Only do this when not done yet for this buffer
if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal softtabstop=2 shiftwidth=2
setlocal suffixesadd=.abap

" Windows allows you to filter the open file dialog
if has("gui_win32") && !exists("b:browsefilter")
  let b:browsefilter = "ABAP Source Files (*.abap)\t*.abap\n" .
                     \ "All Files (*.*)\t*.*\n"
endif

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: set sw=4 sts=4 et tw=80 :

endif
