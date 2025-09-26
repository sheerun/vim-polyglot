if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/web-console.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName console nextgroup=typescriptGlobalConsoleDot
syntax match   typescriptGlobalConsoleDot /\./ contained nextgroup=typescriptConsoleMethod,typescriptProp
syntax keyword typescriptConsoleMethod contained count dir error group groupCollapsed nextgroup=typescriptFuncCallArg
syntax keyword typescriptConsoleMethod contained groupEnd info log time timeEnd trace nextgroup=typescriptFuncCallArg
syntax keyword typescriptConsoleMethod contained warn nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptConsoleMethod
hi def link typescriptConsoleMethod Keyword
