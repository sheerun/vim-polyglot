if !polyglot#util#IsEnabled('docker-compose', expand('<sfile>:p'))
  finish
endif

" Define comment string
setlocal commentstring=#\ %s

" Enable automatic comment insertion
setlocal formatoptions+=cro
