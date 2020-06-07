if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'crystal') == -1

" Variables {{{1
" =========

" Regex of syntax group names that are strings or characters.
let g:crystal#indent#syng_string =
      \ '\<crystal\%(String\|Interpolation\|NoInterpolation\|StringEscape\|CharLiteral\|ASCIICode\)\>'
lockvar g:crystal#indent#syng_string

" Regex of syntax group names that are strings, characters, symbols,
" regexps, or comments.
let g:crystal#indent#syng_strcom =
      \ g:crystal#indent#syng_string.'\|' .
      \ '\<crystal\%(Regexp\|RegexpEscape\|Symbol\|Comment\)\>'
lockvar g:crystal#indent#syng_strcom

" Expression used to check whether we should skip a match with searchpair().
let g:crystal#indent#skip_expr =
      \ 'synIDattr(synID(line("."), col("."), 1), "name") =~# "'.g:crystal#indent#syng_strcom.'"'
lockvar g:crystal#indent#skip_expr

" Regex for the start of a line:
" start of line + whitespace + optional opening macro delimiter
let g:crystal#indent#sol = '^\s*\zs\%(\\\={%\s*\)\='
lockvar g:crystal#indent#sol

" Regex for the end of a line:
" whitespace + optional closing macro delimiter + whitespace +
" optional comment + end of line
let g:crystal#indent#eol = '\s*\%(%}\)\=\ze\s*\%(#.*\)\=$'
lockvar g:crystal#indent#eol

" Regex that defines blocks.
let g:crystal#indent#block_regex =
      \ '\%(\<do\>\|%\@1<!{\)\s*\%(|[^|]*|\)\='.g:crystal#indent#eol
lockvar g:crystal#indent#block_regex

" Regex that defines the start-match for the 'end' keyword.
" NOTE: This *should* properly match the 'do' only at the end of the
" line
let g:crystal#indent#end_start_regex =
      \ g:crystal#indent#sol .
      \ '\%(' .
      \ '\%(\<\%(private\|protected\)\s\+\)\=' .
      \ '\%(\<\%(abstract\s\+\)\=\%(class\|struct\)\>\|\<\%(def\|module\|macro\|lib\|enum\)\>\)' .
      \ '\|' .
      \ '\<\%(if\|unless\|while\|until\|case\|begin\|for\|union\)\>' .
      \ '\)' .
      \ '\|' .
      \ g:crystal#indent#block_regex
lockvar g:crystal#indent#end_start_regex

" Regex that defines the middle-match for the 'end' keyword.
let g:crystal#indent#end_middle_regex =
      \ g:crystal#indent#sol .
      \ '\<\%(else\|elsif\|rescue\|ensure\|when\)\>'
lockvar g:crystal#indent#end_middle_regex

" Regex that defines the end-match for the 'end' keyword.
let g:crystal#indent#end_end_regex =
      \ g:crystal#indent#sol .
      \ '\<end\>'
lockvar g:crystal#indent#end_end_regex

" Regex used for words that add a level of indent.
let g:crystal#indent#crystal_indent_keywords =
      \ g:crystal#indent#end_start_regex .
      \ '\|' .
      \ g:crystal#indent#end_middle_regex
lockvar g:crystal#indent#crystal_indent_keywords

" Regex used for words that remove a level of indent.
let g:crystal#indent#crystal_deindent_keywords =
      \ g:crystal#indent#end_middle_regex .
      \ '\|' .
      \ g:crystal#indent#end_end_regex
lockvar g:crystal#indent#crystal_deindent_keywords

" Regex that defines a type declaration
let g:crystal#indent#crystal_type_declaration =
      \ '@\=\h\k*\s\+:\s\+\S.*'
lockvar g:crystal#indent#crystal_type_declaration

" Regex that defines continuation lines, not including (, {, or [.
let g:crystal#indent#non_bracket_continuation_regex =
      \ '\%(' .
      \ '[\\.,:/%+\-=~<>&^]' .
      \ '\|' .
      \ '\%(\%(\<do\>\|%\@1<!{\)\s*|[^|]*\)\@<!|' .
      \ '\|' .
      \ '\%(]\|\w\)\@1<!?' .
      \ '\|' .
      \ '\<\%(if\|unless\)\>' .
      \ '\|' .
      \ '\%('.g:crystal#indent#crystal_type_declaration.'\h\k*\)\@<!\*' .
      \ '\)' .
      \ g:crystal#indent#eol
lockvar g:crystal#indent#non_bracket_continuation_regex

" Regex that defines bracket continuations
let g:crystal#indent#bracket_continuation_regex = '%\@1<!\%([({[]\)\s*\%(#.*\)\=$'
lockvar g:crystal#indent#bracket_continuation_regex

