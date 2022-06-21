if polyglot#init#is_disabled(expand('<sfile>:p'), 'bicep', 'ftplugin/bicep.vim')
  finish
endif

" bicep.vim - basic bicep integration
" Maintainer: Carl Smedstad <carl.smedstad at protonmail dot com>

if exists('b:did_ftplugin') || v:version < 700 || &compatible
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpoptions
set cpoptions&vim

" Set the commentstring
setlocal commentstring=//%s
let b:undo_ftplugin = 'setlocal commentstring<'

let &cpoptions = s:cpo_save
unlet s:cpo_save
