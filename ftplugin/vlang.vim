if has_key(g:polyglot_is_disabled, 'v')
  finish
endif

setlocal commentstring=//\ %s
setlocal makeprg=v\ %
