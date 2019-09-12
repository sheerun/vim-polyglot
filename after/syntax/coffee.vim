if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cjsx') == -1

if exists('b:current_syntax')
  let s:current_syntax=b:current_syntax
  unlet b:current_syntax
endif

if exists('s:current_syntax')
  let b:current_syntax=s:current_syntax
endif

syn match   cjsxEntity       contained "&[^; \t]*;" contains=cjsxEntityPunct
syn match   cjsxEntityPunct  contained "[&.;]"

syn match   cjsxAttribProperty /[A-Za-z_][A-Za-z0-9_-]*/ contained
syn region  cjsxAttrib start=/\s[A-Za-z_][A-Za-z0-9_-]/hs=s+1 end=/=/ end=/\s[A-Za-z_]/me=e-2 end=+[/>]+me=e-1 contained contains=cjsxAttribProperty

syn region  cjsxBody start=+[^/]>+ms=s+2 start=/>/ms=s+1 end=+<\/+me=e-2 contained contains=cjsxElement,coffeeCurlies,cjsxEntity

syn region  cjsxElement start=/<@\=[A-Za-z_][A-Za-z0-9-_\.]*/ end=/\/>/ end=/<\/@\=[A-Za-z_][A-Za-z0-9-_\.]*>/ contains=cjsxOpenTag,cjsxBody,coffeeCurlies,coffeeString,cjsxAttrib,coffeeNumber,coffeeFloat

syn cluster coffeeAll add=cjsxElement

" The default highlighting.
hi def link cjsxElement         Function
hi def link cjsxTagName         Function
hi def link cjsxEntity          Statement
hi def link cjsxEntityPunct     Type
hi def link cjsxAttribProperty  Type

endif
