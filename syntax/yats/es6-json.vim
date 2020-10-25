if has_key(g:polyglot_is_disabled, 'typescript')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName JSON nextgroup=typescriptGlobalJSONDot,typescriptFuncCallArg
syntax match   typescriptGlobalJSONDot /\./ contained nextgroup=typescriptJSONStaticMethod,typescriptProp
syntax keyword typescriptJSONStaticMethod contained parse stringify nextgroup=typescriptFuncCallArg
if exists("did_typescript_hilink") | HiLink typescriptJSONStaticMethod Keyword
endif
