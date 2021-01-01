if polyglot#init#is_disabled(expand('<sfile>:p'), 'docker-compose', 'ftplugin/docker-compose.vim')
  finish
endif

" Define comment string
setlocal commentstring=#\ %s

" Enable automatic comment insertion
setlocal formatoptions+=cro
