if has_key(g:polyglot_is_disabled, 'swift')
  finish
endif

setlocal commentstring=//\ %s
" @-@ adds the literal @ to iskeyword for @IBAction and similar
setlocal iskeyword+=@-@,#
setlocal completefunc=syntaxcomplete#Complete
