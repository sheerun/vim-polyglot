if polyglot#init#is_disabled(expand('<sfile>:p'), 'gitignore', 'ftplugin/gitignore.vim')
  finish
endif

scriptencoding utf-8

" Copyright (c) 2017-2020 Filip Szymański. All rights reserved.
" Use of this source code is governed by an MIT license that can be
" found in the LICENSE file.

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

setlocal commentstring=#\ %s

let b:undo_ftplugin = 'setlocal commentstring<'

" vim: ts=2 et sw=2
