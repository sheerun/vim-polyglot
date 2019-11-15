if !exists('g:polyglot_disabled') || !(index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'jsx') != -1)

if exists('*shiftwidth')
  function! s:sw()
    return shiftwidth()
  endfunction
else
  function! s:sw()
    return &sw
  endfunction
endif

" Regexp for the start tag
let s:start_tag = '<\_s*\%(>\|\${\|\%(\<[-:._$A-Za-z0-9]\+\>\)\)'
" Regexp for the end tag
let s:end_tag = '\%(<\_s*/\_s*\%(\<[-:._$A-Za-z0-9]\+\>\)\_s*>\|/\_s*>\)'

function s:trim(line)
  return substitute(a:line, '^\s*\|\s*$', '', 'g')
endfunction

" Get the syntax stack at the given position
function s:syntax_stack_at(lnum, col)
  return map(synstack(a:lnum, a:col), 'synIDattr(v:val, "name")')
endfunction

" Get the syntax at the given position
function s:syntax_at(lnum, col)
  return synIDattr(synID(a:lnum, a:col, 1), 'name')
endfunction

" Get the start col of the non-space charactor
function s:start_col(lnum)
  return len(matchstr(getline(a:lnum), '^\s*')) + 1
endfunction

" Get the start syntax of a given line number
function s:start_syntax(lnum)
  return s:syntax_at(a:lnum, s:start_col(a:lnum))
endfunction

" The skip function for searchpair
function s:skip_if_not(current_lnum, ...)
  " Skip the match in current line
  if line('.') == a:current_lnum
    return 1
  endif

  let syntax = s:syntax_at(line('.'), col('.'))
  return syntax !~? join(a:000, '\|')
endfunction

" Whether the specified stytax group is the opening tag
function s:is_opening_tag(syntax)
  return a:syntax =~? 'jsxOpenPunct'
endfunction

" Whether the specified stytax group is the closing tag
function s:is_closing_tag(syntax)
  return a:syntax =~? 'jsxClose'
endfunction

" Whether the specified syntax group is the jsxRegion
function s:is_jsx_region(syntax)
  return a:syntax =~? 'jsxRegion'
endfunction

" Whether the specified syntax group is the jsxElement
function s:is_jsx_element(syntax)
  return a:syntax =~? 'jsxElement'
endfunction

" Whether the specified syntax group is the jsxEscapeJs
function s:is_jsx_escape(syntax)
  return a:syntax =~? 'jsxEscapeJs'
endfunction

" Whether the specified syntax group is the jsxBraces
function s:is_jsx_brace(syntax)
  return a:syntax =~? 'jsxBraces'
endfunction

" Whether the specified syntax group is the jsxComment
function s:is_jsx_comment(syntax)
  return a:syntax =~? 'jsxComment'
endfunction

" Whether the specified line is comment related syntax
function s:is_comment(syntax)
  return a:syntax =~? 'comment'
endfunction

" Whether the specified syntax group is the jsxComment
function s:is_jsx_backticks(syntax)
  return a:syntax =~? 'jsxBackticks'
endfunction

" Get the prvious line number
function s:prev_lnum(lnum)
  return prevnonblank(a:lnum - 1)
endfunction

" Whether the given pos is the parent of the given element who has
" element_count jsxElement syntax
function s:is_parent_element(pos, element_count)
  let syntax_stack = s:syntax_stack_at(a:pos[0], a:pos[1])
  return s:is_opening_tag(syntax_stack[-1]) &&
        \ count(syntax_stack, 'jsxElement') <= a:element_count
endfunction

" Compute the indention of the trail punct
function s:jsx_indent_trail_punct(lnum)
  let pair_line = searchpair('<', '', '>', 'bW', 's:skip_if_not(a:lnum, "jsxOpenPunct", "jsxClose")')
  return indent(pair_line)
endfunction

" Compute the indention of the closing tag
function s:jsx_indent_closing_tag(lnum)
  let pair_line = searchpair(s:start_tag, '', s:end_tag, 'bW', 's:skip_if_not(a:lnum, "jsxOpenPunct", "jsxClose")')
  return pair_line ? indent(pair_line) : indent(a:lnum)
endfunction

" Compute the indentation of the jsxElement
function s:jsx_indent_element(lnum)
  let syntax_stack = s:syntax_stack_at(a:lnum, s:start_col(a:lnum))
  let syntax_name = syntax_stack[-1]
  let element_count = count(syntax_stack, 'jsxElement')

  if s:trim(getline(a:lnum)) =~ '^>'
    return s:jsx_indent_trail_punct(a:lnum)
  endif

  " If current tag is closing tag
  if s:is_closing_tag(syntax_name)
    return s:jsx_indent_closing_tag(a:lnum)
  endif

  " Normalize the jsxElement count for opening tag
  if s:is_opening_tag(syntax_name)
    " <div>
    "   <div></div> <-- jsxRegion->jsxElement->jsxElement->jsxTag->jsxOpenTag->jsxOpenPunct
    " </div>
    if s:is_jsx_element(syntax_stack[-4]) && s:is_jsx_element(syntax_stack[-5])
      let element_count = element_count - 1
    endif
  endif

  let start_time = localtime()
  let pos = searchpos(s:start_tag, 'bW')

  while !s:is_parent_element(pos, element_count)
    if localtime() - start_time >= 0.5
      return -1
    endif
    let pos = searchpos(s:start_tag, 'bW')
  endwhile

  return indent(pos[0]) + s:sw()
