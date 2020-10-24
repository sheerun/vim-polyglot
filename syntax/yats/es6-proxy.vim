let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/yats/es6-proxy.vim', 1, 1), Filter)
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
