if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'terraform') != -1
  finish
endif

" Only load this file if no other indent file was loaded
if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

let s:cpo_save = &cpoptions
set cpoptions&vim

setlocal nolisp
setlocal autoindent shiftwidth=2 tabstop=2 softtabstop=2
setlocal indentexpr=TerraformIndent(v:lnum)
setlocal indentkeys+=<:>,0=},0=)
let b:undo_indent = 'setlocal lisp< autoindent< shiftwidth< tabstop< softtabstop<'
  \ . ' indentexpr< indentkeys<'

let &cpoptions = s:cpo_save
unlet s:cpo_save

if exists('*TerraformIndent')
  finish
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

function! TerraformIndent(lnum)
  " Beginning of the file should have no indent
  if a:lnum == 0
    return 0
  endif

  " Previous non-blank line should continue the indent level
  let prevlnum = prevnonblank(a:lnum-1)

  " Previous line without comments should continue the indent level
  let prevline = substitute(getline(prevlnum), '//.*$', '', '')
  let previndent = indent(prevlnum)
  let thisindent = previndent

  " Config block starting with [ { ( should increase the indent level
  if prevline =~# '[\[{\(]\s*$'
    let thisindent += &shiftwidth
  endif

  " Current line without comments should continue the indent level
  let thisline = substitute(getline(a:lnum), '//.*$', '', '')

  " Config block ending with ) } ] should get the indentation
  " level from the initial config block
  if thisline =~# '^\s*[\)}\]]'
    let thisindent -= &shiftwidth
  endif

  return thisindent
endfunction

let &cpoptions = s:cpo_save
unlet s:cpo_save
