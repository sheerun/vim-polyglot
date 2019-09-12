if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dart') == -1

if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

setlocal cindent
setlocal cinoptions+=j1,J1,(2s,u2s,U1,m1,+2s

setlocal indentexpr=DartIndent()

let b:undo_indent = 'setl cin< cino<'

if exists("*DartIndent")
  finish
endif

function! DartIndent()
  " Default to cindent in most cases
  let indentTo = cindent(v:lnum)

  let previousLine = getline(prevnonblank(v:lnum - 1))
  let currentLine = getline(v:lnum)

  " Don't indent after an annotation
  if previousLine =~# '^\s*@.*$'
    let indentTo = indent(v:lnum - 1)
  endif

  " Indent after opening List literal
  if previousLine =~# '\[$' && !(currentLine =~# '^\s*\]')
    let indentTo = indent(v:lnum - 1) + &shiftwidth
  endif

  return indentTo
endfunction

endif
