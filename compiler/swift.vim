if polyglot#init#is_disabled(expand('<sfile>:p'), 'swift', 'compiler/swift.vim')
  finish
endif

" Vim compiler file
" Compiler:         Swift Compiler
" Maintainer:       Ayman Bagabas <ayman.bagabas@gmail.com>
" Latest Revision:  2020 Feb 16

if exists("current_compiler")
    finish
endif
let current_compiler = "swiftc"

" vint: -ProhibitAbbreviationOption
let s:save_cpo = &cpo
set cpo&vim
" vint: +ProhibitAbbreviationOption

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

if has('patch-7.4.191')
    CompilerSet makeprg=swiftc\ \%:S
else
    CompilerSet makeprg=swiftc\ \%
endif

CompilerSet errorformat=
                \%E%f:%l:%c:\ %trror:\ %m,
                \%W%f:%l:%c:\ %tarning:\ %m,
                \%I%f:%l:%c:\ note:\ %m,
                \%E%f:%l:\ %trror:\ %m,
                \%W%f:%l:\ %tarning:\ %m,
                \%I%f:%l:\ note:\ %m,

" vint: -ProhibitAbbreviationOption
let &cpo = s:save_cpo
unlet s:save_cpo
" vint: +ProhibitAbbreviationOption

" vim: set et sw=4 sts=4 ts=8:
