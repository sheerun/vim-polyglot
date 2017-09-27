if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'terraform') == -1
  
if exists("b:did_indent")
  finish
endif

let b:did_indent = 1

setlocal nolisp
setlocal autoindent
setlocal indentexpr=TerraformIndent(v:lnum)
setlocal indentkeys+=<:>,0=},0=)

if exists("*TerraformIndent")
  finish
endif

function! TerraformIndent(lnum)
  " previous non-blank line
  let prevlnum = prevnonblank(a:lnum-1)

  " beginning of file?
  if prevlnum == 0
    return 0
  endif

  " previous line without comments
  let prevline = substitute(getline(prevlnum), '//.*$', '', '')
  let previndent = indent(prevlnum)
  let thisindent = previndent

  " block open?
  if prevline =~ '[\[{\(]\s*$'
    let thisindent += &sw
  endif

  " current line without comments
  let thisline = substitute(getline(a:lnum), '//.*$', '', '')

  " block close?
  if thisline =~ '^\s*[\)\]}]'
    let thisindent -= &sw
  endif

  return thisindent
endfunction

endif
