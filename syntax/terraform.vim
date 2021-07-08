if polyglot#init#is_disabled(expand('<sfile>:p'), 'terraform', 'syntax/terraform.vim')
  finish
endif

if exists('b:current_syntax')
  finish
endif
runtime! syntax/hcl.vim
unlet b:current_syntax

syn keyword terraType           string bool number object tuple list map set any

hi def link terraType           Type

let b:current_syntax = 'terraform'
