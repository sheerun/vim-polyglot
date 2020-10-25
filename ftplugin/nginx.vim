if !polyglot#util#IsEnabled('nginx', expand('<sfile>:p'))
  finish
endif

setlocal commentstring=#\ %s
