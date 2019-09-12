if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Intl
syntax keyword typescriptIntlMethod contained Collator DateTimeFormat NumberFormat nextgroup=typescriptFuncCallArg
syntax keyword typescriptIntlMethod contained PluralRules nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptIntlMethod
if exists("did_typescript_hilink") | HiLink typescriptIntlMethod Keyword
endif

endif
