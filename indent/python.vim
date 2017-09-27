if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vim') == -1
  
" Vim indent file
" Language:		Python
" Maintainer:		Bram Moolenaar <Bram@vim.org>
" Original Author:	David Bustos <bustos@caltech.edu>
" Last Change:		2013 Jul 9

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" Some preliminary settings
setlocal nolisp		" Make sure lisp indenting doesn't supersede us
setlocal autoindent	" indentexpr isn't much help otherwise

setlocal indentexpr=GetPythonIndent(v:lnum)
setlocal indentkeys+=<:>,=elif,=except

" Only define the function once.
if exists("*GetPythonIndent")
  finish
endif
let s:keepcpo= &cpo
set cpo&vim

" Come here when loading the script the first time.

let s:maxoff = 50	" maximum number of lines to look backwards for ()

function GetPythonIndent(lnum)

  " If this line is explicitly joined: If the previous line was also joined,
  " line it up with that one, otherwise add two 'shiftwidth'
  if getline(a:lnum - 1) =~ '\\$'
    if a:lnum > 1 && getline(a:lnum - 2) =~ '\\$'
      return indent(a:lnum - 1)
    endif
    return indent(a:lnum - 1) + (exists("g:pyindent_continue") ? eval(g:pyindent_continue) : (shiftwidth() * 2))
  endif

  " If the start of the line is in a string don't change the indent.
  if has('syntax_items')
	\ && synIDattr(synID(a:lnum, 1, 1), "name") =~ "String$"
    return -1
  endif

  " Search backwards for the previous non-empty line.
  let plnum = prevnonblank(v:lnum - 1)

  if plnum == 0
    " This is the first non-empty line, use zero indent.
    return 0
  endif

  " If the previous line is inside parenthesis, use the indent of the starting
  " line.
  " Trick: use the non-existing "dummy" variable to break out of the loop when
  " going too far back.
  call cursor(plnum, 1)
  let parlnum = searchpair('(\|{\|\[', '', ')\|}\|\]', 'nbW',
	  \ "line('.') < " . (plnum - s:maxoff) . " ? dummy :"
	  \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
	  \ . " =~ '\\(Comment\\|Todo\\|String\\)$'")
  if parlnum > 0
    let plindent = indent(parlnum)
    let plnumstart = parlnum
  else
    let plindent = indent(plnum)
    let plnumstart = plnum
  endif


  " When inside parenthesis: If at the first line below the parenthesis add
  " two 'shiftwidth', otherwise same as previous line.
  " i = (a
  "       + b
  "       + c)
  call cursor(a:lnum, 1)
  let p = searchpair('(\|{\|\[', '', ')\|}\|\]', 'bW',
	  \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
	  \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
	  \ . " =~ '\\(Comment\\|Todo\\|String\\)$'")
  if p > 0
    if p == plnum
      " When the start is inside parenthesis, only indent one 'shiftwidth'.
      let pp = searchpair('(\|{\|\[', '', ')\|}\|\]', 'bW',
	  \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
	  \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
	  \ . " =~ '\\(Comment\\|Todo\\|String\\)$'")
      if pp > 0
	return indent(plnum) + (exists("g:pyindent_nested_paren") ? eval(g:pyindent_nested_paren) : shiftwidth())
      endif
      return indent(plnum) + (exists("g:pyindent_open_paren") ? eval(g:pyindent_open_paren) : (shiftwidth() * 2))
    endif
    if plnumstart == p
      return indent(plnum)
    endif
    return plindent
  endif


  " Get the line and remove a trailing comment.
  " Use syntax highlighting attributes when possible.
  let pline = getline(plnum)
  let pline_len = strlen(pline)
  if has('syntax_items')
    " If the last character in the line is a comment, do a binary search for
    " the start of the comment.  synID() is slow, a linear search would take
    " too long on a long line.
    if synIDattr(synID(plnum, pline_len, 1), "name") =~ "\\(Comment\\|Todo\\)$"
      let min = 1
      let max = pline_len
      while min < max
	let col = (min + max) / 2
	if synIDattr(synID(plnum, col, 1), "name") =~ "\\(Comment\\|Todo\\)$"
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

  " If the previous line ended with a colon, indent this line
  if pline =~ ':\s*$'
    return plindent + shiftwidth()
  endif

  " If the previous line was a stop-execution statement...
  if getline(plnum) =~ '^\s*\(break\|continue\|raise\|return\|pass\)\>'
    " See if the user has already dedented
    if indent(a:lnum) > indent(plnum) - shiftwidth()
      " If not, recommend one dedent
      return indent(plnum) - shiftwidth()
    endif
    " Otherwise, trust the user
    return -1
  endif

  " If the current line begins with a keyword that lines up with "try"
  if getline(a:lnum) =~ '^\s*\(except\|finally\)\>'
    let lnum = a:lnum - 1
    while lnum >= 1
      if getline(lnum) =~ '^\s*\(try\|except\)\>'
	let ind = indent(lnum)
	if ind >= indent(a:lnum)
	  return -1	" indent is already less than this
	endif
	return ind	" line up with previous try or except
      endif
      let lnum = lnum - 1
    endwhile
    return -1		" no matching "try"!
  endif

  " If the current line begins with a header keyword, dedent
  if getline(a:lnum) =~ '^\s*\(elif\|else\)\>'

    " Unless the previous line was a one-liner
    if getline(plnumstart) =~ '^\s*\(for\|if\|try\)\>'
      return plindent
    endif

    " Or the user has already dedented
    if indent(a:lnum) <= plindent - shiftwidth()
      return -1
    endif

    return plindent - shiftwidth()
  endif

  " When after a () construct we probably want to go back to the start line.
  " a = (b
  "       + c)
  " here
  if parlnum > 0
    return plindent
  endif

  return -1

endfunction

let &cpo = s:keepcpo
unlet s:keepcpo

" vim:sw=2

endif
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
