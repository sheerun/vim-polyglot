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

" Get the end col of the non-space charactor
function s:end_col(lnum)
  return len(substitute(getline(a:lnum), '\s*$', '', 'g'))
endfunction

" Get the start syntax of a given line number
function s:start_syntax(lnum)
  return s:syntax_at(a:lnum, s:start_col(a:lnum))
endfunction

" Get the end syntax of a given line number
function s:end_syntax(lnum)
  let end_col = len(substitute(getline(a:lnum), '\s*$', '', 'g'))
  return s:syntax_at(a:lnum, end_col)
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

" Whether the specified stytax group is an jsx-related syntax
function s:is_jsx(syntax_name)
  return a:syntax_name =~ '^jsx' && a:syntax_name !=? 'jsxEscapeJs'
endfunction

" Whether the specified line is start with jsx-related syntax
function s:start_with_jsx(lnum)
  let start_syntax = s:start_syntax(a:lnum)
  return s:is_jsx(start_syntax)
endfunction

" Whether the specified line is end with jsx-related syntax
function s:end_with_jsx(lnum)
  let end_syntax = s:end_syntax(a:lnum)
  return s:is_jsx(end_syntax)
endfunction

" Whether the specified line is comment related syntax
function s:is_comment(syntax)
  return a:syntax =~? 'comment'
endfunction

" Whether the specified line is embedded comment in jsxTag
function s:is_embedded_comment(lnum)
  let start_col = s:start_col(a:lnum)
  let syntax_stack = s:syntax_stack_at(a:lnum, start_col)
  let last = get(syntax_stack, -1)
  let last_2nd = get(syntax_stack, -2)

  " Patch code for pangloss/vim-javascript
  " <div
  "   /* hello */ <-- syntax stack is [..., jsxTag, jsComment, jsComment]
  " >
  if last_2nd =~ 'comment'
    let last_2nd = get(syntax_stack, -3)
  endif

  return last =~? 'comment' && last_2nd =~? 'jsxTag' &&
        \ trim(getline(a:lnum)) =~ '\%(^/[*/]\)\|\%(\*/$\)'
endfunction

" Whether the specified stytax group is the opening tag
function s:is_opening_tag(syntax)
  return a:syntax =~? 'jsxOpenPunct'
endfunction

" Whether the specified stytax group is the closing tag
function s:is_closing_tag(syntax)
  return a:syntax =~? 'jsxClose'
endfunction

" Whether the specified stytax group is the jsxAttrib
function s:is_jsx_attr(syntax)
  return a:syntax =~? 'jsxAttrib'
endfunction

" Whether the specified syntax group is the jsxElement
function s:is_jsx_element(syntax)
  return a:syntax =~? 'jsxElement'
endfunction

" Whether the specified syntax group is the jsxTag
function s:is_jsx_tag(syntax)
  return a:syntax =~? 'jsxTag'
endfunction

" Whether the specified syntax group is the jsxBraces
function s:is_jsx_brace(syntax)
  return a:syntax =~? 'jsxBraces'
endfunction

" Whether the specified syntax group is the jsxComment
function s:is_jsx_comment(syntax)
  return a:syntax =~? 'jsxComment'
endfunction

" Whether the specified syntax group is the jsxComment
function s:is_jsx_backticks(syntax)
  return a:syntax =~? 'jsxBackticks'
endfunction

" Get the prvious line number
function s:prev_lnum(lnum)
  return prevnonblank(a:lnum - 1)
endfunction

" Given a lnum and get the information of its previous line
function s:prev_info(lnum)
  let prev_lnum = s:prev_lnum(a:lnum)
  let prev_start_syntax = s:start_syntax(prev_lnum)
  let prev_end_syntax = s:end_syntax(prev_lnum)

  return [prev_lnum, prev_start_syntax, prev_end_syntax]
endfunction

" Get the length difference between syntax stack a and b
function s:syntax_stack_length_compare(lnum_a, col_a, lnum_b, col_b)
  let stack_a = s:syntax_stack_at(a:lnum_a, a:col_a)
  let stack_b = s:syntax_stack_at(a:lnum_b, a:col_b)

  return len(stack_a) - len(stack_b)
endfunction

" Determine whether child is a element of parent
function s:is_element_of(parent_lnum, child_lnum)
  let parent_stack = s:syntax_stack_at(a:parent_lnum, s:start_col(a:parent_lnum))
  let child_stack = s:syntax_stack_at(a:child_lnum, s:start_col(a:child_lnum))

  let element_index = len(child_stack) - index(reverse(child_stack), 'jsxElement')
  let rest = parent_stack[element_index:]

  return index(rest, 'jsxElement') == -1
