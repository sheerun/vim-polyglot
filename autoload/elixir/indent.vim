if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elixir') == -1
  
let s:NO_COLON_BEFORE = ':\@<!'
let s:NO_COLON_AFTER = ':\@!'
let s:ENDING_SYMBOLS = '\]\|}\|)'
let s:STARTING_SYMBOLS = '\[\|{\|('
let s:ARROW = '->'
let s:END_WITH_ARROW = s:ARROW.'$'
let s:SKIP_SYNTAX = '\%(Comment\|String\)$'
let s:BLOCK_SKIP = "synIDattr(synID(line('.'),col('.'),1),'name') =~? '".s:SKIP_SYNTAX."'"
let s:DEF = '^\s*def'
let s:FN = '\<fn\>'
let s:MULTILINE_FN = s:FN.'\%(.*end\)\@!'
let s:BLOCK_START = '\%(\<do\>\|'.s:FN.'\)\>'
let s:MULTILINE_BLOCK = '\%(\<do\>'.s:NO_COLON_AFTER.'\|'.s:MULTILINE_FN.'\)'
let s:BLOCK_MIDDLE = '\<\%(else\|match\|elsif\|catch\|after\|rescue\)\>'
let s:BLOCK_END = 'end'
let s:STARTS_WITH_PIPELINE = '^\s*|>.*$'
let s:ENDING_WITH_ASSIGNMENT = '=\s*$'
let s:INDENT_KEYWORDS = s:NO_COLON_BEFORE.'\%('.s:MULTILINE_BLOCK.'\|'.s:BLOCK_MIDDLE.'\)'
let s:DEINDENT_KEYWORDS = '^\s*\<\%('.s:BLOCK_END.'\|'.s:BLOCK_MIDDLE.'\)\>'
let s:PAIR_START = '\<\%('.s:NO_COLON_BEFORE.s:BLOCK_START.'\)\>'.s:NO_COLON_AFTER
let s:PAIR_MIDDLE = '^\s*\%('.s:BLOCK_MIDDLE.'\)\>'.s:NO_COLON_AFTER.'\zs'
let s:PAIR_END = '\<\%('.s:NO_COLON_BEFORE.s:BLOCK_END.'\)\>\zs'

function! s:pending_parenthesis(line)
  if a:line.last.text !~ s:ARROW
    return elixir#util#count_indentable_symbol_diff(a:line.last, '(', '\%(end\s*\)\@<!)')
  end
endfunction

function! s:pending_square_brackets(line)
  if a:line.last.text !~ s:ARROW
    return elixir#util#count_indentable_symbol_diff(a:line.last, '[', ']')
  end
endfunction

function! s:pending_brackets(line)
  if a:line.last.text !~ s:ARROW
    return elixir#util#count_indentable_symbol_diff(a:line.last, '{', '}')
  end
endfunction

function! elixir#indent#deindent_case_arrow(ind, line)
  if get(b:old_ind, 'arrow', 0) > 0
        \ && (a:line.current.text =~ s:ARROW
        \ || a:line.current.text =~ s:BLOCK_END)
    let ind = b:old_ind.arrow
    let b:old_ind.arrow = 0
    return ind
  else
    return a:ind
  end
endfunction

function! elixir#indent#deindent_ending_symbols(ind, line)
  if a:line.current.text =~ '^\s*\('.s:ENDING_SYMBOLS.'\)'
    return a:ind - &sw
  else
    return a:ind
  end
endfunction

function! elixir#indent#deindent_keywords(ind, line)
  if a:line.current.text =~ s:DEINDENT_KEYWORDS
    let bslnum = searchpair(
          \ s:PAIR_START,
          \ s:PAIR_MIDDLE,
          \ s:PAIR_END,
          \ 'nbW',
          \ s:BLOCK_SKIP
          \ )

    return indent(bslnum)
  else
    return a:ind
  end
endfunction

