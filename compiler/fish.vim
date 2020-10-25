if has_key(g:polyglot_is_disabled, 'fish')
  finish
endif

if exists('current_compiler')
    finish
endif
let current_compiler = 'fish'

CompilerSet makeprg=fish\ --no-execute\ %
execute 'CompilerSet errorformat='.escape(fish#errorformat(), ' ')
