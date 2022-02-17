if polyglot#init#is_disabled(expand('<sfile>:p'), 'graphql', 'after/syntax/javascript/graphql.vim')
  finish
endif

" Copyright (c) 2016-2021 Jon Parise <jon@indelible.org>
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
  let s:current_syntax = b:current_syntax
  unlet b:current_syntax
endif

let b:graphql_nested_syntax = 1
syn include @GraphQLSyntax syntax/graphql.vim
unlet b:graphql_nested_syntax

if exists('s:current_syntax')
  let b:current_syntax = s:current_syntax
endif

let s:tags = '\%(' . join(graphql#javascript_tags(), '\|') . '\)'

if graphql#has_syntax_group('jsTemplateExpression')
  " pangloss/vim-javascript
  exec 'syntax region graphqlTemplateString matchgroup=jsTemplateString start=+' . s:tags . '\@20<=`+ skip=+\\\\\|\\`+ end=+`+ contains=@GraphQLSyntax,jsTemplateExpression,jsSpecial extend'
  exec 'syntax match graphqlTaggedTemplate +' . s:tags . '\ze`+ nextgroup=graphqlTemplateString'
  syntax region graphqlTemplateExpression start=+${+ end=+}+ contained contains=jsTemplateExpression containedin=graphqlFold keepend

  syntax region graphqlTemplateString matchgroup=jsTemplateString start=+`#\s\{,4\}\(gql\|graphql\)\>\s*$+ skip=+\\\\\|\\`+ end=+`+ contains=@GraphQLSyntax,jsTemplateExpression,jsSpecial extend

  hi def link graphqlTemplateString jsTemplateString
  hi def link graphqlTaggedTemplate jsTaggedTemplate
  hi def link graphqlTemplateExpression jsTemplateExpression

  syn cluster jsExpression add=graphqlTemplateString,graphqlTaggedTemplate
  syn cluster graphqlTaggedTemplate add=graphqlTemplateString
elseif graphql#has_syntax_group('javaScriptStringT')
  " runtime/syntax/javascript.vim
  exec 'syntax region graphqlTemplateString matchgroup=javaScriptStringT start=+' . s:tags . '\@20<=`+ skip=+\\\\\|\\`+ end=+`+ contains=@GraphQLSyntax,javaScriptSpecial,javaScriptEmbed,@htmlPreproc extend'
  exec 'syntax match graphqlTaggedTemplate +' . s:tags . '\ze`+ nextgroup=graphqlTemplateString'
  syntax region graphqlTemplateExpression start=+${+ end=+}+ contained contains=@javaScriptEmbededExpr containedin=graphqlFold keepend

  syntax region graphqlTemplateString matchgroup=javaScriptStringT start=+`#\s\{,4\}\(gql\|graphql\)\>\s*$+ skip=+\\\\\|\\`+ end=+`+ contains=@GraphQLSyntax,javaScriptSpecial,javaScriptEmbed,@htmlPreproc extend

  hi def link graphqlTemplateString javaScriptStringT
  hi def link graphqlTaggedTemplate javaScriptEmbed
  hi def link graphqlTemplateExpression javaScriptEmbed

  syn cluster htmlJavaScript add=graphqlTaggedTemplate
  syn cluster javaScriptEmbededExpr add=graphqlTaggedTemplate
  syn cluster graphqlTaggedTemplate add=graphqlTemplateString
endif
