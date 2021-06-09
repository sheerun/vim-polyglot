if polyglot#init#is_disabled(expand('<sfile>:p'), 'html5', 'after/syntax/html.vim')
  finish
endif

" Vim syntax file
" Language:     HTML (version 5.1)
" Last Change:  2017 Feb 15
" License:      Public domain
"               (but let me know if you like :) )
"
" Maintainer:   Kao, Wei-Ko(othree) ( othree AT gmail DOT com )

" Comment
" https://github.com/w3c/html/issues/694
syntax region htmlComment start=+<!--+ end=+-->+ contains=@Spell
syntax region htmlComment start=+<!DOCTYPE+ keepend end=+>+
