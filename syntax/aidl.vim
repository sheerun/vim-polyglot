if polyglot#init#is_disabled(expand('<sfile>:p'), 'aidl', 'syntax/aidl.vim')
  finish
endif

" Vim syntax file
" Language:	aidl (Android Interface Definition Language)
"		https://developer.android.com/guide/components/aidl
" Maintainer:	Dominique Pelle <dominique.pelle@tomtom.com>
" LastChange:	2020/12/03

" Quit when a syntax file was already loaded.
if exists("b:current_syntax")
  finish
endif

if filereadable($VIMRUNTIME . "/syntax/java.vim")
  source $VIMRUNTIME/syntax/java.vim
endif

syn keyword aidlStorageClass in out inout const oneway
syn keyword aidlInterfaceDecl parcelable union

hi def link aidlStorageClass javaStorageClass
hi def link aidlInterfaceDecl javaClassDecl

let b:current_syntax = "aidl"