endfunction

" Compute the indention of the opening tag
function s:jsx_indent_opening_tag(lnum)
  let [prev_lnum, prev_start_syntax, prev_end_syntax] = s:prev_info(a:lnum)

  " If current line is start with >
  if trim(getline(a:lnum)) =~ '^>'
    let pair_line = searchpair('<', '', '>', 'bW', 's:skip_if_not(a:lnum, "jsxOpenPunct", "jsxClose")')
    return indent(pair_line)
  endif

  " If both the start and the end of the previous line are not jsx-related syntax
  " return (
  "   <div></div> <--
  " )
  if !s:end_with_jsx(prev_lnum) && !s:start_with_jsx(prev_lnum)
    " return -1, so that it will use the default js indent function
    return -1
  endif

  " If the end of the previous line is not jsx-related syntax
  " [
  "   <div></div>,
  "   <div></div> <--
  " ]
  " should not affect
  " <div
  "   render={() => (
  "     <div> <--
  "     </div>
  "   )}
  " >
  " </div>
  " <div>
  "   {items.map(() => (
  "     <Item /> <--
  "   ))}
  " </div>
  if !s:end_with_jsx(prev_lnum) && 
        \ !s:is_jsx_attr(prev_start_syntax) &&
        \ !s:is_jsx_brace(prev_start_syntax)
    return indent(prev_lnum)
  endif

  " If the start of the previous line is not jsx-related syntax
  " return <div>
  "   <div></div> <--
  " </div>
  if !s:start_with_jsx(prev_lnum)
      return indent(prev_lnum) + s:sw()
    endif
  endif

  " <div>
  "   <span>
  "   </span>
  "   <div> <--
  "   </div>
  " </div>
  if s:is_closing_tag(prev_start_syntax)
    return indent(prev_lnum)
  endif

  " If the previous line is end with a closing tag
  " <div>
  "   <br />
  "   <div></div> <--
  " </div>
  " should not affect case like
  " <div><br />
  "   <span> <--
  " </div>
  if s:is_closing_tag(prev_end_syntax) &&
        \ s:syntax_stack_length_compare(
        \   prev_lnum, s:start_col(prev_lnum), prev_lnum, s:end_col(prev_lnum)) == 2
    return indent(prev_lnum)
  endif

  " If the start of the previous line is the jsxElement
  " <div>
  "   hello
  "   <div></div> <--
  " </div>
  if s:is_jsx_element(prev_start_syntax) ||
        \ s:is_jsx_comment(prev_start_syntax)
    return indent(prev_lnum)
  endif

  " If the start of the prvious line is the jsxBraces {
  " <div>
  "   {foo}
  "   <div></div> <--
  " </div>
  " should not affect case like
  " <div>
  "   {
  "     <div></div> <--
  "   }
  " </div>
  if s:is_jsx_brace(prev_start_syntax) &&
        \ trim(getline(prev_lnum)) =~ '^[$]\?{' &&
        \ s:syntax_stack_length_compare(
        \ prev_lnum, s:start_col(prev_lnum), a:lnum, s:start_col(a:lnum)) == -2
    return indent(prev_lnum)
  endif

  " If the start of the prvious line is the jsxBraces }
  " <div>
  "   {
  "     foo
  "   }
  "   <div></div> <--
  " </div>
  if s:is_jsx_brace(prev_start_syntax) &&
        \ trim(getline(prev_lnum)) =~ '}' &&
        \ s:syntax_stack_length_compare(
        \ prev_lnum, s:start_col(prev_lnum), a:lnum, s:start_col(a:lnum)) == -3
    return indent(prev_lnum)
  endif

  " Otherwise, indent s:sw() spaces
  return indent(prev_lnum) + s:sw()
endfunction

" Compute the indention of the closing tag
function s:jsx_indent_closing_tag(lnum)
  let pair_line = searchpair(s:start_tag, '', s:end_tag, 'bW', 's:skip_if_not(a:lnum, "jsxOpenPunct", "jsxClose")')
  return pair_line ? indent(pair_line) : indent(a:lnum)
endfunction

" Compute the indention of the jsxAttrib
function s:jsx_indent_attr(lnum)
  let [prev_lnum, prev_start_syntax, prev_end_syntax] = s:prev_info(a:lnum)

  " If the start of the previous line is not jsx-related syntax
  " return <div
  "   attr="hello" <--
  " >
  " should not affect
  " <div
  "   // comment here
  "   attr="hello"
  " >
  " </div>
  if !s:start_with_jsx(prev_lnum) &&
        \ !s:is_comment(prev_start_syntax)
    return indent(prev_lnum) + s:sw()
  endif

  " If the start of the previous line is the opening tag
  " <div
  "   title="title" <--
  " >
  if s:is_opening_tag(prev_start_syntax)
    return indent(prev_lnum) + s:sw()
  endif

  " Otherwise, align the attribute with its previous line
  return indent(prev_lnum)
