let files = filter(globpath(&rtp, 'syntax/yats/web-crypto.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptCryptoGlobal containedin=typescriptIdentifierName crypto
if exists("did_typescript_hilink") | HiLink typescriptCryptoGlobal Structure
endif
syntax keyword typescriptSubtleCryptoMethod contained encrypt decrypt sign verify nextgroup=typescriptFuncCallArg
syntax keyword typescriptSubtleCryptoMethod contained digest nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptSubtleCryptoMethod
if exists("did_typescript_hilink") | HiLink typescriptSubtleCryptoMethod Keyword
endif
syntax keyword typescriptCryptoProp contained subtle
syntax cluster props add=typescriptCryptoProp
if exists("did_typescript_hilink") | HiLink typescriptCryptoProp Keyword
endif
syntax keyword typescriptCryptoMethod contained getRandomValues nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptCryptoMethod
if exists("did_typescript_hilink") | HiLink typescriptCryptoMethod Keyword
endif

endif
