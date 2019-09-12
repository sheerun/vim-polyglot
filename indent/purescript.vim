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

if !exists('g:purescript_indent_in')
  " let x = 0
  " >in
  let g:purescript_indent_in = 1
endif

if !exists('g:purescript_indent_where')
  " where
  " >>f :: Int -> Int
  " >>f x = x
  let g:purescript_indent_where = 6
endif

if !exists('g:purescript_indent_do')
  " do x <- a
  " >>>y <- b
  let g:purescript_indent_do = 3
endif

if !exists('g:purescript_indent_dot')
  " f
  "   :: forall a
  "   >. String
  "   -> String
  let g:purescript_indent_dot = 1
endif

setlocal indentexpr=GetPurescriptIndent()
setlocal indentkeys=!^F,o,O,},=where,=in,=::,=->,=→,==>,=⇒

function! s:GetSynStack(lnum, col)
  return map(synstack(a:lnum, a:col), { key, val -> synIDattr(val, "name") })
endfunction

function! GetPurescriptIndent()
  let ppline = getline(v:lnum - 2)
  let prevline = getline(v:lnum - 1)
  let line = getline(v:lnum)

  if line =~ '^\s*\<where\>'
    let s = indent(v:lnum - 1)
    return max([s, &l:shiftwidth])
  endif

  if line =~ '^\s*\<in\>'
    let n = v:lnum
    let s = 0

    while s <= 0 && n > 0
      let n = n - 1
      let s = match(getline(n), '\<let\>')
      if s >= 0 && index(s:GetSynStack(v:lnum - 1, s), 'purescriptString') != -1
	let s = -1
      endif
    endwhile

    return s + g:purescript_indent_in
  endif

  let s = match(prevline, '^\s*\zs\(--\|import\)')
  if s >= 0
    " comments
    " imports
    return s
  endif

  if prevline =~ '^\S.*::' && line !~ '^\s*\(\.\|->\|→\|=>\|⇒\)' && prevline !~ '^instance'
    " f :: String
    "	-> String
    return 0
  endif

  let s = match(prevline, '[[:alnum:][:blank:]]\@<=|[[:alnum:][:blank:]$]')
  if s >= 0 && prevline !~ '^class\>' && index(s:GetSynStack(v:lnum - 1, s), "purescriptFunctionDecl") == -1
    " ident pattern guards but not if we are in a type declaration
    " what we detect using syntax groups
    if prevline =~ '|\s*otherwise\>'
      return indent(search('^\s*\k', 'bnW'))
      " somehow this pattern does not work :/
      " return indent(search('^\(\s*|\)\@!', 'bnW'))
    else
      return s
    endif
  endif

  let s = match(line, '\%(\\.\{-}\)\@<=->')
  if s >= 0
    " inline lambda
    return indent(v:lnum)
  endif

  " indent rules for -> (lambdas and case expressions)
  let s = match(line, '->')
  let p = match(prevline, '\\')
  " protect that we are not in a type signature
  " and not in a case expression
  if s >= 0 && index(s:GetSynStack(s == 0 ? v:lnum - 1 : v:lnum, max([1, s])), "purescriptFunctionDecl") == -1
    \ && p >= 0 &&  index(s:GetSynStack(v:lnum - 1, p), "purescriptString") == -1
    return p
  endif

  if prevline =~ '^\S'
    " start typing signature, function body, data & newtype on next line
    return &l:shiftwidth
  endif

  if ppline =~ '^\S' && prevline =~ '^\s*$'
    return 0
  endif

  if line =~ '^\s*\%(::\|∷\)'
    return match(prevline, '\S') + &l:shiftwidth
  endif

  if prevline =~ '^\s*\(::\|∷\)\s*forall'
    return match(prevline, '\S') + g:purescript_indent_dot
  endif

  let s = match(prevline, '^\s*\zs\%(::\|∷\|=>\|⇒\|->\|→\)')
  let r = match(prevline, '^\s*\zs\.')
  if s >= 0 || r >= 0
    if s >= 0
      if line !~ '^\s*\%(::\|∷\|=>\|⇒\|->\|→\)' && line !~ '^\s*$'
	return s - 2
      else
	return s
      endif
    elseif r >= 0
      if line !~ '^\s\%(::\|∷\|=>\|⇒\|->\|→\)'
	return r - g:purescript_indent_dot
      else
	return r
      endif
    endif
  endif

  if prevline =~ '[!#$%&*+./<>?@\\^~-]\s*$'
    let s = match(prevline, '=')
    if s > 0
      return s + &l:shiftwidth
    endif

    let s = match(prevline, '\<:\>')
    if s > 0
      return s + &l:shiftwidth
    else
      return match(prevline, '\S') + &l:shiftwidth
    endif
  endif

  if prevline =~ '[{([][^})\]]\+$'
    echom "return 1"
    return match(prevline, '[{([]')
  endif

  let s = match(prevline, '\<let\>\s\+\zs\S')
  if s >= 0 && index(s:GetSynStack(v:lnum - 1, s), 'purescriptString') == -1
    return s
  endif

  let s = match(prevline, '\<let\>\s*$')
  if s >= 0 && index(s:GetSynStack(v:lnum - 1, s), 'purescriptString') == -1
    return s + g:purescript_indent_let
  endif

  let s = match(prevline, '\<let\>\s\+.\+\(\<in\>\)\?\s*$')
  if s >= 0 && index(s:GetSynStack(v:lnum - 1, s), 'purescriptString') == -1
    return match(prevline, '\<let\>') + g:purescript_indent_let
  endif

  let s = searchpairpos('\%(--.\{-}\)\@<!\<if\>', '\<then\>', '\<else\>.*\zs$', 'bnrc')[0]
  if s > 0
    " this rule ensures that using `=` in visual mode will correctly indent
    " `if then else`, but it does not handle lines after `then` and `else`
    if line =~ '\<\%(then\|else\)\>'
      return match(getline(s), '\<if\>') + &l:shiftwidth
    endif
  endif

  let p = match(prevline, '\<if\>\%(.\{-}\<then\>.\{-}\<else\>\)\@!')
  if p > 0
    return p + &l:shiftwidth
  endif

  let s = match(prevline, '=\s*$')
  if s >= 0 && index(s:GetSynStack(v:lnum - 1, s), 'purescriptString') == -1
    return match(prevline, '\S') + &l:shiftwidth
  endif

  let s = match(prevline, '[{([]\s*$')
  if s >= 0 && index(s:GetSynStack(v:lnum - 1, s), 'purescriptString') == -1
    return match(prevline, '\S') + (line !~ '^\s*[})]]' ? 0 : &l:shiftwidth)
  endif

  if prevline =~ '^class'
    return &l:shiftwidth
  endif

  let s = match(prevline, '\<where\>\s*$')
  if s >= 0 && index(s:GetSynStack(v:lnum - 1, s), 'purescriptString') == -1
    return match(prevline, '\S') + g:purescript_indent_where
  endif

  let s = match(prevline, '\<where\>\s\+\zs\S\+.*$')
  if s >= 0 && index(s:GetSynStack(v:lnum - 1, s), 'purescriptString') == -1
    return s
  endif

  let s = match(prevline, '\<do\>\s*$')
  if s >= 0 && index(s:GetSynStack(v:lnum - 1, s), 'purescriptString') == -1
    return match(prevline, '\S') + g:purescript_indent_do
  endif

  let s = match(prevline, '\<do\>\s\+\zs\S\+.*$')
  if s >= 0 && index(s:GetSynStack(v:lnum - 1, s), 'purescriptString') == -1
    return s
  endif

  let s = match(prevline, '^\s*\<data\>\s\+[^=]\+\s\+=\s\+\S\+.*$')
  if s >= 0 && index(s:GetSynStack(v:lnum - 1, s), 'purescriptString') == -1
    return match(prevline, '=')
  endif

  let s = match(prevline, '\<case\>\s\+.\+\<of\>\s*$')
  if s >= 0 && index(s:GetSynStack(v:lnum - 1, s), 'purescriptString') == -1
    return match(prevline, '\<case\>') + g:purescript_indent_case
  endif

  if prevline =~ '^\s*\<\data\>\s\+\S\+\s*$'
    return match(prevline, '\<data\>') + &l:shiftwidth
  endif

  let s = match(prevline, '^\s*[}\]]')
  if s >= 0 && index(s:GetSynStack(v:lnum - 1, s), 'purescriptString') == -1
    return match(prevline, '\S') - &l:shiftwidth
  endif

  return match(prevline, '\S')
endfunction

endif
