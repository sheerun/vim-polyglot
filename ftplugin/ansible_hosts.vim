if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ansible') == -1

if exists("b:did_ftplugin")
  finish
else
  let b:did_ftplugin = 1
endif

setlocal comments=:# commentstring=#\ %s formatoptions-=t formatoptions-=c

let b:undo_ftplugin = "setl comments< commentstring< formatoptions<"

endif
