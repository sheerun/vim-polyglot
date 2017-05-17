if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'graphql') == -1
  
" Vim syntax file
" Language: GraphQL
" Maintainer: Jon Parise <jon@indelible.org>

if exists("b:current_syntax")
    finish
endif

syn match graphqlComment    "#.*$" contains=@Spell

syn match graphqlOperator   "="
syn match graphqlOperator   "!"
syn match graphqlOperator   "|"
syn match graphqlOperator   "\M..."

syn keyword graphqlBoolean  true false
syn keyword graphqlNull     null
syn match   graphqlNumber   "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>"
syn region  graphqlString	start=+"+  skip=+\\\\\|\\"+  end=+"\|$+

syn keyword graphqlStructure enum scalar type union nextgroup=graphqlType skipwhite
syn keyword graphqlStructure input interface subscription nextgroup=graphqlType skipwhite
syn keyword graphqlStructure implements on nextgroup=graphqlType skipwhite
syn keyword graphqlStructure query mutation fragment nextgroup=graphqlIdentifier skipwhite
syn keyword graphqlStructure directive nextgroup=graphqlDirective skipwhite
syn keyword graphqlStructure extend nextgroup=graphqlStructure skipwhite

syn match graphqlDirective  "\<@\h\w*\>"   display
syn match graphqlVariable   "\<\$\h\w*\>"  display

syn match graphqlIdentifier "\<\h\w*\>"    display contained
syn match graphqlType       "\<_*\u\w*\>"  display contained
syn match graphqlConstant   "\<[A-Z_]\+\>" display contained

syn keyword graphqlMetaFields __schema __type __typename

syn region  graphqlFold matchgroup=graphqlBraces start="{" end=/}\(\_s\+\ze\("\|{\)\)\@!/ transparent fold contains=ALLBUT,graphqlStructure
syn region  graphqlList matchgroup=graphqlBraces start="\[" end=/]\(\_s\+\ze"\)\@!/ transparent contains=ALLBUT,graphqlDirective,graphqlStructure

hi def link graphqlComment          Comment
hi def link graphqlOperator         Operator

hi def link graphqlBraces           Delimiter

hi def link graphqlBoolean          Boolean
hi def link graphqlNull             Keyword
hi def link graphqlNumber           Number
hi def link graphqlString           String

hi def link graphqlConstant         Constant
hi def link graphqlDirective        PreProc
hi def link graphqlIdentifier       Identifier
hi def link graphqlMetaFields       Special
hi def link graphqlStructure        Structure
hi def link graphqlType             Type
hi def link graphqlVariable         Identifier

syn sync minlines=500

let b:current_syntax = "graphql"

endif
