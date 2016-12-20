if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  
" Vim indent file
" Language: Javascript
" Maintainer: Chris Paul ( https://github.com/bounceme )
" URL: https://github.com/pangloss/vim-javascript
" Last Change: December 14, 2016

" Only load this indent file when no other was loaded.
if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

" Now, set up our indentation expression and keys that trigger it.
setlocal indentexpr=GetJavascriptIndent()
setlocal autoindent nolisp nosmartindent
setlocal indentkeys+=0],0)

let b:undo_indent = 'setlocal indentexpr< smartindent< autoindent< indentkeys<'

" Only define the function once.
if exists('*GetJavascriptIndent')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Get shiftwidth value
if exists('*shiftwidth')
  function s:sw()
    return shiftwidth()
  endfunction
else
  function s:sw()
    return &sw
  endfunction
endif

" searchpair() wrapper
if has('reltime')
  function s:GetPair(start,end,flags,skip,time,...)
    return searchpair(a:start,'',a:end,a:flags,a:skip,max([prevnonblank(v:lnum) - 2000,0] + a:000),a:time)
  endfunction
else
  function s:GetPair(start,end,flags,skip,...)
    return searchpair(a:start,'',a:end,a:flags,a:skip,max([prevnonblank(v:lnum) - 1000,get(a:000,1)]))
  endfunction
endif

" Regex of syntax group names that are or delimit string or are comments.
let s:syng_strcom = 'string\|comment\|regex\|special\|doc\|template'
let s:syng_str = 'string\|template'
let s:syng_com = 'comment\|doc'
" Expression used to check whether we should skip a match with searchpair().
let s:skip_expr = "synIDattr(synID(line('.'),col('.'),0),'name') =~? '".s:syng_strcom."'"

function s:skip_func()
  if !s:free || search('`\|\*\/','nW',s:looksyn)
    let s:free = !eval(s:skip_expr)
    let s:looksyn = s:free ? line('.') : s:looksyn
    return !s:free
  endif
  let s:looksyn = line('.')
  return (search('\/','nbW',s:looksyn) || search('[''"\\]','nW',s:looksyn)) && eval(s:skip_expr)
endfunction

function s:alternatePair(stop)
  while search('[][(){}]','bW',a:stop)
    if !s:skip_func()
      let idx = stridx('])}',s:looking_at())
      if idx + 1
        if !s:GetPair(['\[','(','{'][idx], '])}'[idx],'bW','s:skip_func()',2000,a:stop)
          break
        endif
      else
        return
      endif
    endif
  endwhile
  call cursor(v:lnum,1)
endfunction

function s:syn_at(l,c)
  return synIDattr(synID(a:l,a:c,0),'name')
endfunction

function s:looking_at()
  return getline('.')[col('.')-1]
endfunction

function s:token()
  return s:looking_at() =~ '\k' ? expand('<cword>') : s:looking_at()
endfunction

" NOTE: Moves the cursor, unless a arg is supplied.
function s:previous_token(...)
  let l:pos = getpos('.')[1:2]
  return [search('.\>\|[^[:alnum:][:space:]_$]','bW') ?
        \ (s:looking_at() == '/' || line('.') != l:pos[0] && getline('.') =~ '\/\/') &&
        \ s:syn_at(line('.'),col('.')) =~? s:syng_com ?
        \ search('\_[^/]\zs\/[/*]','bW') ? s:previous_token() : ''
        \ : s:token()
        \ : ''][a:0 && call('cursor',l:pos)]
endfunction

" switch case label pattern
let s:case_stmt = '\<\%(case\>\s*[^ \t:].*\|default\s*\):\C'

