if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'swift') == -1

setlocal commentstring=//\ %s
" @-@ adds the literal @ to iskeyword for @IBAction and similar
setlocal iskeyword+=@-@,#
setlocal completefunc=syntaxcomplete#Complete

endif
