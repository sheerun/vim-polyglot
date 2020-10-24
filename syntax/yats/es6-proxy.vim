let files = filter(globpath(&rtp, 'syntax/yats/es6-proxy.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Proxy
syntax keyword typescriptProxyAPI contained getOwnPropertyDescriptor getOwnPropertyNames
syntax keyword typescriptProxyAPI contained defineProperty deleteProperty freeze seal
syntax keyword typescriptProxyAPI contained preventExtensions has hasOwn get set enumerate
syntax keyword typescriptProxyAPI contained iterate ownKeys apply construct
if exists("did_typescript_hilink") | HiLink typescriptProxyAPI Keyword
endif

endif
