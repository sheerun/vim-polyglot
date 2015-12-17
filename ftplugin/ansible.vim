if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ansible') == -1
  
" Slow yaml highlighting workaround
if exists('+regexpengine') && ('&regexpengine' == 0)
  setlocal regexpengine=1
endif

endif
