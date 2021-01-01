if polyglot#init#is_disabled(expand('<sfile>:p'), 'v', 'ftplugin/vlang.vim')
  finish
endif

setlocal commentstring=//\ %s
setlocal makeprg=v\ %
