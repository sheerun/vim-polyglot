if !polyglot#util#IsEnabled('handlebars', expand('<sfile>:p'))
  finish
endif

runtime! ftplugin/handlebars*.vim ftplugin/handlebars/*.vim
