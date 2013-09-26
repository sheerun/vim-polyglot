if exists("current_compiler")
  finish
endif
let current_compiler = "typescript"

CompilerSet makeprg=tsc\ $*\ %

CompilerSet errorformat=%+A\ %#%f\ %#(%l\\\,%c):\ %m,%C%m
