if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'slim') == -1

if exists("b:did_ftplugin")
  finish
endif

" Define some defaults in case the included ftplugins don't set them.
let s:undo_ftplugin = ""

" Override our defaults if these were set by an included ftplugin.
if exists("b:undo_ftplugin")
  let s:undo_ftplugin = b:undo_ftplugin
  unlet b:undo_ftplugin
endif

runtime! ftplugin/ruby.vim ftplugin/ruby_*.vim ftplugin/ruby/*.vim
let b:did_ftplugin = 1

" Combine the new set of values with those previously included.
if exists("b:undo_ftplugin")
  let s:undo_ftplugin = b:undo_ftplugin . " | " . s:undo_ftplugin
endif

let b:undo_ftplugin = "setl isk<" . " | " . s:undo_ftplugin

setlocal iskeyword+=-
setlocal commentstring=/%s

endif
