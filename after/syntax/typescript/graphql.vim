if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'graphql') == -1
  
if exists('b:current_syntax')
  let s:current_syntax = b:current_syntax
  unlet b:current_syntax
endif
syn include @GraphQLSyntax syntax/graphql.vim
if exists('s:current_syntax')
  let b:current_syntax = s:current_syntax
endif

syntax region graphqlTemplateString start=+`+ skip=+\\\(`\|$\)+ end=+`+ contains=@GraphQLSyntax,typescriptTemplateTag extend
exec 'syntax match graphqlTaggedTemplate +\%(' . join(g:graphql_javascript_tags, '\|') . '\)\%(`\)\@=+ nextgroup=graphqlTemplateString'

hi def link graphqlTemplateString typescriptTemplate

syn cluster typescriptExpression add=graphqlTaggedTemplate
syn cluster graphqlTaggedTemplate add=graphqlTemplateString

endif
