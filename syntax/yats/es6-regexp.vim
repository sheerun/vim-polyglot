if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/es6-regexp.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName RegExp nextgroup=typescriptGlobalRegExpDot,typescriptFuncCallArg
syntax match   typescriptGlobalRegExpDot /\./ contained nextgroup=typescriptRegExpStaticProp,typescriptProp
syntax keyword typescriptRegExpStaticProp contained lastIndex
if exists("did_typescript_hilink") | HiLink typescriptRegExpStaticProp Keyword
endif
syntax keyword typescriptRegExpProp contained dotAll global ignoreCase multiline source sticky
syntax cluster props add=typescriptRegExpProp
if exists("did_typescript_hilink") | HiLink typescriptRegExpProp Keyword
endif
syntax keyword typescriptRegExpMethod contained exec test nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptRegExpMethod
if exists("did_typescript_hilink") | HiLink typescriptRegExpMethod Keyword
endif
