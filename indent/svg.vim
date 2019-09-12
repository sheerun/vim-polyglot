if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'svg-indent') == -1

" Vim indent file
"
" Language: svg
" Maintainer: Jason Shell <jason.shell.mail@gmail.com>
" Last Change:	2015 Sep 23
" Notes: 1) will be confused by unbalanced tags in comments

" Only load this indent file when no other was loaded.
if exists('b:did_indent')
  finish
endif
let b:did_indent = 1
let s:keepcpo= &cpo
set cpo&vim

" [-- local settings (must come before aborting the script) --]
setlocal indentexpr=SvgIndentGet(v:lnum,1)
setlocal indentkeys=o,O,*<Return>,<>>,<<>,/,{,}

if !exists('b:svg_indent_open')
  let b:svg_indent_open = '.\{-}<\a'
  " pre tag, e.g. <address>
  " let b:svg_indent_open = '.\{-}<[/]\@!\(address\)\@!'
endif

if !exists('b:svg_indent_close')
  let b:svg_indent_close = '.\{-}</'
  " end pre tag, e.g. </address>
  " let b:svg_indent_close = '.\{-}</\(address\)\@!'
endif

let &cpo = s:keepcpo
unlet s:keepcpo

" [-- finish, if the function already exists --]
if exists('*SvgIndentGet')
  finish
endif

let s:keepcpo= &cpo
set cpo&vim

fun! <SID>SvgIndentWithPattern(line, pat)
  let s = substitute('x'.a:line, a:pat, "\1", 'g')
  return strlen(substitute(s, "[^\1].*$", '', ''))
endfun

" [-- check if it's svg --]
fun! <SID>SvgIndentSynCheck(lnum)
  if '' != &syntax
    let syn1 = synIDattr(synID(a:lnum, 1, 1), 'name')
    let syn2 = synIDattr(synID(a:lnum, strlen(getline(a:lnum)) - 1, 1), 'name')
    if '' != syn1 && syn1 !~ 'svg' && '' != syn2 && syn2 !~ 'svg'
      " don't indent pure non-xml code
      return 0

    " elseif syn1 =~ '^xmlComment' && syn2 =~ '^xmlComment'
    elseif syn1 =~ '^svgComment' && syn2 =~ '^svgComment'
      " indent comments specially
      return -1
    endif
  endif
  return 1
endfun

" [-- return the sum of indents of a:lnum --]
fun! <SID>SvgIndentSum(lnum, style, add)
  let line = getline(a:lnum)
  if a:style == match(line, '^\s*</')
    return (&sw *
    \  (<SID>SvgIndentWithPattern(line, b:svg_indent_open)
    \ - <SID>SvgIndentWithPattern(line, b:svg_indent_close)
    \ - <SID>SvgIndentWithPattern(line, '.\{-}/>'))) + a:add
  else
    return a:add
  endif
endfun

fun! SvgIndentGet(lnum, use_syntax_check)
  " Find a non-empty line above the current line.
  let lnum = prevnonblank(a:lnum - 1)

  " Hit the start of the file, use zero indent.
  if lnum == 0
    return 0
  endif

  if a:use_syntax_check
    let check_lnum = <SID>SvgIndentSynCheck(lnum)
    let check_alnum = <SID>SvgIndentSynCheck(a:lnum)
    if 0 == check_lnum || 0 == check_alnum
      return indent(a:lnum)
    elseif -1 == check_lnum || -1 == check_alnum
      return -1
    endif
  endif

  let ind = <SID>SvgIndentSum(lnum, -1, indent(lnum))
  let ind = <SID>SvgIndentSum(a:lnum, 0, ind)

  return ind
endfun

let &cpo = s:keepcpo
unlet s:keepcpo

endif
