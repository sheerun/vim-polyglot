if polyglot#init#is_disabled(expand('<sfile>:p'), 'puppet', 'ftplugin/puppet.vim')
  finish
endif

" Vim filetype plugin
" Language:             Puppet
" Maintainer:           Tim Sharpe <tim@sharpe.id.au>
" URL:                  https://github.com/rodjek/vim-puppet
" Last Change:          2019-08-31

if (exists('b:did_ftplugin'))
  finish
endif
let b:did_ftplugin = 1

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal keywordprg=puppet\ describe\ --providers
setlocal comments=sr:/*,mb:*,ex:*/,b:#
setlocal commentstring=#\ %s
" adding : to iskeyword is tempting in order to make word movements skip over a
" full resource name, however since : is used in many non-keyword contexts it
" is a bad idea to add it to the option.

setlocal formatoptions-=t formatoptions+=croql
setlocal formatexpr=puppet#format#Format()

let b:undo_ftplugin = '
    \ setlocal tabstop< tabstop< softtabstop< shiftwidth< expandtab<
    \| setlocal keywordprg< iskeyword< comments< commentstring<
    \| setlocal formatoptions< formatexpr<
    \'
