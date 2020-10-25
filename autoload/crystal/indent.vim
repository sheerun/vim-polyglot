if has_key(g:polyglot_is_disabled, 'crystal')
  finish
endif

" Variables {{{1
" =========

" Syntax group names that are strings.
let g:crystal#indent#syng_string =
      \ '\<crystal\%(String\|Interpolation\|NoInterpolation\|StringEscape\)\>'
lockvar g:crystal#indent#syng_string

" Syntax group names that are strings/symbols/regexes or comments.
let g:crystal#indent#syng_strcom =
      \ g:crystal#indent#syng_string .
      \ '\|' .
      \ '\<crystal\%(CharLiteral\|Comment\|Regexp\|RegexpCharClass\|RegexpEscape\|Symbol\|ASCIICode\)\>'
lockvar g:crystal#indent#syng_strcom

" Syntax group names that are string/regex/symbol delimiters.
let g:crystal#indent#syng_delim =
      \ '\<crystal\%(StringDelimiter\|RegexpDelimiter\|SymbolDelimiter\|InterpolationDelim\)\>'
lockvar g:crystal#indent#syng_delim

" Syntax group that represents all of the above combined.
let g:crystal#indent#syng_strcomdelim =
      \ g:crystal#indent#syng_strcom .
      \ '\|' .
      \ g:crystal#indent#syng_delim
lockvar g:crystal#indent#syng_strcomdelim

" Regex for the start of a line
let g:crystal#indent#sol = '\%(\_^\|;\)\s*\zs'
lockvar g:crystal#indent#sol

" Regex for the end of a line
let g:crystal#indent#eol = '\ze\s*\%(#.*\)\=\%(\_$\|;\)'
lockvar g:crystal#indent#eol

" Expression used to check whether we should skip a match with searchpair().
let g:crystal#indent#skip_expr =
      \ 'crystal#indent#IsInStringOrComment(line("."), col("."))'
lockvar g:crystal#indent#skip_expr

" Regex that defines a link attribute
let g:crystal#indent#link_attribute_regex =
      \ g:crystal#indent#sol.'@\[.*]'
lockvar g:crystal#indent#link_attribute_regex

" Regex that defines a type declaration
let g:crystal#indent#type_declaration_regex =
      \ g:crystal#indent#sol .
      \ '\%(\<\%(private\|protected\)\s\+\)\=' .
      \ '\%(\<\%(getter\|setter\|property\)?\=\s\+\)\=' .
      \ '@\=\h\k*\s\+:\s\+\S.*'
lockvar g:crystal#indent#type_declaration_regex

" Regex for operator symbols:
" , : / + * - = ~ < & ^ \
" | that is not part of a block opening
" % that is not part of a macro delimiter
" ! that is not part of a method name
" ? that is not part of a method name
" > that is not part of a ->
"
" Additionally, all symbols must not be part of a global variable name,
" like $~.
let g:crystal#indent#operator_regex =
      \ '\$\@1<!' .
      \ '\%(' .
      \ '[.,:/+*\-=~<&^\\]' .
      \ '\|' .
      \ '\%(\%(\<do\>\|%\@1<!{\)\s*|[^|]*\)\@<!|' .
      \ '\|' .
      \ '{\@1<!%' .
      \ '\|' .
      \ '\%(\k\|]\)\@1<!\!' .
      \ '\|' .
      \ '\%(\k\|]\)\@1<!?' .
      \ '\|' .
      \ '-\@1<!>' .
      \ '\)'
lockvar g:crystal#indent#operator_regex

" Regex that defines blocks.
let g:crystal#indent#block_regex =
      \ '\%(' .
      \ '\%('.g:crystal#indent#operator_regex.'\s*\)\@<!{\@1<!{' .
      \ '\|' .
      \ '\<do\>' .
      \ '\)' .
      \ '\s*\%(|[^|]*|\)\=' .
      \ g:crystal#indent#eol
lockvar g:crystal#indent#block_regex

" Regex that defines the beginning of a hanging expression.
let g:crystal#indent#hanging_assignment_regex =
      \ '\%('.g:crystal#indent#operator_regex.'\s*\)\@<=' .
      \ '\.\@1<!\<\%(if\||unless\|case\|begin\)\>'
