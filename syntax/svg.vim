if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vim') == -1
  
" Vim syntax file
" Language:	SVG (Scalable Vector Graphics)
" Maintainer:	Vincent Berthoux <twinside@gmail.com>
" File Types:	.svg (used in Web and vector programs)
"
" Directly call the xml syntax, because SVG is an XML
" dialect. But as some plugins base their effect on filetype,
" providing a distinct filetype from xml is better.

if exists("b:current_syntax")
  finish
endif

runtime! syntax/xml.vim
let b:current_syntax = "svg"

endif
