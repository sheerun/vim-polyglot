if has_key(g:polyglot_is_disabled, 'handlebars')
  finish
endif

runtime! ftplugin/handlebars*.vim ftplugin/handlebars/*.vim
