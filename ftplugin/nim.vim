if exists("b:nim_loaded")
  finish
endif

let b:nim_loaded = 1

let s:cpo_save = &cpo
set cpo&vim

call nim#init()

setlocal formatoptions-=t formatoptions+=croql
setlocal comments=:##,:#
setlocal commentstring=#\ %s
setlocal omnifunc=NimComplete
setlocal suffixesadd=.nim 
setlocal expandtab  "Make sure that only spaces are used

compiler nim

let &cpo = s:cpo_save
unlet s:cpo_save

