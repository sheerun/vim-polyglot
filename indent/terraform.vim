if polyglot#init#is_disabled(expand('<sfile>:p'), 'terraform', 'indent/terraform.vim')
  finish
endif

" Only load this file if no other indent file was loaded
if exists('b:did_indent')
  finish
endif
runtime! indent/hcl.vim