function! elixir#indent#deindent_opened_symbols(ind, line)
  let s:opened_symbol =
        \   s:pending_parenthesis(a:line)
        \ + s:pending_square_brackets(a:line)
        \ + s:pending_brackets(a:line)

  if s:opened_symbol < 0
    let ind = get(b:old_ind, 'symbol', a:ind + (s:opened_symbol * &sw))
    let ind = float2nr(ceil(floor(ind)/&sw)*&sw)
    return ind <= 0 ? 0 : ind
  else
    return a:ind
  end
endfunction

function! elixir#indent#indent_after_pipeline(ind, line)
  if a:line.last.text =~ s:STARTS_WITH_PIPELINE
    if empty(substitute(a:line.current.text, ' ', '', 'g'))
          \ || a:line.current.text =~ s:STARTS_WITH_PIPELINE
      return indent(a:line.last.num)
    elseif a:line.last.text !~ s:INDENT_KEYWORDS
      let ind = b:old_ind.pipeline
      let b:old_ind.pipeline = 0
      return ind
    end
  end

  return a:ind
endfunction

function! elixir#indent#indent_assignment(ind, line)
  if a:line.last.text =~ s:ENDING_WITH_ASSIGNMENT
    let b:old_ind.pipeline = indent(a:line.last.num) " FIXME: side effect
    return a:ind + &sw
  else
    return a:ind
  end
endfunction

function! elixir#indent#indent_brackets(ind, line)
  if s:pending_brackets(a:line) > 0
    return a:ind + &sw
  else
    return a:ind
  end
endfunction

function! elixir#indent#indent_case_arrow(ind, line)
  if a:line.last.text =~ s:END_WITH_ARROW && a:line.last.text !~ '\<fn\>'
    let b:old_ind.arrow = a:ind
    return a:ind + &sw
  else
    return a:ind
  end
endfunction

function! elixir#indent#indent_ending_symbols(ind, line)
  if a:line.last.text =~ '^\s*\('.s:ENDING_SYMBOLS.'\)\s*$'
    return a:ind + &sw
  else
    return a:ind
  end
endfunction

function! elixir#indent#indent_keywords(ind, line)
  if a:line.last.text =~ s:INDENT_KEYWORDS
    return a:ind + &sw
  else
    return a:ind
  end
endfunction

function! elixir#indent#indent_parenthesis(ind, line)
  if s:pending_parenthesis(a:line) > 0
        \ && a:line.last.text !~ s:DEF
        \ && a:line.last.text !~ s:END_WITH_ARROW
    let b:old_ind.symbol = a:ind
    return matchend(a:line.last.text, '(')
  else
    return a:ind
  end
endfunction

function! elixir#indent#indent_pipeline_assignment(ind, line)
  if a:line.current.text =~ s:STARTS_WITH_PIPELINE
        \ && a:line.last.text =~ '^[^=]\+=.\+$'
    let b:old_ind.pipeline = indent(a:line.last.num)
    " if line starts with pipeline
    " and last line is an attribution
    " indents pipeline in same level as attribution
    return match(a:line.last.text, '=\s*\zs[^ ]')
  else
    return a:ind
  end
endfunction

function! elixir#indent#indent_pipeline_continuation(ind, line)
  if a:line.last.text =~ s:STARTS_WITH_PIPELINE
        \ && a:line.current.text =~ s:STARTS_WITH_PIPELINE
    return indent(a:line.last.num)
  else
    return a:ind
  end
endfunction

function! elixir#indent#indent_square_brackets(ind, line)
  if s:pending_square_brackets(a:line) > 0
    if a:line.last.text =~ '[\s*$'
      return a:ind + &sw
    else
      " if start symbol is followed by a character, indent based on the
      " whitespace after the symbol, otherwise use the default shiftwidth
      " Avoid negative indentation index
      return matchend(a:line.last.text, '[\s*')
    end
  else
    return a:ind
  end
endfunction

function! elixir#indent#deindent_case_arrow(ind, line)
  if get(b:old_ind, 'arrow', 0) > 0
        \ && (a:line.current.text =~ s:ARROW
        \ || a:line.current.text =~ s:BLOCK_END)
    let ind = b:old_ind.arrow
    let b:old_ind.arrow = 0
    return ind
  else
    return a:ind
  end
endfunction

endif
