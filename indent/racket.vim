if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'racket') == -1

" Language:     Racket
" Maintainer:   Will Langstroth <will@langstroth.com>
" URL:          http://github.com/wlangstroth/vim-racket

if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

setlocal ai nosi

let b:undo_indent = "setl ai< si<"

endif
