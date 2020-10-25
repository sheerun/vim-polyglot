if has_key(g:polyglot_is_disabled, 'graphql')
  finish
endif

runtime! after/syntax/javascript/graphql.vim
