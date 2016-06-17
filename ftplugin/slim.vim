if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'slim') == -1
  
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = "setl isk<"

setlocal iskeyword+=-
setlocal commentstring=/%s

endif
