let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/yats/web-console.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName console
syntax keyword typescriptConsoleMethod contained count dir error group groupCollapsed nextgroup=typescriptFuncCallArg
syntax keyword typescriptConsoleMethod contained groupEnd info log time timeEnd trace nextgroup=typescriptFuncCallArg
syntax keyword typescriptConsoleMethod contained warn nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptConsoleMethod
if exists("did_typescript_hilink") | HiLink typescriptConsoleMethod Keyword
endif

endif
