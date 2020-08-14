if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'svelte') == -1

" Vim indent file
" Language:   Svelte 3 (HTML/JavaScript)
" Author:     Evan Lecklider <evan@lecklider.com>
" Maintainer: Evan Lecklide <evan@lecklider.com>
" URL:        https://github.com/evanleck/vim-svelte

if exists("b:did_indent")
  finish
endif

runtime! indent/html.vim
unlet! b:did_indent

let s:html_indent = &l:indentexpr
let b:did_indent = 1

if !exists('g:svelte_indent_script')
  let g:svelte_indent_script = 1
endif

if !exists('g:svelte_indent_style')
  let g:svelte_indent_style = 1
endif

setlocal indentexpr=GetSvelteIndent()
setlocal indentkeys=o,O,*<Return>,<>>,{,},0),0],!^F,;,=:else,=:then,=:catch,=/if,=/each,=/await

" Only define the function once.
if exists('*GetSvelteIndent')
  finish
endif

function! GetSvelteIndent()
  let current_line_number = v:lnum

  if current_line_number == 0
    return 0
  endif

  let current_line = getline(current_line_number)

  " Opening script and style tags should be all the way outdented.
  if current_line =~ '^\s*</\?\(script\|style\)'
    return 0
  endif

  let previous_line_number = prevnonblank(current_line_number - 1)
  let previous_line = getline(previous_line_number)
  let previous_line_indent = indent(previous_line_number)

  " The inside of scripts an styles should be indented unless disabled.
  if previous_line =~ '^\s*<script'
    if g:svelte_indent_script
      return previous_line_indent + shiftwidth()
    else
      return previous_line_indent
    endif
  endif

  if previous_line =~ '^\s*<style'
    if g:svelte_indent_style
      return previous_line_indent + shiftwidth()
    else
      return previous_line_indent
    endif
  endif

  execute "let indent = " . s:html_indent

  " For some reason, the HTML CSS indentation keeps indenting the next line over
  " and over after each style declaration.
  if searchpair('<style>', '', '</style>', 'bW') && previous_line =~ ';$' && current_line !~ '}'
    return previous_line_indent
  endif

  " "/await" or ":catch" or ":then"
  if current_line =~ '^\s*{\s*\/await' || current_line =~ '^\s*{\s*:\(catch\|then\)'
    let await_start = searchpair('{\s*#await\>', '', '{\s*\/await\>', 'bW')

    if await_start
      return indent(await_start)
    endif
  endif

  " "/each"
  if current_line =~ '^\s*{\s*\/each'
    let each_start = searchpair('{\s*#each\>', '', '{\s*\/each\>', 'bW')

    if each_start
      return indent(each_start)
    endif
  endif

  " "/if"
  if current_line =~ '^\s*{\s*\/if'
    let if_start = searchpair('{\s*#if\>', '', '{\s*\/if\>', 'bW')

    if if_start
      return indent(if_start)
    endif
  endif

  " ":else" is tricky because it can match an opening "#each" _or_ an opening
  " "#if", so we try to be smart and look for the closest of the two.
  if current_line =~ '^\s*{\s*:else'
    let if_start = searchpair('{\s*#if\>', '', '{\s*\/if\>', 'bW')

    " If it's an "else if" then we know to look for an "#if"
    if current_line =~ '^\s*{\s*:else if' && if_start
      return indent(if_start)
    else
      " The greater line number will be closer to the cursor position because
      " we're searching backward.
      return indent(max([if_start, searchpair('{\s*#each\>', '', '{\s*\/each\>', 'bW')]))
    endif
  endif

  " "#if" or "#each"
  if previous_line =~ '^\s*{\s*#\(if\|each\|await\)'
    return previous_line_indent + shiftwidth()
  endif

  " ":else" or ":then"
  if previous_line =~ '^\s*{\s*:\(else\|catch\|then\)'
    return previous_line_indent + shiftwidth()
  endif

  " Custom element juggling for abnormal self-closing tags (<Widget />),
  " capitalized component tags (<Widget></Widget>), and custom svelte tags
  " (<svelte:head></svelte:head>).
  if synID(previous_line_number, match(previous_line, '\S') + 1, 0) == hlID('htmlTag')
        \ && synID(current_line_number, match(current_line, '\S') + 1, 0) != hlID('htmlEndTag')
    let indents_match = indent == previous_line_indent
    let previous_closes = previous_line =~ '/>$'

    if indents_match && !previous_closes && previous_line =~ '<\(\u\|\l\+:\l\+\)'
      return previous_line_indent + shiftwidth()
    elseif !indents_match && previous_closes
      return previous_line_indent
    endif
  endif

  return indent
endfunction

endif