endfunction

" Compute the indentation of the jsxElement
function s:jsx_indent_element(lnum)
  let [prev_lnum, prev_start_syntax, prev_end_syntax] = s:prev_info(a:lnum)

  " Fix test case like
  " <div|> <-- press enter
  " should indent as
  " <div
  " > <--
  if trim(getline(a:lnum)) =~ '^>' && !s:is_opening_tag(prev_end_syntax)
    return indent(prev_lnum)
  endif

  " If the start of the previous line is start with >
  " <div
  "   attr="foo"
  " >
  "   text <--
  " </div>
  if s:is_opening_tag(prev_start_syntax) &&
        \ trim(getline(prev_lnum)) =~ '^>$'
    return indent(prev_lnum) + s:sw()
  endif

  " <div>
  "   text <--
  " </div>
  " should not affect case like
  " <div>
  "   <br />
  "   hello <--
  " </div>
  if s:is_opening_tag(prev_start_syntax) &&
        \ s:is_element_of(prev_lnum, a:lnum)
    return indent(prev_lnum) + s:sw()
  endif

  " return <div>
  "   text <--
  " </div>
  if !s:start_with_jsx(prev_lnum)
    return indent(prev_lnum) + s:sw()
  endif

  " Otherwise, align with the previous line
  " <div>
  "   {foo}
  "   text <--
  " </div>
  return indent(prev_lnum)
endfunction

" Compute the indentation of jsxBraces
function s:jsx_indent_brace(lnum)
  let [prev_lnum, prev_start_syntax, prev_end_syntax] = s:prev_info(a:lnum)
  
  " If the start of the previous line is start with >
  " <div
  "   attr="foo"
  " >
  "   {foo} <--
  " </div>
  if s:is_opening_tag(prev_start_syntax) &&
        \ trim(getline(prev_lnum)) =~ '^>$'
    return indent(prev_lnum) + s:sw()
  endif

  " <div>
  "   {foo} <--
  " </div>
  " should not affect case like
  " <div>
  "   <br />
  "   {foo} <--
  "   text
  "   {foo} <--
  " </div>
  if s:is_opening_tag(prev_start_syntax) &&
        \ s:syntax_stack_length_compare(
        \ prev_lnum, s:start_col(prev_lnum), a:lnum, s:start_col(a:lnum)) == 1
    return indent(prev_lnum) + s:sw()
  endif

  " If current line is the close brace }
  if trim(getline(a:lnum)) =~ '^}'
    let pair_line = searchpair('{', '', '}', 'bW', 's:skip_if_not(a:lnum, "jsxBraces")')
    return indent(pair_line)
  endif

  " return <div>
  "   {foo} <--
  " </div>
  " should not affect
  " <div
  "   // js comment
  "   {...props} <--
  " >
  " </div>
  if !s:start_with_jsx(prev_lnum) &&
        \ !s:is_comment(prev_start_syntax)
    return indent(prev_lnum) + s:sw()
  endif
  
  return indent(prev_lnum)
endfunction

" Compute the indentation of the comment
function s:jsx_indent_comment(lnum)
  let [prev_lnum, prev_start_syntax, prev_end_syntax] = s:prev_info(a:lnum)

  " If current line is jsxComment
  if s:is_jsx_comment(s:start_syntax(a:lnum))
    let line = trim(getline(a:lnum))
    if line =~ '^<!--'
      " Patch code for yajs.vim
      " ${logs.map(log => html`
      "   <${Log} class="log" ...${log} />
      " `)} <-- The backtick here is Highlighted as javascriptTemplate
      " <!-- <-- Correct the indentation here
      if !s:start_with_jsx(prev_lnum) && s:end_with_jsx(prev_lnum)
        return indent(prev_lnum)
      endif

      " Return the element indent for the opening comment
      return s:jsx_indent_element(a:lnum)
    elseif line =~ '^-->'
      " Return the paired indent for the closing comment
      let pair_line = searchpair('<!--', '', '-->', 'bW')
      return indent(pair_line)
    else
      if trim(getline(prev_lnum)) =~ '^<!--'
        " <!--
        "   comment <--
        " -->
        return indent(prev_lnum) + s:sw()
      else
        " <!--
        "   comment
        "   comment <--
        " -->
        return indent(prev_lnum)
      endif
    endif
  endif

  " For comment inside the jsxTag
  if s:is_opening_tag(prev_start_syntax)
    return indent(prev_lnum) + s:sw()
  endif

  if trim(getline(a:lnum)) =~ '\*/$'
    let pair_line = searchpair('/\*', '', '\*/', 'bW', 's:skip_if_not(a:lnum)')
    return indent(pair_line) + 1
  endif
  
  return indent(prev_lnum)
