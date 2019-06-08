if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'hive') != -1
  finish
endif

setlocal comments=:--
setlocal commentstring=--\ %s
