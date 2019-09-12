if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haskell') == -1

" indentation for haskell
"
" author: raichoo (raichoo@googlemail.com)
"
" Modify g:haskell_indent_if and g:haskell_indent_case to
" change indentation for `if'(default 3) and `case'(default 5).
" Example (in .vimrc):
" > let g:haskell_indent_if = 2

if exists('b:did_indent')
  finish
endif

if get(g:, 'haskell_indent_disable', 0)
  finish
endif

let b:did_indent = 1

if !exists('g:haskell_indent_if')
  " if x
  " >>>then ...
  " >>>else ...
  let g:haskell_indent_if = 3
endif

if !exists('g:haskell_indent_case')
  " case xs of
  " >>[]     -> ...
  " >>(y:ys) -> ...
  let g:haskell_indent_case = 2
endif

if !exists('g:haskell_indent_let')
  " let x = 0 in
  " >>>>x
  "
  " let x = 0
  "     y = 1
  let g:haskell_indent_let = 4
endif

if !exists('g:haskell_indent_where')
  " where f :: Int -> Int
  " >>>>>>f x = x
  let g:haskell_indent_where = 6
endif

if !exists('g:haskell_indent_do')
  " do x <- a
  " >>>y <- b
  let g:haskell_indent_do = 3
endif

if !exists('g:haskell_indent_in')
  " let x = 1
  " >in x
  let g:haskell_indent_in = 1
endif

if !exists('g:haskell_indent_guard')
  " f x y
  " >>|
  let g:haskell_indent_guard = 2
endif

setlocal indentexpr=GetHaskellIndent()
setlocal indentkeys=!^F,o,O,0{,0},0(,0),0[,0],0,,0=where,0=let,0=deriving,0=in\ ,0=::\ ,0=\-\>\ ,0=\=\>\ ,0=\|\ ,=\=\ 

function! s:isInBlock(hlstack)
  return index(a:hlstack, 'haskellDelimiter') > -1 || index(a:hlstack, 'haskellParens') > -1 || index(a:hlstack, 'haskellBrackets') > -1 || index(a:hlstack, 'haskellBlock') > -1 || index(a:hlstack, 'haskellBlockComment') > -1 || index(a:hlstack, 'haskellPragma') > -1
endfunction

function! s:stripComment(line)
  if a:line =~ '^\s*--\(-*\s\+\|$\)'
    return ''
  else
    let l:stripped = split(a:line, '-- ')
    if len(l:stripped) > 1
      return substitute(l:stripped[0], '\s*$', '', '')
    else
      return a:line
    endif
  endif
endfunction

function! s:isSYN(grp, line, col)
  return index(s:getHLStack(a:line, a:col), a:grp) != -1
endfunction

function! s:getNesting(hlstack)
  return filter(a:hlstack, 'v:val == "haskellBlock" || v:val == "haskellBrackets" || v:val == "haskellParens" || v:val == "haskellBlockComment" || v:val == "haskellPragma" ')
endfunction

function! s:getHLStack(line, col)
  return map(synstack(a:line, a:col), 'synIDattr(v:val, "name")')
endfunction

" indent matching character
function! s:indentMatching(char)
  normal! 0
  call search(a:char, 'cW')
  normal! %
  return col('.') - 1
endfunction

" backtrack to find guard clause
function! s:indentGuard(pos, prevline)
  let l:l = a:prevline
  let l:c = v:lnum - 1
  let l:s = indent(l:c)

  while l:c >= 1
    if l:s == 0 && strlen(l:l) > 0
      " top-level start, stop looking
      return g:haskell_indent_guard
    elseif l:l =~ '^\s\+[|,=]\s\+'
      " guard block found
      return match(l:l, '[|,=]')
    else
      if l:s > 0 && l:s <= a:pos
        " found less deeper indentation (not starting with `,` or `=`)
        " stop looking
        return l:s + g:haskell_indent_guard
      endif
    endif
    let l:c -= 1
    let l:l = getline(l:c)
    let l:s = indent(l:c)
  endwhile

  return -1
endfunction

