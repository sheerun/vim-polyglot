if polyglot#init#is_disabled(expand('<sfile>:p'), 'gitignore', 'autoload/fzf_gitignore.vim')
  finish
endif

scriptencoding utf-8

" Copyright (c) 2017-2020 Filip Szymański. All rights reserved.
" Use of this source code is governed by an MIT license that can be
" found in the LICENSE file.

function! s:template_sink(templates) abort
  try
    let l:lines = _fzf_gitignore_create(a:templates)
  catch /^Vim(\(let\|return\)):/
    return
  endtry

  new
  setlocal filetype=gitignore

  call setline(1, l:lines)

  $-2,$delete _
  normal! gg
endfunction

function! fzf_gitignore#run() abort
  try
    let l:opts = {
          \ 'source': _fzf_gitignore_get_all_templates(),
          \ 'sink*': function('s:template_sink'),
          \ 'options': '-m --prompt="Template> " --header="gitignore.io"'
          \ }
  catch /^Vim(\(let\|return\)):/
    return
  endtry

  call fzf#run(fzf#wrap(l:opts))
endfunction

" vim: ts=2 et sw=2
