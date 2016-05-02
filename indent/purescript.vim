if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'purescript') == -1
  
" indentation for purescript
"
" Based on idris indentation
"
" author: raichoo (raichoo@googlemail.com)
"
" Modify g:purescript_indent_if and g:purescript_indent_case to
" change indentation for `if'(default 3) and `case'(default 5).
" Example (in .vimrc):
" > let g:purescript_indent_if = 2

if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

if !exists('g:purescript_indent_if')
  " if bool
  " >>>then ...
  " >>>else ...
  let g:purescript_indent_if = 3
endif

if !exists('g:purescript_indent_case')
  " case xs of
  " >>>>>[]     -> ...
  " >>>>>(y:ys) -> ...
  let g:purescript_indent_case = 5
endif

if !exists('g:purescript_indent_let')
  " let x = 0 in
  " >>>>x
  let g:purescript_indent_let = 4
endif

if !exists('g:purescript_indent_where')
  " where f :: Int -> Int
  " >>>>>>f x = x
  let g:purescript_indent_where = 6
endif

if !exists('g:purescript_indent_do')
  " do x <- a
  " >>>y <- b
  let g:purescript_indent_do = 3
endif

setlocal indentexpr=GetPurescriptIndent()
setlocal indentkeys=!^F,o,O,},=where,=in

function! GetPurescriptIndent()
  let prevline = getline(v:lnum - 1)
  let line = getline(v:lnum)

  if line =~ '^\s*\<where\>'
    let s = match(prevline, '\S')
    return s + 2
  endif

  if line =~ '^\s*\<in\>'
    let n = v:lnum
    let s = 0

    while s <= 0 && n > 0
      let n = n - 1
      let s = match(getline(n),'\<let\>')
    endwhile

    return s + 1
  endif

  if prevline =~ '[!#$%&*+./<>?@\\^|~-]\s*$'
    let s = match(prevline, '=')
    if s > 0
      return s + 2
    endif

    let s = match(prevline, ':')
    if s > 0
      return s + 3
    else
      return match(prevline, '\S')
    endif
  endif

  if prevline =~ '[{([][^})\]]\+$'
    return match(prevline, '[{([]')
  endif

  if prevline =~ '\<let\>\s\+.\+\(\<in\>\)\?\s*$'
    return match(prevline, '\<let\>') + g:purescript_indent_let
  endif

  if prevline !~ '\<else\>'
    let s = match(prevline, '\<if\>.*\&.*\zs\<then\>')
    if s > 0
      return s
    endif

    let s = match(prevline, '\<if\>')
    if s > 0
      return s + g:purescript_indent_if
    endif
  endif

  if prevline =~ '\(\<where\>\|\<do\>\|=\|[{([]\)\s*$'
    return match(prevline, '\S') + &shiftwidth
  endif

  if prevline =~ '\<where\>\s\+\S\+.*$'
    return match(prevline, '\<where\>') + g:purescript_indent_where
  endif

  if prevline =~ '\<do\>\s\+\S\+.*$'
    return match(prevline, '\<do\>') + g:purescript_indent_do
  endif

  if prevline =~ '^\s*\<data\>\s\+[^=]\+\s\+=\s\+\S\+.*$'
    return match(prevline, '=')
  endif

  if prevline =~ '\<case\>\s\+.\+\<of\>\s*$'
    return match(prevline, '\<case\>') + g:purescript_indent_case
  endif

  if prevline =~ '^\s*\<\data\>\s\+\S\+\s*$'
    return match(prevline, '\<data\>') + &shiftwidth
  endif

  if (line =~ '^\s*}\s*' && prevline !~ '^\s*;')
    return match(prevline, '\S') - &shiftwidth
  endif

  return match(prevline, '\S')
endfunction

endif
