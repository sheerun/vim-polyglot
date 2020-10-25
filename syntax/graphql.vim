if has_key(g:polyglot_is_disabled, 'graphql')
  finish
endif

" Copyright (c) 2016-2020 Jon Parise <jon@indelible.org>
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to
" deal in the Software without restriction, including without limitation the
" rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
" sell copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
" FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
" IN THE SOFTWARE.
"
" Language: GraphQL
" Maintainer: Jon Parise <jon@indelible.org>

if exists('b:current_syntax')
  finish
endif

syn case match

syn match graphqlComment    "#.*$" contains=@Spell

syn match graphqlOperator   "=" display
syn match graphqlOperator   "!" display
syn match graphqlOperator   "|" display
syn match graphqlOperator   "&" display
syn match graphqlOperator   "\M..." display

syn keyword graphqlBoolean  true false
syn keyword graphqlNull     null
syn match   graphqlNumber   "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>" display
syn region  graphqlString   start=+"+  skip=+\\\\\|\\"+  end=+"\|$+
syn region  graphqlString   start=+"""+ skip=+\\"""+ end=+"""+

syn keyword graphqlKeyword on nextgroup=graphqlType,graphqlDirectiveLocation skipwhite

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

" https://graphql.github.io/graphql-spec/June2018/#ExecutableDirectiveLocation
syn keyword graphqlDirectiveLocation QUERY MUTATION SUBSCRIPTION FIELD
syn keyword graphqlDirectiveLocation FRAGMENT_DEFINITION FRAGMENT_SPREAD
syn keyword graphqlDirectiveLocation INLINE_FRAGMENT
" https://graphql.github.io/graphql-spec/June2018/#TypeSystemDirectiveLocation
syn keyword graphqlDirectiveLocation SCHEMA SCALAR OBJECT FIELD_DEFINITION
syn keyword graphqlDirectiveLocation ARGUMENT_DEFINITION INTERFACE UNION
syn keyword graphqlDirectiveLocation ENUM ENUM_VALUE INPUT_OBJECT
syn keyword graphqlDirectiveLocation INPUT_FIELD_DEFINITION

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

hi def link graphqlDirective        PreProc
hi def link graphqlDirectiveLocation Special
hi def link graphqlName             Identifier
hi def link graphqlMetaFields       Special
hi def link graphqlKeyword          Keyword
hi def link graphqlStructure        Structure
hi def link graphqlType             Type
hi def link graphqlVariable         Identifier

syn sync minlines=500

let b:current_syntax = 'graphql'
