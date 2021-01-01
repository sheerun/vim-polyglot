if polyglot#init#is_disabled(expand('<sfile>:p'), 'crystal', 'indent/ecrystal.vim')
  finish
endif

" Setup {{{1
" =====

if exists('b:did_indent')
  finish
endif

call ecrystal#SetSubtype()

if b:ecrystal_subtype !=# ''
  exec 'runtime! indent/'.b:ecrystal_subtype.'.vim'
  unlet! b:did_indent
endif

if &l:indentexpr ==# ''
  if &l:cindent
    let &l:indentexpr = 'cindent(v:lnum)'
  else
    let &l:indentexpr = 'indent(prevnonblank(v:lnum - 1))'
  endif
endif

let b:ecrystal_subtype_indentexpr = &l:indentexpr

" Should we use folding?
if has('folding') && get(g:, 'ecrystal_fold', 0)
  setlocal foldmethod=expr
  setlocal foldexpr=GetEcrystalFold()
endif

" Should closing control tags be aligned with their corresponding
" opening tags?
if !exists('b:ecrystal_align_end')
  if exists('g:ecrystal_align_end')
    let b:ecrystal_align_end = g:ecrystal_align_end
  else
    let b:ecrystal_align_end = b:ecrystal_subtype !=# 'html' && b:ecrystal_subtype !=# 'xml'
  endif
endif

" Should multiline tags be indented?
if !exists('b:ecrystal_indent_multiline')
  let b:ecrystal_indent_multiline = get(g:, 'ecrystal_indent_multiline', 1)
endif

if b:ecrystal_indent_multiline
  runtime! indent/crystal.vim
  unlet! b:did_indent
  setlocal indentexpr<
endif

setlocal indentexpr=GetEcrystalIndent()
setlocal indentkeys+=<>>,=end,=else,=elsif,=rescue,=ensure,=when,=in

let b:did_indent = 1

" Only define the function once.
if exists('*GetEcrystalIndent')
  finish
endif

" Helper variables and functions {{{1
" ==============================

let s:ecr_open = '<%%\@!'
let s:ecr_close = '%>'

let s:ecr_control_open = '<%%\@!-\=[=#]\@!'
let s:ecr_comment_open = '<%%\@!-\=#'

let s:ecr_indent_regex =
      \ '\<\%(if\|unless\|else\|elsif\|case\|when\|in\|while\|until\|begin\|do\|rescue\|ensure\|\)\>'

let s:ecr_dedent_regex =
      \ '\<\%(end\|else\|elsif\|when\|in\|rescue\|ensure\)\>'

" Return the value of a single shift-width
if exists('*shiftwidth')
  let s:sw = function('shiftwidth')
else
  function s:sw()
    return &shiftwidth
  endfunction
endif

" Does the given pattern match at the given position?
function! s:MatchAt(lnum, col, pattern) abort
  let idx = a:col - 1
  return match(getline(a:lnum), a:pattern, idx) == idx
endfunction

" Does the given pattern match at the cursor's position?
function! s:MatchCursor(pattern) abort
  return s:MatchAt(line('.'), col('.'), a:pattern)
endfunction

