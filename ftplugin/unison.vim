if polyglot#init#is_disabled(expand('<sfile>:p'), 'unison', 'ftplugin/unison.vim')
  finish
endif

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

call unison#SetBufferDefaults()
