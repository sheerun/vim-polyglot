if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  
" Vim filetype plugin file
" Language:     JavaScript
" Maintainer:   vim-javascript community
" URL:          https://github.com/pangloss/vim-javascript

setlocal iskeyword+=$ suffixesadd+=.js

let b:undo_ftplugin .= ' | setlocal iskeyword< suffixesadd<'

endif
