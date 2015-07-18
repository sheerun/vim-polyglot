if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'python') == -1
  
" PEP8 compatible Python indent file
" Only load this indent file when no other was loaded.
if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal expandtab
setlocal nolisp
setlocal autoindent
setlocal indentexpr=GetPythonPEPIndent(v:lnum)
setlocal indentkeys=!^F,o,O,<:>,0),0],0},=elif,=except

let s:maxoff = 50

" Find backwards the closest open parenthesis/bracket/brace.
function! s:SearchParensPair()
  let line = line('.')
  let col = col('.')

  " Skip strings and comments and don't look too far
  let skip = "line('.') < " . (line - s:maxoff) . " ? dummy :" .
        \ 'synIDattr(synID(line("."), col("."), 0), "name") =~? ' .
        \ '"string\\|comment"'

  " Search for parentheses
  call cursor(line, col)
  let parlnum = searchpair('(', '', ')', 'bW', skip)
  let parcol = col('.')

  " Search for brackets
  call cursor(line, col)
  let par2lnum = searchpair('\[', '', '\]', 'bW', skip)
  let par2col = col('.')

  " Search for braces
  call cursor(line, col)
  let par3lnum = searchpair('{', '', '}', 'bW', skip)
  let par3col = col('.')

  " Get the closest match
  if par2lnum > parlnum || (par2lnum == parlnum && par2col > parcol)
    let parlnum = par2lnum
    let parcol = par2col
  endif
  if par3lnum > parlnum || (par3lnum == parlnum && par3col > parcol)
    let parlnum = par3lnum
    let parcol = par3col
  endif

  " Put the cursor on the match
  if parlnum > 0
    call cursor(parlnum, parcol)
  endif
  return parlnum
endfunction

" Find the start of a multi-line statement
function! s:StatementStart(lnum)
  let lnum = a:lnum
  while 1
    if getline(lnum - 1) =~ '\\$'
      let lnum = lnum - 1
    else
      call cursor(lnum, 1)
      let maybe_lnum = s:SearchParensPair()
      if maybe_lnum < 1
        return lnum
      else
        let lnum = maybe_lnum
      endif
    endif
  endwhile
endfunction

" Find the block starter that matches the current line
function! s:BlockStarter(lnum, block_start_re)
  let lnum = a:lnum
  let maxindent = 10000       " whatever
  while lnum > 1
    let lnum = prevnonblank(lnum - 1)
    if indent(lnum) < maxindent
      if getline(lnum) =~ a:block_start_re
        return lnum
      else
        let maxindent = indent(lnum)
        " It's not worth going further if we reached the top level
        if maxindent == 0
          return -1
        endif
      endif
    endif
  endwhile
  return -1
endfunction

function! GetPythonPEPIndent(lnum)
  let scol = col('.')

  " First line has indent 0
  if a:lnum == 1
    return 0
  endif

  " If we can find an open parenthesis/bracket/brace, line up with it.
  call cursor(a:lnum, 1)
  let parlnum = s:SearchParensPair()
  if parlnum > 0
    let parcol = col('.')
    let matches = matchlist(getline(a:lnum), '^\(\s*\)[])}]')
    if len(matches) == 0
      let closing_paren = 0
      let closing_paren_pos = 0
    else
      let closing_paren = 1
      let closing_paren_pos = len(matches[1])
    endif
    if match(getline(parlnum), '[([{]\s*$', parcol - 1) != -1
      if closing_paren
        return indent(parlnum)
      else
        return indent(parlnum) + &shiftwidth
      endif
    elseif a:lnum - 1 != parlnum
      if closing_paren && closing_paren_pos > scol
        return indent(parlnum)
      else
        let lastindent = match(getline(a:lnum - 1), '\S')
        if lastindent != -1 && lastindent < parcol
          return lastindent
        endif
      endif
    endif

    " If we line up with an opening column there is a special case
    " we want to handle: a docstring as argument.  In that case we
    " don't want to line up with the paren but with the statement
    " imagine foo(doc=""" as example
    echo getline(parlnum)
    if match(getline(parlnum), '\("""\|' . "'''" . '\)\s*$') != -1
      return indent(parlnum)
    endif

    return parcol
  endif

  " Examine this line
  let thisline = getline(a:lnum)
  let thisindent = indent(a:lnum)

  " If the line starts with 'elif' or 'else', line up with 'if' or 'elif'
  if thisline =~ '^\s*\(elif\|else\)\>'
    let bslnum = s:BlockStarter(a:lnum, '^\s*\(if\|elif\)\>')
    if bslnum > 0
      return indent(bslnum)
    else
      return -1
    endif
  endif

  " If the line starts with 'except' or 'finally', line up with 'try'
  " or 'except'
  if thisline =~ '^\s*\(except\|finally\)\>'
    let bslnum = s:BlockStarter(a:lnum, '^\s*\(try\|except\)\>')
    if bslnum > 0
      return indent(bslnum)
    else
      return -1
    endif
  endif

  " Examine previous line
  let plnum = a:lnum - 1
  let pline = getline(plnum)
  let sslnum = s:StatementStart(plnum)

  " If the previous line is blank, keep the same indentation
  if pline =~ '^\s*$'
    return -1
  endif

  " If this line is explicitly joined, try to find an indentation that looks
  " good.
  if pline =~ '\\$'
    let compound_statement = '^\s*\(if\|while\|from\|import\|for\s.*\sin\|except\)\s*'
    let maybe_indent = matchend(getline(sslnum), compound_statement)
    if maybe_indent != -1
      return maybe_indent
    else
      return indent(sslnum) + &sw * 2
    endif
  endif

  " If the previous line ended with a colon and is not a comment, indent
  " relative to statement start.
  if pline =~ '^[^#]*:\s*\(#.*\)\?$'
    return indent(sslnum) + &sw
  endif

  " If the previous line was a stop-execution statement or a pass
  if getline(sslnum) =~ '^\s*\(break\|continue\|raise\|return\|pass\)\>'
    " See if the user has already dedented
    if indent(a:lnum) > indent(sslnum) - &sw
      " If not, recommend one dedent
      return indent(sslnum) - &sw
    endif
    " Otherwise, trust the user
    return -1
  endif

  " In all other cases, line up with the start of the previous statement.
  return indent(sslnum)
endfunction

endif
