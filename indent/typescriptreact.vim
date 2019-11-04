if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

exe 'runtime! indent/typescript.vim'
" Save the current JavaScript indentexpr.
let b:tsx_ts_indentexpr = &indentexpr

" Prologue; load in XML indentation.
if exists('b:did_indent')
  let s:did_indent=b:did_indent
  unlet b:did_indent
endif
exe 'runtime! indent/xml.vim'
if exists('s:did_indent')
  let b:did_indent=s:did_indent
endif

setlocal indentexpr=GetTsxIndent()

" JS indentkeys
setlocal indentkeys=0{,0},0),0],0\,,!^F,o,O,e
" XML indentkeys
setlocal indentkeys+=*<Return>,<>>,<<>,/

" Multiline end tag regex (line beginning with '>' or '/>')
let s:endtag = '^\s*\/\?>\s*;\='
let s:startexp = '[\{\(]\s*$'

" Get all syntax types at the beginning of a given line.
fu! SynSOL(lnum)
  return map(synstack(a:lnum, 1), 'synIDattr(v:val, "name")')
endfu

" Get all syntax types at the end of a given line.
fu! SynEOL(lnum)
  let lnum = prevnonblank(a:lnum)
  let col = strlen(getline(lnum))
  return map(synstack(lnum, col), 'synIDattr(v:val, "name")')
endfu

" Check if a syntax attribute is XMLish.
fu! SynAttrXMLish(synattr)
  return a:synattr =~ "^xml" || a:synattr =~ "^tsx"
endfu

" Check if a synstack is XMLish (i.e., has an XMLish last attribute).
fu! SynXMLish(syns)
  return SynAttrXMLish(get(a:syns, -1))
endfu

" Check if a synstack denotes the end of a TSX block.
fu! SynTSXBlockEnd(syns)
  return get(a:syns, -1) =~ '\%(ts\|typescript\)Braces' &&
       \ SynAttrXMLish(get(a:syns, -2))
endfu

" Determine how many tsxRegions deep a synstack is.
fu! SynTSXDepth(syns)
  return len(filter(copy(a:syns), 'v:val ==# "tsxRegion"'))
endfu

" Check whether `cursyn' continues the same tsxRegion as `prevsyn'.
fu! SynTSXContinues(cursyn, prevsyn)
  let curdepth = SynTSXDepth(a:cursyn)
  let prevdepth = SynTSXDepth(a:prevsyn)

  " In most places, we expect the nesting depths to be the same between any
  " two consecutive positions within a tsxRegion (e.g., between a parent and
  " child node, between two TSX attributes, etc.).  The exception is between
  " sibling nodes, where after a completed element (with depth N), we return
  " to the parent's nesting (depth N - 1).  This case is easily detected,
  " since it is the only time when the top syntax element in the synstack is
  " tsxRegion---specifically, the tsxRegion corresponding to the parent.
  return prevdepth == curdepth ||
      \ (prevdepth == curdepth + 1 && get(a:cursyn, -1) ==# 'tsxRegion')
endfu

" Cleverly mix JS and XML indentation.
fu! GetTsxIndent()
  let cursyn  = SynSOL(v:lnum)
  let prevsyn = SynEOL(v:lnum - 1)

  " Use XML indenting iff:
  "   - the syntax at the end of the previous line was either TSX or was the
  "     closing brace of a jsBlock whose parent syntax was TSX; and
  "   - the current line continues the same tsxRegion as the previous line.
  if (SynXMLish(prevsyn) || SynTSXBlockEnd(prevsyn)) &&
        \ SynTSXContinues(cursyn, prevsyn)
    let ind = XmlIndentGet(v:lnum, 0)
    let l:line = getline(v:lnum)
    let l:pline = getline(v:lnum - 1)

    " Align '/>' and '>' with '<' for multiline tags.
    " Align end of expression ')' or '}'.
    if l:line =~? s:endtag
      let ind = ind - shiftwidth()
    endif

    " Then correct the indentation of any TSX following '/>' or '>'.
    " Align start of expression '(' or '{'
    if l:pline =~? s:endtag || l:pline =~? s:startexp
      let ind = ind + shiftwidth()
    endif
  else
    if len(b:tsx_ts_indentexpr)
      " Invoke the base TS package's custom indenter
      let ind = eval(b:tsx_ts_indentexpr)
    else
      let ind = cindent(v:lnum)
    endif
  endif

  return ind
endfu
endif