function s:label_end(ln,con)
  return !cursor(a:ln,match(' '.a:con, '.*\zs' . s:case_stmt . '$')) &&
        \ (expand('<cword>') !=# 'default' || s:previous_token(1) !~ '[{,.]')
endfunction

" configurable regexes that define continuation lines, not including (, {, or [.
let s:opfirst = '^' . get(g:,'javascript_opfirst',
      \ '\%([<>=,?^%|*/&]\|\([-.:+]\)\1\@!\|!=\|in\%(stanceof\)\=\>\)')
let s:continuation = get(g:,'javascript_continuation',
      \ '\%([<=,.~!?/*^%|&:]\|+\@<!+\|-\@<!-\|=\@<!>\|\<\%(typeof\|delete\|void\|in\|instanceof\)\)') . '$'

function s:continues(ln,con)
  return !cursor(a:ln, match(' '.a:con,s:continuation)) &&
        \ eval((['s:syn_at(line("."),col(".")) !~? "regex"'] +
        \ repeat(['s:previous_token() != "."'],5) + [1])[
        \ index(split('/ typeof in instanceof void delete'),s:token())])
endfunction

" get the line of code stripped of comments. if called with two args, leave
" cursor at the last non-comment char.
function s:Trim(ln,...)
  let pline = substitute(getline(a:ln),'\s*$','','')
  let l:max = max([match(pline,'.*[^/]\zs\/[/*]'),0])
  while l:max && s:syn_at(a:ln, strlen(pline)) =~? s:syng_com
    let pline = substitute(strpart(pline, 0, l:max),'\s*$','','')
    let l:max = max([match(pline,'.*[^/]\zs\/[/*]'),0])
  endwhile
  return !a:0 || cursor(a:ln,strlen(pline)) ? pline : pline
endfunction

" Find line above 'lnum' that isn't empty or in a comment
function s:PrevCodeLine(lnum)
  let l:n = prevnonblank(a:lnum)
  while getline(l:n) =~ '^\s*\/[/*]' || s:syn_at(l:n,1) =~? s:syng_com
    let l:n = prevnonblank(l:n-1)
  endwhile
  return l:n
endfunction

" Check if line 'lnum' has a balanced amount of parentheses.
function s:Balanced(lnum)
  let l:open = 0
  let l:line = getline(a:lnum)
  let pos = match(l:line, '[][(){}]', 0)
  while pos != -1
    if s:syn_at(a:lnum,pos + 1) !~? s:syng_strcom
      let l:open += match(' ' . l:line[pos],'[[({]')
      if l:open < 0
        return
      endif
    endif
    let pos = match(l:line, '[][(){}]', pos + 1)
  endwhile
  return !l:open
endfunction

function s:OneScope(lnum)
  let pline = s:Trim(a:lnum,1)
  if pline[-1:] == ')' && s:GetPair('(', ')', 'bW', s:skip_expr, 100) > 0
    let token = s:previous_token()
    if index(split('await each'),token) + 1
      return s:previous_token() ==# 'for'
    endif
    return index(split('for if let while with'),token) + 1
  endif
  return eval((['getline(".")[col(".")-2] == "="'] +
        \ repeat(['s:previous_token(1) != "."'],2) + [0])[
        \ index(split('> else do'),s:token())])
endfunction

" returns braceless levels started by 'i' and above lines * &sw. 'num' is the
" lineNr which encloses the entire context, 'cont' if whether line 'i' + 1 is
" a continued expression, which could have started in a braceless context
function s:iscontOne(i,num,cont)
  let [l:i, l:num, bL] = [a:i, a:num + !a:num, 0]
  let pind = a:num ? indent(l:num) + s:W : 0
  let ind = indent(l:i) + (a:cont ? 0 : s:W)
  while l:i >= l:num && (ind > pind || l:i == l:num)
    if indent(l:i) < ind && s:OneScope(l:i)
      let bL += s:W
      let l:i = line('.')
    elseif !a:cont || bL || ind < indent(a:i)
      break
    endif
    let ind = min([ind, indent(l:i)])
    let l:i = s:PrevCodeLine(l:i - 1)
  endwhile
  return bL
endfunction

" https://github.com/sweet-js/sweet.js/wiki/design#give-lookbehind-to-the-reader
function s:IsBlock()
  let l:ln = line('.')
  let char = s:previous_token()
  let syn = char =~ '[{>/]' ? s:syn_at(line('.'),col('.')-(char == '{')) : ''
  if syn =~? 'xml\|jsx'
    return char != '{'
  elseif char =~ '\k'
    return index(split('return const let import export yield default delete var void typeof throw new in instanceof')
          \ ,char) < (0 + (line('.') != l:ln)) || s:previous_token() == '.'
  elseif char == '>'
    return getline('.')[col('.')-2] == '=' || syn =~? '^jsflow'
  elseif char == ':'
    return s:label_end(0,strpart(getline('.'),0,col('.')))
  endif
  return syn =~? 'regex' || char !~ '[-=~!<*+,/?^%|&([]'
endfunction

function GetJavascriptIndent()
  let b:js_cache = get(b:,'js_cache',[0,0,0])
  " Get the current line.
  let l:line = getline(v:lnum)
  let syns = s:syn_at(v:lnum, 1)

  " start with strings,comments,etc.
  if syns =~? s:syng_com
    if l:line =~ '^\s*\*'
      return cindent(v:lnum)
    elseif l:line !~ '^\s*\/[/*]'
      return -1
    endif
  elseif syns =~? s:syng_str && l:line !~ '^[''"]'
    if b:js_cache[0] == v:lnum - 1 && s:Balanced(v:lnum-1)
      let b:js_cache[0] = v:lnum
    endif
    return -1
  endif
  let l:lnum = s:PrevCodeLine(v:lnum - 1)
  if !l:lnum
    return
  endif

  let l:line = substitute(l:line,'^\s*','','')
  if l:line[:1] == '/*'
    let l:line = substitute(l:line,'^\%(\/\*.\{-}\*\/\s*\)*','','')
  endif
  if l:line =~ '^\/[/*]'
    let l:line = ''
  endif

  " the containing paren, bracket, or curly. Many hacks for performance
  call cursor(v:lnum,1)
  let idx = strlen(l:line) ? stridx('])}',l:line[0]) : -1
  if b:js_cache[0] >= l:lnum && b:js_cache[0] < v:lnum &&
        \ (b:js_cache[0] > l:lnum || s:Balanced(l:lnum))
    call call('cursor',b:js_cache[1:])
  else
    let [s:looksyn, s:free, top] = [v:lnum - 1, 1, (!indent(l:lnum) &&
          \ s:syn_at(l:lnum,1) !~? s:syng_str) * l:lnum]
    if idx + 1
      call s:GetPair(['\[','(','{'][idx], '])}'[idx],'bW','s:skip_func()',2000,top)
    elseif indent(v:lnum) && syns =~? 'block'
      call s:GetPair('{','}','bW','s:skip_func()',2000,top)
    else
      call s:alternatePair(top)
    endif
  endif

  if idx + 1
    if idx == 2 && search('\S','bW',line('.')) && s:looking_at() == ')'
      call s:GetPair('(',')','bW',s:skip_expr,200)
    endif
    return indent('.')
  endif

  let b:js_cache = [v:lnum] + (line('.') == v:lnum ? [0,0] : getpos('.')[1:2])
  let num = b:js_cache[1]

  let [s:W, isOp, bL, switch_offset] = [s:sw(),0,0,0]
  if !num || s:looking_at() == '{' && s:IsBlock()
    let pline = s:Trim(l:lnum)
    if num && s:looking_at() == ')' && s:GetPair('(', ')', 'bW', s:skip_expr, 100) > 0
      let num = line('.')
      if s:previous_token() ==# 'switch'
        if &cino !~ ':' || !has('float')
          let switch_offset = s:W
        else
          let cinc = matchlist(&cino,'.*:\(-\)\=\([0-9.]*\)\(s\)\=\C')
          let switch_offset = float2nr(str2float(cinc[1].(strlen(cinc[2]) ? cinc[2] : strlen(cinc[3])))
                \ * (strlen(cinc[3]) ? s:W : 1))
        endif
        if pline[-1:] != '.' && l:line =~# '^' . s:case_stmt
          return indent(num) + switch_offset
        elseif s:label_end(l:lnum,pline)
          return indent(l:lnum) + s:W
        endif
      endif
    endif
    if pline[-1:] !~ '[{;]'
      let isOp = l:line =~# s:opfirst || s:continues(l:lnum,pline)
      let bL = s:iscontOne(l:lnum,num,isOp)
      let bL -= (bL && l:line[0] == '{') * s:W
    endif
  endif

  " main return
  if isOp
    return (num ? indent(num) : -s:W) + (s:W * 2) + switch_offset + bL
  elseif num
    return indent(num) + s:W + switch_offset + bL
  endif
  return bL
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save

endif
