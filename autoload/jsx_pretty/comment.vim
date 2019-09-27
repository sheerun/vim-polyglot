if !exists('g:polyglot_disabled') || !(index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'jsx') != -1)

function! jsx_pretty#comment#update_commentstring(original)
  let syn_current = s:syn_name(line('.'), col('.'))
  let syn_start = s:syn_name(line('.'), 1)
  let save_cursor = getcurpos()

  if syn_start =~? '^jsx'
    let line = getline(".")
    let start = len(matchstr(line, '^\s*'))
    let syn_name = s:syn_name(line('.'), start + 1)

    if line =~ '^\s*//'
      let &l:commentstring = '// %s'
    elseif s:syn_contains(line('.'), col('.'), 'jsxTaggedRegion')
      let &l:commentstring = '<!-- %s -->'
    elseif syn_name =~? '^jsxAttrib'
      let &l:commentstring = '// %s'
    else
      let &l:commentstring = '{/* %s */}'
    endif
  else
    let &l:commentstring = a:original
  endif

  " Restore the cursor position
  call setpos('.', save_cursor)
endfunction

function! s:syn_name(lnum, cnum)
  let syn_id = get(synstack(a:lnum, a:cnum), -1)
  return synIDattr(syn_id, "name")
endfunction

function! s:syn_contains(lnum, cnum, syn_name)
  let stack = synstack(a:lnum, a:cnum)
  let syn_names = map(stack, 'synIDattr(v:val, "name")')
  return index(syn_names, a:syn_name) >= 0
endfunction

endif
