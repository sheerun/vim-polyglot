if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vue') == -1
  
" Vim indent file
" Language: Vue.js
" Maintainer: Eduardo San Martin Morote
" Author: Adriaan Zonnenberg

if exists("b:did_indent")
  finish
endif

" Load indent files for required languages
for language in ['stylus', 'pug', 'css', 'javascript', 'html', 'coffee']
  unlet! b:did_indent
  exe "runtime! indent/".language.".vim"
  exe "let s:".language."indent = &indentexpr"
endfor

let b:did_indent = 1

setlocal indentexpr=GetVueIndent()

if exists("*GetVueIndent")
  finish
endif

function! GetVueIndent()
  if searchpair('<template lang="pug"', '', '</template>', 'bWr')
    exe "let indent = ".s:pugindent
  elseif searchpair('<style lang="stylus"', '', '</style>', 'bWr')
    exe "let indent = ".s:stylusindent
  elseif searchpair('<style', '', '</style>', 'bWr')
    exe "let indent = ".s:cssindent
  elseif searchpair('<script lang="coffee"', '', '</script>', 'bWr')
    exe "let indent = ".s:coffeeindent
  elseif searchpair('<script', '', '</script>', 'bWr')
    exe "let indent = ".s:javascriptindent
  else
    exe "let indent = ".s:htmlindent
  endif

  return indent > -1 ? indent : s:htmlindent
endfunction

endif
