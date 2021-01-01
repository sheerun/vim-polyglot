if polyglot#init#is_disabled(expand('<sfile>:p'), 'html5', 'after/ftplugin/html.vim')
  finish
endif

" Maintainer:  	othree <othree@gmail.com>
" URL:		      http://github.com/othree/html5.vim
" Last Change:  2014-05-02
" License:      MIT
" Changes:      Add - to keyword

" setlocal iskeyword+=-

setlocal commentstring=<!--%s-->
