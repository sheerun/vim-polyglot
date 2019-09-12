if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'graphql') == -1

" Vim indent file
" Language: GraphQL
" Maintainer: Jon Parise <jon@indelible.org>

if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

setlocal autoindent
setlocal nocindent
setlocal nolisp
setlocal nosmartindent

setlocal indentexpr=GetGraphQLIndent()
setlocal indentkeys=0{,0},0),0[,0],0#,!^F,o,O

" If our indentation function already exists, we have nothing more to do.
if exists('*GetGraphQLIndent')
  finish
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

" Check if the character at lnum:col is inside a string.
function s:InString(lnum, col)
  return synIDattr(synID(a:lnum, a:col, 1), 'name') is# 'graphqlString'
endfunction

function GetGraphQLIndent()
  " If this is the first non-blank line, we have nothing more to do because
  " all of our indentation rules are based on matching against earlier lines.
  let l:prevlnum = prevnonblank(v:lnum - 1)
  if l:prevlnum == 0
    return 0
  endif

  let l:line = getline(v:lnum)

  " If this line contains just a closing bracket, find its matching opening
  " bracket and indent the closing backet to match.
  let l:col = matchend(l:line, '^\s*[]})]')
  if l:col > 0 && !s:InString(v:lnum, l:col)
    let l:bracket = l:line[l:col - 1]
    call cursor(v:lnum, l:col)

    if l:bracket is# '}'
      let l:matched = searchpair('{', '', '}', 'bW')
    elseif l:bracket is# ']'
      let l:matched = searchpair('\[', '', '\]', 'bW')
    elseif l:bracket is# ')'
      let l:matched = searchpair('(', '', ')', 'bW')
    else
      let l:matched = -1
    endif

    return l:matched > 0 ? indent(l:matched) : virtcol('.') - 1
  endif

  " If we're inside of a multiline string, continue with the same indentation.
  if s:InString(v:lnum, matchend(l:line, '^\s*') + 1)
    return indent(v:lnum)
  endif

  " If the previous line contained an opening bracket, and we are still in it,
  " add indent depending on the bracket type.
  if getline(l:prevlnum) =~# '[[{(]\s*$'
    return indent(l:prevlnum) + shiftwidth()
  endif

  " Default to the existing indentation level.
  return indent(l:prevlnum)
endfunction

let &cpoptions = s:cpo_save
unlet s:cpo_save

endif
