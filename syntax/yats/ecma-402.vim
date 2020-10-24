let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/yats/ecma-402.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Intl
syntax keyword typescriptIntlMethod contained Collator DateTimeFormat NumberFormat nextgroup=typescriptFuncCallArg
syntax keyword typescriptIntlMethod contained PluralRules nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptIntlMethod
if exists("did_typescript_hilink") | HiLink typescriptIntlMethod Keyword
endif

endif
