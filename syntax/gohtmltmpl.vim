if has_key(g:polyglot_is_disabled, 'go')
  finish
endif

if exists("b:current_syntax")
  finish
endif

if !exists("g:main_syntax")
  let g:main_syntax = 'html'
endif

runtime! syntax/gotexttmpl.vim
runtime! syntax/html.vim
unlet b:current_syntax

syn cluster htmlPreproc add=gotplAction,goTplComment

let b:current_syntax = "gohtmltmpl"

" vim: sw=2 ts=2 et
