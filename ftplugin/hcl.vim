if polyglot#init#is_disabled(expand('<sfile>:p'), 'terraform', 'ftplugin/hcl.vim')
  finish
endif

" hcl.vim - basic vim/hcl integration
" Maintainer: HashiVim <https://github.com/hashivim>

if exists('b:did_ftplugin') || v:version < 700 || &compatible
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpoptions
set cpoptions&vim

" j is a relatively recent addition; silence warnings when setting it.
setlocal formatoptions-=t formatoptions+=croql
silent! setlocal formatoptions+=j
let b:undo_ftplugin = 'setlocal formatoptions<'

if !has('patch-7.4.1142')
  " Include hyphens as keyword characters so that a keyword appearing as
  " part of a longer name doesn't get partially highlighted.
  setlocal iskeyword+=-
  let b:undo_ftplugin .= ' iskeyword<'
endif

if get(g:, 'hcl_fold_sections', 0)
  setlocal foldmethod=syntax
  let b:undo_ftplugin .= ' foldmethod<'
endif

" Set the commentstring
setlocal commentstring=#%s
let b:undo_ftplugin .= ' commentstring<'

if get(g:, 'hcl_align', 0) && exists(':Tabularize')
  inoremap <buffer> <silent> = =<Esc>:call hcl#align()<CR>a
  let b:undo_ftplugin .= '|iunmap <buffer> ='
endif

let &cpoptions = s:cpo_save
unlet s:cpo_save
