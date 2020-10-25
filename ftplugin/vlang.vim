if !polyglot#util#IsEnabled('v', expand('<sfile>:p'))
  finish
endif

setlocal commentstring=//\ %s
setlocal makeprg=v\ %
