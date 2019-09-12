if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dlang') == -1

" Vim indent file for the D programming language (version 1.076 and 2.063).
"
" Language:     D
" Maintainer:   Jesse Phillips <Jesse.K.Phillips+D@gmail.com>
" Last Change:  2014 January 19
" Version:      0.26
"
" Please submit bugs/comments/suggestions to the github repo:
" https://github.com/JesseKPhillips/d.vim

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal cindent
setlocal indentkeys& indentkeys+=0=in indentkeys+=0=out indentkeys+=0=body
setlocal indentexpr=GetDIndent()

if exists("*GetDIndent")
  finish
endif

function! SkipBlanksAndComments(startline)
  let lnum = a:startline
  while lnum > 1
    let lnum = prevnonblank(lnum)
    if getline(lnum) =~ '[*+]/\s*$'
      while getline(lnum) !~ '/[*+]' && lnum > 1
	let lnum = lnum - 1
      endwhile
      if getline(lnum) =~ '^\s*/[*+]'
	let lnum = lnum - 1
      else
	break
      endif
    elseif getline(lnum) =~ '\s*//'
      let lnum = lnum - 1
    else
      break
    endif
  endwhile
  return lnum
endfunction

function GetDIndent()
  let lnum = v:lnum
  let line = getline(lnum)
  let cind = cindent(lnum)

  " Align contract blocks with function signature.
  if line =~ '^\s*\(body\|in\|out\)\>'
    " Skip in/out parameters.
    if getline(lnum - 1) =~ '[(,]\s*$'
      return cind
    endif
    " Find the end of the last block or the function signature.
    if line !~ '^\s*}' && getline(lnum - 1) !~ '('
      while lnum > 1 && getline(lnum - 1) !~ '[(}]'
	let lnum = lnum - 1
      endwhile
    endif
    let lnum = SkipBlanksAndComments(lnum)
    return cindent(lnum - 1)
  endif

  " Align multiline array literals. e.g.:
  " auto a = [
  "   [ 1, 2, 3 ],
  "   [ 4, 5, 6 ],
  if line =~ '^\s*\[' && getline(lnum - 1) =~ '^\s*\['
    return indent(lnum - 1)
  endif

  return cind
endfunction

endif