endfunction

" Compute the indentation of the comment
function s:jsx_indent_comment(lnum)
  let line = s:trim(getline(a:lnum))

  if s:is_jsx_comment(s:start_syntax(a:lnum))
    if line =~ '^<!--' || line =~ '^-->'
      return s:jsx_indent_element(a:lnum)
    else
      return s:jsx_indent_element(a:lnum) + s:sw()
    endif
  else
    if line =~ '^/\*' || line =~ '^//'
      return s:jsx_indent_element(a:lnum)
    else
      return s:jsx_indent_element(a:lnum) + 1
    endif
  endif
endfunction

" Compute the indentation of jsxBackticks
function s:jsx_indent_backticks(lnum)
  let tags = get(g:, 'vim_jsx_pretty_template_tags', ['html', 'jsx'])
  let start_tag = '\%(' . join(tags, '\|') . '\)`'
  let end_tag = '\%(' . join(tags, '\|') . '\)\@<!`'
  let pair_line = searchpair(start_tag, '', end_tag, 'bW', 's:skip_if_not(a:lnum)')

  return indent(pair_line)
endfunction

" Syntax context types:
" - jsxRegion
" - jsxTaggedRegion
" - jsxElement
" - jsxEscapeJs
" - Other
function s:syntax_context(lnum)
  let start_col = s:start_col(a:lnum)
  let syntax_stack = s:syntax_stack_at(a:lnum, start_col)
  let start_syntax = syntax_stack[-1]
  let reversed = reverse(syntax_stack)
  let i = 0

  for syntax_name in reversed
    " If the current line is jsxEscapeJs and not starts with jsxBraces
    if s:is_jsx_escape(syntax_name)
      return 'jsxEscapeJs'
    endif

    if s:is_jsx_region(syntax_name)
      return 'jsxRegion'
    endif

    if s:is_jsx_element(syntax_name)
      " If current line starts with the opening tag
      if s:is_opening_tag(start_syntax) || s:is_closing_tag(start_syntax)
        " And the next syntax is jsxRegion
        if s:is_jsx_region(reversed[i+1])
          return 'jsxRegion'
        elseif reversed[i+1] =~ 'jsxTaggedRegion'
          return 'jsxTaggedRegion'
        else
          return 'jsxElement'
        endif
      elseif reversed[i+1] =~ 'jsxTaggedRegion'
        return 'jsxTaggedRegion'
      else
        return 'jsxElement'
      endif
    endif

    let i = i + 1
  endfor
  
  return 'Other'
endfunction


function! jsx_pretty#indent#get(js_indent)
  let line = s:trim(getline(v:lnum))
  let start_syntax = s:start_syntax(v:lnum)

  if s:is_jsx_backticks(start_syntax)
    return s:jsx_indent_backticks(v:lnum)
  endif

  if s:is_jsx_brace(start_syntax)
    return s:jsx_indent_element(v:lnum)
  endif

  if s:is_opening_tag(start_syntax) && line =~ '^>'
    return s:jsx_indent_trail_punct(v:lnum)
  endif

  let syntax_context = s:syntax_context(v:lnum)

  if syntax_context == 'jsxRegion'
    if s:is_closing_tag(start_syntax)
      return s:jsx_indent_closing_tag(v:lnum)
    endif

    let prev_lnum = s:prev_lnum(v:lnum)
    let prev_line = s:trim(getline(prev_lnum))

    if prev_line =~ '[([{=?]$'
      return indent(prev_lnum) + s:sw()
    elseif prev_line =~ '[:|&<>]$' &&
          \ s:trim(getline(s:prev_lnum(prev_lnum))) !~ '[?:|&<>]$'
      return indent(prev_lnum) + s:sw()
    else
      return indent(prev_lnum)
    endif
  elseif syntax_context == 'jsxTaggedRegion'
    if s:is_closing_tag(start_syntax)
      return s:jsx_indent_closing_tag(v:lnum)
    elseif s:is_jsx_comment(start_syntax)
      return s:jsx_indent_comment(v:lnum)
    else
      return indent(s:prev_lnum(v:lnum)) + s:sw()
    endif
  elseif syntax_context == 'jsxElement'
    if s:is_jsx_comment(start_syntax)
      return s:jsx_indent_comment(v:lnum)
    endif

    if s:is_comment(start_syntax)
      return s:jsx_indent_comment(v:lnum)
    endif

    return s:jsx_indent_element(v:lnum)
  elseif syntax_context == 'jsxEscapeJs'
    let prev_lnum = s:prev_lnum(v:lnum)
    let prev_line = s:trim(getline(prev_lnum))

    if line =~ '^?'
      return indent(prev_lnum) + s:sw()
    elseif line =~ '^:'
      return indent(prev_lnum)
    else
      return a:js_indent()
    endif
  endif

  return a:js_indent()
endfunction

endif