" Regex that defines continuation lines.
let g:crystal#indent#continuation_regex =
      \ g:crystal#indent#non_bracket_continuation_regex .
      \ '\|' .
      \ g:crystal#indent#bracket_continuation_regex
lockvar g:crystal#indent#continuation_regex

" Regex that defines end of bracket continuation followed by another continuation
let g:crystal#indent#bracket_switch_continuation_regex =
      \ '^\([^(]\+\zs).\+\)\+'.g:crystal#indent#continuation_regex
lockvar g:crystal#indent#bracket_switch_continuation_regex

" Regex that defines continuable keywords
let g:crystal#indent#continuable_regex =
      \ '\%(^\s*\|[=,*/%+\-|;{]\|<<\|>>\|:\s\)\s*\zs' .
      \ '\<\%(if\|for\|while\|until\|unless\):\@!\>'
lockvar g:crystal#indent#continuable_regex

" Regex that defines the first part of a splat pattern
let g:crystal#indent#splat_regex = '[[,(]\s*\*\s*\%(#.*\)\=$'
lockvar g:crystal#indent#splat_regex

let g:crystal#indent#block_continuation_regex = '^\s*[^])}\t ].*'.g:crystal#indent#block_regex
lockvar g:crystal#indent#block_continuation_regex

" Regex that describes a leading operator (only a method call's dot for now)
let g:crystal#indent#leading_operator_regex = '^\s*[.]'
lockvar g:crystal#indent#leading_operator_regex

" Auxiliary Functions {{{1
" ===================

" Check if the character at lnum:col is inside a string, comment, or is ascii.
function! crystal#indent#IsInStringOrComment(lnum, col) abort
  return synIDattr(synID(a:lnum, a:col, 1), 'name') =~# g:crystal#indent#syng_strcom
endfunction

" Check if the character at lnum:col is inside a string or character.
function! crystal#indent#IsInString(lnum, col) abort
  return synIDattr(synID(a:lnum, a:col, 1), 'name') =~# g:crystal#indent#syng_string
endfunction

" Check if the character at lnum:col is inside a string or regexp
" delimiter
function! crystal#indent#IsInStringDelimiter(lnum, col) abort
  return synIDattr(synID(a:lnum, a:col, 1), 'name') =~# '\<crystal\%(StringDelimiter\|RegexpDelimiter\)\>'
endfunction

" Find line above 'lnum' that isn't empty, in a comment, or in a string.
function! crystal#indent#PrevNonBlankNonString(lnum) abort
  let lnum = prevnonblank(a:lnum)

  while lnum > 0
    let line = getline(lnum)
    let start = match(line, '\S')

    if !crystal#indent#IsInStringOrComment(lnum, start + 1)
      break
    endif

    let lnum = prevnonblank(lnum - 1)
  endwhile

  return lnum
endfunction

