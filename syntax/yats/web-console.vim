if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName console
syntax keyword typescriptConsoleMethod contained count dir error group groupCollapsed nextgroup=typescriptFuncCallArg
syntax keyword typescriptConsoleMethod contained groupEnd info log time timeEnd trace nextgroup=typescriptFuncCallArg
syntax keyword typescriptConsoleMethod contained warn nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptConsoleMethod
if exists("did_typescript_hilink") | HiLink typescriptConsoleMethod Keyword
endif

endif
