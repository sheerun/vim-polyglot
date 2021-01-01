if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/es6-json.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName JSON nextgroup=typescriptGlobalJSONDot,typescriptFuncCallArg
syntax match   typescriptGlobalJSONDot /\./ contained nextgroup=typescriptJSONStaticMethod,typescriptProp
syntax keyword typescriptJSONStaticMethod contained parse stringify nextgroup=typescriptFuncCallArg
if exists("did_typescript_hilink") | HiLink typescriptJSONStaticMethod Keyword
endif
