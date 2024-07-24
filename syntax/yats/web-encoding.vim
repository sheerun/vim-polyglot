if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/web-encoding.vim')
  finish
endif

syntax keyword typescriptEncodingGlobal containedin=typescriptIdentifierName TextEncoder
syntax keyword typescriptEncodingGlobal containedin=typescriptIdentifierName TextDecoder
hi def link typescriptEncodingGlobal Structure
syntax keyword typescriptEncodingProp contained encoding fatal ignoreBOM
syntax cluster props add=typescriptEncodingProp
hi def link typescriptEncodingProp Keyword
syntax keyword typescriptEncodingMethod contained encode decode nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptEncodingMethod
hi def link typescriptEncodingMethod Keyword