lockvar g:crystal#indent#hanging_assignment_regex

" Regex that defines the start-match for the 'end' keyword.
let g:crystal#indent#end_start_regex =
      \ '\%(' .
      \ g:crystal#indent#sol .
      \ '\%(' .
      \ '\%(\<\%(private\|protected\)\s\+\)\=' .
      \ '\%(\<\%(abstract\s\+\)\=\%(class\|struct\)\>\|\<\%(def\|module\|macro\|lib\|enum\|annotation\)\>\)' .
      \ '\|' .
      \ '\<\%(if\|unless\|while\|until\|case\|begin\|union\)\>' .
      \ '\)' .
      \ '\|' .
      \ g:crystal#indent#hanging_assignment_regex .
      \ '\|' .
      \ g:crystal#indent#block_regex .
      \ '\)'
lockvar g:crystal#indent#end_start_regex

" Regex that defines the middle-match for the 'end' keyword.
let g:crystal#indent#end_middle_regex =
      \ g:crystal#indent#sol .
      \ '\<\%(else\|elsif\|when\|in\|rescue\|ensure\)\>'
lockvar g:crystal#indent#end_middle_regex

" Regex that defines the end-match for the 'end' keyword.
let g:crystal#indent#end_end_regex =
      \ g:crystal#indent#sol.'\%(\<end\>\|%\@1<!}\@1<!}}\@!\)'
lockvar g:crystal#indent#end_end_regex

" Regex used for words that, at the start of a line, add a level of indent.
let g:crystal#indent#crystal_indent_keywords =
      \ g:crystal#indent#end_start_regex .
      \ '\|' .
      \ g:crystal#indent#end_middle_regex
lockvar g:crystal#indent#crystal_indent_keywords

" Regex used for words that, at the start of a line, remove a level of indent.
let g:crystal#indent#crystal_deindent_keywords =
      \ g:crystal#indent#end_middle_regex .
      \ '\|' .
      \ g:crystal#indent#end_end_regex
lockvar g:crystal#indent#crystal_deindent_keywords

" Regex that defines hanging expressions for macro control tags.
let g:crystal#indent#macro_hanging_assignment_regex =
      \ '\%('.g:crystal#indent#operator_regex.'\s*\)\@<=' .
      \ '\\\=\zs{%\s*\%(if\|unless\|begin\)\>.*%}'
lockvar g:crystal#indent#macro_hanging_assignment_regex

" Regex that defines the start-match for the 'end' keyword in macro
" control tags.
let g:crystal#indent#macro_end_start_regex =
      \ '\%(' .
      \ g:crystal#indent#sol .
      \ '\%(' .
      \ '\\\=\zs{%\s*\%(if\|unless\|for\|begin\)\>.*%}' .
      \ '\|' .
      \ '\\\=\zs{%.*\<do\s*%}' .
      \ '\)' .
      \ '\|' .
      \ g:crystal#indent#macro_hanging_assignment_regex .
      \ '\)'
lockvar g:crystal#indent#macro_end_start_regex

" Regex that defines the middle-match for the 'end' keyword in macro
" control tags.
let g:crystal#indent#macro_end_middle_regex =
      \ g:crystal#indent#sol.'\\\=\zs{%\s*\%(else\|elsif\)\>.*%}'
lockvar g:crystal#indent#macro_end_middle_regex

" Regex that defines the end-match for the 'end' keyword in macro
" control tags.
let g:crystal#indent#macro_end_end_regex =
      \ g:crystal#indent#sol.'\\\=\zs{%\s*end\s*%}'
lockvar g:crystal#indent#macro_end_end_regex

" Regex used for words that, at the start of a line, add a level of
" indent after macro control tags.
let g:crystal#indent#crystal_macro_indent_keywords =
      \ g:crystal#indent#macro_end_start_regex .
      \ '\|' .
      \ g:crystal#indent#macro_end_middle_regex
lockvar g:crystal#indent#crystal_macro_indent_keywords

" Regex used for words that, at the start of a line, remove a level of
" indent after macro control tags.
let g:crystal#indent#crystal_macro_deindent_keywords =
      \ g:crystal#indent#macro_end_middle_regex .
      \ '\|' .
      \ g:crystal#indent#macro_end_end_regex
