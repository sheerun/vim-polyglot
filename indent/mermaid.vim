if polyglot#init#is_disabled(expand('<sfile>:p'), 'mermaid', 'indent/mermaid.vim')
  finish
endif

let s:indent_next_line_keywords = [
      \ '^classDiagram',
      \ '^classDiagram-v2',
      \ '^erDiagram',
      \ '^gantt',
      \ '^graph',
      \ '^flowchart',
      \ '^pie',
      \ '^sequenceDiagram',
      \ '^stateDiagram',
      \ '^stateDiagram-v2',
      \ 'class.*{',
      \ 'subgraph',
      \ 'loop',
      \ 'alt',
      \ 'else',
      \ 'opt',
      \ 'par',
      \ 'and',
      \ 'rect',
      \ '[^a-z]activate',
      \ ]

let s:deindent_current_line_keywords = [
      \ '^\s\+classDiagram',
      \ '^\s\+classDiagram-v2',
      \ '^\s\+erDiagram',
      \ '^\s\+gantt',
      \ '^\s\+graph',
      \ '^\s\+flowchart',
      \ '^\s\+pie',
      \ '^\s\+sequenceDiagram',
      \ '^\s\+stateDiagram',
      \ '^\s\+stateDiagram-v2',
      \ '^\s\+end$',
      \ '^\s\+}$',
      \ '^\s\+deactivate$'
      \ ]

function! s:matches_any_word_in(text, list)
  return empty(filter(copy(a:list), {_idx, val -> matchstr(a:text, val) != ""})) == v:false
endfunction

function! MermaidIndent()
  let sw = shiftwidth()
  let indent_level = indent(v:lnum - 1) / sw
  let current_line = getline(v:lnum)
  let line_above = getline(v:lnum - 1)

  " TODO don't incorrect indent when has empty lines inside graph
  if s:matches_any_word_in(current_line, s:deindent_current_line_keywords)
    return (indent_level - 1) * sw
  endif

  if s:matches_any_word_in(line_above, s:indent_next_line_keywords)
    return (indent_level + 1) * sw
  endif

  return indent_level * sw
endfunction
