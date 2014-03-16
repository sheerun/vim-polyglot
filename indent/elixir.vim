" Vim indent file
" Language: Elixir
" Maintainer: Carlos Galdino <carloshsgaldino@gmail.com>
" Last Change: 2013 Apr 24

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal nosmartindent

setlocal indentexpr=GetElixirIndent()
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
let s:arrow        = '^.*->$'
let s:pipeline     = '^\s*|>.*$'

let s:indent_keywords   = '\<\%(' . s:block_start . '\|' . s:block_middle . '\)$' . '\|' . s:arrow
let s:deindent_keywords = '^\s*\<\%(' . s:block_end . '\|' . s:block_middle . '\)\>' . '\|' . s:arrow

function! GetElixirIndent()
  let lnum = prevnonblank(v:lnum - 1)
  let ind  = indent(lnum)

  " At the start of the file use zero indent.
  if lnum == 0
    return 0
  endif

  " TODO: Remove these 2 lines
  " I don't know why, but for the test on spec/indent/lists_spec.rb:24.
  " Vim is making some mess on parsing the syntax of 'end', it is being
  " recognized as 'elixirString' when should be recognized as 'elixirBlock'.
  " This forces vim to sync the syntax.
  call synID(v:lnum, 1, 1)
  syntax sync fromstart

  if synIDattr(synID(v:lnum, 1, 1), "name") !~ s:skip_syntax
    let current_line = getline(v:lnum)
    let last_line = getline(lnum)

    let splited_line = split(last_line, '\zs')
    let opened_symbol = 0
    let opened_symbol += count(splited_line, '[') - count(splited_line, ']')
    let opened_symbol += count(splited_line, '{') - count(splited_line, '}')

    let ind += opened_symbol * &sw

    if current_line =~ '^\s*\(\]\|}\)'
      let ind -= &sw
    endif

    if last_line =~ s:indent_keywords
      let ind += &sw
    endif

    " if line starts with pipeline
    " and last line is an attribution
    " indents pipeline in same level as attribution
    if current_line =~ s:pipeline &&
          \ last_line =~ '^[^=]\+=.\+$'
      let b:old_ind = ind
      let ind = float2nr(matchend(last_line, '=\s*[^ ]') / &sw) * &sw
    endif

    " if last line starts with pipeline
    " and current line doesn't start with pipeline
    " returns the indentation before the pipeline
    if last_line =~ s:pipeline &&
          \ current_line !~ s:pipeline
      let ind = b:old_ind
    endif

    if current_line =~ s:deindent_keywords
      let bslnum = searchpair( '\<\%(' . s:block_start . '\):\@!\>',
            \ '\<\%(' . s:block_middle . '\):\@!\>\zs',
            \ '\<:\@<!' . s:block_end . '\>\zs',
            \ 'nbW',
            \ s:block_skip )

      let ind = indent(bslnum)
    endif

    " indent case statements '->'
    if current_line =~ s:arrow
      let ind += &sw
    endif
  endif

  return ind
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
