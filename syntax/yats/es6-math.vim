if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Math nextgroup=typescriptGlobalMathDot,typescriptFuncCallArg
syntax match   typescriptGlobalMathDot /\./ contained nextgroup=typescriptMathStaticProp,typescriptMathStaticMethod,typescriptProp
syntax keyword typescriptMathStaticProp contained E LN10 LN2 LOG10E LOG2E PI SQRT1_2
syntax keyword typescriptMathStaticProp contained SQRT2
if exists("did_typescript_hilink") | HiLink typescriptMathStaticProp Keyword
endif
syntax keyword typescriptMathStaticMethod contained abs acos acosh asin asinh atan nextgroup=typescriptFuncCallArg
syntax keyword typescriptMathStaticMethod contained atan2 atanh cbrt ceil clz32 cos nextgroup=typescriptFuncCallArg
syntax keyword typescriptMathStaticMethod contained cosh exp expm1 floor fround hypot nextgroup=typescriptFuncCallArg
syntax keyword typescriptMathStaticMethod contained imul log log10 log1p log2 max nextgroup=typescriptFuncCallArg
syntax keyword typescriptMathStaticMethod contained min pow random round sign sin nextgroup=typescriptFuncCallArg
syntax keyword typescriptMathStaticMethod contained sinh sqrt tan tanh trunc nextgroup=typescriptFuncCallArg
if exists("did_typescript_hilink") | HiLink typescriptMathStaticMethod Keyword
endif

endif
