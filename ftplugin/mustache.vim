if polyglot#init#is_disabled(expand('<sfile>:p'), 'handlebars', 'ftplugin/mustache.vim')
  finish
endif

runtime! ftplugin/handlebars*.vim ftplugin/handlebars/*.vim
