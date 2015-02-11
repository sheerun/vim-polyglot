" File: ftplugin/toml.vim
" Author: Kevin Ballard <kevin@sb.org>
" Description: FileType Plugin for Toml
" Last Change: Dec 09, 2014

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

setlocal commentstring=#\ %s

" Add NERDCommenter delimiters

let s:delims = { 'left': '#' }
if exists('g:NERDDelimiterMap')
    if !has_key(g:NERDDelimiterMap, 'toml')
        let g:NERDDelimiterMap.toml = s:delims
    endif
elseif exists('g:NERDCustomDelimiters')
    if !has_key(g:NERDCustomDelimiters, 'toml')
        let g:NERDCustomDelimiters.toml = s:delims
    endif
else
    let g:NERDCustomDelimiters = { 'toml': s:delims }
endif
unlet s:delims

let b:undo_ftplugin = ""

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sw=4 ts=4:
