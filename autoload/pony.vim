if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'pony') == -1

" Vim plugin file
" Language:     Pony
" Maintainer:   Jak Wings

" TODO: Make sure echomsg is off for release.
let s:cpo_save = &cpo
set cpo&vim


"let s:skip = '<SID>InCommentOrLiteral(line("."), col("."))'
let s:skip2 = '<SID>InLiteral(line("."), col(".")) || <SID>InComment(line("."), col(".")) == 1'
let s:skip3 = '!<SID>InKeyword(line("."), col("."))'
let s:skip4 = '!<SID>InBracket(line("."), col("."))'
let s:cfstart = '\v<%(ifdef|if|match|while|for|repeat|try|with|recover|object|lambda|iftype)>'
let s:cfmiddle = '\v<%(then|elseif|else|until|do|in|elseiftype)>|\|'
let s:cfend = '\v<end>'
let s:bstartp = '\v<%(ifdef|if|then|elseif|else|(match)|while|for|in|do|try|with|recover|repeat|until|(object)|lambda|iftype|elseiftype)>'

function! pony#Indent()
  if v:lnum <= 1
    return 0
  endif

  call cursor(v:lnum, 1)
  let l:pnzpos = searchpos('.', 'cbnW')
  if l:pnzpos == [0, 0]
    return 0
  endif

  if s:InComment2(l:pnzpos) > 1
    "echomsg 'Comment' (l:pnzpos[0] . '-' . v:lnum) -1
    return cindent(v:lnum)
  endif

  if s:InLiteral2(l:pnzpos)
    "echomsg 'String' (l:pnzpos[0] . '-' . v:lnum) -1
    return -1
  endif

  unlet! l:pnzpos

  " NOTE: Lines started in comments and strings are checked already.

  let l:pnblnum = s:PrevNonblank(v:lnum - 1)
  if l:pnblnum < 1
    return 0
  endif

  let l:pnbline = getline(l:pnblnum)
  let l:pnbindent = indent(l:pnblnum)

  let l:line = getline(v:lnum)
  let l:indent = l:pnbindent
  let l:shiftwidth = shiftwidth()

  " FIXME?
  let l:continuing = 0
  " If the previous line ends with a unary or binary operator,
  if s:IsContinued(l:pnblnum)
    let l:contlnum = l:pnblnum
    let l:ppcontinued = 0
    let l:ppnblnum = s:PrevNonblank(l:pnblnum - 1)
    while s:IsContinued(l:ppnblnum)
      let l:ppcontinued += 1
      let l:contlnum = l:ppnblnum
      let l:ppnblnum = s:PrevNonblank(l:ppnblnum - 1)
    endwhile
    "echomsg 'Continued1' l:pnblnum l:contlnum
    " If the previous line is also continuing another line,
    if l:ppcontinued
      let l:continuing = 1
      if getline(l:contlnum) =~# '\v^\s*%(actor|class|struct|primitive|trait|type|interface)>'
        " reset the indent level.
        "echomsg 'Continuing0' (l:contlnum . '-' . v:lnum) (l:shiftwidth * 2)
        let l:indent = l:shiftwidth * 2
      else
        " keep using the previous indent.
        "echomsg 'Continuing1' (l:pnblnum . '-' . v:lnum) l:pnbindent
        let l:indent = l:pnbindent
      endif
    " if the previous line is part of the definition of a class,
    elseif l:pnbline =~# '\v^\s*%(actor|class|struct|primitive|trait|type|interface)>'
      " reset the indent level.
      "echomsg 'Continuing2' (l:pnblnum . '-' . v:lnum) (l:shiftwidth * 2)
      let l:continuing = 1
      let l:indent = l:shiftwidth * 2
    " if the previous line is part of the definition of a method,
    elseif l:pnbline =~# '\v^\s*%(fun|new|be)>'
      " reset the indent level.
      "echomsg 'Continuing3' (l:pnblnum . '-' . v:lnum) (l:pnbindent + l:shiftwidth)
      let l:continuing = 1
      let l:indent = l:pnbindent + l:shiftwidth
    " if the previous line is the start of a definition body,
    elseif l:pnbline =~# '=>\s*$'
      " indent this line.
      "echomsg 'Continuing4' (l:pnblnum . '-' . v:lnum) (l:pnbindent + l:shiftwidth)
      let l:continuing = 1
      let l:indent = l:pnbindent + l:shiftwidth
    else
      " indent this line twice as far.
      "echomsg 'Continuing5' (l:pnblnum . '-' . v:lnum) (l:pnbindent + l:shiftwidth * 2)
      let l:continuing = 1
      let l:indent = l:pnbindent + l:shiftwidth * 2
    endif

    unlet! l:contlnum l:ppnblnum l:ppcontinued
  endif

  " If this line starts a document string,
  if !l:continuing && l:line =~# '^\s*"""'
    let l:ppnblnum = s:PrevNonblank(l:pnblnum - 1)
    if s:IsContinued(l:ppnblnum)
      let l:contlnum = l:ppnblnum
      while s:IsContinued(l:ppnblnum)
        let l:contlnum = l:ppnblnum
        let l:ppnblnum = s:PrevNonblank(l:ppnblnum - 1)
      endwhile
      if getline(l:contlnum) =~# '\v^\s*%(actor|class|struct|primitive|trait|type|interface)>'
        " reset the indent level.
        "echomsg 'DocString' (l:contlnum . '-' . v:lnum) l:shiftwidth
        return l:shiftwidth
      endif
    endif

    unlet! l:contlnum l:ppnblnum
  endif

  " If the previous line contains an unmatched opening bracket
  if !l:continuing && l:pnbline =~# '[{[(]'
    " if the line ends with an opening bracket,
    if l:pnbline =~# '[{[(]\s*$' && !s:InCommentOrLiteral(l:pnblnum, col([l:pnblnum, '$']) - 1)
      " indent this line.
      let l:indent += l:shiftwidth
    else
      " find the unmatched opening bracket,
      let l:start = [0, 0]
      let l:end = col([l:pnblnum, '$']) - 1
      call cursor(l:pnblnum, l:end)
      while l:end > 0
        let l:start = s:OuterPos(l:start, searchpairpos('(', '', ')', 'bnW', s:skip4, l:pnblnum))
        let l:start = s:OuterPos(l:start, searchpairpos('\[', '', '\]', 'bnW', s:skip4, l:pnblnum))
        let l:start = s:OuterPos(l:start, searchpairpos('{', '', '}', 'bnW', s:skip4, l:pnblnum))
        if l:start == [0, 0]
          break
        endif
        " find the matched closing bracket on the same line,
        call cursor(l:start[0], l:start[1])
        let l:c = s:CharAtCursor(l:start[0], l:start[1])
        if searchpair(escape(l:c, '['), '', escape(tr(l:c, '([{', ')]}'), ']'),
              \ 'znW', s:skip4, l:pnblnum) < 1
          " the unmatched opening bracket is found,
          break
        endif
        let l:end = l:start[1]
        let l:start = [0, 0]
      endwhile
      if l:start != [0, 0]
        " indent this line.
        "echomsg 'Open bracket' (l:pnblnum . '-' . v:lnum) (l:indent + l:shiftwidth)
        let l:indent += l:shiftwidth
      endif
    endif

    unlet! l:start l:end l:c
  endif

  " If there is a matched closing bracket on the previous line,
  " NOTE:
  " >|[
  "  |  (1 -
  "  |      1) * 2]
  "  |  command
  "   ^
  if !l:continuing
    call cursor(l:pnblnum, 1)
    " find the last closing bracket,
    let l:end = [0, 0]
    let l:end = s:OuterPos(l:end, searchpairpos('(', '', ')', 'zncr', s:skip4, l:pnblnum))
    let l:end = s:OuterPos(l:end, searchpairpos('\[', '', '\]', 'zncr', s:skip4, l:pnblnum))
    let l:end = s:OuterPos(l:end, searchpairpos('{', '', '}', 'zncr', s:skip4, l:pnblnum))
    if l:end != [0, 0]
      " find the matched opening bracket on another line,
      let l:c = s:CharAtCursor(l:end[0], l:end[1])
      let l:start = searchpairpos(escape(tr(l:c, ')]}', '([{'), '['), '', escape(l:c, ']'), 'nbW', s:skip4)
      if l:start[0] != l:end[0]
        " and then this line has the same indent as the line the matched bracket stays.
        "echomsg 'Matched bracket' (l:start[0] . '-' . v:lnum) indent(l:start[0])
        let l:indent = indent(l:start[0])
      endif
    endif

    unlet! l:start l:end l:c
  endif

  " If there is a matched closing bracket on this line,
  " NOTE:
  "  |[
  " >|  (1 -
  "  |      1) * 2
  "  |]
  "   ^     ^
  if l:line =~# '^\s*[)\]}]'
    " find the first closing bracket,
    call cursor(v:lnum, 1)
    let l:end = [0, 0]
    let l:end = s:InnerPos(l:end, searchpairpos('(', '', ')', 'zncW', s:skip4, v:lnum))
    let l:end = s:InnerPos(l:end, searchpairpos('\[', '', '\]', 'zncW', s:skip4, v:lnum))
    let l:end = s:InnerPos(l:end, searchpairpos('{', '', '}', 'zncW', s:skip4, v:lnum))
    if l:end != [0, 0]
      " find the matched opening bracket on another line,
      let l:c = s:CharAtCursor(l:end[0], l:end[1])
      let l:start = searchpairpos(escape(tr(l:c, ')]}', '([{'), '['), '', escape(l:c, ']'), 'nbW', s:skip4)
      if l:start[0] != l:end[0]
        " and then this line has the same indent as the line the matched bracket stays.
        "echomsg 'Closing Bracket' (l:start[0] . '-' . v:lnum) indent(l:start[0])
        let l:indent = indent(l:start[0])
      endif
    endif

    unlet! l:start l:end l:c
  endif

  " If this line starts the definition of a method, closure or match case,
  if l:line =~# '^\s*=>'
    " find the start of the definition,
    call cursor(v:lnum, 1)
    let l:start = searchpairpos('\v<%(new|be|fun|lambda)>|\|', '', '=>\zs', 'bnW', s:skip3)
    if l:start != [0, 0]
      " then this line has the same indent as the start.
      "echomsg 'Method body' (l:start[0] . '-' . v:lnum) indent(l:start[0])
      return indent(l:start[0])
    endif

    unlet! l:start
  endif

  " If this line starts a class definition or starts an alias,
  if l:line =~# '\v^\s*%(actor|class|struct|primitive|trait|interface|use|type)>'
    " reset the indent level.
    return 0
  endif

  " If this line starts a method definition,
  if l:line =~# '\v^\s*%(new|be|fun)>'
    call cursor(v:lnum, 1)
    let l:start = searchpairpos(s:cfstart, s:cfmiddle, s:cfend, 'bW', s:skip3)
    if l:start != [0, 0]
      let l:start = searchpos(s:bstartp, 'zcnpW', l:start[0])
      " see if it is in an object block,
      if l:start[2] == 3
        "echomsg 'Method in object' (l:start[0] . '-' . v:lnum) (l:shiftwidth + indent(l:start[0]))
        return l:shiftwidth + indent(l:start[0])
      endif
    endif
    return l:shiftwidth
  endif

  " If this line starts a match case,
  call cursor(v:lnum, 1)
  if l:line =~# '^\s*|' && s:InKeyword(searchpos('|', 'znW', v:lnum))
    " find the start or the previous case of the match block,
    let l:start = searchpairpos(s:cfstart, s:cfmiddle, s:cfend, 'bnW', s:skip3)
    if l:start != [0, 0]
      " then this line has the same indent as the start.
      "echomsg 'Match case' (l:start[0] . '-' . v:lnum) indent(l:start[0])
      return indent(l:start[0])
    endif

    unlet! l:start
  endif

  " If this line ends (part of) a control flow,
  if l:line =~# '\v^\s*%(end|elseif|else|then|in|do|until|elseiftype)>'
    " find the start or middle of the control block,
    call cursor(v:lnum, 1)
    let l:start = searchpairpos(s:cfstart, s:cfmiddle, s:cfend, 'bnW', s:skip3)
    if l:start != [0, 0]
      " then this line has the same indent as the start.
      "echomsg 'Block end' (l:start[0] . '-' . v:lnum) indent(l:start[0])
      return indent(l:start[0])
    endif

    unlet! l:start
  endif

  " If the previous line starts a class definition,
  if l:pnbline =~# '\v^\s*%(actor|class|struct|primitive|trait|type|interface)>'
    " reset the indent level.
    if s:IsContinued(l:pnblnum)
      return l:shiftwidth * 2
    else
      return l:shiftwidth
    endif
  endif

  " If the previous line starts a method definition,
  if l:pnbline =~# '\v^\s*%(new|be|fun)>'
    return l:pnbindent + l:shiftwidth
  endif

  " If the previous line starts (part of) a control flow,
  call cursor(l:pnblnum, 1)
  while 1
    " find the start of the control block,
    let l:start = searchpos(s:bstartp, 'zcepW', l:pnblnum)
    if l:start[2] == 0
      break
    endif
    if !s:InKeyword(l:start[0:1])
      call cursor(l:pnblnum, l:start[1] + 3)
      continue
    endif
    let l:index = l:start[2]
    " find the end of the control block on the same line,
    let l:end = searchpair(s:cfstart, '', s:cfend, 'znW', s:skip3, l:pnblnum)
    " if the control block is not ended,
    if l:end < 1
      " if this line is a case for a match,
      if l:index == 2 && l:line =~# '^\s*|'
        " then this line has the same indent as the start of the match block.
        return l:pnbindent
      else
        " then indent this line.
        "echomsg 'Block start' (l:pnblnum . '-' . v:lnum) (l:pnbindent + l:shiftwidth)
        return l:pnbindent + l:shiftwidth
      endif
    endif
  endwhile

  unlet! l:start l:end l:index

  return l:indent
endfunction

function! s:PrevNonblank(lnum)
  let l:lnum = prevnonblank(a:lnum)
  while l:lnum > 0 && (s:InComment2(l:lnum, 1) || s:InLiteral2(l:lnum, 1))
    let l:lnum = prevnonblank(l:lnum - 1)
  endwhile
  return l:lnum
endfunction

" NOTE:
"                 v
"  |1 /* comment */
"  |2
function! s:IsContinued(lnum)
  let l:lnum = s:PrevNonblank(a:lnum)
  if l:lnum < 1
    return 0
  endif
  let l:line = getline(l:lnum)
  let l:width = strwidth(substitute(l:line, '\s*$', '', ''))
  " FIXME?
  "  | 1 + //
  "  | //
  "  |     2
  return !s:InCommentOrLiteral(a:lnum, l:width)
        \ && (l:line =~# '\v<%(and|or|xor|is|isnt|as|not|consume|addressof|digestof)\s*$'
        \ || l:line =~# '\v%([=\-.]\>|[<!=>]\=\~?|\<\<\~?|\>\>\~?|\<:|[+\-*/%<>]\~?|[.,|:@~])\s*$'
        \ )
endfunction

function! s:InCommentOrLiteral(...)
  return call('s:InComment', a:000) || call('s:InLiteral', a:000)
