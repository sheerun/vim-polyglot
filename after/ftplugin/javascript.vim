if !exists('g:polyglot_disabled') || (index(g:polyglot_disabled, 'javascript') == -1 && index(g:polyglot_disabled, 'jsx') == -1)

if get(g:, 'vim_jsx_pretty_disable_js', 0)
  finish
endif

source <sfile>:h/jsx.vim

endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1

" Vim filetype plugin file
" Language:     JavaScript
" Maintainer:   vim-javascript community
" URL:          https://github.com/pangloss/vim-javascript

setlocal iskeyword+=$ suffixesadd+=.js

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | setlocal iskeyword< suffixesadd<'
else
  let b:undo_ftplugin = 'setlocal iskeyword< suffixesadd<'
endif

endif
