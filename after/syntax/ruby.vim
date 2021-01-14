if polyglot#init#is_disabled(expand('<sfile>:p'), 'yard', 'after/syntax/ruby.vim')
  finish
endif

" Ruby syntax extensions for highlighting YARD documentation.
"
" Author: Joel Holdbrooks <https://github.com/noprompt>
" URI: https://github.com/noprompt/vim-yardoc
" Version: 0.0.1
"
" This file reuses the main yardoc syntax definitions and glues them together
" with Vim's builtin ruby syntax groups

runtime! after/syntax/yardoc_support.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Yard glue to ruby
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syn match rubyComment "#.*" contains=rubySharpBang,rubySpaceError,rubyTodo,@Spell,yardComment
syn region rubyMultilineComment start="\%(\%(^\s*#.*\n\)\@<!\%(^\s*#.*\n\)\)\%(\(^\s*#.*\n\)\{1,}\)\@=" end="\%(^\s*#.*\n\)\@<=\%(^\s*#.*\n\)\%(^\s*#\)\@!" contains=rubyComment transparent fold keepend
syn cluster rubyNotTop add=@yardTags,@yardDirectives,@yardTypes,@yardLists,@yardHashes

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tacking on Yard to ruby syntax classes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi def link yardComment rubyComment
hi def link yardGenericTag rubyKeyword
hi def link yardGenericDirective rubyKeyword
