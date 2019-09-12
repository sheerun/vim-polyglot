if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'objc') == -1

" Vim indent file
" Language:	Objective-C
" Maintainer:	Bjorn Winckler <bjorn.winckler@gmail.com>
" Last Change:	2012 Jan 01

" Ensure 'cpo' is set to Vim default values and restore later
let s:save_cpo = &cpo
set cpo&vim

" Only load this indent file when no other was loaded.
"if exists("b:did_indent")
"    finish
"endif
"let b:did_indent = 1
"setlocal cindent

setl indentkeys=0{,0},:,0#,!^F,o,O,e,<:>

setlocal indentexpr=GetObjCIndentImproved()

" Top level statements which should not be indented, and which should not
" cause next (non-blank) line to be indented either.
let s:topLev = '^\s*@\%(class\|end\|implementation\|interface\|protocol\|\)\>'

function! GetObjCIndentImproved()
  " NOTE: Ignore leading white space to avoid having to deal with space vs.
  " tab issues.  Rely on the indent() function instead.
  let thisLine = substitute(getline(v:lnum), '^\s*', '', '')

  if thisLine =~# s:topLev || getline(prevnonblank(v:lnum - 1)) =~# s:topLev
    return 0
  endif

  " If current line looks like an argument to a message dispatch, then line
  " up colon with previous line.  This will indent the second line so that
  " the colons line up in
  "
  "   [obj firstParameter:value
  "                paramB:value2];
  "
  " but it will not line up colons in
  "
  "   if ([obj something:here])
  "       [obj other:here];
  "
  let thisColon = match(thisLine, '^\s*\K\k*\zs:')
  if thisColon > 0
    let prevLine = substitute(getline(v:lnum - 1), '^\s*', '', '')
    let prevColon = match(prevLine, ':')
    if prevColon > 0
      " Try to align colons, always making sure line is indented at least
      " one shiftwidth more than the indentation at the beginning of the
      " message.  Avoids situations like this:
      "
      "     if ([obj a:x
      "  aLongParameter:y])
      "
      let [lnum,lcol] = searchpairpos('\[', '', '\]', 'b', 0,
            \ max([1, v:lnum - 10]))
      let minInd = &sw + (lnum > 0 ? indent(lnum) : 0)
      let alignedInd = indent(v:lnum - 1) + prevColon - thisColon
      return alignedInd > minInd ? alignedInd : minInd
    endif
  endif

  let prevLnum = v:lnum - 1
  let ind      = indent(prevLnum)

  " Indent one shiftwidth after opening block, e.g.:
  "
  "   call_func_with_block(param, ^{
  "       do_stuff();
  "   });
  "
  let blockPat = '\^\s*\(([^)]*)\)\?\s*{$'
  if thisLine =~ '^}'
    norm '^%'
    if getline(".") =~ blockPat
      return indent(".")
    endif
  endif

  if getline(prevLnum) =~ blockPat
    return ind + &sw
  endif

  return cindent(v:lnum)
endfunction


" Restore 'cpo' options
let &cpo = s:save_cpo
unlet s:save_cpo

endif
