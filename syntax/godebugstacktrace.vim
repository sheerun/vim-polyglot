if polyglot#init#is_disabled(expand('<sfile>:p'), 'go', 'syntax/godebugstacktrace.vim')
  finish
endif

if exists("b:current_syntax")
  finish
endif

syn match godebugStacktrace '^\S\+'

let b:current_syntax = "godebugoutput"

hi def link godebugStacktrace SpecialKey

" vim: sw=2 ts=2 et
