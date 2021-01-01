if polyglot#init#is_disabled(expand('<sfile>:p'), 'gleam', 'ftplugin/gleam.vim')
  finish
endif


if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

compiler gleam

setlocal commentstring=//%s
setlocal formatoptions-=t formatoptions+=croqnl

setlocal comments=s0:/*!,ex:*/,s1:/*,mb:*,ex:*/,:////,:///,://

" j was only added in 7.3.541, so stop complaints about its nonexistence
silent! setlocal formatoptions+=j

" smartindent will be overridden by indentexpr if filetype indent is on, but
" otherwise it's better than nothing.
setlocal smartindent nocindent

setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
setlocal textwidth=79

setlocal suffixesadd=.gleam

augroup gleam.vim
autocmd!
augroup END
