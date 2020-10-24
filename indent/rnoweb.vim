let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/rnoweb.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'rnoweb') == -1

" Vim indent file
" Language:	Rnoweb
" Author:	Jakson Alves de Aquino <jalvesaq@gmail.com>
" Homepage:     https://github.com/jalvesaq/R-Vim-runtime
" Last Change:	Fri Apr 15, 2016  10:58PM


" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
runtime indent/tex.vim

function! s:NoTeXIndent()
  return indent(line("."))
endfunction

if &indentexpr == "" || &indentexpr == "GetRnowebIndent()"
  let s:TeXIndent = function("s:NoTeXIndent")
else
  let s:TeXIndent = function(substitute(&indentexpr, "()", "", ""))
endif

unlet! b:did_indent
runtime indent/r.vim
let s:RIndent = function(substitute(&indentexpr, "()", "", ""))
let b:did_indent = 1

setlocal indentkeys=0{,0},!^F,o,O,e,},=\bibitem,=\item
setlocal indentexpr=GetRnowebIndent()

if exists("*GetRnowebIndent")
  finish
endif

function GetRnowebIndent()
  let curline = getline(".")
  if curline =~ '^<<.*>>=$' || curline =~ '^\s*@$'
    return 0
  endif
  if search("^<<", "bncW") > search("^@", "bncW")
    return s:RIndent()
  endif
  return s:TeXIndent()
endfunction

" vim: sw=2

endif
