" Vim indent file
" Language: Haskell
" Maintainer: Tristan Ravitch

if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

if !exists('g:hasksyn_indent_search_backward')
  let g:hasksyn_indent_search_backward = 100
endif

if !exists('g:hasksyn_dedent_after_return')
  let g:hasksyn_dedent_after_return = 1
endif

if !exists('g:hasksyn_dedent_after_catchall_case')
  let g:hasksyn_dedent_after_catchall_case = 1
endif

setlocal noautoindent
setlocal indentexpr=HIndent(v:lnum)
setlocal indentkeys+=0=where
setlocal indentkeys+=0=->
setlocal indentkeys+=0==>
setlocal indentkeys+=0=in
setlocal indentkeys+=0=class,0=instance,0=import
setlocal indentkeys+=<Bar>
setlocal indentkeys+=0\,

if exists("*HIndent")
  finish
endif


function! HIndent(lnum)
  " Don't do anything boneheaded if we are inside of a block comment
  if s:IsInBlockComment()
    return -1
  endif

  let plnum = s:PrevNonCommentLineNum(a:lnum)
  if plnum == 0
    return 0
  endif

  let prevl = s:GetAndStripTrailingComments(plnum)
  let thisl = s:GetAndStripTrailingComments(a:lnum)
  let previ = indent(plnum)

  " If this is a bare where clause, indent it one step.  where as part of an
  " instance should be unaffected unless you put it in an odd place.
  " This is the wrong thing if you are deeply indented already and want to put
  " a where clause on the top-level construct, but there isn't much that can
  " be done about that case...
  if thisl =~ '^\s*where\s*$'
    return previ + &sw
  endif

  " If we start a new line for a type signature, see if we can line it up with
  " the previous line.
  if thisl =~ '^\s*\(->\|=>\)\s*'
    let tokPos = s:BackwardPatternSearch(a:lnum, '\(::\|->\|=>\)')
    if tokPos != -1
      return tokPos
    endif
  endif

  if prevl =~ '\Wof\s*$' || prevl =~ '\Wdo\s*$'
    return previ + &sw
  endif

  " Now for commas.  Commas will align pretty naturally for simple pattern
  " guards, so don't worry about that for now.  If we see the line is just a
  " comma, search up for something to align it to.  In the easy case, look
  " for a [ or { (the last in their line).  Also consider other commas that
  " are preceeded only by whitespace.  This isn't just a previous line check
  " necessarily, though that would cover most cases.
  if thisl =~ '^\s*,'
    let cmatch = match(prevl, '\(^\s*\)\@<=,')
    if cmatch != -1
      return cmatch
    endif

    let bmatch = match(prevl, '\({\|\[\)')
    if bmatch != -1
      return bmatch
    endif
  endif

  " Match an 'in' keyword with the corresponding let.  Unfortunately, if the
  " name of your next binding happens to start with 'in', this will muck with
  " it.  Not sure if there is a workaround because we can't force an
  " auto-indent after 'in ' as far as I can see.
  if thisl =~ '\s*in$'
    let letStart = s:BackwardPatternSearch(a:lnum, '\(\W\)\@<=let\W')
    if letStart != -1
      return letStart
    endif
  endif

  " We don't send data or type to column zero because they can be indented
  " inside of 'class' definitions for data/type families
  if thisl =~ '^\s*\(class\|instance\|newtype\|import\)'
    return 0
  endif

  " FIXME: Only do this if the previous line was not already indented for the
  " same reason.  Also be careful of -> in type signatures.  Make sure we have
  " an earlier rule to line those up properly.
  if prevl =~ '[=>\$\.\^+\&`(-]\s*$'
    return previ + &sw
  endif

  " We have a special case for dealing with trailing '*' operators.  If the *
  " is the end of a kind signature in a type family/associated type, we don't
  " want to indent the next line.  We do if it is just being a * operator in
  " an expression, though.
  if prevl =~ '\(\(type\|data\).*\)\@<!\*\s*$'
    return previ + &sw
  endif

  " If the previous line ends in a where, indent us a step
  if prevl =~ '\Wwhere\s*$'
    return previ + &sw
  endif

  " If we see a |, first try to line it up with the pipe on the previous line.
  " Search backward on nearby lines, giving up if we hit a line with a \w at
  " column 0. Otherwise, indent it relative to the previous line
  "
  " Here we can also handle the case of lining up data declarations.  The
  " backwards pipe search will fail for a data declaration (since data is at
  " column 0), so we can have an extra check after the pipe search for
  " data..=.
  if thisl =~ '^\s*|$'
    let nearestPipeIndex = s:BackwardPatternSearch(a:lnum, '\(^\s*\)\@<=|')
    if nearestPipeIndex != -1
      return nearestPipeIndex
    endif

    let dataEquals = match(prevl, '\(data.*\)\@<==')
    if dataEquals != -1
      return dataEquals
    endif

    return previ + &sw
  endif

  " If the previous line has a let, line the cursor up with the start of the
  " first binding name.  Autoindent handles subsequent cases.
  "
  " This should come after the 'in' aligner so that 'in' is not treated as
  " just something to be aligned to the previous binding.
  let lbindStart = match(prevl, '\(\Wlet\s\+\)\@<=\w')
  if lbindStart != -1
    return lbindStart
  endif

  " If requested, dedent from a bare return (presumably in a do block).
  " This comes after the trailing operator case - hopefully that will avoid
  " returns on lines by themselves but not really in a do block.  This is a
  " heuristic.
  if g:hasksyn_dedent_after_return && prevl =~ '^\s*return\W'
    return previ - &sw
  endif

  " Similar to the return dedent - after a catchall case _ -> ..., we can
  " almost certainly dedent.  Again, it comes after the line continuation
  " heuristic so we don't dedent while someone is making an obviously
  " multi-line construct
  if g:hasksyn_dedent_after_catchall_case && prevl =~ '^\s*_\s*->\W'
    return previ - &sw
  endif

  " On the other hand, if the previous line is a where with some bindings
  " following it on the same line, accommodate and align with the first non-ws
  " char after the where
  if prevl =~ '\Wwhere\s\+\w'
    let bindStart = match(prevl, '\(\Wwhere\s\+\)\@<=\w')
    if bindStart != -1
      return bindStart
    endif

    return previ + &sw
  endif

  return previ
