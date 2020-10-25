if !polyglot#util#IsEnabled('fish', expand('<sfile>:p'))
  finish
endif

if exists('current_compiler')
    finish
endif
let current_compiler = 'fish'

CompilerSet makeprg=fish\ --no-execute\ %
execute 'CompilerSet errorformat='.escape(fish#errorformat(), ' ')
