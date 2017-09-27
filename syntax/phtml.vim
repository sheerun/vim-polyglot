if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vim') == -1
  
" Vim syntax file
" PHTML used to be the filetype for PHP 2.0.  Now everything is PHP.

if !exists("b:current_syntax")
  runtime! syntax/php.vim
endif

endif
