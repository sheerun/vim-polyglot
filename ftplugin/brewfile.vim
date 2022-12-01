if polyglot#init#is_disabled(expand('<sfile>:p'), 'brewfile', 'ftplugin/brewfile.vim')
  finish
endif

" Load ruby filetype plugin
runtime! ftplugin/ruby.vim
