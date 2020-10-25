if has_key(g:polyglot_is_disabled, 'docker-compose')
  finish
endif

" Define comment string
setlocal commentstring=#\ %s

" Enable automatic comment insertion
setlocal formatoptions+=cro
