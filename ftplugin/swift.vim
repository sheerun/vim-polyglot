let files = filter(globpath(&rtp, 'ftplugin/swift.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'swift') == -1

setlocal commentstring=//\ %s
" @-@ adds the literal @ to iskeyword for @IBAction and similar
setlocal iskeyword+=@-@,#
setlocal completefunc=syntaxcomplete#Complete

endif
