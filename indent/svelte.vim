if polyglot#init#is_disabled(expand('<sfile>:p'), 'svelte', 'indent/svelte.vim')
  finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim indent file
"
" Language: Svelte
" Maintainer: leafOfTree <leafvocation@gmail.com>
"
" CREDITS: Inspired by mxw/vim-jsx.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists("b:did_indent")
  finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Variables {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:name = 'vim-svelte-plugin'
" Let <template> handled by HTML
let s:svelte_tag_start = '\v^\<(script|style)' 
let s:svelte_tag_end = '\v^\<\/(script|style)'
let s:template_tag = '\v^\s*\<\/?template'
" https://developer.mozilla.org/en-US/docs/Glossary/Empty_element
let s:empty_tagname = '(area|base|br|col|embed|hr|input|img|keygen|link|meta|param|source|track|wbr)'
let s:empty_tag = '\v\C\<'.s:empty_tagname.'[^/]*\>' 
let s:empty_tag_start = '\v\<'.s:empty_tagname.'[^\>]*$' 
let s:empty_tag_end = '\v^\s*[^\<\>\/]*\>\s*' 
let s:tag_end = '\v^\s*\/?\>\s*'
let s:oneline_block = '^\s*{#.*{/.*}\s*$'
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Config {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:use_pug = svelte#GetConfig('use_pug', 0)
let s:use_sass = svelte#GetConfig('use_sass', 0)
let s:use_coffee = svelte#GetConfig('use_coffee', 0)
let s:use_typescript = svelte#GetConfig('use_typescript', 0)
let s:has_init_indent = svelte#GetConfig('has_init_indent', 1)
let s:debug = svelte#GetConfig('debug', 0)
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Load indent method {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Save shiftwidth
let s:sw = &sw

" Use lib/indent/ files for compatibility
unlet! b:did_indent
runtime lib/indent/xml.vim

unlet! b:did_indent
runtime lib/indent/css.vim

" Use normal indent files
unlet! b:did_indent
runtime! indent/javascript.vim
let b:javascript_indentexpr = &indentexpr

if s:use_pug
  unlet! b:did_indent
  let s:save_formatoptions = &formatoptions
  runtime! indent/pug.vim
  let &formatoptions = s:save_formatoptions
endif

if s:use_sass
  unlet! b:did_indent
  runtime! indent/sass.vim
endif

if s:use_coffee
  unlet! b:did_indent
  runtime! indent/coffee.vim
endif

if s:use_typescript
  unlet! b:did_indent
  runtime! indent/typescript.vim
endif

" Recover shiftwidth
let &sw = s:sw
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Settings {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" JavaScript indentkeys
setlocal indentkeys=0{,0},0),0],0\,,!^F,o,O,e,:,=:else
" XML indentkeys
setlocal indentkeys+=*<Return>,<>>,<<>,/
setlocal indentexpr=GetSvelteIndent()
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Functions {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! GetSvelteIndent()
  let prevlnum = prevnonblank(v:lnum-1)
  let prevline = getline(prevlnum)
  let prevsyns = s:SynsSOL(prevlnum)

  let curline = getline(v:lnum)
  let cursyns = s:SynsSOL(v:lnum)
  let cursyn = get(cursyns, 0, '')

  if s:SynHTML(cursyn)
    call s:Log('syntax: html')
    let ind = XmlIndentGet(v:lnum, 0)
    if prevline =~? s:empty_tag
      call s:Log('previous line is empty tag')
      let ind = ind - &sw
    endif

    if s:IsBlockStart(prevsyns) && prevline !~ s:oneline_block
      call s:Log('increase block indent')
      let ind = ind + &sw
    endif

    if s:IsBlockEnd(cursyns, curline)
      call s:Log('decrease block indent')
      let ind = ind - &sw
    endif

    " Align '/>' and '>' with '<' for multiline tags.
    if curline =~? s:tag_end 
      let ind = ind - &sw
    endif
    " Then correct the indentation of any element following '/>' or '>'.
    if prevline =~? s:tag_end
      let ind = ind + &sw

      "Decrease indent if prevlines are a multiline empty tag
      let [start, end] = s:PrevMultilineEmptyTag(v:lnum)
      if end == prevlnum
        call s:Log('previous line is a multiline empty tag')
        let ind = indent(v:lnum - 1)
      endif
    endif
  elseif s:SynPug(cursyn)
    call s:Log('syntax: pug')
    let ind = GetPugIndent()
  elseif s:SynCoffee(cursyn)
    call s:Log('syntax: coffee')
    let ind = GetCoffeeIndent(v:lnum)
  elseif s:SynTypeScript(cursyn)
    call s:Log('syntax: typescript')
    let ind = GetTypescriptIndent()
  elseif s:SynSASS(cursyn)
    call s:Log('syntax: sass')
    let ind = GetSassIndent()
  elseif s:SynStyle(cursyn)
    call s:Log('syntax: style')
    let ind = GetCSSIndent()
  else
    call s:Log('syntax: javascript')
    if len(b:javascript_indentexpr)
      let ind = eval(b:javascript_indentexpr)
    else
      let ind = cindent(v:lnum)
    endif
  endif

  if curline =~? s:svelte_tag_start || curline =~? s:svelte_tag_end 
        \|| prevline =~? s:svelte_tag_end
        \|| (curline =~ s:template_tag && s:SynPug(cursyn))
    call s:Log('current line is svelte tag or previous line is svelte tag end')
    call s:Log('... or current line is pug template tag')
    let ind = 0
  elseif s:has_init_indent
    if s:SynSvelteScriptOrStyle(cursyn) && ind < 1
      call s:Log('add initial indent')
      let ind = &sw
    endif
  elseif prevline =~? s:svelte_tag_start
    call s:Log('previous line is svelte tag start')
    let ind = 0
  endif

  call s:Log('indent: '.ind)
  return ind
endfunction

function! s:IsBlockStart(prevsyns)
  let prevsyn_second = get(a:prevsyns, 1, '')
  " Some HTML tags add an extra syntax layer
  let prevsyn_third = get(a:prevsyns, 2, '')
  return s:SynBlockBody(prevsyn_second)
        \ || s:SynBlockStart(prevsyn_second)
        \ || s:SynBlockBody(prevsyn_third)
        \ || s:SynBlockStart(prevsyn_third)
endfunction

function! s:IsBlockEnd(cursyns, curline)
  let cursyn_second = get(a:cursyns, 1, '')
  " Some HTML tags add an extra syntax layer
  let cursyn_third = get(a:cursyns, 2, '')
  return a:curline !~ '^\s*$'
        \ && (s:SynBlockBody(cursyn_second)
        \ || s:SynBlockEnd(cursyn_second)
        \ || s:SynBlockBody(cursyn_third)
        \ || s:SynBlockEnd(cursyn_third))
endfunction

function! s:SynsEOL(lnum)
  let lnum = prevnonblank(a:lnum)
  let col = strlen(getline(lnum))
  return map(synstack(lnum, col), 'synIDattr(v:val, "name")')
endfunction

function! s:SynsSOL(lnum)
  let lnum = prevnonblank(a:lnum)
  let col = match(getline(lnum), '\S') + 1
  return map(synstack(lnum, col), 'synIDattr(v:val, "name")')
endfunction

function! s:SynHTML(syn)
  return a:syn ==? 'htmlSvelteTemplate'
endfunction

function! s:SynBlockBody(syn)
  return a:syn ==? 'svelteBlockBody'
endfunction

function! s:SynBlockStart(syn)
  return a:syn ==? 'svelteBlockStart'
endfunction

function! s:SynBlockEnd(syn)
  return a:syn ==? 'svelteBlockEnd'
endfunction

function! s:SynPug(syn)
  return a:syn ==? 'pugSvelteTemplate'
endfunction

function! s:SynCoffee(syn)
  return a:syn ==? 'coffeeSvelteScript'
endfunction

function! s:SynTypeScript(syn)
  return a:syn ==? 'typescriptSvelteScript'
endfunction

function! s:SynSASS(syn)
  return a:syn ==? 'cssSassSvelteStyle'
endfunction

function! s:SynStyle(syn)
  return a:syn =~? 'SvelteStyle'
endfunction

function! s:SynSvelteScriptOrStyle(syn)
  return a:syn =~? '\v(SvelteStyle)|(SvelteScript)'
endfunction

function! s:PrevMultilineEmptyTag(lnum)
  let lnum = a:lnum - 1
  let lnums = [0, 0]
  while lnum > 0
    let line = getline(lnum)
    if line =~? s:empty_tag_end
      let lnums[1] = lnum
    endif

    if line =~? s:tag_start
      if line =~? s:empty_tag_start
        let lnums[0] = lnum
        return lnums
      else
        return [0, 0]
      endif
    endif

    let lnum = lnum - 1
  endwhile
endfunction

function! s:Log(msg)
  if s:debug
    echom '['.s:name.']['.v:lnum.'] '.a:msg
  endif
endfunction
"}}}

let b:did_indent = 1
" vim: fdm=marker
