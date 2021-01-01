if polyglot#init#is_disabled(expand('<sfile>:p'), 'javascript-sql', 'after/syntax/javascript/sql.vim')
  finish
endif

" Vim plugin
" Language: JavaScript
" Maintainer: Ian Langworth <ian@langworth.com>

if exists('b:current_syntax')
  let s:current_syntax = b:current_syntax
  unlet b:current_syntax
endif

exec 'syntax include @SQLSyntax syntax/' . g:javascript_sql_dialect . '.vim'
if exists('s:current_syntax')
  let b:current_syntax = s:current_syntax
endif

syntax region sqlTemplateString start=+`+ skip=+\\\(`\|$\)+ end=+`+ contains=@SQLSyntax,jsTemplateExpression,jsSpecial extend
exec 'syntax match sqlTaggedTemplate +\%(SQL\)\%(`\)\@=+ nextgroup=sqlTemplateString'

hi def link sqlTemplateString jsTemplateString
hi def link sqlTaggedTemplate jsTaggedTemplate

syn cluster jsExpression add=sqlTaggedTemplate
syn cluster sqlTaggedTemplate add=sqlTemplateString
