if polyglot#init#is_disabled(expand('<sfile>:p'), 'fish', 'compiler/fish.vim')
  finish
endif

if exists('current_compiler')
    finish
endif
let current_compiler = 'fish'

CompilerSet makeprg=fish\ --no-execute\ %
execute 'CompilerSet errorformat='.escape(fish#errorformat(), ' ')