function! GetHaskellIndent()
  let l:hlstack = s:getHLStack(line('.'), col('.'))

  " do not indent in strings and quasiquotes
  if index(l:hlstack, 'haskellQuasiQuote') > -1 || index(l:hlstack, 'haskellBlockComment') > -1
    return -1
  endif

  let l:prevline = s:stripComment(getline(v:lnum - 1))
  let l:line     = getline(v:lnum)

  " indent multiline strings
  if index(l:hlstack, 'haskellString') > -1
    if l:line =~ '^\s*\\'
      return match(l:prevline, '["\\]')
    else
      return - 1
    endif
  endif

  " reset
  if l:prevline =~ '^\s*$' && l:line !~ '^\s*\S'
    return 0
  endif

  "   { foo :: Int
  " >>,
  "
  "   |
  "   ...
  " >>,
  if l:line =~ '^\s*,'
    if s:isInBlock(s:getHLStack(line('.'), col('.')))
      normal! 0
      call search(',', 'cW')
      let l:n = s:getNesting(s:getHLStack(line('.'), col('.')))
      call search('[([{]', 'bW')
      let l:cl = line('.')
      let l:cc = col('.')

      while l:n != s:getNesting(s:getHLStack(l:cl, l:cc)) || s:isSYN('haskellString', l:cl, l:cc) || s:isSYN('haskellChar', l:cl, l:cc)
        call search('[([{]', 'bW')
        let l:cl = line('.')
        let l:cc = col('.')
      endwhile

      return l:cc - 1
    else
      let l:s = s:indentGuard(match(l:line, ','), l:prevline)
      if l:s > -1
        return l:s
      end
    endif
  endif

  " operator at end of previous line
  if l:prevline =~ '[!#$%&*+./<>?@\\^|~-]\s*$'
    return indent(v:lnum - 1) + &shiftwidth
  endif

  " let foo =
  " >>>>>>bar
  if l:prevline =~ '\C\<let\>\s\+[^=]\+=\s*$'
    return match(l:prevline, '\C\<let\>') + g:haskell_indent_let + &shiftwidth
  endif

  " let x = 1 in
  " >>>>x
  if l:prevline =~ '\C\<let\>.\{-}\<in\>\s*$' && l:line !~ '\C^\s*\<in\>'
    return match(l:prevline, '\C\<let\>') + g:haskell_indent_let
  endif

  " let x = 1
  " let y = 2
  "
  " let x = 1
  " >>>>y = 2
  "
  " let x = 1
  " y 2
  if l:prevline =~ '\C\<let\>\s\+.\+$'
    if l:line =~ '\C^\s*\<let\>'
      let l:s = match(l:prevline, '\C\<let\>')
      if s:isSYN('haskellLet', v:lnum - 1, l:s + 1)
        return l:s
      endif
    elseif l:line =~ '\s=\s'
      let l:s = match(l:prevline, '\C\<let\>')
      if s:isSYN('haskellLet', v:lnum - 1, l:s + 1)
        return l:s + g:haskell_indent_let
      endif
    endif
  endif

  " if handling
  if l:prevline !~ '\C\<else\>'
    let l:s = match(l:prevline, '\C\<if\>.*\&.*\zs\<then\>')
    if l:s > 0
      return l:s
    endif

    let l:s = match(l:prevline, '\C\<if\>')
    if l:s > 0
      return l:s + g:haskell_indent_if
    endif
  endif

  " where
  " >>foo
  "
  if l:prevline =~ '\C\<where\>\s*$'
    return indent(v:lnum - 1) + get(g:, 'haskell_indent_after_bare_where', &shiftwidth)
  endif

  " do
  " >>foo
  "
  " foo =
  " >>bar
  if l:prevline =~ '\C\(\<do\>\|=\)\s*$'
    return indent(v:lnum - 1) + &shiftwidth
  endif

  " do foo
  " >>>bar
  if l:prevline =~ '\C\<do\>\s\+\S\+.*$'
    let l:s = match(l:prevline, '\C\<do\>')
    if s:isSYN('haskellKeyword', v:lnum - 1, l:s + 1)
      return l:s + g:haskell_indent_do
    endif
  endif

  " case foo of
  " >>bar -> quux
  if l:prevline =~ '\C\<case\>.\+\<of\>\s*$'
    if get(g:,'haskell_indent_case_alternative', 0)
      return indent(v:lnum - 1) + &shiftwidth
    else
      return match(l:prevline, '\C\<case\>') + g:haskell_indent_case
    endif
  endif

  "" where foo
  "" >>>>>>bar
  ""
  "" where foo :: Int
  "" >>>>>>>>>>-> Int
  ""
  "" where foo x
  "" >>>>>>>>|
  if l:prevline =~ '\C\<where\>\s\+\S\+.*$'
    if  l:line =~ '^\s*[=-]>\s' && l:prevline =~ ' :: '
      return match(l:prevline, ':: ')
    elseif  l:line =~ '^\s*|\s'
      let l:s = match(l:prevline, '\C\<where\>')
      if s:isSYN('haskellWhere', v:lnum - 1, l:s + 1)
        return l:s + g:haskell_indent_where + g:haskell_indent_guard
      endif
    else
      let l:s = match(l:prevline, '\C\<where\>')
      if s:isSYN('haskellWhere', v:lnum - 1, l:s + 1)
        return l:s + g:haskell_indent_where
      endif
    endif
  endif

  " newtype Foo = Foo
  " >>deriving
  if l:prevline =~ '\C^\s*\<\(newtype\|data\)\>[^{]\+' && l:line =~ '\C^\s*\<deriving\>'
    return indent(v:lnum - 1) + &shiftwidth
  endif

  " foo :: Int
  " >>>>-> Int
  "
  " foo
  "   :: Int
  " foo
  if l:prevline =~ '\s::\s'
    if l:line =~ '^\s*[-=]>'
      return match(l:prevline, '::\s')
    elseif match(l:prevline, '^\s\+::') > -1
      return match(l:prevline, '::\s') - &shiftwidth
    endif
  endif

  " foo :: Int
  "     -> Int
  " >>>>-> Int
  "
  " foo :: Monad m
  "     => Functor f
  " >>>>=> Int
  "
  " foo :: Int
  "     -> Int
  " foo x
  "
  " foo
  "   :: Int
  "   -> Int
  " foo x
  if l:prevline =~ '^\s*[-=]>'
    if l:line =~ '^\s*[-=]>'
      return match(l:prevline, '[-=]')
    else
      if s:isInBlock(l:hlstack)
        return match(l:prevline, '[^-=]')
      else
        let l:m = matchstr(l:line, '^\s*\zs\<\S\+\>\ze')
        let l:l = l:prevline
        let l:c = v:lnum - 1

        while l:c >= 1
          " fun decl
          if l:l =~ ('^\s*' . l:m . '\(\s*::\|\n\s\+::\)')
            let l:s = match(l:l, l:m)
            if match(l:l, '\C^\s*\<default\>') > -1
              return l:s - 8
            else
              return l:s
            endif
          " empty line, stop looking
          elseif l:l =~ '^$'
             return 0
          endif
          let l:c -= 1
          let l:l = getline(l:c)
        endwhile

        return 0
      endif
    endif
  endif

  "   | otherwise = ...
  " foo
  "
  "   | foo
  " >>, bar
  "
  "   | foo
  " >>= bar
  "
  "   | Foo
  " >>deriving
  if l:prevline =~ '^\s\+|' && !s:isInBlock(l:hlstack)
    if l:line =~ '\s*[,=]'
      return match(l:prevline, '|')
    elseif l:line =~ '\C^\s*\<deriving\>'
      return match(l:prevline, '|')
    elseif l:line !~ '^\s*|'
      return match(l:prevline, '|') - g:haskell_indent_guard
    endif
  endif

  " foo :: ( Monad m
  "        , Functor f
  "        )
  ">>>>>=> Int
  if l:prevline =~ '^\s*)' && l:line =~ '^\s*=>'
    let l:s = match(l:prevline, ')')
    return l:s - (&shiftwidth + 1)
  endif

  " module Foo
  " >>( bar
  if l:prevline =~ '\C^\<module\>'
    return &shiftwidth
  endif

  " foo
  " >>{
  if l:line =~ '^\s*{'
    let l:s = indent(v:lnum - 1)
    if l:s >= 0
      return l:s + &shiftwidth
    endif
  endif

  "  in foo
  " where bar
  "
  " or
  "
  " foo
  " >>where
  if l:line =~ '\C^\s*\<where\>'
    if match(l:prevline, '\C^\s\+in\s\+') == 0
      return match(l:prevline, 'in') - g:haskell_indent_in
    endif

    return indent(v:lnum - 1) + get(g:, 'haskell_indent_before_where', &shiftwidth)
  endif

  " let x = 1
  "     y = 2
  " >in x + 1
  if l:line =~ '\C^\s*\<in\>'
    let l:s = 0
    let l:c = v:lnum - 1

    while l:s <= 0 && l:c >= 1
      let l:l = getline(l:c)
      let l:s = match(l:l, '\C\<let\>')
      if l:s >= 1 && s:isSYN('haskellLet', l:c, l:s + 1)
        break
      elseif l:l =~ '^\S'
        return -1
      endif
      let l:c -= 1
    endwhile
    return l:s + g:haskell_indent_in
  endif

  " data Foo
  " >>= Bar
  "
  "   |
  "   ...
  " >>=
  "
  " foo
  " >>=
  if l:line =~ '^\s*='
    if l:prevline =~ '\C^\<data\>\s\+[^=]\+\s*$'
      return match(l:prevline, '\C\<data\>') + &shiftwidth
    else
      let l:s = s:indentGuard(match(l:line, '='), l:prevline)
      if l:s > 0
        return l:s
      else
        return &shiftwidth
      endif
    endif
  endif

  "   |
  "   ...
  " >>|
  "
  " data Foo = Bar
  " >>>>>>>>>|
  if l:line =~ '^\s*|\s'
    if l:prevline =~ '\C^\s*\<data\>.\+=.\+$'
      return match(l:prevline, '=')
    else
      let l:s = s:indentGuard(match(l:line, '|'), l:prevline)
      if l:s > -1
        return l:s
      endif
    endif
  endif

  " foo
  " >>:: Int
  if l:line =~ '^\s*::\s'
    return indent(v:lnum - 1) + &shiftwidth
  endif

  " indent closing brace, paren or bracket
  if l:line =~ '^\s*}'
    return s:indentMatching('}')
  endif

  if l:line =~ '^\s*)'
    return s:indentMatching(')')
  endif

  if l:line =~ '^\s*]'
    return s:indentMatching(']')
  endif

  return -1
endfunction

endif
