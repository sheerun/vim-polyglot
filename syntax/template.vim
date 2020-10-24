let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/template.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'template') == -1

" Vim syntax file
" Language:	Generic template
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2019 May 06

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Known template types are very similar to HTML, E.g. golang and "Xfire User
" Interface Template"
" If you know how to recognize a more specific type for *.tmpl suggest a
" change to runtime/scripts.vim.
runtime! syntax/html.vim

endif
