if has_key(g:polyglot_is_disabled, 'razor')
  finish
endif

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" vim:set sw=2:
