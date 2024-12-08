if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/es6-number.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Number nextgroup=typescriptGlobalNumberDot,typescriptFuncCallArg
syntax match   typescriptGlobalNumberDot /\./ contained nextgroup=typescriptNumberStaticProp,typescriptNumberStaticMethod,typescriptProp
syntax keyword typescriptNumberStaticProp contained EPSILON MAX_SAFE_INTEGER MAX_VALUE
syntax keyword typescriptNumberStaticProp contained MIN_SAFE_INTEGER MIN_VALUE NEGATIVE_INFINITY
syntax keyword typescriptNumberStaticProp contained NaN POSITIVE_INFINITY
hi def link typescriptNumberStaticProp Keyword
syntax keyword typescriptNumberStaticMethod contained isFinite isInteger isNaN isSafeInteger nextgroup=typescriptFuncCallArg
syntax keyword typescriptNumberStaticMethod contained parseFloat parseInt nextgroup=typescriptFuncCallArg
hi def link typescriptNumberStaticMethod Keyword
syntax keyword typescriptNumberMethod contained toExponential toFixed toLocaleString nextgroup=typescriptFuncCallArg
syntax keyword typescriptNumberMethod contained toPrecision toSource toString valueOf nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptNumberMethod
hi def link typescriptNumberMethod Keyword
