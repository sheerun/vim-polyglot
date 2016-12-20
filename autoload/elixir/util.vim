if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elixir') == -1
  
let s:SKIP_SYNTAX = '\%(Comment\|String\)$'
let s:BLOCK_SKIP = "synIDattr(synID(line('.'),col('.'),1),'name') =~? '".s:SKIP_SYNTAX."'"

function! elixir#util#is_indentable_at(line, col)
  if a:col == -1 " skip synID lookup for not found match
    return 1
  end
  " TODO: Remove these 2 lines
  " I don't know why, but for the test on spec/indent/lists_spec.rb:24.
  " Vim is making some mess on parsing the syntax of 'end', it is being
  " recognized as 'elixirString' when should be recognized as 'elixirBlock'.
  call synID(a:line, a:col, 1)
  " This forces vim to sync the syntax. Using fromstart is very slow on files
  " over 1k lines
  syntax sync minlines=20 maxlines=150

  return synIDattr(synID(a:line, a:col, 1), "name")
        \ !~ s:SKIP_SYNTAX
endfunction

function! elixir#util#is_indentable_match(line, pattern)
  return elixir#util#is_indentable_at(a:line.num, match(a:line.text, a:pattern))
endfunction

function! elixir#util#count_indentable_symbol_diff(line, open, close)
  if elixir#util#is_indentable_match(a:line, a:open)
        \ && elixir#util#is_indentable_match(a:line, a:close)
    return
          \   s:match_count(a:line.text, a:open)
          \ - s:match_count(a:line.text, a:close)
  else
    return 0
  end
endfunction

function! s:match_count(string, pattern)
  let size = strlen(a:string)
  let index = 0
  let counter = 0

  while index < size
    let index = match(a:string, a:pattern, index)
    if index >= 0
      let index += 1
      let counter +=1
    else
      break
    end
  endwhile

  return counter
endfunction

endif