" Find line above 'lnum' that started the continuation 'lnum' may be part of.
function! crystal#indent#GetMSL(lnum) abort
  " Start on the line we're at and use its indent.
  let msl = a:lnum
  let msl_body = getline(msl)
  let lnum = crystal#indent#PrevNonBlankNonString(a:lnum - 1)

  while lnum > 0
    " If we have a continuation line, or we're in a string, use line as MSL.
    " Otherwise, terminate search as we have found our MSL already.
    let line = getline(lnum)

    if crystal#indent#Match(msl, g:crystal#indent#leading_operator_regex)
      " If the current line starts with a leading operator, keep its indent
      " and keep looking for an MSL.
      let msl = lnum
    elseif crystal#indent#Match(lnum, g:crystal#indent#splat_regex)
      " If the above line looks like the "*" of a splat, use the current one's
      " indentation.
      "
      " Example:
      "   Hash[*
      "     method_call do
      "       something
      "
      return msl
    elseif crystal#indent#Match(lnum, g:crystal#indent#non_bracket_continuation_regex) &&
          \ crystal#indent#Match(msl, g:crystal#indent#non_bracket_continuation_regex)
      " If the current line is a non-bracket continuation and so is the
      " previous one, keep its indent and continue looking for an MSL.
      "
      " Example:
      "   method_call one,
      "     two,
      "     three
      "
      let msl = lnum
    elseif crystal#indent#Match(lnum, g:crystal#indent#non_bracket_continuation_regex) &&
          \ (
          \ crystal#indent#Match(msl, g:crystal#indent#bracket_continuation_regex) ||
          \ crystal#indent#Match(msl, g:crystal#indent#block_continuation_regex)
          \ )
      " If the current line is a bracket continuation or a block-starter, but
      " the previous is a non-bracket one, respect the previous' indentation,
      " and stop here.
      "
      " Example:
      "   method_call one,
      "     two {
      "     three
      "
      return lnum
    elseif crystal#indent#Match(lnum, g:crystal#indent#bracket_continuation_regex) &&
          \ (
          \ crystal#indent#Match(msl, g:crystal#indent#bracket_continuation_regex) ||
          \ crystal#indent#Match(msl, g:crystal#indent#block_continuation_regex)
          \ )
      " If both lines are bracket continuations (the current may also be a
      " block-starter), use the current one's and stop here
      "
      " Example:
      "   method_call(
      "     other_method_call(
      "       foo
      return msl
    elseif crystal#indent#Match(lnum, g:crystal#indent#block_regex) &&
          \ !crystal#indent#Match(msl, g:crystal#indent#continuation_regex) &&
          \ !crystal#indent#Match(msl, g:crystal#indent#block_continuation_regex)
      " If the previous line is a block-starter and the current one is
      " mostly ordinary, use the current one as the MSL.
      "
      " Example:
      "   method_call do
      "     something
      "     something_else
      return msl
    else
      let col = match(line, g:crystal#indent#continuation_regex) + 1

      if (col > 0 && !crystal#indent#IsInStringOrComment(lnum, col))
            \ || crystal#indent#IsInString(lnum, strlen(line))
        let msl = lnum
      else
        break
      endif
    endif

    let msl_body = getline(msl)
    let lnum = crystal#indent#PrevNonBlankNonString(lnum - 1)
  endwhile

  return msl
endfunction

" Check if line 'lnum' has more opening brackets than closing ones.
function! crystal#indent#ExtraBrackets(lnum) abort
  let opening = {'parentheses': [], 'braces': [], 'brackets': []}
  let closing = {'parentheses': [], 'braces': [], 'brackets': []}

  let line = getline(a:lnum)
  let pos  = match(line, '[][(){}]', 0)

  " Save any encountered opening brackets, and remove them once a matching
  " closing one has been found. If a closing bracket shows up that doesn't
  " close anything, save it for later.
  while pos != -1
    if !crystal#indent#IsInStringOrComment(a:lnum, pos + 1)
      if line[pos] ==# '('
        call add(opening.parentheses, {'type': '(', 'pos': pos})
      elseif line[pos] ==# ')'
        if empty(opening.parentheses)
          call add(closing.parentheses, {'type': ')', 'pos': pos})
        else
          let opening.parentheses = opening.parentheses[0:-2]
        endif
      elseif line[pos] ==# '{'
        call add(opening.braces, {'type': '{', 'pos': pos})
      elseif line[pos] ==# '}'
        if empty(opening.braces)
          call add(closing.braces, {'type': '}', 'pos': pos})
        else
          let opening.braces = opening.braces[0:-2]
        endif
      elseif line[pos] ==# '['
        call add(opening.brackets, {'type': '[', 'pos': pos})
      elseif line[pos] ==# ']'
        if empty(opening.brackets)
          call add(closing.brackets, {'type': ']', 'pos': pos})
        else
          let opening.brackets = opening.brackets[0:-2]
        endif
      endif
    endif

    let pos = match(line, '[][(){}]', pos + 1)
  endwhile

  " Find the rightmost brackets, since they're the ones that are important in
  " both opening and closing cases
  let rightmost_opening = {'type': '(', 'pos': -1}
  let rightmost_closing = {'type': ')', 'pos': -1}

  for opening in opening.parentheses + opening.braces + opening.brackets
    if opening.pos > rightmost_opening.pos
      let rightmost_opening = opening
    endif
  endfor

  for closing in closing.parentheses + closing.braces + closing.brackets
    if closing.pos > rightmost_closing.pos
      let rightmost_closing = closing
    endif
  endfor

  return [rightmost_opening, rightmost_closing]
endfunction

function! crystal#indent#Match(lnum, regex) abort
  let regex = '\C'.a:regex

  let line = getline(a:lnum)
  let col  = match(line, regex) + 1

  while col &&
        \ crystal#indent#IsInStringOrComment(a:lnum, col) ||
        \ crystal#indent#IsInStringDelimiter(a:lnum, col)
    let col = match(line, regex, col) + 1
  endwhile

  return col
endfunction

" Locates the containing class/module/struct/enum/lib's definition line,
" ignoring nested classes along the way.
function! crystal#indent#FindContainingClass() abort
  let saved_position = getcurpos()

  while searchpair(
        \ g:crystal#indent#end_start_regex,
        \ g:crystal#indent#end_middle_regex,
        \ g:crystal#indent#end_end_regex,
        \ 'bWz',
        \ g:crystal#indent#skip_expr) > 0
    if expand('<cword>') =~# '\<\%(class\|module\|struct\|enum\|lib\)\>'
      let found_lnum = line('.')
      call setpos('.', saved_position)
      return found_lnum
    endif
  endwhile

  call setpos('.', saved_position)
  return 0
endfunction

" vim: sw=2 sts=2 et:

endif
