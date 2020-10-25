if !polyglot#util#IsEnabled('graphql', expand('<sfile>:p'))
  finish
endif

runtime! after/syntax/javascript/graphql.vim
