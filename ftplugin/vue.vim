if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vue') == -1

" Vim filetype plugin
" Language: Vue.js
" Maintainer: Eduardo San Martin Morote
" Author: Adriaan Zonnenberg

if exists('b:did_ftplugin')
  finish
endif

runtime! ftplugin/html.vim

setlocal suffixesadd+=.vue

if !exists('g:no_plugin_maps') && !exists('g:no_vue_maps')
  nnoremap <silent> <buffer> [[ :call search('^<\(template\<Bar>script\<Bar>style\)', 'bW')<CR>
  nnoremap <silent> <buffer> ]] :call search('^<\(template\<Bar>script\<Bar>style\)', 'W')<CR>
  nnoremap <silent> <buffer> [] :call search('^</\(template\<Bar>script\<Bar>style\)', 'bW')<CR>
  nnoremap <silent> <buffer> ][ :call search('^</\(template\<Bar>script\<Bar>style\)', 'W')<CR>
endif

endif
