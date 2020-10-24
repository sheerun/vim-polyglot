let files = filter(globpath(&rtp, 'syntax/yats/es6-regexp.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName RegExp nextgroup=typescriptGlobalRegExpDot,typescriptFuncCallArg
syntax match   typescriptGlobalRegExpDot /\./ contained nextgroup=typescriptRegExpStaticProp,typescriptProp
syntax keyword typescriptRegExpStaticProp contained lastIndex
if exists("did_typescript_hilink") | HiLink typescriptRegExpStaticProp Keyword
endif
syntax keyword typescriptRegExpProp contained global ignoreCase multiline source sticky
syntax cluster props add=typescriptRegExpProp
if exists("did_typescript_hilink") | HiLink typescriptRegExpProp Keyword
endif
syntax keyword typescriptRegExpMethod contained exec test nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptRegExpMethod
if exists("did_typescript_hilink") | HiLink typescriptRegExpMethod Keyword
endif

endif
