let files = filter(globpath(&rtp, 'indent/glsl.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
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
