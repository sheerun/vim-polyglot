if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'scss') == -1

" Vim indent file
" Language    : SCSS (Sassy CSS)
" Maintainer  : Daniel Hofstetter (daniel.hofstetter@42dh.com)
" URL         : https://github.com/cakebaker/scss-syntax.vim
" Last Change : 2019-08-04
" Based on    : css.vim by Nikolai Weibull, Oleg Zubchenko
" Modified by : ObserverOfTime

if exists('b:did_indent') | finish | endif
let b:did_indent = 1

setlocal indentexpr=GetSCSSIndent()
setlocal indentkeys=0{,0},0(,0),!^F,o,O
setlocal nosmartindent

let b:undo_indent = 'setl smartindent< indentkeys< indentexpr<'

if exists('*GetSCSSIndent') | finish | endif
let s:keepcpo= &cpoptions
set cpoptions&vim

function s:prevnonblanknoncomment(lnum)
  let l:lnum = a:lnum
  while l:lnum > 1
    let l:lnum = prevnonblank(l:lnum)
    let l:line = getline(l:lnum)
    if l:line =~? '\*/'
      while l:lnum > 1 && l:line !~? '/\*'
        let l:lnum -= 1
      endwhile
      if l:line =~? '^\s*/\*'
        let l:lnum -= 1
      else
        break
      endif
    else
      break
    endif
  endwhile
  return l:lnum
endfunction

function s:count_chars(lnum, count_open, chars)
  let l:n_open = 0
  let l:n_close = 0
  let l:line = getline(a:lnum)
  let l:pattern = '['. a:chars .']'
  let l:i = match(l:line, l:pattern)
  let l:noi = 'scss\%(Comment\|StringQ\{1,2}\)'
  while l:i != -1
    if synIDattr(synID(a:lnum, l:i + 1, 0), 'name') !~? l:noi
      if l:line[l:i] ==# a:chars[0]
        let l:n_open += 1
      elseif l:line[l:i] ==# a:chars[1]
        if l:n_open > 0
          let l:n_open -= 1
        else
          let l:n_close += 1
        endif
      endif
    endif
    let l:i = match(l:line, l:pattern, l:i + 1)
  endwhile
  return a:count_open ? l:n_open : l:n_close
endfunction

function GetSCSSIndent()
  let l:line = getline(v:lnum)
  if l:line =~? '^\s*\*'
    return cindent(v:lnum)
  endif

  let l:pnum = s:prevnonblanknoncomment(v:lnum - 1)
  if l:pnum == 0
    return 0
  endif

  return indent(l:pnum)
        \ + s:count_chars(l:pnum, 1, '{}') * shiftwidth()
        \ - s:count_chars(v:lnum, 0, '{}') * shiftwidth()
        \ + s:count_chars(l:pnum, 1, '()') * shiftwidth()
        \ - s:count_chars(v:lnum, 0, '()') * shiftwidth()
endfunction

let &cpoptions = s:keepcpo
unlet s:keepcpo

" vim:set et ts=2 sw=2:


endif
