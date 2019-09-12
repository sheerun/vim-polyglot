if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

if exists('current_compiler')
  finish
endif

let current_compiler='typescript'

if !exists('g:typescript_compiler_binary')
  let g:typescript_compiler_binary = 'tsc'
endif

if !exists('g:typescript_compiler_options')
  if exists('g:syntastic_typescript_tsc_args')
    let g:typescript_compiler_options = g:syntastic_typescript_tsc_args
  else
    let g:typescript_compiler_options = ''
  endif
endif

let &l:makeprg = g:typescript_compiler_binary . ' ' . g:typescript_compiler_options . ' $* %'

CompilerSet errorformat=%+A\ %#%f\ %#(%l\\\,%c):\ %m,%C%m

endif