endfunction

" Search backwards for a token from the cursor position
function! s:FindTokenNotInCommentOrString(tok)
  return search('\(--.*\|"\([^"]\|\\"\)*\)\@<!' . tok, 'bcnW')
endfunction

" Should return -1 if the given line is inside of an unclosed block comment.
" This is meant to let us exit early from the indenter if we are in a comment.
" Look for the nearest -} and {- such that they are not between "" or in a
" line comment
"
" Note: we may need to restrict how far back this will search.  On the other
" hand, the native vim 'search' function might be efficient enough to support
" entire buffers.
function! s:IsInBlockComment()
  let openCommPos = s:FindTokenNotInCommentOrString('{-')
  " If there is no open comment, then we don't have to look for a close
  if openCommPos == 0
    return 0
  endif

  " Or if there is a close comment marker that comes after the open marker, we
  " are not in a comment.  Note that we potentially need to check the position
  " in the line if they are both on the same line.  I'll fix it later.
  let closeCommPos = s:FindTokenNotInCommentOrString('-}')
  if closeCommPos >= openCommPos
    return 0
  endif

  return 1
endfunction

" Get the previous line that is not a comment.  Pass in the *current* line
" number.  Also skips blank lines.
function! s:PrevNonCommentLineNum(lnum)
  if a:lnum <= 1
    return 0
  endif

  let lnum = a:lnum - 1

  while 1
    if lnum == 0
      return 0
    endif

    let aline = getline(lnum)
    if aline =~ '^\s*--'
      let lnum = lnum - 1
    else
      return lnum
    endif
  endwhile
endfunction

function! s:GetAndStripTrailingComments(lnum)
  let aline = getline(a:lnum)
  " We can't just remove the string literal since that leaves us with a
  " trailing operator (=), so replace it with a fake identifier
  let noStrings = substitute(aline, '"\([^"]\|\\"\)*"', 's', '')
  let noLineCom = substitute(noStrings, '--.*$', '', '')

  " If there are no fancy block comments involved, skip some of this extra
  " work
  if noLineCom !~ '\({-\|-}\)'
    return noLineCom
  endif

  " We stripped line comments, now we need to strip out any relevant multiline
  " comments.  This includes comments starting much earlier but ending on this
  " line or comments starting on this line and continuing to the next.  This
  " is probably easiest in two steps: {- to (-}|$) and then ^ to -}.
  " Note we are using a non-greedy match here so that only the minimal {- -}
  " pair is consumed.
  let noBlock1 = substitute(noLineComm, '{-.\{-}-}', '', '')
  let noBlock2 = substitute(noBlock1, '{-.\{-}$', '', '')
  let noBlock3 = substitute(noBlock2, '^.\{-}-}', '', '')
  return noBlock3
endfunction

" Search backwards from lnum for pat, returning the starting index if found
" within the search range or -1 if not found.  Stops searching at lines
" starting at column 0 with an identifier character.
function! s:BackwardPatternSearch(lnum, pat)
  let lnum = s:PrevNonCommentLineNum(a:lnum)
  while 1
    let aline = s:GetAndStripTrailingComments(lnum)
    if a:lnum - lnum > g:hasksyn_indent_search_backward
      return -1
    endif

    let theMatch = match(aline, a:pat)
    if theMatch != -1
      return theMatch
    else
      " We want to be able to consider lines starting in column 0, but we don't
      " want to search back past them.
      if aline =~ '^\w'
        return -1
      endif
      let lnum = s:PrevNonCommentLineNum(lnum)
    endif
  endwhile
endfunction

