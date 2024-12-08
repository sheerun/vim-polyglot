if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/web-fetch.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Headers Request
syntax keyword typescriptGlobal containedin=typescriptIdentifierName Response
syntax keyword typescriptGlobalMethod containedin=typescriptIdentifierName fetch nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptGlobalMethod
hi def link typescriptGlobalMethod Structure
syntax keyword typescriptHeadersMethod contained append delete get getAll has set nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptHeadersMethod
hi def link typescriptHeadersMethod Keyword
syntax keyword typescriptRequestProp contained method url headers context referrer
syntax keyword typescriptRequestProp contained mode credentials cache
syntax cluster props add=typescriptRequestProp
hi def link typescriptRequestProp Keyword
syntax keyword typescriptRequestMethod contained clone nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptRequestMethod
hi def link typescriptRequestMethod Keyword
syntax keyword typescriptResponseProp contained type url status statusText headers
syntax keyword typescriptResponseProp contained redirected
syntax cluster props add=typescriptResponseProp
hi def link typescriptResponseProp Keyword
syntax keyword typescriptResponseMethod contained clone nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptResponseMethod
hi def link typescriptResponseMethod Keyword
