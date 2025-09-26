if polyglot#init#is_disabled(expand('<sfile>:p'), 'prisma', 'syntax/prisma.vim')
  finish
endif

if exists("b:current_syntax")
  finish
endif

syn case match

" Comment
syn match prismaComment "\v//.*$"
" Directive
syn match prismaDirective /\<@@\=\h\w*/ nextgroup=prismaFunctionParans
" Ugly hack right now, probably this is not needed after refactoring
syn match prismaPartialDirective /@@\=\h\w*/ nextgroup=prismaFunctionParans
syn region prismaFunctionParans matchgroup=prismaParans start=/(/ end=/)/ contained contains=prismaString,prismaFunctionArgs,prismaFunction,prismaList
syn match prismaFunction /\v\h\w*/ contained nextgroup=prismaFunctionParans
syn match prismaFunctionArgs /\v\h\w*:/ contained containedin=prismaFunctionParans nextgroup=prismaString
syn region prismaTypeAliasDeclaration matchgroup=prismaTypeAliasDeclaration start=/\vtype\s+/ end=/\v$/ contains=prismaValue,prismaDirective,prismaComment,prismaOperator


syn region prismaString start=/\v"/ skip=/\v\\./ end=/\v"/
" Model Declaration
syn region prismaModelDeclaration matchgroup=prismaModel start=/\vmodel\s+\h\w*\s*\{/ end=/}/ contains=prismaComment,prismaOperator,prismaString,prismaFieldRegion,prismaDirective transparent
syn match prismaField /\<\h\w*\>/ contained containedin=prismaFieldRegion nextgroup=prismaType skipwhite
syn match prismaType /\<\h\w*\>/ contained containedin=prismaModelDeclaration nextgroup=prismaDirective skipwhite
syn region prismaFieldRegion start=/\v^\s*/ms=e+1 end=/\v\s/me=s-1 contains=prismaField,prismaComment contained transparent containedin=prismaModelDeclaration skipwhite
syn match prismaMultiFieldDirective /^\s*@/ contained containedin=prismaModelDeclaration nextgroup=prismaPartialDirective

syn region prismaNonModelDeclaration matchgroup=prismaModel start=/\v((datasource)=(generator)=(enum)=)+\s+\h\w*\s*\{/ end=/}/ contains=prismaString,prismaList,prismaValueDeclarationRegion,prismaOperator transparent
syn match prismaValue /\<\h\w*\>/ contained containedin=prismaValueDeclarationRegion,prismaTypeAliasDeclaration nextgroup=prismaOperator skipwhite
syn region prismaValueDeclarationRegion start=/\v^\s*/ms=e+1 end=/\v\s*/me=s-1 contains=prismaValueDeclaration contained transparent containedin=prismaNonModelDeclaration skipwhite

syn match prismaOperator "?" display 
syn match prismaOperator "\[\]" display 
syn match prismaOperator /\v\=/ display
syn region prismaList matchgroup=prismaList start="\[" end="]" contains=ALLBUT,prismaDirective,prismaModelDeclaration,prismaNonModelDeclaration


hi def link prismaList Delimiter
hi def link prismaParans Delimiter
hi def link prismaDirective PreProc
hi def link prismaOperator Operator
hi def link prismaMultiFieldDirective PreProc
hi def link prismaField Keyword
hi def link prismaType Type
hi def link prismaModel Delimiter
hi def link prismaString String
hi def link prismaFunctionArgs Identifier
hi def link prismaFunction Function
hi def link prismaPartialDirective PreProc
hi def link prismaValue Identifier
hi def link prismaModel Delimiter
hi def link prismaComment Comment
hi def link prismaTypeAliasDeclaration Keyword

let b:current_syntax = "prisma"
