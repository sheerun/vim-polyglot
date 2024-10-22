if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/web-crypto.vim')
  finish
endif

syntax keyword typescriptCryptoGlobal containedin=typescriptIdentifierName crypto
hi def link typescriptCryptoGlobal Structure
syntax keyword typescriptSubtleCryptoMethod contained encrypt decrypt sign verify nextgroup=typescriptFuncCallArg
syntax keyword typescriptSubtleCryptoMethod contained digest nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptSubtleCryptoMethod
hi def link typescriptSubtleCryptoMethod Keyword
syntax keyword typescriptCryptoProp contained subtle
syntax cluster props add=typescriptCryptoProp
hi def link typescriptCryptoProp Keyword
syntax keyword typescriptCryptoMethod contained getRandomValues nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptCryptoMethod
hi def link typescriptCryptoMethod Keyword
