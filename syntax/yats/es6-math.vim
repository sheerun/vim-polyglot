if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/es6-math.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Math nextgroup=typescriptGlobalMathDot,typescriptFuncCallArg
syntax match   typescriptGlobalMathDot /\./ contained nextgroup=typescriptMathStaticProp,typescriptMathStaticMethod,typescriptProp
syntax keyword typescriptMathStaticProp contained E LN10 LN2 LOG10E LOG2E PI SQRT1_2
syntax keyword typescriptMathStaticProp contained SQRT2
hi def link typescriptMathStaticProp Keyword
syntax keyword typescriptMathStaticMethod contained abs acos acosh asin asinh atan nextgroup=typescriptFuncCallArg
syntax keyword typescriptMathStaticMethod contained atan2 atanh cbrt ceil clz32 cos nextgroup=typescriptFuncCallArg
syntax keyword typescriptMathStaticMethod contained cosh exp expm1 floor fround hypot nextgroup=typescriptFuncCallArg
syntax keyword typescriptMathStaticMethod contained imul log log10 log1p log2 max nextgroup=typescriptFuncCallArg
syntax keyword typescriptMathStaticMethod contained min pow random round sign sin nextgroup=typescriptFuncCallArg
syntax keyword typescriptMathStaticMethod contained sinh sqrt tan tanh trunc nextgroup=typescriptFuncCallArg
hi def link typescriptMathStaticMethod Keyword
