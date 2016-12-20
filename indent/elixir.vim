if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elixir') == -1
  
setlocal nosmartindent
setlocal indentexpr=elixir#indent()
setlocal indentkeys+=0),0],0=\|>,=->
setlocal indentkeys+=0=end,0=else,0=match,0=elsif,0=catch,0=after,0=rescue

if exists("b:did_indent") || exists("*elixir#indent")
  finish
end
let b:did_indent = 1

let s:cpo_save = &cpo
set cpo&vim

function! elixir#indent()
  " initiates the `old_ind` dictionary
  let b:old_ind = get(b:, 'old_ind', {})
  " initialtes the `line` dictionary
  let line = s:build_line(v:lnum)

  if s:is_beginning_of_file(line)
    " Reset `old_ind` dictionary at the beginning of the file
    let b:old_ind = {}
    " At the start of the file use zero indent.
    return 0
  elseif !s:is_indentable_line(line)
    " Keep last line indentation if the current line does not have an
    " indentable syntax
    return indent(line.last.num)
  else
    " Calculates the indenation level based on the rules
    " All the rules are defined in `autoload/indent.vim`
    let ind = indent(line.last.num)
    let ind = elixir#indent#deindent_case_arrow(ind, line)
    let ind = elixir#indent#indent_parenthesis(ind, line)
    let ind = elixir#indent#indent_square_brackets(ind, line)
    let ind = elixir#indent#indent_brackets(ind, line)
    let ind = elixir#indent#deindent_opened_symbols(ind, line)
    let ind = elixir#indent#indent_pipeline_assignment(ind, line)
    let ind = elixir#indent#indent_pipeline_continuation(ind, line)
    let ind = elixir#indent#indent_after_pipeline(ind, line)
    let ind = elixir#indent#indent_assignment(ind, line)
    let ind = elixir#indent#indent_ending_symbols(ind, line)
    let ind = elixir#indent#indent_keywords(ind, line)
    let ind = elixir#indent#deindent_keywords(ind, line)
    let ind = elixir#indent#deindent_ending_symbols(ind, line)
    let ind = elixir#indent#indent_case_arrow(ind, line)
    return ind
  end
endfunction

function! s:is_beginning_of_file(line)
  return a:line.last.num == 0
endfunction

function! s:is_indentable_line(line)
  return elixir#util#is_indentable_at(a:line.current.num, 1)
endfunction

function! s:build_line(line)
  let line = { 'current': {}, 'last': {} }
  let line.current.num = a:line
  let line.current.text = getline(line.current.num)
  let line.last.num = prevnonblank(line.current.num - 1)
  let line.last.text = getline(line.last.num)

  return line
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save

endif
