if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'graphql') == -1

" Vim syntax file
" Language: GraphQL
" Maintainer: Jon Parise <jon@indelible.org>

if exists('b:current_syntax')
    finish
endif

syn match graphqlComment    "#.*$" contains=@Spell

syn match graphqlOperator   "=" display
syn match graphqlOperator   "!" display
syn match graphqlOperator   "|" display
syn match graphqlOperator   "\M..." display

syn keyword graphqlBoolean  true false
syn keyword graphqlNull     null
syn match   graphqlNumber   "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>" display
syn region  graphqlString   start=+"+  skip=+\\\\\|\\"+  end=+"\|$+
syn region  graphqlString   start=+"""+ end=+"""+

syn keyword graphqlKeyword on nextgroup=graphqlType skipwhite

syn keyword graphqlStructure enum scalar type union nextgroup=graphqlType skipwhite
syn keyword graphqlStructure input interface subscription nextgroup=graphqlType skipwhite
syn keyword graphqlStructure implements nextgroup=graphqlType skipwhite
syn keyword graphqlStructure query mutation fragment nextgroup=graphqlName skipwhite
syn keyword graphqlStructure directive nextgroup=graphqlDirective skipwhite
syn keyword graphqlStructure extend nextgroup=graphqlStructure skipwhite
syn keyword graphqlStructure schema nextgroup=graphqlFold skipwhite

syn match graphqlDirective  "\<@\h\w*\>"   display
syn match graphqlVariable   "\<\$\h\w*\>"  display
syn match graphqlName       "\<\h\w*\>"    display
syn match graphqlType       "\<_*\u\w*\>"  display
syn match graphqlConstant   "\<[A-Z_]\+\>" display

syn keyword graphqlMetaFields __schema __type __typename

syn region  graphqlFold matchgroup=graphqlBraces start="{" end="}" transparent fold contains=ALLBUT,graphqlStructure
syn region  graphqlList matchgroup=graphqlBraces start="\[" end="]" transparent contains=ALLBUT,graphqlDirective,graphqlStructure

hi def link graphqlComment          Comment
hi def link graphqlOperator         Operator

hi def link graphqlBraces           Delimiter

hi def link graphqlBoolean          Boolean
hi def link graphqlNull             Keyword
hi def link graphqlNumber           Number
hi def link graphqlString           String

hi def link graphqlConstant         Constant
hi def link graphqlDirective        PreProc
hi def link graphqlName             Identifier
hi def link graphqlMetaFields       Special
hi def link graphqlKeyword          Keyword
hi def link graphqlStructure        Structure
hi def link graphqlType             Type
hi def link graphqlVariable         Identifier

syn sync minlines=500

let b:current_syntax = 'graphql'

endif
