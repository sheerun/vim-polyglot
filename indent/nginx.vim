if polyglot#init#is_disabled(expand('<sfile>:p'), 'nginx', 'indent/nginx.vim')
  finish
endif

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal indentexpr=

" cindent actually works for nginx' simple file structure
setlocal cindent
" Just make sure that the comments are not reset as defs would be.
setlocal cinkeys-=0#

let b:undo_indent = "setl cin< cink< inde<"
