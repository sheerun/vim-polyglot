if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/es6-regexp.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName RegExp nextgroup=typescriptGlobalRegExpDot,typescriptFuncCallArg
syntax match   typescriptGlobalRegExpDot /\./ contained nextgroup=typescriptRegExpStaticProp,typescriptProp
syntax keyword typescriptRegExpStaticProp contained lastIndex
hi def link typescriptRegExpStaticProp Keyword
syntax keyword typescriptRegExpProp contained dotAll global ignoreCase multiline source sticky
syntax cluster props add=typescriptRegExpProp
hi def link typescriptRegExpProp Keyword
syntax keyword typescriptRegExpMethod contained exec test nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptRegExpMethod
hi def link typescriptRegExpMethod Keyword
