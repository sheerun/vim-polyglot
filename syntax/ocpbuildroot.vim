if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ocaml') == -1

" Vim syntax file
" Language: ocp-build.root files
" Maintainer: Florent Monnier
" Latest Revision: 14 September 2013

if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword ocprKeywords digest
syn keyword ocprKeywords verbosity
syn keyword ocprKeywords njobs
syn keyword ocprKeywords autoscan
syn keyword ocprKeywords bytecode
syn keyword ocprKeywords native
syn keyword ocprKeywords meta_dirnames
syn keyword ocprKeywords install_destdir
syn keyword ocprKeywords install_bin
syn keyword ocprKeywords install_lib
syn keyword ocprKeywords install_data
syn keyword ocprKeywords install_doc
syn keyword ocprKeywords ocamllib
syn keyword ocprKeywords use_ocamlfind
syn keyword ocprKeywords ocpbuild_version
syn keyword ocprKeywords project_external_dirs
syn keyword ocprKeywords files
syn keyword ocprKeywords install_docdir
syn keyword ocprKeywords install_datadir
syn keyword ocprKeywords install_libdir
syn keyword ocprKeywords install_bindir
syn keyword ocprKeywords install_metadir

syn keyword ocprNumber None
syn keyword ocprNumber true
syn keyword ocprNumber false

" Strings
syn match ocprString    "\".\{-}\""

" Comments
syn keyword ocprTodo     TODO XXX FIXME BUG contained
syn region  ocprComment  start="(\*" end="\*)" contains=ocprTodo


hi def link ocprKeywords      Keyword
hi def link ocprTodo          Todo
hi def link ocprComment       Comment
hi def link ocprString        String
hi def link ocprNumber        Number

let b:current_syntax = "ocpbuildroot"


endif
