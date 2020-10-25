if !polyglot#util#IsEnabled('swift', expand('<sfile>:p'))
  finish
endif

setlocal commentstring=//\ %s
" @-@ adds the literal @ to iskeyword for @IBAction and similar
setlocal iskeyword+=@-@,#
setlocal completefunc=syntaxcomplete#Complete
