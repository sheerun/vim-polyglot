let files = filter(globpath(&rtp, 'indent/nginx.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal indentexpr=

" cindent actually works for nginx' simple file structure
setlocal cindent
" Just make sure that the comments are not reset as defs would be.
setlocal cinkeys-=0#

endif
