if polyglot#init#is_disabled(expand('<sfile>:p'), 'terraform', 'indent/hcl.vim')
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
setlocal autoindent shiftwidth=2 tabstop=2 softtabstop=2 expandtab
setlocal indentexpr=HclIndent(v:lnum)
setlocal indentkeys+=<:>,0=},0=)
let b:undo_indent = 'setlocal lisp< autoindent< shiftwidth< tabstop< softtabstop<'
  \ . ' expandtab< indentexpr< indentkeys<'

let &cpoptions = s:cpo_save
unlet s:cpo_save

if exists('*HclIndent')
  finish
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

function! HclIndent(lnum)
  " Beginning of the file should have no indent
  if a:lnum == 0
    return 0
  endif

  " Usual case is to continue at the same indent as the previous non-blank line.
  let prevlnum = prevnonblank(a:lnum-1)
  let thisindent = indent(prevlnum)

  " If that previous line is a non-comment ending in [ { (, increase the
  " indent level.
  let prevline = getline(prevlnum)
  if prevline !~# '^\s*\(#\|//\)' && prevline =~# '[\[{\(]\s*$'
    let thisindent += &shiftwidth
  endif

  " If the current line ends a block, decrease the indent level.
  let thisline = getline(a:lnum)
  if thisline =~# '^\s*[\)}\]]'
    let thisindent -= &shiftwidth
  endif

  " If the previous line starts a block comment /*, increase by one
  if prevline =~# '/\*'
    let thisindent += 1
  endif

  " If the previous line ends a block comment */, decrease by one
  if prevline =~# '\*/'
    let thisindent -= 1
  endif

  return thisindent
endfunction

let &cpoptions = s:cpo_save
unlet s:cpo_save
