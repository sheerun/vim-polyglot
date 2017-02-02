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
  " initiates the `line` dictionary
  let line = s:build_line(v:lnum)

  if s:is_beginning_of_file(line)
    " Reset `old_ind` dictionary at the beginning of the file
    let b:old_ind = {}
    " At the start of the file use zero indent.
    return 0
  elseif !s:is_indentable_line(line)
    " Keep last line indentation if the current line does not have an
    " indentable syntax
    return indent(line.last_non_blank.num)
  else
    " Calculates the indenation level based on the rules
    " All the rules are defined in `autoload/elixir/indent.vim`
    let ind = indent(line.last_non_blank.num)
    call s:debug('>>> line = ' . string(line.current))
    call s:debug('>>> ind = ' . ind)
    let ind = s:indent('deindent_case_arrow', ind, line)
    let ind = s:indent('indent_parenthesis', ind, line)
    let ind = s:indent('indent_square_brackets', ind, line)
    let ind = s:indent('indent_brackets', ind, line)
    let ind = s:indent('deindent_opened_symbols', ind, line)
    let ind = s:indent('indent_pipeline_assignment', ind, line)
    let ind = s:indent('indent_pipeline_continuation', ind, line)
    let ind = s:indent('indent_after_pipeline', ind, line)
    let ind = s:indent('indent_assignment', ind, line)
    let ind = s:indent('indent_ending_symbols', ind, line)
    let ind = s:indent('indent_keywords', ind, line)
    let ind = s:indent('deindent_keywords', ind, line)
    let ind = s:indent('deindent_ending_symbols', ind, line)
    let ind = s:indent('indent_case_arrow', ind, line)
    let ind = s:indent('indent_ecto_queries', ind, line)
    call s:debug('<<< final = ' . ind)
    return ind
  end
endfunction

function s:indent(rule, ind, line)
  let Fn = function('elixir#indent#'.a:rule)
  let ind = Fn(a:ind, a:line)
  call s:debug(a:rule . ' = ' . ind)
  return ind
endfunction

function s:debug(message)
  if get(g:, 'elixir_indent_debug', 0)
    echom a:message
  end
endfunction

function! s:is_beginning_of_file(line)
  return a:line.last_non_blank.num == 0
endfunction

function! s:is_indentable_line(line)
  return elixir#util#is_indentable_at(a:line.current.num, 1)
endfunction

function! s:build_line(line)
  let line = { 'current': {}, 'last': {}, 'last_non_blank': {} }
  let line.current = s:new_line(a:line)
  let line.last = s:new_line(line.current.num - 1)
  let line.last_non_blank = s:new_line(prevnonblank(line.current.num - 1))

  return line
endfunction

function! s:new_line(num)
  return {
        \ "num": a:num,
        \ "text": getline(a:num)
        \ }
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save

endif
