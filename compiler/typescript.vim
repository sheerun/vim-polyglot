if exists("current_compiler")
  finish
endif
let current_compiler = "typescript"

if !exists("g:typescript_compiler_options")
  let g:typescript_compiler_options = ""
endif


let &l:makeprg='tsc' . g:typescript_compiler_options . ' $*  %'

CompilerSet errorformat=%+A\ %#%f\ %#(%l\\\,%c):\ %m,%C%m
