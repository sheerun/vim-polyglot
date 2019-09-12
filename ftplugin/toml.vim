if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'toml') == -1

" File: ftplugin/toml.vim
" Author: Kevin Ballard <kevin@sb.org>
" Description: FileType Plugin for Toml
" Last Change: Feb 12, 2019

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim
let b:undo_ftplugin = 'setlocal commentstring< comments<'

setlocal commentstring=#\ %s
setlocal comments=:#

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sw=4 ts=4:

endif
