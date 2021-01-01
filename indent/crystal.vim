if polyglot#init#is_disabled(expand('<sfile>:p'), 'crystal', 'indent/crystal.vim')
  finish
endif

" Initialization {{{1
" ==============

" Only load this indent file when no other was loaded.
if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

if !exists('g:crystal_indent_assignment_style')
  " Possible values: 'variable', 'hanging'
  let g:crystal_indent_assignment_style = 'hanging'
endif

if !exists('g:crystal_indent_block_style')
  " Possible values: 'expression', 'do'
  let g:crystal_indent_block_style = 'expression'
endif

setlocal nosmartindent

" Now, set up our indentation expression and keys that trigger it.
setlocal indentexpr=GetCrystalIndent(v:lnum)
setlocal indentkeys=0{,0},0),0],!^F,o,O,e,.
setlocal indentkeys+==end,=else,=elsif,=when,=in,=ensure,=rescue

" Only define the function once.
if exists('*GetCrystalIndent')
  finish
endif

" Return the value of a single shift-width
if exists('*shiftwidth')
  let s:sw = function('shiftwidth')
else
  function! s:sw()
    return &shiftwidth
  endfunction
endif

" GetCrystalIndent Function {{{1
" =========================

function! GetCrystalIndent(...) abort
  " Setup {{{2
  " -----

  let indent_info = {}

  " The value of a single shift-width
  let indent_info.sw = s:sw()

  " For the current line, use the first argument if given, else v:lnum
  let indent_info.clnum = a:0 ? a:1 : v:lnum
  let indent_info.cline = getline(indent_info.clnum)

  " Set up variables for restoring position in file.
  let indent_info.col = col('.')

  " Work on the current line {{{2
  " ------------------------

  for callback_name in g:crystal#indent#curr_line_callbacks
    let indent = call(function(callback_name), [indent_info])

    if indent >= 0
      return indent
    endif
  endfor

  " Work on the previous line. {{{2
  " --------------------------

  " Special case: we don't need the real PrevNonBlank for an empty line
  " inside a string. And that call can be quite expensive in that
  " particular situation.
  let indent = crystal#indent#EmptyInsideString(indent_info)

  if indent >= 0
    return indent
  endif

  " Previous line number
  let indent_info.plnum = crystal#indent#PrevNonBlank(indent_info.clnum - 1)
  let indent_info.pline = getline(indent_info.plnum)

  for callback_name in g:crystal#indent#prev_line_callbacks
    let indent = call(function(callback_name), [indent_info])

    if indent >= 0
      return indent
    endif
  endfor

  " Work on the MSL. {{{2
  " ----------------

  " Most Significant line based on the previous one -- in case it's a
  " contination of something above
  let indent_info.plnum_msl = crystal#indent#GetMSL(indent_info.plnum)
  let indent_info.pline_msl = getline(indent_info.plnum_msl)

  for callback_name in g:crystal#indent#msl_callbacks
    let indent = call(function(callback_name), [indent_info])

    if indent >= 0
      return indent
    endif
  endfor

  " }}}2

  " By default, just return the previous line's indent
  return indent(indent_info.plnum)
endfunction

" }}}1

" vim:sw=2 sts=2 ts=8 fdm=marker et:
