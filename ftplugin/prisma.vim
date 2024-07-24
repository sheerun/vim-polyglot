if polyglot#init#is_disabled(expand('<sfile>:p'), 'prisma', 'ftplugin/prisma.vim')
  finish
endif

if (exists('b:did_ftplugin'))
  finish
endif
let b:did_ftplugin = 1
setlocal iskeyword+=@-@
setlocal comments=://
setlocal commentstring=//\ %s