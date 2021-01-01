if polyglot#init#is_disabled(expand('<sfile>:p'), 'swift', 'ftplugin/swift.vim')
  finish
endif

setlocal commentstring=//\ %s
" @-@ adds the literal @ to iskeyword for @IBAction and similar
setlocal iskeyword+=@-@,#
setlocal completefunc=syntaxcomplete#Complete
