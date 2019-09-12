if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'opencl') == -1

if exists("b:did_ftplugin") | finish | endif

if version > 600
  runtime! ftplugin/c.vim
endif

" Smaller tab stops.
setlocal tabstop=4
setlocal shiftwidth=4

" Smart tabbing/indenting
setlocal smarttab
setlocal smartindent

let b:did_ftplugin = 1

endif