endfunction

function! s:InKeyword(...)
  let [l:lnum, l:col] = (type(a:1) == type([]) ? a:1 : a:000)
  for id in s:Or(synstack(l:lnum, l:col), [])
    if synIDattr(id, 'name') =~# '^ponyKw'
      return 1
    endif
  endfor
  return 0
endfunction

function! s:InBracket(...)
  let [l:lnum, l:col] = (type(a:1) == type([]) ? a:1 : a:000)
  for id in s:Or(synstack(l:lnum, l:col), [])
    if synIDattr(id, 'name') ==# 'ponyBracket'
      return 1
    endif
  endfor
  return 0
endfunction

function! s:InComment(...)
  let [l:lnum, l:col] = (type(a:1) == type([]) ? a:1 : a:000)
  let l:stack = synstack(l:lnum, l:col)
  let l:i = len(l:stack)
  while l:i > 0
    let l:sname = synIDattr(l:stack[l:i - 1], 'name')
    if l:sname =~# '^ponyNestedCommentX\?$'
      return 1 + l:i - (l:sname =~# 'X$')
    elseif l:sname =~# '^ponyCommentX\?$'
      return 1
    endif
    let l:i -= 1
  endwhile
  return 0
endfunction

function! s:InLiteral(...)
  let [l:lnum, l:col] = (type(a:1) == type([]) ? a:1 : a:000)
  let l:stack = synstack(l:lnum, l:col)
  let l:i = len(l:stack)
  while l:i > 0
    let l:sname = synIDattr(l:stack[l:i - 1], 'name')
    if l:sname =~# '^ponyDocumentStringX\?$'
      return 3
    elseif l:sname =~# '^ponyStringX\?$'
      return 2
    elseif l:sname =~# '^ponyCharacterX\?$'
      return 1
    endif
    let l:i -= 1
  endwhile
  return 0
endfunction

" NOTE:
" |// //inside
"   ^^^^^^^^^^
" |/* /*inside*/ */
"   ^^^^^^^^^^^^^^
function! s:InComment2(...)
  let [l:lnum, l:col] = (type(a:1) == type([]) ? a:1 : a:000)
  let l:stack = synstack(l:lnum, l:col)
  let l:i = len(l:stack)
  while l:i > 0
    let l:sname = synIDattr(l:stack[l:i - 1], 'name')
    if l:sname ==# 'ponyNestedComment'
      return 1 + l:i
    elseif l:sname ==# 'ponyComment'
      return 1
    elseif l:sname =~# '\v^pony%(Nested)?CommentX$'
      return 0
    endif
    let l:i -= 1
  endwhile
  return 0
endfunction

" NOTE:
" |"inside"
"   ^^^^^^
" |"""inside"""""
"   ^^^^^^^^^^^^
function! s:InLiteral2(...)
  let [l:lnum, l:col] = (type(a:1) == type([]) ? a:1 : a:000)
  let l:stack = synstack(l:lnum, l:col)
  let l:i = len(l:stack)
  while l:i > 0
    let l:sname = synIDattr(l:stack[l:i - 1], 'name')
    if l:sname ==# 'ponyDocumentString'
      return 3
    elseif l:sname ==# 'ponyString'
      return 2
    elseif l:sname ==# 'ponyCharacter'
      return 1
    elseif l:sname =~# '\v^pony%(DocumentString|String|Character)X$'
      return 0
    endif
    let l:i -= 1
  endwhile
  return 0
endfunction

function! s:CharAtCursor(...)
  let [l:lnum, l:col] = (type(a:1) == type([]) ? a:1 : a:000)
  return matchstr(getline(l:lnum), '\%' . l:col . 'c.')
endfunction

function! s:Or(x, y)
  return !empty(a:x) ? a:x : a:y
endfunction

function! s:InnerPos(x, y)
  if a:x == [0, 0]
    return a:y
  elseif a:y == [0, 0]
    return a:x
  else
    return a:x[1] < a:y[1] ? a:x : a:y
  end
endfunction

function! s:OuterPos(x, y)
  if a:x == [0, 0]
    return a:y
  elseif a:y == [0, 0]
    return a:x
  else
    return a:x[1] > a:y[1] ? a:x : a:y
  end
endfunction

function! pony#ClearTrailingSpace(all, alt, ...)
  let l:force = (a:0 > 0 ? a:1 : 0)
  if !l:force && (&readonly || !&modifiable || !&modified)
    return
  endif
  if a:all
    for lnum in range(1, line('$'))
      let l:line = getline(lnum)
      let l:end = col([lnum, '$']) - 1
      if l:end > 0 && l:line =~# '\s$' && !s:InLiteral(lnum, l:end)
        if a:alt
          call setline(lnum, substitute(l:line, '\S\@<=\s\s*$', '', ''))
        else
          call setline(lnum, substitute(l:line, '\s\+$', '', ''))
        endif
      endif
    endfor
  else
    let l:lnum = line('.')
    let l:end = col('$') - 1
    let l:line = getline(l:lnum)
    if l:line =~# '\s$' && !s:InLiteral(l:lnum, l:end)
      if a:alt
        call setline(l:lnum, substitute(l:line, '\s\+$', '', ''))
      else
        call setline(l:lnum, substitute(l:line, '\S\@<=\s\s*$', '', ''))
      endif
    endif
  endif
endfunction


let &cpo = s:cpo_save
unlet s:cpo_save

endif