endfunction

function s:jsx_indent_backticks(lnum)
  let tags = get(g:, 'vim_jsx_pretty_template_tags', ['html', 'jsx'])
  let start_tag = '\%(' . join(tags, '\|') . '\)`'
  let end_tag = '\%(' . join(tags, '\|') . '\)\@<!`'
  let pair_line = searchpair(start_tag, '', end_tag, 'bW', 's:skip_if_not(a:lnum)')

  return indent(pair_line)
endfunction

" Compute the indentation for the jsx-related element
function s:jsx_indent(lnum)
  let start_syntax = s:start_syntax(a:lnum)

  if s:is_opening_tag(start_syntax)
    return s:jsx_indent_opening_tag(a:lnum)
  elseif s:is_closing_tag(start_syntax)
    return s:jsx_indent_closing_tag(a:lnum)
  elseif s:is_jsx_attr(start_syntax)
    return s:jsx_indent_attr(a:lnum)
  elseif s:is_jsx_element(start_syntax)
    return s:jsx_indent_element(a:lnum)
  elseif s:is_jsx_brace(start_syntax)
    return s:jsx_indent_brace(a:lnum)
  elseif s:is_jsx_comment(start_syntax)
    return s:jsx_indent_comment(a:lnum)
  elseif s:is_jsx_backticks(start_syntax)
    return s:jsx_indent_backticks(a:lnum)
  endif

  return -1
endfunction

" Return the jsx context of the specified line 
function s:jsx_context(lnum)
  if !s:end_with_jsx(prev_lnum)
    return 'non-jsx'
  endif

  let prev_lnum = s:prev_lnum(a:lnum)
  let start_syntax = s:start_syntax(prev_lnum)
  let end_col = s:end_col(prev_lnum)
  let end_syntax_stack = s:syntax_stack_at(prev_lnum, end_col)
  let reversed = reverse(end_syntax_stack)

  for item in reversed
    if item =~? 'jsxEscapeJs'
      return 'unknown'
    elseif s:is_jsx_element(item) && s:is_jsx(start_syntax) && start_syntax !~? 'jsxEscapeJs'
      " <div>
      "   <br /> <-- press o
      " </div>
      " --------------------
      " <div>
      " {
      "     a > 0 ? 1 <div>|</div> <-- press enter
      " }
      " </div>
      return 'jsxElement'
    elseif s:is_jsx_tag(item)
      return 'jsxTag'
    elseif s:is_jsx_brace(item) && trim(getline(prev_lnum)) =~ '{$'
      return 'jsxBraces'
    endif
  endfor

  return 'unknown'
endfunction

function! jsx_pretty#indent#get(js_indent)
  " The start column index of the current line (one-based)
  let start_col = s:start_col(v:lnum)
  " The end column index of the current line (one-based)
  let end_col = s:end_col(v:lnum)

  if s:start_with_jsx(v:lnum)
    let ind = s:jsx_indent(v:lnum)
    return ind == -1 ? a:js_indent() : ind
  elseif s:is_embedded_comment(v:lnum)
    return s:jsx_indent_comment(v:lnum)
  else
    let line = trim(getline(v:lnum))
    let prev_lnum = s:prev_lnum(v:lnum)

    " Fix the case where pressing enter at the cursor
    " return <div>|</div>
    if line =~ '^' . s:end_tag &&
          \ s:end_with_jsx(s:prev_lnum(v:lnum))
      return s:jsx_indent_closing_tag(v:lnum)
    endif

    " Fix cases for the new line
    if empty(line)
      let context = s:jsx_context(v:lnum)

      if context == 'jsxElement'
        " <div> <-- press o
        " </div>
        return s:jsx_indent_element(v:lnum)
      elseif context == 'jsxTag'
        " <div <-- press o
        " >
        " </div>
        " -----------------------
        " <div
        "   attr="attr" <-- press o
        " >
        " </div>
        return s:jsx_indent_attr(v:lnum)
      elseif context == 'jsxBraces'
        " <div>
        "   { <-- press o
        "   }
        " </div>
        return indent(prev_lnum) + s:sw()
      endif
    endif

    return a:js_indent()
  endif
endfunction

endif
