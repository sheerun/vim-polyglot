if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elixir') == -1
  
if exists("b:did_indent")
  finish
end
let b:did_indent = 1

setlocal nosmartindent

setlocal indentexpr=GetElixirIndent()
setlocal indentkeys+=0),0],0=end,0=else,0=match,0=elsif,0=catch,0=after,0=rescue,0=\|>

if exists("*GetElixirIndent")
  finish
end

let s:cpo_save = &cpo
set cpo&vim

let s:no_colon_before = ':\@<!'
let s:no_colon_after = ':\@!'
let s:symbols_end = '\]\|}\|)'
let s:symbols_start = '\[\|{\|('
let s:arrow = '^.*->$'
let s:skip_syntax = '\%(Comment\|String\)$'
let s:block_skip = "synIDattr(synID(line('.'),col('.'),1),'name') =~? '".s:skip_syntax."'"
let s:block_start = '\<\%(do\|fn\)\>'
let s:block_middle = 'else\|match\|elsif\|catch\|after\|rescue'
let s:block_end = 'end'
let s:starts_with_pipeline = '^\s*|>.*$'
let s:ending_with_assignment = '=\s*$'

let s:indent_keywords = '\<'.s:no_colon_before.'\%('.s:block_start.'\|'.s:block_middle.'\)$'.'\|'.s:arrow
let s:deindent_keywords = '^\s*\<\%('.s:block_end.'\|'.s:block_middle.'\)\>'.'\|'.s:arrow

let s:pair_start = '\<\%('.s:no_colon_before.s:block_start.'\)\>'.s:no_colon_after
let s:pair_middle = '^\s*\%('.s:block_middle.'\)\>'.s:no_colon_after.'\zs'
let s:pair_end = '\<\%('.s:no_colon_before.s:block_end.'\)\>\zs'

function! s:is_indentable_syntax()
  " TODO: Remove these 2 lines
  " I don't know why, but for the test on spec/indent/lists_spec.rb:24.
  " Vim is making some mess on parsing the syntax of 'end', it is being
  " recognized as 'elixirString' when should be recognized as 'elixirBlock'.
  call synID(s:current_line_ref, 1, 1)
  " This forces vim to sync the syntax.
  syntax sync fromstart

  return synIDattr(synID(s:current_line_ref, 1, 1), "name")
        \ !~ s:skip_syntax
endfunction

function! s:indent_opened_symbol(ind)
  if s:opened_symbol > 0
    if s:pending_parenthesis > 0
          \ && s:last_line !~ '^\s*def'
          \ && s:last_line !~ s:arrow
      let b:old_ind = a:ind
      return matchend(s:last_line, '(')
      " if start symbol is followed by a character, indent based on the
      " whitespace after the symbol, otherwise use the default shiftwidth
      " Avoid negative indentation index
    elseif s:last_line =~ '\('.s:symbols_start.'\).'
      let regex = '\('.s:symbols_start.'\)\s*'
      let opened_prefix = matchlist(s:last_line, regex)[0]
      return a:ind + (s:opened_symbol * strlen(opened_prefix))
    else
      return a:ind + (s:opened_symbol * &sw)
    end
  elseif s:opened_symbol < 0
    let ind = get(b:, 'old_ind', a:ind + (s:opened_symbol * &sw))
    let ind = float2nr(ceil(floor(ind)/&sw)*&sw)
    return ind <= 0 ? 0 : ind
  else
    return a:ind
  end
endfunction

function! s:indent_last_line_end_symbol_or_indent_keyword(ind)
  if s:last_line =~ '^\s*\('.s:symbols_end.'\)'
        \ || s:last_line =~ s:indent_keywords
    return a:ind + &sw
  else
    return a:ind
  end
endfunction

function! s:indent_symbols_ending(ind)
  if s:current_line =~ '^\s*\('.s:symbols_end.'\)'
    return a:ind - &sw
  else
    return a:ind
  end
endfunction

function! s:indent_assignment(ind)
  if s:last_line =~ s:ending_with_assignment
    let b:old_ind = indent(s:last_line_ref) " FIXME: side effect
    return a:ind + &sw
  else
    return a:ind
  end
endfunction

function! s:indent_pipeline(ind)
  if s:last_line =~ s:starts_with_pipeline
        \ && s:current_line =~ s:starts_with_pipeline
    indent(s:last_line_ref)
  elseif s:current_line =~ s:starts_with_pipeline
        \ && s:last_line =~ '^[^=]\+=.\+$'
    let b:old_ind = indent(s:last_line_ref)
    " if line starts with pipeline
    " and last line is an attribution
    " indents pipeline in same level as attribution
    return match(s:last_line, '=\s*\zs[^ ]')
  else
    return a:ind
  end
endfunction

function! s:indent_after_pipeline(ind)
  if s:last_line =~ s:starts_with_pipeline
    if empty(substitute(s:current_line, ' ', '', 'g'))
          \ || s:current_line =~ s:starts_with_pipeline
      return indent(s:last_line_ref)
    elseif s:last_line !~ s:indent_keywords
      return b:old_ind
    else
      return a:ind
    end
  else
    return a:ind
  end
endfunction

function! s:deindent_keyword(ind)
  if s:current_line =~ s:deindent_keywords
    let bslnum = searchpair(
          \ s:pair_start,
          \ s:pair_middle,
          \ s:pair_end,
          \ 'nbW',
          \ s:block_skip
          \ )

    return indent(bslnum)
  else
    return a:ind
  end
endfunction

function! s:indent_arrow(ind)
  if s:current_line =~ s:arrow
    " indent case statements '->'
    return a:ind + &sw
  else
    return a:ind
  end
endfunction

function! GetElixirIndent()
  let s:current_line_ref = v:lnum
  let s:last_line_ref = prevnonblank(s:current_line_ref - 1)
  let s:current_line = getline(s:current_line_ref)
  let s:last_line = getline(s:last_line_ref)
  let s:pending_parenthesis = 0
  let s:opened_symbol = 0

  if s:last_line !~ s:arrow
    let splitted_line = split(s:last_line, '\zs')
    let s:pending_parenthesis =
          \ + count(splitted_line, '(') - count(splitted_line, ')')
    let s:opened_symbol =
          \ + s:pending_parenthesis
          \ + count(splitted_line, '[') - count(splitted_line, ']')
          \ + count(splitted_line, '{') - count(splitted_line, '}')
  end

  if s:last_line_ref == 0
    " At the start of the file use zero indent.
    return 0
  elseif !s:is_indentable_syntax()
    " Current syntax is not indentable, keep last line indentation
    return indent(s:last_line_ref)
  else
    let ind = indent(s:last_line_ref)
    let ind = s:indent_opened_symbol(ind)
    let ind = s:indent_symbols_ending(ind)
    let ind = s:indent_pipeline(ind)
    let ind = s:indent_after_pipeline(ind)
    let ind = s:indent_assignment(ind)
    let ind = s:indent_last_line_end_symbol_or_indent_keyword(ind)
    let ind = s:deindent_keyword(ind)
    let ind = s:indent_arrow(ind)
    return ind
  end
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save

endif
