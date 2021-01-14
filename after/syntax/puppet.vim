if polyglot#init#is_disabled(expand('<sfile>:p'), 'yard', 'after/syntax/puppet.vim')
  finish
endif

" Puppet syntax extensions for highlighting YARD documentation.
"
" Author: Gabriel Filion <gabster@lelutin.ca>
" URI: https://github.com/noprompt/vim-yardoc
" Version: 0.0.1
"
" This file reuses the main yardoc syntax definitions and glues them together
" with puppet syntax groups from vim-puppet

runtime! after/syntax/yardoc_support.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Yard glue to puppet
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syn match  puppetComment "\s*#.*$" contains=puppetTodo,@Spell,yardComment
syn region puppetComment start="/\*" end="\*/" contains=puppetTodo,@Spell,yardComment extend fold keepend
syn cluster puppetNotTop add=@yardTags,@yardDirectives,@yardTypes,@yardLists,@yardHashes

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tacking on Yard to puppet syntax classes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi def link yardComment puppetComment
hi def link yardGenericTag puppetKeyword
hi def link yardGenericDirective puppetKeyword
