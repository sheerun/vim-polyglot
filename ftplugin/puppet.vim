if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'puppet') == -1
  
setl ts=2
setl sts=2
setl sw=2
setl et
setl keywordprg=puppet\ describe\ --providers
setl iskeyword=-,:,@,48-57,_,192-255
setl cms=#\ %s

endif
