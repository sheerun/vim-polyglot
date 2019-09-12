if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'arduino') == -1

" Vim indent file
" Language:	Arduino
" Maintainer:	Kevin Sjöberg <kev.sjoberg@gmail.com>
" Last Change:	2014 Feb 28

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

" C++ indenting is built-in, thus this is very simple
setlocal cindent

let b:undo_indent = "setl cin<"

endif
