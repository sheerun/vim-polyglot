if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nim') == -1

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" Some preliminary settings
setlocal nolisp         " Make sure lisp indenting doesn't supersede us
setlocal autoindent     " indentexpr isn't much help otherwise

setlocal indentexpr=GetNimIndent(v:lnum)
setlocal indentkeys=!^F,o,O,<:>,0),0],0},=elif

" Only define the function once.
if exists("*GetNimIndent")
  finish
endif

function! s:FindStartLine(fromln, pattern)
  let lnum = a:fromln
  let safechoice = indent(lnum)
  while getline(lnum) !~ a:pattern
    if indent(lnum) == 0 || lnum == 1
      return safechoice
    endif
    let lnum = lnum - 1
  endwhile
  return indent(lnum)
endfunction

function! GetNimIndent(lnum)
  " Search backwards for the previous non-empty line.
  let plnum = prevnonblank(a:lnum - 1)

  if plnum == 0
    " This is the first non-empty line, use zero indent.
    return 0
  endif

  " If the start of the line is in a string don't change the indent.
  if has('syntax_items') && synIDattr(synID(a:lnum, 1, 1), "name") =~ "String$"
    return -1
  endif

  let pline = getline(plnum)
  let cline = getline(a:lnum)
  let pline_len = strlen(pline)
  let plindent = indent(plnum)
  let clindent = indent(a:lnum)

  " Remove any trailing comment from previous line.
  " Use syntax highlighting attributes when possible.
  if has('syntax_items')
    " If the last character in the line is a comment, do a binary search for
    " the start of the comment.  synID() is slow, a linear search would take
    " too long on a long line.
    if synIDattr(synID(plnum, pline_len, 1), "name") =~ "Comment$"
      let min = 1
      let max = pline_len
      while min < max
        let col = (min + max) / 2
        if synIDattr(synID(plnum, col, 1), "name") =~ "Comment$"
          let max = col
        else
          let min = col + 1
        endif
      endwhile
      let pline = strpart(pline, 0, min - 1)
    endif
  else
    let col = 0
    while col < pline_len
      if pline[col] == '#'
        let pline = strpart(pline, 0, col)
        break
      endif
      let col = col + 1
    endwhile
  endif

  if cline =~ '^\s*\(if\|when\|for\|while\|case\|of\|try\)\>'
    " This is a benign line, do nothing
    return -1
  endif

  " If the current line begins with a keyword that lines up with "try"
  if cline =~ '^\s*\(except\|finally\)\>'
    let lnum = a:lnum - 1
    while lnum >= 1
      if getline(lnum) =~ '^\s*\(try\|except\)\>'
        let ind = indent(lnum)
        if ind >= clindent
          return -1     " indent is already less than this
        endif
        return ind      " line up with previous try or except
      endif
      let lnum = lnum - 1
    endwhile
    return -1           " no matching "try"!
  endif

  " If the current line begins with a header keyword, dedent
  if cline =~ '^\s*\(elif\|else\)\>'
    return s:FindStartLine(a:lnum, '^\s*\(if\|when\|elif\|of\)')
  endif

  if pline =~ ':\s*$'
    "return s:FindStartLine(plnum, '(^\s*\(if\|when\|else\|elif\|case\|of\|try\|except\|finally\)\>)\|\<do\>') + &sw
    return s:FindStartLine(plnum, '^\s*\(if\|when\|else\|elif\|for\|while\|case\|of\|try\|except\|finally\)\>') + &sw
  endif

  if pline =~ '=\s*$'
    return s:FindStartLine(plnum, '^\s*\(proc\|template\|macro\|iterator\)\>') + &sw
  endif

  " if we got here, this should be the begging of a multi-line if expression for example
  if pline =~ '^\s*\(if\|when\|proc\|iterator\|macro\|template\|for\|while\)[^:]*$'
    return plindent + &sw
  endif

  if pline =~ '\(type\|import\|const\|var\|let\)\s*$'
    \ || pline =~ '=\s*\(object\|enum\|tuple\|concept\)'
    return plindent + &sw
  endif

  " If the previous line was a stop-execution statement...
  if pline =~ '^\s*\(break\|continue\|raise\|return\)\>'
    " See if the user has already dedented
    if indent(a:lnum) > plindent - &sw
      " If not, recommend one dedent
      return plindent - &sw
    endif
    " Otherwise, trust the user
    return -1
  endif

  return -1

endfunction

" vim:sw=2


endif
