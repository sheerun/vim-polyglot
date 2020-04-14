if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'crystal') == -1

" Only load this indent file when no other was loaded.
if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

setlocal nosmartindent

" Now, set up our indentation expression and keys that trigger it.
setlocal indentexpr=GetCrystalIndent(v:lnum)
setlocal indentkeys=0{,0},0),0],!^F,o,O,e,:,.
setlocal indentkeys+==end,=else,=elsif,=when,=ensure,=rescue
setlocal indentkeys+==private,=protected

let s:cpo_save = &cpo
set cpo&vim

" Only define the function once.
if exists('*GetCrystalIndent')
  finish
endif

" Return the value of a single shift-width
if exists('*shiftwidth')
  let s:sw = function('shiftwidth')
else
  function s:sw()
    return &shiftwidth
  endfunction
endif

" GetCrystalIndent Function {{{1
" =========================

function GetCrystalIndent(...)
  " Setup {{{2
  " -----

  " For the current line, use the first argument if given, else v:lnum
  let clnum = a:0 ? a:1 : v:lnum

  " Set up variables for restoring position in file
  let vcol = col(clnum)

  " Work on the current line {{{2
  " ------------------------

  " Get the current line.
  let line = getline(clnum)
  let ind = -1

  " If we got a closing bracket on an empty line, find its match and indent
  " according to it.  For parentheses we indent to its column - 1, for the
  " others we indent to the containing line's MSL's level.  Return -1 if fail.
  let col = matchend(line, '^\s*[]})]')
  if col > 0 && !crystal#indent#IsInStringOrComment(clnum, col)
    call cursor(clnum, col)
    let bs = strpart('(){}[]', stridx(')}]', line[col - 1]) * 2, 2)
    if searchpair(escape(bs[0], '\['), '', bs[1], 'bW', g:crystal#indent#skip_expr)
      if line[col-1] ==# ')' && col('.') != col('$') - 1
        let ind = virtcol('.') - 1
      else
        let ind = indent(crystal#indent#GetMSL(line('.')))
      endif
    endif
    return ind
  endif

  " If we have a deindenting keyword, find its match and indent to its level.
  " TODO: this is messy
  if crystal#indent#Match(clnum, g:crystal#indent#crystal_deindent_keywords)
    call cursor(clnum, 1)
    if searchpair(
          \ g:crystal#indent#end_start_regex,
          \ g:crystal#indent#end_middle_regex,
          \ g:crystal#indent#end_end_regex,
          \ 'bW', g:crystal#indent#skip_expr)
      let msl  = crystal#indent#GetMSL(line('.'))
      let line = getline(line('.'))

      if strpart(line, 0, col('.') - 1) =~# '=\s*$' &&
            \ strpart(line, col('.') - 1, 2) !~# 'do'
        " assignment to case/begin/etc, on the same line, hanging indent
        let ind = virtcol('.') - 1
      elseif getline(msl) =~# '=\s*\(#.*\)\=$'
        " in the case of assignment to the msl, align to the starting line,
        " not to the msl
        let ind = indent(line('.'))
      else
        " align to the msl
        let ind = indent(msl)
      endif
    endif
    return ind
  endif

  " If we are in a multi-line string, don't do anything to it.
  if crystal#indent#IsInString(clnum, matchend(line, '^\s*') + 1)
    return indent('.')
  endif

  " If we are at the closing delimiter of a "<<" heredoc-style string, set the
  " indent to 0.
  if line =~# '^\k\+\s*$'
        \ && crystal#indent#IsInStringDelimiter(clnum, 1)
        \ && search('\V<<'.line, 'nbW')
    return 0
  endif

  " If the current line starts with a leading operator, add a level of indent.
  if crystal#indent#Match(clnum, g:crystal#indent#leading_operator_regex)
    return indent(crystal#indent#GetMSL(clnum)) + s:sw()
  endif

  " Work on the previous line. {{{2
  " --------------------------

  " Find a non-blank, non-multi-line string line above the current line.
  let lnum = crystal#indent#PrevNonBlankNonString(clnum - 1)

  " If the line is empty and inside a string, use the previous line.
  if line =~# '^\s*$' && lnum != prevnonblank(clnum - 1)
    return indent(prevnonblank(clnum))
  endif

  " At the start of the file use zero indent.
  if lnum == 0
    return 0
  endif

  " Set up variables for the previous line.
  let line = getline(lnum)
  let ind = indent(lnum)

  if crystal#indent#Match(lnum, g:crystal#indent#continuable_regex) &&
        \ crystal#indent#Match(lnum, g:crystal#indent#continuation_regex)
    return indent(crystal#indent#GetMSL(lnum)) + s:sw() * 2
  endif

  " If the previous line ended with a block opening, add a level of indent.
  if crystal#indent#Match(lnum, g:crystal#indent#block_regex)
    let msl = crystal#indent#GetMSL(lnum)

    if getline(msl) =~# '=\s*\(#.*\)\=$'
      " in the case of assignment to the msl, align to the starting line,
      " not to the msl
      let ind = indent(lnum) + s:sw()
    else
      let ind = indent(msl) + s:sw()
    endif
    return ind
  endif

  " If the previous line started with a leading operator, use its MSL's level
  " of indent
  if crystal#indent#Match(lnum, g:crystal#indent#leading_operator_regex)
    return indent(crystal#indent#GetMSL(lnum))
  endif

  " If the previous line ended with the "*" of a splat, add a level of indent
  if line =~ g:crystal#indent#splat_regex
    return indent(lnum) + s:sw()
  endif

  " If the previous line contained unclosed opening brackets and we are still
  " in them, find the rightmost one and add indent depending on the bracket
  " type.
  "
  " If it contained hanging closing brackets, find the rightmost one, find its
  " match and indent according to that.
  if line =~# '[[({]' || line =~# '[])}]\s*\%(#.*\)\=$'
    let [opening, closing] = crystal#indent#ExtraBrackets(lnum)

    if opening.pos != -1
      if opening.type ==# '(' && searchpair('(', '', ')', 'bW', g:crystal#indent#skip_expr)
        if col('.') + 1 == col('$')
          return ind + s:sw()
        else
          return virtcol('.')
        endif
      else
        let nonspace = matchend(line, '\S', opening.pos + 1) - 1
        return nonspace > 0 ? nonspace : ind + s:sw()
      endif
    elseif closing.pos != -1
      call cursor(lnum, closing.pos + 1)
      normal! %

      if crystal#indent#Match(line('.'), g:crystal#indent#crystal_indent_keywords)
        return indent('.') + s:sw()
      else
        return indent('.')
      endif
    else
      call cursor(clnum, vcol)
    end
  endif

  " If the previous line ended with an "end", match that "end"s beginning's
  " indent.
  let col = crystal#indent#Match(lnum, g:crystal#indent#end_end_regex)
  if col
    call cursor(lnum, col)
    if searchpair(
          \ g:crystal#indent#end_start_regex,
          \ g:crystal#indent#end_middle_regex,
          \ g:crystal#indent#end_end_regex,
          \ 'bW',
          \ g:crystal#indent#skip_expr)
      let n = line('.')
      let ind = indent('.')
      let msl = crystal#indent#GetMSL(n)
      if msl != n
        let ind = indent(msl)
      end
      return ind
    endif
  end

  let col = crystal#indent#Match(lnum, g:crystal#indent#crystal_indent_keywords)
  if col
    call cursor(lnum, col)
    let ind = virtcol('.') - 1 + s:sw()
    " TODO: make this better (we need to count them) (or, if a searchpair
    " fails, we know that something is lacking an end and thus we indent a
    " level
    if crystal#indent#Match(lnum, g:crystal#indent#end_end_regex)
      let ind = indent('.')
    endif
    return ind
  endif

  " Work on the MSL line. {{{2
  " ---------------------

  " Set up variables to use and search for MSL to the previous line.
  let p_lnum = lnum
  let lnum = crystal#indent#GetMSL(lnum)

  " If the previous line wasn't a MSL.
  if p_lnum != lnum
    " If previous line ends bracket and begins non-bracket continuation decrease indent by 1.
    if crystal#indent#Match(p_lnum, g:crystal#indent#bracket_switch_continuation_regex)
      return ind - 1
    " If previous line is a continuation return its indent.
    " TODO: the || crystal#indent#IsInString() thing worries me a bit.
    elseif crystal#indent#Match(p_lnum, g:crystal#indent#non_bracket_continuation_regex) ||
          \ crystal#indent#IsInString(p_lnum,strlen(line))
      return ind
    endif
  endif

  " Set up more variables, now that we know we wasn't continuation bound.
  let line = getline(lnum)
  let msl_ind = indent(lnum)

  " If the MSL line had an indenting keyword in it, add a level of indent.
  " TODO: this does not take into account contrived things such as
  " module Foo; class Bar; end
  if crystal#indent#Match(lnum, g:crystal#indent#crystal_indent_keywords)
    let ind = msl_ind + s:sw()
    if crystal#indent#Match(lnum, g:crystal#indent#end_end_regex)
      let ind = ind - s:sw()
    endif
    return ind
  endif

  " If the previous line ended with an operator -- but wasn't a block
  " ending, closing bracket, or type declaration -- indent one extra
  " level.
  if crystal#indent#Match(lnum, g:crystal#indent#non_bracket_continuation_regex) &&
        \ !crystal#indent#Match(lnum, '^\s*\([\])}]\|end\)')
    if lnum == p_lnum
      let ind = msl_ind + s:sw()
    else
      let ind = msl_ind
    endif
    return ind
  endif

  " }}}2

  return ind
endfunction

" }}}1

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2 ts=8 et:

endif
