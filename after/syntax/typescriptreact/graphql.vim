if !polyglot#util#IsEnabled('graphql', expand('<sfile>:p'))
  finish
endif

runtime! after/syntax/typescript/graphql.vim
