if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haskell') == -1

setlocal comments=s1fl:{-,mb:-,ex:-},:--
setlocal iskeyword+=-,.,*
setlocal commentstring=--\ %s

endif
