if polyglot#init#is_disabled(expand('<sfile>:p'), 'stylus', 'indent/stylus.vim')
  finish
endif

" Vim indent file
" Language: Stylus
" Maintainer: Ilia Loginov
" Last Change: 2018 Jan 19
" Based On: sass.vim from Tim Pope

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetStylusIndent()
setlocal autoindent nolisp nosmartindent
setlocal indentkeys=o,O,*<Return>,0),!^F
setlocal formatoptions+=r

if exists('*GetStylusIndent')
  finish
endif

function s:prevnonblanknoncomment(lnum)
  let lnum = a:lnum
  while lnum > 1
    let lnum = prevnonblank(lnum)
    let line = getline(lnum)
    if line =~ '\*/'
      while lnum > 1 && line !~ '/\*'
        let lnum -= 1
      endwhile
      if line =~ '^\s*/\*'
        let lnum -= 1
      else
        break
      endif
    else
      break
    endif
  endwhile
  return lnum
endfunction

function GetStylusIndent()
  let line = getline(v:lnum)
  if line =~ '^\s*\*'
    return cindent(v:lnum)
  endif

  let pnum = s:prevnonblanknoncomment(v:lnum - 1)
  if pnum == 0
    return 0
  endif

  let lnum = prevnonblank(v:lnum-1)
  if lnum == 0
    return 0
  endif

  let pline = getline(pnum)

  " Get last line strip ending whitespace
  let line = substitute(getline(lnum),'[\s()]\+$','','')
  " Get current line, trimmed
  let cline    = substitute(substitute(getline(v:lnum),'\s\+$','',''),'^\s\+','','')
  " Get last col in prev line
  let lastcol  = strlen(line)
  " Then remove preceeding whitespace
  let line     = substitute(line,'^\s\+','','')
  " Get indent on prev line
  let indent   = indent(lnum)
  " Get indent on current line
  let cindent  = indent(v:lnum)
  " Increase indent by the shift width
  let increase = indent + &sw
  if indent   == indent(lnum)
    let indent = cindent <= indent ? indent : increase
  endif

  let group = synIDattr(synID(lnum, cindent + 1, 1), 'name')

  if group =~ 'stylusSelector\w*'
    return increase
  elseif group =~ 'stylusAtRule\(Viewport\|Page\|Supports\|Document\|Font\|Keyframes\)\w*'
    return increase
  " Mixin or function definition
  elseif group =~ 'stylusFunction\w*' && indent(lnum) == 0
    return increase
  else
    return indent
  endif
endfunction
