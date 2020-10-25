if has_key(g:polyglot_is_disabled, 'racket')
  finish
endif

" Language:     Racket
" Maintainer:   Will Langstroth <will@langstroth.com>
" URL:          http://github.com/wlangstroth/vim-racket

if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

setlocal ai nosi

let b:undo_indent = "setl ai< si<"
