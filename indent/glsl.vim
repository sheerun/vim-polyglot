if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'glsl') == -1

" Language: OpenGL Shading Language
" Maintainer: Sergey Tikhomirov <sergey@tikhomirov.io>

if exists("b:did_indent")
  finish
endif

setlocal autoindent cindent
setlocal formatoptions+=roq

" vim:set sts=2 sw=2 :

endif