lockvar g:crystal#indent#crystal_macro_deindent_keywords

" Regex that defines bracket continuations
let g:crystal#indent#bracket_continuation_regex =
      \ '%\@1<![({[]'.g:crystal#indent#eol
lockvar g:crystal#indent#bracket_continuation_regex

" Regex that defines continuation lines, not including (, {, or [.
let g:crystal#indent#non_bracket_continuation_regex =
      \ '\%(' .
      \ g:crystal#indent#operator_regex .
      \ '\|' .
      \ '\<\%(if\|unless\|then\)\>' .
      \ '\)' .
      \ g:crystal#indent#eol
lockvar g:crystal#indent#non_bracket_continuation_regex

" Regex that defines continuation lines.
let g:crystal#indent#continuation_regex =
      \ g:crystal#indent#bracket_continuation_regex .
      \ '\|' .
      \ g:crystal#indent#non_bracket_continuation_regex
lockvar g:crystal#indent#continuation_regex

" Regex that defines dot continuations
let g:crystal#indent#dot_continuation_regex = '\.'.g:crystal#indent#eol
lockvar g:crystal#indent#dot_continuation_regex

" Regex that defines end of bracket continuation followed by another continuation
let g:crystal#indent#bracket_switch_continuation_regex =
      \ '^\%([^(]\+\zs).\+\)\+\%('.g:crystal#indent#continuation_regex.'\)'
lockvar g:crystal#indent#bracket_switch_continuation_regex

let g:crystal#indent#block_continuation_regex =
      \ '^\s*[^])}\t ].*'.g:crystal#indent#block_regex
lockvar g:crystal#indent#block_continuation_regex

" Regex that describes a leading operator (only a method call's dot for now)
let g:crystal#indent#leading_operator_regex = g:crystal#indent#sol.'\.'
lockvar g:crystal#indent#leading_operator_regex

" Indent callbacks for the current line
let g:crystal#indent#curr_line_callbacks = [
      \ 'crystal#indent#MultilineString',
      \ 'crystal#indent#ClosingBracketOnEmptyLine',
      \ 'crystal#indent#DeindentingMacroTag',
      \ 'crystal#indent#DeindentingKeyword',
      \ 'crystal#indent#LeadingOperator'
      \ ]
lockvar g:crystal#indent#curr_line_callbacks

" Indent callbacks for the previous line
let g:crystal#indent#prev_line_callbacks = [
      \ 'crystal#indent#StartOfFile',
      \ 'crystal#indent#AfterTypeDeclaration',
      \ 'crystal#indent#AfterLinkAttribute',
      \ 'crystal#indent#ContinuedLine',
      \ 'crystal#indent#AfterBlockOpening',
      \ 'crystal#indent#AfterUnbalancedBracket',
      \ 'crystal#indent#AfterLeadingOperator',
      \ 'crystal#indent#AfterEndMacroTag',
      \ 'crystal#indent#AfterEndKeyword',
      \ 'crystal#indent#AfterIndentMacroTag',
      \ 'crystal#indent#AfterIndentKeyword'
      \ ]
lockvar g:crystal#indent#prev_line_callbacks

" Indent callbacks for the MSL
let g:crystal#indent#msl_callbacks = [
      \ 'crystal#indent#PreviousNotMSL',
      \ 'crystal#indent#IndentingKeywordInMSL',
      \ 'crystal#indent#ContinuedHangingOperator'
      \ ]
lockvar g:crystal#indent#msl_callbacks

" Indenting Logic Callbacks {{{1
" =========================