" Is the cell at the given position part of a tag? If so, return the
" position of the opening delimiter.
function! s:MatchECR(...) abort
  if a:0
    let lnum = a:1
    let col = a:2

    call cursor(lnum, col)
  endif

  let pos = getcurpos()

  try
    let flags = s:MatchCursor(s:ecr_open) ? 'bcWz' : 'bWz'

    let [open_lnum, open_col] = searchpairpos(
          \ s:ecr_open, '', s:ecr_close,
          \ flags, g:crystal#indent#skip_expr)
  finally
    call setpos('.', pos)
  endtry

  return [open_lnum, open_col]
endfunction

" If the cell at the given position is part of a control tag, return the
" respective positions of the opening and closing delimiters for that
" tag.
function! s:MatchECRControl(...) abort
  let pos = getcurpos()

  if a:0
    let lnum = a:1
    let col = a:2

    call cursor(lnum, col)
  else
    let [lnum, col] = [line('.'), col('.')]
  endif

  let open = { 'lnum': 0, 'col': 0 }
  let close = { 'lnum': 0, 'col': 0 }

  let [open.lnum, open.col] = s:MatchECR(lnum, col)

  if !open.lnum
    call setpos('.', pos)
    return [open, close]
  endif

  call cursor(open.lnum, open.col)

  if !s:MatchCursor(s:ecr_control_open)
    let open.lnum = 0
    let open.col = 0

    call setpos('.', pos)
    return [open, close]
  endif

  let [close.lnum, close.col] = searchpairpos(
        \ s:ecr_control_open, '', s:ecr_close,
        \ 'Wz', g:crystal#indent#skip_expr)

  call setpos('.', pos)
  return [open, close]
endfunction

" Determine whether or not the control tag at the given position starts
" an indent.
function! s:ECRIndent(...) abort
  if a:0
    if type(a:1) == 0
      let [open, close] = s:MatchECRControl(a:1, a:2)
    elseif type(a:1) == 4
      let [open, close] = [a:1, a:2]
    endif
  else
    let [open, close] = s:MatchECRControl()
  endif

  let result = 0

  if !open.lnum
    return result
  endif

  let pos = getcurpos()

  call cursor(open.lnum, open.col)

  " Find each Crystal keyword that starts an indent; if any of them do
  " not have a corresponding ending keyword, then this tag starts an
  " indent.
  while search(s:ecr_indent_regex, 'z', close.lnum)
    let [lnum, col] = [line('.'), col('.')]

    if lnum == close.lnum && col > close.col
      break
    endif

    if crystal#indent#IsInStringOrComment(lnum, col)
      continue
    endif

    let [end_lnum, end_col] = searchpairpos(
          \ g:crystal#indent#end_start_regex,
          \ g:crystal#indent#end_middle_regex,
          \ g:crystal#indent#end_end_regex,
          \ 'nz',
          \ g:crystal#indent#skip_expr,
          \ close.lnum)

    if end_lnum
      if end_lnum == close.lnum && end_col > close.col
        let result = 1
      endif
    else
      let result = 1
    endif

    if result
      break
    endif
  endwhile

  call setpos('.', pos)
  return result
endfunction

" Determine if the control tag at the given position ends an indent or
" not.
function! s:ECRDedent(...) abort
  if a:0
    if type(a:1) == 0
      let [open, close] = s:MatchECRControl(a:1, a:2)
    elseif type(a:1) == 4
      let [open, close] = [a:1, a:2]
    endif
  else
    let [open, close] = s:MatchECRControl()
  endif

  let result = 0

  if !open.lnum
    return result
  endif

  let pos = getcurpos()

  call cursor(open.lnum, open.col)

  " Find each Crystal keyword that ends an indent; if any of them do not
  " have a corresponding starting keyword, then this tag ends an indent
  while search(s:ecr_dedent_regex, 'z', close.lnum)
    let [lnum, col] = [line('.'), col('.')]

    if lnum == close.lnum && col > close.col
      break
    endif

    if crystal#indent#IsInStringOrComment(lnum, col)
      continue
    endif

    let [begin_lnum, begin_col] = searchpairpos(
          \ g:crystal#indent#end_start_regex,
          \ g:crystal#indent#end_middle_regex,
          \ g:crystal#indent#end_end_regex,
          \ 'bnz',
          \ g:crystal#indent#skip_expr,
          \ open.lnum)

    if begin_lnum
      if begin_lnum == open.lnum && begin_col < open.col
        let result = 1
      endif
    else
      let result = 1
    endif

    if result
      break
    endif
  endwhile

  call setpos('.', pos)
  return result
endfunction

" Find and match a control tag in the given line, if one exists.
function! s:FindECRControl(...) abort
  let lnum = a:0 ? a:1 : line('.')

  let open = { 'lnum': 0, 'col': 0 }
  let close = { 'lnum': 0, 'col': 0 }

  let pos = getcurpos()

  call cursor(lnum, 1)

  while search(s:ecr_control_open, 'cz', lnum)
    let [open, close] = s:MatchECRControl()

    if open.lnum
      break
    endif
  endwhile

  call setpos('.', pos)
  return [open, close]
endfunction

" Find and match the previous control tag.
"
" This takes two arguments: the first is the line to start searching
" from (exclusive); the second is the line to stop searching at
" (inclusive).
function! s:FindPrevECRControl(...) abort
  if a:0 == 0
    let start = line('.')
    let stop = 1
  elseif a:0 == 1
    let start = a:1
    let stop = 1
  elseif a:0 == 2
    let start = a:1
    let stop = a:2
  endif

  let open = { 'lnum': 0, 'col': 0 }
  let close = { 'lnum': 0, 'col': 0 }

  let pos = getcurpos()

  call cursor(start, 1)

  let [lnum, col] = searchpos(s:ecr_close, 'bWz', stop)

  if !lnum
    call setpos('.', pos)
    return [open, close]
  endif

  let [open, close] = s:MatchECRControl()

  while !open.lnum
    let [lnum, col] = searchpos(s:ecr_close, 'bWz', stop)

    if !lnum
      break
    endif

    let [open, close] = s:MatchECRControl()
  endwhile

  call setpos('.', pos)
  return [open, close]
endfunction

" GetEcrystalIndent {{{1
" =================

function! GetEcrystalIndent() abort
  let prev_lnum = prevnonblank(v:lnum - 1)

  if b:ecrystal_indent_multiline
    let [open_tag_lnum, open_tag_col] = s:MatchECR()
  else
    let open_tag_lnum = 0
  endif

  if open_tag_lnum && open_tag_lnum < v:lnum
    " If we are inside a multiline eCrystal tag...

    let ind = indent(open_tag_lnum)

    " If this line has a closing delimiter that isn't inside a string or
    " comment, then we are done with this tag
    if crystal#indent#Match(v:lnum, s:ecr_close)
      return ind
    endif

    " All tag contents will have at least one indent
    let ind += s:sw()

    if open_tag_lnum == prev_lnum
      " If this is the first line after the opening delimiter, then one
      " indent is enough
      return ind
    elseif s:MatchAt(open_tag_lnum, open_tag_col, s:ecr_comment_open)[0]
      " eCrystal comments shouldn't be indented any further
      return ind
    else
      " Else, fall back to Crystal indentation...
      let crystal_ind = GetCrystalIndent()

      " But only if it isn't less than the default indentation for this
      " tag
      return crystal_ind < ind ? ind : crystal_ind
    endif
  else
    let [prev_ecr_open, prev_ecr_close] = s:FindPrevECRControl(v:lnum, prev_lnum)
    let [curr_ecr_open, curr_ecr_close] = s:FindECRControl()

    let prev_is_ecr = prev_ecr_open.lnum != 0
    let curr_is_ecr = curr_ecr_open.lnum != 0

    let shift = 0

    if prev_is_ecr
      if s:ECRIndent(prev_ecr_open, prev_ecr_close)
        let shift = 1
      endif
    endif

    if curr_is_ecr
      if s:ECRDedent(curr_ecr_open, curr_ecr_close)
        if !b:ecrystal_align_end
          let shift = shift ? 0 : -1
        else
          " Find the nearest previous control tag that starts an indent
          " and align this one with that one
          let end_tags = 0

          let [open, close] = s:FindPrevECRControl()

          while open.lnum
            if s:ECRIndent(open, close)
              if end_tags
                let end_tags -= 1
              else
                return indent(open.lnum)
              endif
            elseif s:ECRDedent(open, close)
              let end_tags += 1
            endif

            let [open, close] = s:FindPrevECRControl(open.lnum)
          endwhile
        endif
      endif
    endif

    if shift
      return indent(prev_lnum) + s:sw() * shift
    else
      exec 'return ' . b:ecrystal_subtype_indentexpr
    endif
  endif
endfunction

" GetEcrystalFold {{{1
" ===============

function! GetEcrystalFold() abort
  let fold = '='

  let col = crystal#indent#Match(v:lnum, s:ecr_control_open)

  if col
    let [open, close] = s:MatchECRControl(v:lnum, col)

    let starts_indent = s:ECRIndent(open, close)
    let ends_indent = s:ECRDedent(open, close)

    if starts_indent && !ends_indent
      let fold = 'a1'
    elseif ends_indent && !starts_indent
      let fold = 's1'
    endif
  endif

  return fold
endfunction

" }}}

" vim:fdm=marker
