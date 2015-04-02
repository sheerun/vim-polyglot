"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim indent file
"
" Language: JSX (JavaScript)
" Maintainer: Max Wang <mxawng@gmail.com>
" Depends: pangloss/vim-javascript
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Do nothing if we don't find the @jsx pragma (and we care).
exec 'source '.fnameescape(expand('<sfile>:p:h:h').'/jsx-config.vim')
if g:jsx_pragma_required && !b:jsx_pragma_found | finish | endif

" Do nothing if we don't have the .jsx extension (and we care).
if g:jsx_ext_required && !exists('b:jsx_ext_found') | finish | endif

" Prologue; load in XML indentation.
if exists('b:did_indent')
  let s:did_indent=b:did_indent
  unlet b:did_indent
endif
exe 'runtime! indent/xml.vim'
if exists('s:did_indent')
  let b:did_indent=s:did_indent
endif

setlocal indentexpr=GetJsxIndent()

" JS indentkeys
setlocal indentkeys=0{,0},0),0],0\,,!^F,o,O,e
" XML indentkeys
setlocal indentkeys+=*<Return>,<>>,<<>,/

" Self-closing tag regex.
let s:sctag = '^\s*\/>\s*;\='

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
  return a:synattr =~ "^xml" || a:synattr =~ "^jsx"
endfu

" Check if a synstack is XMLish (i.e., has an XMLish last attribute).
fu! SynXMLish(syns)
  return SynAttrXMLish(get(a:syns, -1))
endfu

" Check if a synstack has any XMLish attribute.
fu! SynXMLishAny(syns)
  for synattr in a:syns
    if SynAttrXMLish(synattr)
      return 1
    endif
  endfor
  return 0
endfu

" Check if a synstack denotes the end of a JSX block.
fu! SynJSXBlockEnd(syns)
  return get(a:syns, -1) == 'jsBraces' && SynAttrXMLish(get(a:syns, -2))
endfu

" Cleverly mix JS and XML indentation.
fu! GetJsxIndent()
  let cursyn  = SynSOL(v:lnum)
  let prevsyn = SynEOL(v:lnum - 1)

  " Use XML indenting if the syntax at the end of the previous line was either
  " JSX or was the closing brace of a jsBlock whose parent syntax was JSX.
  if (SynXMLish(prevsyn) || SynJSXBlockEnd(prevsyn)) && SynXMLishAny(cursyn)
    let ind = XmlIndentGet(v:lnum, 0)

    " Align '/>' with '<' for multiline self-closing tags.
    if getline(v:lnum) =~? s:sctag
      let ind = ind - &sw
    endif

    " Then correct the indentation of any JSX following '/>'.
    if getline(v:lnum - 1) =~? s:sctag
      let ind = ind + &sw
    endif
  else
    let ind = GetJavascriptIndent()
  endif

  return ind
endfu