function! crystal#indent#ClosingBracketOnEmptyLine(cline_info) abort
  let info = a:cline_info

  " If we got a closing bracket on an empty line, find its match and indent
  " according to it.  For parentheses we indent to its column - 1, for the
  " others we indent to the containing line's MSL's level.  Return -1 if fail.

  let idx = match(info.cline, g:crystal#indent#sol.'[]})]')

  if idx >= 0
    let closing_bracket = info.cline[idx]

    if closing_bracket ==# ')'
      let opening_bracket = '('
    elseif closing_bracket ==# ']'
      let opening_bracket = '\['
    elseif closing_bracket ==# '}'
      let opening_bracket = '{'
    endif

    call searchpair(
          \ opening_bracket,
          \ '',
          \ closing_bracket,
          \ 'bW',
          \ g:crystal#indent#skip_expr)

    if line('.') == info.clnum
      return indent('.')
    endif

    if g:crystal_indent_block_style ==# 'do' &&
          \ getline('.') =~# g:crystal#indent#block_regex
        return col('.') - 1
      else
        return indent(crystal#indent#GetMSL(line('.')))
    endif
  endif

  return -1
endfunction

function! crystal#indent#DeindentingKeyword(cline_info) abort
  let info = a:cline_info

  " If we have a deindenting keyword, find its match and indent to its level.
  let idx = match(info.cline, g:crystal#indent#crystal_deindent_keywords)

  if idx >= 0
    call cursor(0, idx + 1)

    call searchpair(
          \ g:crystal#indent#end_start_regex,
          \ g:crystal#indent#end_middle_regex,
          \ g:crystal#indent#end_end_regex,
          \ 'bW',
          \ g:crystal#indent#skip_expr)

    let lnum = line('.')

    " If the search did not change the current line, then either 1) the
    " code is malformed or 2) the indenting keyword is on the same line
    " as this one: in either case, do nothing and exit the indent
    " expression.
    if lnum == info.clnum
      return indent('.')
    endif

    " Count the number of both opening and closing macro control tags
    " between this line and the starting line: if the number of
    " opening tags is greater than the number of closing tags, then we
    " must be inside of a macro block, so indent accordingly.
    let diff = crystal#indent#RelativeMacroDepth(lnum, info.clnum)

    if diff > 0
      return indent(lnum) + info.sw * (diff + 1)
    elseif diff < 0
      return indent(lnum) + info.sw * (diff - 1)
    endif

    " If none of the above special cases apply, proceed normally.
    let line = getline(lnum)

    if g:crystal_indent_block_style ==# 'do' &&
          \ line =~# g:crystal#indent#block_regex
      return col('.') - 1
    elseif g:crystal_indent_assignment_style ==# 'hanging' &&
          \ line =~# g:crystal#indent#hanging_assignment_regex
      return col('.') - 1
    else
      return indent(crystal#indent#GetMSL(lnum))
    endif
  endif

  return -1
endfunction

function! crystal#indent#DeindentingMacroTag(cline_info) abort
  let info = a:cline_info

  " If we have a deindenting tag, find its match and indent to its level.
  let idx = match(info.cline, g:crystal#indent#crystal_macro_deindent_keywords)

  if idx >= 0
    call cursor(0, idx + 1)

    call searchpair(
          \ g:crystal#indent#macro_end_start_regex,
          \ g:crystal#indent#macro_end_middle_regex,
          \ g:crystal#indent#macro_end_end_regex,
          \ 'bW',
          \ g:crystal#indent#skip_expr)

    " If this tag was preceded by a \, we need to keep searching until
    " we find a tag that also has a \.
    if info.cline[idx - 1] ==# '\'
      while getline('.')[col('.') - 2] !=# '\'
        call searchpair(
              \ g:crystal#indent#macro_end_start_regex,
              \ g:crystal#indent#macro_end_middle_regex,
              \ g:crystal#indent#macro_end_end_regex,
              \ 'bW',
              \ g:crystal#indent#skip_expr)
      endwhile

      " Position the cursor on the \ for later
      call cursor(0, col('.') - 1)
    endif

    " If the search did not change the current line, then either 1) the
    " code is malformed or 2) the indenting tag is on the same line as
    " this one: in either case, do nothing and exit the indent
    " expression.
    if line('.') == info.clnum
      return indent('.')
    endif

    if g:crystal_indent_assignment_style ==# 'hanging' &&
          \ getline('.') =~# g:crystal#indent#macro_hanging_assignment_regex
      return col('.') - 1
    else
      return indent('.')
    endif
  endif

  return -1
endfunction

function! crystal#indent#MultilineString(cline_info) abort
  let info = a:cline_info

  " If we are in a multi-line string, don't do anything to it.
  if crystal#indent#IsInString(info.clnum, 1)
    return indent('.')
  endif

  return -1
endfunction

function! crystal#indent#LeadingOperator(cline_info) abort
  let info = a:cline_info

  " If the current line starts with a leading operator, add a level of indent.
  if info.cline =~# g:crystal#indent#leading_operator_regex
    return indent(crystal#indent#GetMSL(info.clnum)) + info.sw
  endif

  return -1
endfunction

function! crystal#indent#EmptyInsideString(pline_info) abort
  let info = a:pline_info

  " If the line is empty and inside a string (the previous line is a string,
  " too), use the previous line's indent

  let plnum = prevnonblank(info.clnum - 1)
  let pline = getline(plnum)

  if info.cline =~# '^\s*$'
        \ && crystal#indent#IsInString(plnum, 1)
        \ && crystal#indent#IsInString(plnum, strlen(pline))
    return indent(plnum)
  endif

  return -1
endfunction

function! crystal#indent#StartOfFile(pline_info) abort
  let info = a:pline_info

  " At the start of the file use zero indent.
  if info.plnum == 0
    return 0
  endif

  return -1
endfunction

function! crystal#indent#AfterTypeDeclaration(pline_info) abort
  let info = a:pline_info

  " Short circuit if the previous line was a type declaration; this
  " allows us to skip checking for type declarations before * and
  " ? later on, which will save a lot of time.

  if info.pline =~# g:crystal#indent#type_declaration_regex
    if info.pline =~# ','.g:crystal#indent#eol
      return indent(info.plnum)
    else
      let idx = match(info.pline, g:crystal#indent#block_regex)

      if idx >= 0
        if g:crystal_indent_block_style ==# 'do'
          return idx + info.sw
        else
          return indent(info.plnum)
        endif
      endif

      return indent(crystal#indent#GetMSL(info.plnum))
    endif
  endif

  return -1
endfunction

function! crystal#indent#AfterLinkAttribute(pline_info) abort
  let info = a:pline_info

  " Short circuit if the previous line was a link attribute.

  if info.pline =~# g:crystal#indent#link_attribute_regex
    return indent(info.plnum)
  endif

  return -1
endfunction

" Example:
"
"   if foo || bar ||
"       baz || bing
"     puts "foo"
"   end
"
function! crystal#indent#ContinuedLine(pline_info) abort
  let info = a:pline_info

  let idx = match(info.pline, g:crystal#indent#end_start_regex)

  if idx >= 0 && info.pline =~# g:crystal#indent#non_bracket_continuation_regex
    if info.pline =~# g:crystal#indent#hanging_assignment_regex
      if g:crystal_indent_assignment_style ==# 'hanging'
        " hanging indent
        let ind = idx
      else
        " align with variable
        let ind = indent(info.plnum)
      endif
    else
      let ind = indent(crystal#indent#GetMSL(info.plnum))
    endif

    return ind + info.sw * 2
  endif

  return -1
endfunction

function! crystal#indent#AfterBlockOpening(pline_info) abort
  let info = a:pline_info

  " If the previous line ended with a block opening, add a level of indent.
  let idx = match(info.pline, g:crystal#indent#block_regex)

  if idx >= 0
    if g:crystal_indent_block_style ==# 'do'
      " don't align to the msl, align to the "do"
      let ind = idx + info.sw
    else
      let plnum_msl = crystal#indent#GetMSL(info.plnum)

      if getline(plnum_msl) =~# '='.g:crystal#indent#eol
        " in the case of assignment to the msl, align to the starting line,
        " not to the msl
        let ind = indent(info.plnum) + info.sw
      else
        let ind = indent(plnum_msl) + info.sw
      endif
    endif

    return ind
  endif

  return -1
endfunction

function! crystal#indent#AfterLeadingOperator(pline_info) abort
  let info = a:pline_info

  " If the previous line started with a leading operator, use its MSL's level
  " of indent
  if info.pline =~# g:crystal#indent#leading_operator_regex
    return indent(crystal#indent#GetMSL(info.plnum))
  endif

  return -1
endfunction

function! crystal#indent#AfterUnbalancedBracket(pline_info) abort
  let info = a:pline_info

  " If the previous line contained unclosed opening brackets and we are still
  " in them, find the rightmost one and add indent depending on the bracket
  " type.
  "
  " If it contained hanging closing brackets, find the rightmost one, find its
  " match and indent according to that.

  if info.pline =~# '[[({]\|[])}]'.g:crystal#indent#eol
    let [opening, closing] = crystal#indent#ExtraBrackets(info.plnum)

    if opening.pos != -1
      if strpart(info.pline, opening.pos + 1) =~# '^'.g:crystal#indent#eol
        return indent(crystal#indent#GetMSL(info.plnum)) + info.sw
      else
        return opening.pos + 1
      endif
    elseif closing.pos != -1
      call cursor(info.plnum, closing.pos + 1)

      if closing.type ==# ')'
        let target = '('
      elseif closing.type ==# ']'
        let target = '\['
      elseif closing.type ==# '}'
        let target = '{'
      endif

      call searchpair(target, '', closing.type, 'bW', g:crystal#indent#skip_expr)

      return indent(crystal#indent#GetMSL(line('.')))
    end
  endif

  return -1
endfunction

function! crystal#indent#AfterEndKeyword(pline_info) abort
  let info = a:pline_info

  let idx = match(info.pline, g:crystal#indent#end_end_regex)

  if idx >= 0
    if g:crystal_indent_assignment_style ==# 'variable' &&
          \ g:crystal_indent_block_style ==# 'expression'
      " Simply align with the "end"
      return idx
    endif

    " Return the indent of the nearest indenting line
    call cursor(info.plnum, idx + 1)

    let lnum = searchpair(
          \ g:crystal#indent#end_start_regex,
          \ '',
          \ g:crystal#indent#end_end_regex,
          \ 'bW',
          \ g:crystal#indent#skip_expr)

    return indent(crystal#indent#GetMSL(lnum))
  endif

  return -1
endfunction

function! crystal#indent#AfterEndMacroTag(pline_info) abort
  let info = a:pline_info

  " If the previous line ended with an "end" macro tag, match the indent
  " of that tag's corresponding opening tag.
  let idx = match(info.pline, g:crystal#indent#macro_end_end_regex)

  if idx >= 0
    call cursor(info.plnum, idx + 1)

    if g:crystal_indent_assignment_style ==# 'hanging'
      let lnum = searchpair(
            \ g:crystal#indent#macro_end_start_regex,
            \ '',
            \ g:crystal#indent#macro_end_end_regex,
            \ 'bW',
            \ g:crystal#indent#skip_expr)
    else
      let lnum = searchpair(
            \ g:crystal#indent#macro_end_start_regex,
            \ g:crystal#indent#macro_end_middle_regex,
            \ g:crystal#indent#macro_end_end_regex,
            \ 'bW',
            \ g:crystal#indent#skip_expr)
    endif

    return indent(lnum)
  end

  return -1
endfunction

function! crystal#indent#AfterIndentKeyword(pline_info) abort
  let info = a:pline_info

  let idx = match(info.pline, g:crystal#indent#crystal_indent_keywords)

  if idx >= 0
    " If there is an "end" after the indenting keyword on the same line,
    " do nothing.
    let idx2 = match(info.pline, g:crystal#indent#end_end_regex)

    if idx2 > idx
      return indent('.')
    endif

    if g:crystal_indent_assignment_style ==# 'hanging' &&
          \ info.pline =~# g:crystal#indent#hanging_assignment_regex
      return idx + info.sw
    else
      return indent(info.plnum) + info.sw
    endif
  endif

  return -1
endfunction

function! crystal#indent#AfterIndentMacroTag(pline_info) abort
  let info = a:pline_info

  let idx = match(info.pline, g:crystal#indent#crystal_macro_indent_keywords)

  if idx >= 0
    if g:crystal_indent_assignment_style ==# 'hanging' &&
          \ info.pline =~# g:crystal#indent#macro_hanging_assignment_regex
      " If the indenting tag was preceded by a \, we must shift over an
      " additional space.
      let shift = info.pline[idx - 1] ==# '\'
      return idx + info.sw - shift
    else
      return indent(info.plnum) + info.sw
    endif
  endif

  return -1
endfunction

function! crystal#indent#PreviousNotMSL(msl_info) abort
  let info = a:msl_info

  if info.plnum != info.plnum_msl
    if info.pline =~# g:crystal#indent#bracket_switch_continuation_regex
      return indent(info.plnum) - 1
    elseif info.pline =~# g:crystal#indent#non_bracket_continuation_regex
      return indent(info.plnum)
    endif
  endif

  return -1
endfunction

function! crystal#indent#IndentingKeywordInMSL(msl_info) abort
  let info = a:msl_info

  " If the MSL line had an indenting keyword in it, add a level of indent.
  let idx = match(info.pline_msl, g:crystal#indent#crystal_indent_keywords)

  if idx >= 0
    let ind = indent(info.plnum_msl) + info.sw

    if info.pline_msl =~# g:crystal#indent#end_end_regex
      let ind = ind - info.sw
    elseif info.pline =~# g:crystal#indent#hanging_assignment_regex
      if g:crystal_indent_assignment_style ==# 'hanging'
        " hanging indent
        let ind = idx + info.sw
      else
        " align with variable
        let ind = indent(info.plnum_msl) + info.sw
      endif
    endif

    return ind
  endif

  return -1
endfunction

function! crystal#indent#ContinuedHangingOperator(msl_info) abort
  let info = a:msl_info

  " If the previous line ended with an operator but wasn't a block
  " ending or a closing bracket, indent one extra level.
  if crystal#indent#Match(info.plnum_msl, g:crystal#indent#non_bracket_continuation_regex) &&
        \ info.pline_msl !~# g:crystal#indent#sol.'\%([\])}]\|\<end\>\)'
    if info.plnum_msl == info.plnum
      let ind = indent(info.plnum_msl) + info.sw
    else
      let ind = indent(info.plnum_msl)
    endif

    return ind
  endif

  return -1
endfunction

" Auxiliary Functions {{{1
" ===================

" Check if the character at lnum:col is inside a string.
function! crystal#indent#IsInString(lnum, col) abort
  return synIDattr(synID(a:lnum, a:col, 1), 'name') =~# g:crystal#indent#syng_string
endfunction

" Check if the character at lnum:col is inside a string delimiter.
function! crystal#indent#IsInStringDelimiter(lnum, col) abort
  return synIDattr(synID(a:lnum, a:col, 1), 'name') =~# g:crystal#indent#syng_delim
endfunction

" Check if the character at lnum:col is inside a string, comment, regexp, etc.
function! crystal#indent#IsInStringOrComment(lnum, col) abort
  return synIDattr(synID(a:lnum, a:col, 1), 'name') =~# g:crystal#indent#syng_strcom
endfunction

" Check if the character lnum:col is inside a string, comment, regexp,
" delimiter, etc.
function! crystal#indent#IsInStringOrCommentOrDelimiter(lnum, col) abort
  return synIDattr(synID(a:lnum, a:col, 1), 'name') =~# g:crystal#indent#syng_strcomdelim
endfunction

function! crystal#indent#IsAssignment(str, pos) abort
  return strpart(a:str, 0, a:pos - 1) =~# '=\s*$'
endfunction

function! crystal#indent#IsLineComment(lnum) abort
  return getline(a:lnum) =~# g:crystal#indent#sol.'#'
endfunction

" Determine the relative macro block depth of one line versus another.
" 'a' and 'b' are the line numbers for said lines.
"
" For example:
"
" A return value of 2 would indicate that line A is inside two macro
" blocks relative to line B.
"
" A return value of -2 would indicate that line B is inside two macro
" blocks relative to line A.
"
" A return value of 0 would indicate that line A and line B are either
" in the same macro block or at the same relative macro block depth.
"
" NOTE: It is assumed that a < b - 2; otherwise, the return value will
" always be 0.
function! crystal#indent#RelativeMacroDepth(a, b) abort
  let diff = 0

  for i in range(a:a + 1, a:b - 1)
    if crystal#indent#Match(i, g:crystal#indent#macro_end_start_regex)
      let diff += 1
    elseif crystal#indent#Match(i, g:crystal#indent#macro_end_end_regex)
      let diff -= 1
    endif
  endfor

  return diff
endfunction

" Wrapper for prevnonblank() that skips lines that are line comments or
" inside of multiline strings.
function! crystal#indent#PrevNonBlank(lnum) abort
  let lnum = prevnonblank(a:lnum)

  while lnum > 0
    let line = getline(lnum)
    let start = match(line, '\S') + 1

    if !crystal#indent#IsInStringOrComment(lnum, start)
      break
    endif

    let lnum = prevnonblank(lnum - 1)
  endwhile

  return lnum
endfunction

" Find line above 'lnum' that started the continuation 'lnum' may be part of.
function! crystal#indent#GetMSL(lnum) abort
  " Start on the line we're at and use its indent.
  let mslnum = a:lnum
  let lnum = crystal#indent#PrevNonBlank(a:lnum - 1)

  while lnum > 0
    " If we have a continuation line, or we're in a string, use line as MSL.
    " Otherwise, terminate search as we have found our MSL already.
    let msl = getline(mslnum)
    let line = getline(lnum)

    if msl =~# g:crystal#indent#leading_operator_regex
      " If the current line starts with a leading operator, keep its indent
      " and keep looking for an MSL.
      let mslnum = lnum
    elseif line =~# g:crystal#indent#type_declaration_regex &&
          \ line !~# ','.g:crystal#indent#eol &&
          \ line !~# g:crystal#indent#block_regex
      " If the previous line is a type declaration that doesn't end with
      " a comman or a block opening, it is the MSL.
      "
      " Example:
      "   record ColorRGB,
      "     red : UInt8,
      "     green : UInt8,
      "     blue : UInt8 do
      "     def fore(io : IO) : Nil
      "       io << "38;2;"
      "       io << red << ";"
      "       io << green << ";"
      "       io << blue
      "     end
      "   end
      "
      return mslnum
    elseif line =~# g:crystal#indent#non_bracket_continuation_regex &&
          \ msl =~# g:crystal#indent#non_bracket_continuation_regex
      " If the current line is a non-bracket continuation and so is the
      " previous one, keep its indent and continue looking for an mslnum.
      "
      " Example:
      "   method_call one,
      "     two,
      "     three
      "
      let mslnum = lnum
    elseif line =~# g:crystal#indent#non_bracket_continuation_regex &&
          \ (
          \ msl =~# g:crystal#indent#bracket_continuation_regex ||
          \ msl =~# g:crystal#indent#block_continuation_regex
          \ )
      " If the current line is a bracket continuation or a block-starter, but
      " the previous is a non-bracket one, keep looking for an mslnum.
      "
      " Example:
      "   method_call one,
      "     two {
      "     three
      "
      "   method_call one,
      "     two,
      "     three {
      "     four
      "
      let mslnum = lnum
    elseif line =~# g:crystal#indent#bracket_continuation_regex &&
          \ (
          \ msl =~# g:crystal#indent#bracket_continuation_regex ||
          \ msl =~# g:crystal#indent#block_continuation_regex
          \ )
      " If both lines are bracket continuations (the current may also be a
      " block-starter), use the current one's and stop here.
      "
      " Example:
      "   method_call(
      "     other_method_call(
      "       foo
      "
      return mslnum
    elseif line =~# g:crystal#indent#block_regex &&
          \ msl !~# g:crystal#indent#continuation_regex
      " If the previous line is a block-starter and the current one is
      " mostly ordinary, use the current one as the mslnum.
      "
      " Example:
      "   method_call do
      "     something
      "     something_else
      "
      return mslnum
    elseif line =~# g:crystal#indent#continuation_regex
      let mslnum = lnum
    else
      break
    endif

    let lnum = crystal#indent#PrevNonBlank(lnum - 1)
  endwhile

  return mslnum
endfunction

" Check if line 'lnum' has more opening brackets than closing ones.
function! crystal#indent#ExtraBrackets(lnum) abort
  let opening = {'parentheses': [], 'braces': [], 'brackets': []}
  let closing = {'parentheses': [], 'braces': [], 'brackets': []}

  let line = getline(a:lnum)
  let pos  = match(line, '[][(){}]')

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
  let line   = getline(a:lnum)
  let offset = match(line, '\C'.a:regex)
  let col    = offset + 1

  while col && crystal#indent#IsInStringOrCommentOrDelimiter(a:lnum, col)
    let offset = match(line, '\C'.a:regex, offset + 1)
    let col = offset + 1
  endwhile

  return col ? col : 0
endfunction

" }}}1

" vim:sw=2 sts=2 ts=8 fdm=marker et: