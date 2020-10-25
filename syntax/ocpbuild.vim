if has_key(g:polyglot_is_disabled, 'ocaml')
  finish
endif

" Vim syntax file
" Language: ocp-build files
" Maintainer: Florent Monnier
" Latest Revision: 14 September 2013

if exists("b:current_syntax")
  finish
endif

syn keyword ocpKeywords  begin end pack
syn keyword ocpKeywords  if then else

syn keyword ocpBlockKind  library syntax objects program test

syn keyword ocpFields  files generated dirname archive
syn keyword ocpFields  requires bundle
syn keyword ocpFields  tests test_dir test_args test_benchmark
syn keyword ocpFields  bytecomp bytelink link
syn keyword ocpFields  has_asm nopervasives sort
syn keyword ocpFields  comp ccopt byte has_byte
syn keyword ocpFields  version authors license copyright
syn keyword ocpFields  lib_files install installed

syn keyword ocpPreProc  test_exit ocp2ml env_strings
syn keyword ocpPreProc  ocaml_major_version
syn keyword ocpPreProc  system

" Strings
syn region ocpString    start=+"+ end=+"+

" Comments
syn keyword ocpTodo     TODO XXX FIXME BUG contained
syn region  ocpComment  start="(\*" end="\*)" contains=ocpTodo

" Usual Values
syn keyword ocpNumber None
syn keyword ocpNumber true
syn keyword ocpNumber false

hi def link ocpTodo         Todo
hi def link ocpComment      Comment
hi def link ocpString       String
hi def link ocpBlockKind    Identifier
hi def link ocpNumber       Number
hi def link ocpFields       Structure
hi def link ocpKeywords     Keyword
hi def link ocpPreProc      PreProc

let b:current_syntax = "ocpbuild"

