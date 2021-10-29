if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/es6-string.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName String nextgroup=typescriptGlobalStringDot,typescriptFuncCallArg
syntax match   typescriptGlobalStringDot /\./ contained nextgroup=typescriptStringStaticMethod,typescriptProp
syntax keyword typescriptStringStaticMethod contained fromCharCode fromCodePoint raw nextgroup=typescriptFuncCallArg
if exists("did_typescript_hilink") | HiLink typescriptStringStaticMethod Keyword
endif
syntax keyword typescriptStringMethod contained anchor charAt charCodeAt codePointAt nextgroup=typescriptFuncCallArg
syntax keyword typescriptStringMethod contained concat endsWith includes indexOf lastIndexOf nextgroup=typescriptFuncCallArg
syntax keyword typescriptStringMethod contained link localeCompare match matchAll normalize nextgroup=typescriptFuncCallArg
syntax keyword typescriptStringMethod contained padStart padEnd repeat replace replaceAll search nextgroup=typescriptFuncCallArg
syntax keyword typescriptStringMethod contained slice split startsWith substr substring nextgroup=typescriptFuncCallArg
syntax keyword typescriptStringMethod contained toLocaleLowerCase toLocaleUpperCase nextgroup=typescriptFuncCallArg
syntax keyword typescriptStringMethod contained toLowerCase toString toUpperCase trim nextgroup=typescriptFuncCallArg
syntax keyword typescriptStringMethod contained trimEnd trimStart valueOf nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptStringMethod
if exists("did_typescript_hilink") | HiLink typescriptStringMethod Keyword
endif
