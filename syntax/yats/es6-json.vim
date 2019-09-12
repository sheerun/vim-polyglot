if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName JSON nextgroup=typescriptGlobalJSONDot,typescriptFuncCallArg
syntax match   typescriptGlobalJSONDot /\./ contained nextgroup=typescriptJSONStaticMethod,typescriptProp
syntax keyword typescriptJSONStaticMethod contained parse stringify nextgroup=typescriptFuncCallArg
if exists("did_typescript_hilink") | HiLink typescriptJSONStaticMethod Keyword
endif

endif
