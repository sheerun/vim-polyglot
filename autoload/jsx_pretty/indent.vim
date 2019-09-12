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

" Get the syntax group of start of line
function! s:syn_sol(lnum)
  let line = getline(a:lnum)
  let sol = matchstr(line, '^\s*')
  return map(synstack(a:lnum, len(sol) + 1), 'synIDattr(v:val, "name")')
endfunction

" Get the syntax group of end of line
function! s:syn_eol(lnum)
  let lnum = prevnonblank(a:lnum)
  let col = strlen(getline(lnum))
  return map(synstack(lnum, col), 'synIDattr(v:val, "name")')
endfunction

function! s:prev_indent(lnum)
  let lnum = prevnonblank(a:lnum - 1)
  return indent(lnum)
endfunction

function! s:prev_line(lnum)
  let lnum = prevnonblank(a:lnum - 1)
  return substitute(getline(lnum), '^\s*\|\s*$', '', 'g')
endfunction

function! s:syn_attr_jsx(synattr)
  return a:synattr =~? "^jsx"
endfunction

function! s:syn_xmlish(syns)
  return s:syn_attr_jsx(get(a:syns, -1))
endfunction

function! s:syn_jsx_element(syns)
  return get(a:syns, -1) =~? 'jsxElement'
endfunction

function! s:syn_js_comment(syns)
  return get(a:syns, -1) =~? 'Comment$'
endfunction

function! s:syn_jsx_escapejs(syns)
  return get(a:syns, -1) =~? '\(\(js\(Template\)\?\|javaScript\(Embed\)\?\|typescript\)Braces\|javascriptTemplateSB\|typescriptInterpolationDelimiter\)' &&
        \ (get(a:syns, -2) =~? 'jsxEscapeJs' ||
        \ get(a:syns, -3) =~? 'jsxEscapeJs')
endfunction

function! s:syn_jsx_attrib(syns)
  return len(filter(copy(a:syns), 'v:val =~? "jsxAttrib"'))
endfunction

let s:start_tag = '<\s*\([-:_\.\$0-9A-Za-z]\+\|>\)'
" match `/end_tag>` and `//>`
let s:end_tag = '/\%(\s*[-:_\.\$0-9A-Za-z]*\s*\|/\)>'
let s:opfirst = '^' . get(g:,'javascript_opfirst',
      \ '\C\%([<>=,.?^%|/&]\|\([-:+]\)\1\@!\|\*\+\|!=\|in\%(stanceof\)\=\>\)')

