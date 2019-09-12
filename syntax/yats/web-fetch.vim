if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Headers Request
syntax keyword typescriptGlobal containedin=typescriptIdentifierName Response
syntax keyword typescriptGlobalMethod containedin=typescriptIdentifierName fetch nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptGlobalMethod
if exists("did_typescript_hilink") | HiLink typescriptGlobalMethod Structure
endif
syntax keyword typescriptHeadersMethod contained append delete get getAll has set nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptHeadersMethod
if exists("did_typescript_hilink") | HiLink typescriptHeadersMethod Keyword
endif
syntax keyword typescriptRequestProp contained method url headers context referrer
syntax keyword typescriptRequestProp contained mode credentials cache
syntax cluster props add=typescriptRequestProp
if exists("did_typescript_hilink") | HiLink typescriptRequestProp Keyword
endif
syntax keyword typescriptRequestMethod contained clone nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptRequestMethod
if exists("did_typescript_hilink") | HiLink typescriptRequestMethod Keyword
endif
syntax keyword typescriptResponseProp contained type url status statusText headers
syntax keyword typescriptResponseProp contained redirected
syntax cluster props add=typescriptResponseProp
if exists("did_typescript_hilink") | HiLink typescriptResponseProp Keyword
endif
syntax keyword typescriptResponseMethod contained clone nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptResponseMethod
if exists("did_typescript_hilink") | HiLink typescriptResponseMethod Keyword
endif

endif
