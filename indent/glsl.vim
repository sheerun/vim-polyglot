if has_key(g:polyglot_is_disabled, 'glsl')
  finish
endif

" Language: OpenGL Shading Language
" Maintainer: Sergey Tikhomirov <sergey@tikhomirov.io>

if exists("b:did_indent")
  finish
endif

setlocal autoindent cindent
setlocal formatoptions+=roq

" vim:set sts=2 sw=2 :
