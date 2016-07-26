if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'lua') == -1
  
" Vim indent file
" Language: Lua
" URL: https://github.com/tbastos/vim-lua

" Initialization ------------------------------------------{{{1

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal autoindent
setlocal nosmartindent

setlocal indentexpr=GetLuaIndent()
setlocal indentkeys+=0=end,0=until,0=elseif,0=else

" Only define the function once.
if exists("*GetLuaIndent")
  finish
endif

" Variables -----------------------------------------------{{{1

let s:open_patt = '\%(\<\%(function\|if\|repeat\|do\)\>\|(\|{\)'
let s:middle_patt = '\<\%(else\|elseif\)\>'
let s:close_patt = '\%(\<\%(end\|until\)\>\|)\|}\)'

let s:anon_func_start = '\S\+\s*[({].*\<function\s*(.*)\s*$'
let s:anon_func_end = '\<end\%(\s*[)}]\)\+'

" Expression used to check whether we should skip a match with searchpair().
let s:skip_expr = "synIDattr(synID(line('.'),col('.'),1),'name') =~ 'luaComment\\|luaString'"

" Auxiliary Functions -------------------------------------{{{1

function s:IsInCommentOrString(lnum, col)
  return synIDattr(synID(a:lnum, a:col, 1), 'name') =~ 'luaCommentLong\|luaStringLong'
        \ && !(getline(a:lnum) =~ '^\s*\%(--\)\?\[=*\[') " opening tag is not considered 'in'
endfunction

" Find line above 'lnum' that isn't blank, in a comment or string.
function s:PrevLineOfCode(lnum)
  let lnum = prevnonblank(a:lnum)
  while s:IsInCommentOrString(lnum, 1)
    let lnum = prevnonblank(lnum - 1)
  endwhile
  return lnum
endfunction

" Gets line contents, excluding trailing comments.
function s:GetContents(lnum)
  return substitute(getline(a:lnum), '\v\m--.*$', '', '')
endfunction

" GetLuaIndent Function -----------------------------------{{{1

function GetLuaIndent()
  " if the line is in a long comment or string, don't change the indent
  if s:IsInCommentOrString(v:lnum, 1)
    return -1
  endif

  let prev_line = s:PrevLineOfCode(v:lnum - 1)
  if prev_line == 0
    " this is the first non-empty line
    return 0
  endif

  let contents_cur = s:GetContents(v:lnum)
  let contents_prev = s:GetContents(prev_line)

  let original_cursor_pos = getpos(".")

  let i = 0

  " check if the previous line opens blocks
  call cursor(v:lnum, 1)
  let num_pairs = searchpair(s:open_patt, s:middle_patt, s:close_patt,
        \ 'mrb', s:skip_expr, prev_line)
  if num_pairs > 0
    let i += num_pairs
  endif

  " special case: call(with, {anon = function() -- should indent only once
  if num_pairs > 1 && contents_prev =~ s:anon_func_start
    let i = 1
  endif

  " check if current line closes blocks
  call cursor(prev_line, col([prev_line,'$']))
  let num_pairs = searchpair(s:open_patt, s:middle_patt, s:close_patt,
        \ 'mr', s:skip_expr, v:lnum)
  if num_pairs > 0
    let i -= num_pairs
  endif

  " special case: end}) -- end of call with anon func should unindent once
  if num_pairs > 1 && contents_cur =~ s:anon_func_end
    let i = -1
  endif

  " if the previous line closed a paren, unindent (except with anon funcs)
  call cursor(prev_line - 1, col([prev_line - 1, '$']))
  let num_pairs = searchpair('(', '', ')', 'mr', s:skip_expr, prev_line)
  if num_pairs > 0 && contents_prev !~ s:anon_func_end
    let i -= 1
  endif

  " if this line closed a paren, indent (except with anon funcs)
  call cursor(prev_line, col([prev_line, '$']))
  let num_pairs = searchpair('(', '', ')', 'mr', s:skip_expr, v:lnum)
  if num_pairs > 0 && contents_cur !~ s:anon_func_end
    let i += 1
  endif

  " restore cursor
  call setpos(".", original_cursor_pos)

  return indent(prev_line) + (&sw * i)

endfunction

endif
