if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dockerfile') == -1

" Define comment string
setlocal commentstring=#\ %s

" Enable automatic comment insertion
setlocal formatoptions+=cro

endif
