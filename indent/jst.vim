if exists("b:did_indent")
  finish
endif

runtime! indent/javascript.vim
unlet! b:did_indent
setlocal indentexpr=

if exists("b:jst_subtype")
  exe "runtime! indent/".b:jst_subtype.".vim"
else
  runtime! indent/html.vim
endif
unlet! b:did_indent

if &l:indentexpr == ''
  if &l:cindent
    let &l:indentexpr = 'cindent(v:lnum)'
  else
    let &l:indentexpr = 'indent(prevnonblank(v:lnum-1))'
  endif
endif
let b:jst_subtype_indentexpr = &l:indentexpr

let b:did_indent = 1

setlocal indentexpr=GetJstIndent()
setlocal indentkeys=o,O,*<Return>,<>>,{,},0),0],o,O,!^F,=end,=else,=elsif,=rescue,=ensure,=when

" Only define the function once.
if exists("*GetJstIndent")
  finish
endif

function! GetJstIndent(...)
  if a:0 && a:1 == '.'
    let v:lnum = line('.')
  elseif a:0 && a:1 =~ '^\d'
    let v:lnum = a:1
  endif
  let vcol = col('.')
  call cursor(v:lnum,1)
  let injavascript = searchpair('<%','','%>','W')
  call cursor(v:lnum,vcol)
  if injavascript && getline(v:lnum) !~ '^<%\|^\s*[-=]\=%>'
    let ind = GetJavascriptIndent()
  else
    exe "let ind = ".b:jst_subtype_indentexpr
  endif
  let lnum = prevnonblank(v:lnum-1)
  let line = getline(lnum)
  let cline = getline(v:lnum)
  if cline =~# '^\s*<%[-=]\=\s*\%(}.\{-\}\)\s*\%([-=]\=%>\|$\)'
    let ind = ind - &sw
  endif
  if line =~# '\S\s*<%[-=]\=\s*\%(}\).\{-\}\s*\%([-=]\=%>\|$\)'
    let ind = ind - &sw
  endif
  if line =~# '\%({\|\<do\)\%(\s*|[^|]*|\)\=\s*[-=]\=%>'
    let ind = ind + &sw
  endif
  if line =~# '^\s*<%[=#-]\=\s*$' && cline !~# '^\s*end\>'
    let ind = ind + &sw
  endif
  if line !~# '^\s*<%' && line =~# '%>\s*$'
    let ind = ind - &sw
  endif
  if cline =~# '^\s*[-=]\=%>\s*$'
    let ind = ind - &sw
  endif
  return ind
endfunction

" vim:set sw=2 sts=2 ts=8 noet:

