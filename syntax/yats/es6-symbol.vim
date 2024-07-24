if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/es6-symbol.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Symbol nextgroup=typescriptGlobalSymbolDot,typescriptFuncCallArg
syntax match   typescriptGlobalSymbolDot /\./ contained nextgroup=typescriptSymbolStaticProp,typescriptSymbolStaticMethod,typescriptProp
syntax keyword typescriptSymbolStaticProp contained description length iterator match matchAll replace
syntax keyword typescriptSymbolStaticProp contained search split hasInstance isConcatSpreadable
syntax keyword typescriptSymbolStaticProp contained unscopables species toPrimitive
syntax keyword typescriptSymbolStaticProp contained toStringTag
hi def link typescriptSymbolStaticProp Keyword
syntax keyword typescriptSymbolStaticMethod contained for keyFor nextgroup=typescriptFuncCallArg
hi def link typescriptSymbolStaticMethod Keyword
