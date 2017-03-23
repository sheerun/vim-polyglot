if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vue') == -1
  
" Vim filetype plugin
" Language: Vue.js
" Maintainer: Eduardo San Martin Morote
" Author: Adriaan Zonnenberg

if exists("b:did_ftplugin")
  finish
endif

runtime! ftplugin/html.vim

setlocal suffixesadd+=.vue

endif
