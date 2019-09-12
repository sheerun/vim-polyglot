if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'hcl') == -1

" File: ftplugin/hcl.vim
" Author: BABAROT <b4b4r07@gmail.com>
" Description: FileType Plugin for HCL
" Last Change: Nob 05, 2015

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
    if !has_key(g:NERDDelimiterMap, 'hcl')
        let g:NERDDelimiterMap.hcl = s:delims
    endif
elseif exists('g:NERDCustomDelimiters')
    if !has_key(g:NERDCustomDelimiters, 'hcl')
        let g:NERDCustomDelimiters.hcl = s:delims
    endif
else
    let g:NERDCustomDelimiters = { 'hcl': s:delims }
endif
unlet s:delims

let b:undo_ftplugin = ""

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sw=4 ts=4:

endif
