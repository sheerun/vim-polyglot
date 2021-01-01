if polyglot#init#is_disabled(expand('<sfile>:p'), 'javascript', 'syntax/flow.vim')
  finish
endif

runtime syntax/javascript.vim
runtime extras/flow.vim
