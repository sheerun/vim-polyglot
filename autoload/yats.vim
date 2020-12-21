if has_key(g:polyglot_is_disabled, 'typescript')
  finish
endif

" Regex of syntax group names that are strings or documentation.
let s:syng_multiline = 'comment\c'

" Regex of syntax group names that are line comment.
let s:syng_linecom = 'linecomment\c'

" Check if the character at lnum:col is inside a multi-line comment.
function yats#IsInMultilineComment(lnum, col)
  return !s:IsLineComment(a:lnum, a:col) && synIDattr(synID(a:lnum, a:col, 1), 'name') =~ s:syng_multiline
endfunction

" Check if the character at lnum:col is a line comment.
function yats#IsLineComment(lnum, col)
  return synIDattr(synID(a:lnum, a:col, 1), 'name') =~ s:syng_linecom
endfunction

