if !polyglot#util#IsEnabled('ansible', expand('<sfile>:p'))
  finish
endif

set isfname+=@-@
set path+=./../templates,./../files,templates,files
