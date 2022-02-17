if polyglot#init#is_disabled(expand('<sfile>:p'), 'glsl', 'indent/glsl.vim')
  finish
endif

" Language: OpenGL Shading Language
" Maintainer: Sergii Tykhomyrov <sergii@tykhomyrov.net>

if exists("b:did_indent")
  finish
endif

setlocal autoindent cindent
setlocal formatoptions+=roq

" vim:set sts=2 sw=2 :