function! jsx_pretty#indent#get(js_indent)
  let lnum = v:lnum
  let line = substitute(getline(lnum), '^\s*\|\s*$', '', 'g')
  let current_syn = s:syn_sol(lnum)
  let current_syn_eol = s:syn_eol(lnum)
  let prev_line_num = prevnonblank(lnum - 1)
  let prev_syn_sol = s:syn_sol(prev_line_num)
  let prev_syn_eol = s:syn_eol(prev_line_num)
  let prev_line = s:prev_line(lnum)
  let prev_ind = s:prev_indent(lnum)

  if s:syn_xmlish(current_syn)

    if !s:syn_xmlish(prev_syn_sol)
          \ && !s:syn_jsx_escapejs(prev_syn_sol)
          \ && !s:syn_jsx_escapejs(prev_syn_eol)
          \ && !s:syn_js_comment(prev_syn_sol)
      if line =~ '^/\s*>' || line =~ '^<\s*' . s:end_tag
        return prev_ind
      else
        return prev_ind + s:sw()
      endif
    elseif !s:syn_xmlish(prev_syn_sol) && !s:syn_js_comment(prev_syn_sol) && s:syn_jsx_attrib(current_syn)
      " For #79
      return prev_ind + s:sw()
    " {
    "   <div></div>
    " ##} <--
    elseif s:syn_jsx_element(current_syn) && line =~ '}$'
      let pair_line = searchpair('{', '', '}', 'b')
      return indent(pair_line)
    elseif line =~ '^-->$'
      if prev_line =~ '^<!--'
        return prev_ind
      else
        return prev_ind - s:sw()
      endif
    elseif prev_line =~ '-->$'
      return prev_ind
    " close tag </tag> or /> including </>
    elseif prev_line =~ s:end_tag . '$'
      if line =~ '^<\s*' . s:end_tag
        return prev_ind - s:sw()
      elseif s:syn_jsx_attrib(prev_syn_sol)
        return prev_ind - s:sw()
      else
        return prev_ind
      endif
    elseif line =~ '^\(>\|/\s*>\)'
      if prev_line =~ '^<'
        return prev_ind
      else
        return prev_ind - s:sw()
      endif
    elseif prev_line =~ '^\(<\|>\)' &&
          \ (s:syn_xmlish(prev_syn_eol) || s:syn_js_comment(prev_syn_eol))
      if line =~ '^<\s*' . s:end_tag
        return prev_ind
      else
        return prev_ind + s:sw()
      endif
    elseif line =~ '^<\s*' . s:end_tag
      if !s:syn_xmlish(prev_syn_sol) 
        if s:syn_jsx_escapejs(prev_syn_eol)
              \ || s:syn_jsx_escapejs(prev_syn_sol)
          return prev_ind - s:sw()
        else
          return prev_ind
        endif
      elseif prev_line =~ '^\<return'
        return prev_ind
      else
        return prev_ind - s:sw()
      endif
    elseif !s:syn_xmlish(prev_syn_eol)
      if prev_line =~ '\(&&\|||\|=>\|[([{]\|`\)$'
        " <div>
        "   {
        "   }
        " </div>
        if line =~ '^[)\]}]'
          return prev_ind
        else
          return prev_ind + s:sw()
        endif
      else
        return prev_ind
      endif
    else
      return prev_ind
    endif
  elseif s:syn_jsx_escapejs(current_syn)
    if line =~ '^}'
      let char = getline('.')[col('.') - 1]
      " When pressing enter after the }, keep the indent
      if char != '}' && search('}', 'b', lnum)
        return indent(lnum)
      else
        let pair_line = searchpair('{', '', '}', 'bW')
        return indent(pair_line)
      endif
    elseif line =~ '^{' || line =~ '^\${'
      if s:syn_jsx_escapejs(prev_syn_eol)
            \ || s:syn_jsx_attrib(prev_syn_sol)
        return prev_ind
      elseif s:syn_xmlish(prev_syn_eol) && (prev_line =~ s:end_tag || prev_line =~ '-->$')
        return prev_ind
      else
        return prev_ind + s:sw()
      endif
    endif
  elseif line =~ '^`' && s:syn_jsx_escapejs(current_syn_eol)
    " For `} of template syntax
    let pair_line = searchpair('{', '', '}', 'bW')
    return indent(pair_line)
  elseif line =~ '^/[/*]' " js comment in jsx tag
    if get(prev_syn_sol, -1) =~ 'Punct'
      return prev_ind + s:sw()
    elseif synIDattr(synID(lnum - 1, 1, 1), 'name') =~ 'jsxTag'
      return prev_ind
    else
      return a:js_indent()
    endif
  else
    let ind = a:js_indent()

    " Issue #68
    " return (<div>
    " |<div>)
    if (line =~ '^/\s*>' || line =~ '^<\s*' . s:end_tag)
          \ && !s:syn_xmlish(prev_syn_sol)
      return prev_ind
    endif

    " If current syntax is not a jsx syntax group
    if s:syn_xmlish(prev_syn_eol) && line !~ '^[)\]}]'
      let sol = matchstr(line, s:opfirst)
      if sol is ''
        " Fix javascript continue indent
        return ind - s:sw()
      else
        return ind
      endif
    endif
    return ind
  endif

endfunction

endif
