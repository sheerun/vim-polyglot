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
  let s:current_syntax = b:current_syntax
  unlet b:current_syntax
endif
syn include @GraphQLSyntax syntax/graphql.vim
if exists('s:current_syntax')
  let b:current_syntax = s:current_syntax
endif

let s:tags = '\%(' . join(graphql#javascript_tags(), '\|') . '\)'

exec 'syntax region graphqlTemplateString matchgroup=typescriptTemplate start=+' . s:tags . '\@20<=`+ skip=+\\`+ end=+`+ contains=@GraphQLSyntax,typescriptTemplateSubstitution extend'
exec 'syntax match graphqlTaggedTemplate +' . s:tags . '\ze`+ nextgroup=graphqlTemplateString'

" Support expression interpolation ((${...})) inside template strings.
syntax region graphqlTemplateExpression start=+${+ end=+}+ contained contains=typescriptTemplateSubstitution containedin=graphqlFold keepend

hi def link graphqlTemplateString typescriptTemplate
hi def link graphqlTemplateExpression typescriptTemplateSubstitution

syn cluster typescriptExpression add=graphqlTaggedTemplate
syn cluster graphqlTaggedTemplate add=graphqlTemplateString
