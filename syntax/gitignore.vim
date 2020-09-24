if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'gitignore') == -1

" Vim syntax file
" Language:	.gitignore
" Maintainer:	Roman Dolgushin <rd@roman-dolgushin.ru>
" URL:		http://github.com/rdolgushin/gitignore.vim

if exists('b:current_syntax')
  finish
endif

if !exists('main_syntax')
  let main_syntax = 'conf'
endif

runtime! syntax/conf.vim
unlet b:current_syntax

let b:current_syntax = 'gitignore'

setlocal commentstring=#%s

endif
