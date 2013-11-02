" Vim indent file
" Language: Elixir
" Maintainer: Carlos Galdino <carloshsgaldino@gmail.com>
" Last Change: 2013 Apr 24

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal nosmartindent

setlocal indentexpr=GetElixirIndent(v:lnum)
setlocal indentkeys+==end,=else:,=match:,=elsif:,=catch:,=after:,=rescue:

if exists("*GetElixirIndent")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

let s:skip_syntax  = '\%(Comment\|String\)$'
let s:block_skip   = "synIDattr(synID(line('.'),col('.'),1),'name') =~? '" . s:skip_syntax . "'"
let s:block_start  = 'do\|fn'
let s:block_middle = 'else\|match\|elsif\|catch\|after\|rescue'
let s:block_end    = 'end'
let s:pipeline     = '^\s*|>.*$'

let s:indent_keywords   = '\<\%(' . s:block_start . '\|' . s:block_middle . '\)$'
let s:deindent_keywords = '^\s*\<\%(' . s:block_end . '\|' . s:block_middle . '\)\>'

function! GetElixirIndent(...)
  let lnum = prevnonblank(v:lnum - 1)
  let ind  = indent(lnum)

  " At the start of the file use zero indent.
  if lnum == 0
    return 0
  endif

  if synIDattr(synID(v:lnum, 1, 1), "name") !~ s:skip_syntax
    let splited_line = split(getline(lnum), '\zs')
    let opened_symbol  = 0
    let opened_symbol += count(splited_line, '[') - count(splited_line, ']')
    let opened_symbol += count(splited_line, '{') - count(splited_line, '}')

    let ind += opened_symbol * &sw

    if getline(lnum) =~ s:indent_keywords .
          \ '\|^\s*\%(.*->\)$'
      let ind += &sw
    endif

    " if line starts with pipeline
    " and last line doesn't start with pipeline
    if getline(v:lnum) =~ s:pipeline &&
          \ getline(lnum) !~ s:pipeline
      let ind += &sw
    endif

    " if last line starts with pipeline
    " and currentline doesn't start with pipeline
    if getline(lnum) =~ s:pipeline &&
          \ getline(v:lnum) !~ s:pipeline
      let ind -= &sw
    endif

    " if last line starts with pipeline
    " and current line doesn't start with pipeline
    " but last line started a block
    if getline(lnum) =~ s:pipeline &&
          \ getline(v:lnum) !~ s:pipeline &&
          \ getline(lnum) =~ s:block_start
      let ind += &sw
    endif

    if getline(v:lnum) =~ s:deindent_keywords
      let bslnum = searchpair( '\<\%(' . s:block_start . '\):\@!\>',
            \ '\<\%(' . s:block_middle . '\):\@!\>\zs',
            \ '\<:\@<!' . s:block_end . '\>\zs',
            \ 'nbW',
            \ s:block_skip )
      let ind = indent(bslnum)
    endif
  endif

  return ind
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
