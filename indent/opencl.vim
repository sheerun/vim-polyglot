" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif

if version > 600
  runtime! indent/c.vim
endif

let b:did_indent = 1
