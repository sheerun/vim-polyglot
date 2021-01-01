if polyglot#init#is_disabled(expand('<sfile>:p'), 'hive', 'ftplugin/hive.vim')
  finish
endif

setlocal comments=:--
setlocal commentstring=--\ %s
