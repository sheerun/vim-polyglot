if polyglot#init#is_disabled(expand('<sfile>:p'), 'svelte', 'syntax/svelte-html.vim')
  finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Config {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:highlight_svelte_attr = svelte#GetConfig('highlight_svelte_attr', 0)
")}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Syntax highlight {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax match svelteComponentName containedin=htmlTagN '\v\C<[a-zA-Z0-9]+(\.[A-Z][a-zA-Z0-9]+)*>'

syntax match svelteComponentName containedin=htmlTagN '\v\C<[a-z0-9]+(-[a-z0-9]+)+>'

syntax match svelteComponentName containedin=htmlTagN '\vsvelte:\w*'

" Syntax for vim-svelte-theme
syntax match htmlAttr '\v(\S|\<)@<![^\/\<\>[:blank:]]+' containedin=htmlTag
      \ contains=htmlString,svelteValue,htmlArg
syntax match htmlAttrEqual '\v\=' containedin=htmlAttr

syntax match svelteAttr 
      \ '\v(\S)@<!(on|bind|use|in|out|transition|animate|class):[^\=\>[:blank:]]+(\=\"[^"]*\"|\=\{[^}]*\})?'
      \ containedin=htmlTag 
      \ contains=svelteKey,svelteValue

syntax match svelteKey contained '\v(on|bind|use|in|out|transition|animate|class):[^\=\>[:blank:]]+'
syntax match svelteValue contained '\v\{[^}]*\}'

syntax region svelteExpression 
      \ containedin=htmlH.*,htmlItalic
      \ matchgroup=svelteBrace
      \ transparent
      \ start="{"
      \ end="}\(}\)\@!"

syntax region svelteExpression 
      \ containedin=htmlSvelteTemplate,svelteValue,htmlString,htmlValue,htmlArg,htmlTag
      \ contains=@simpleJavascriptExpression,svelteAtTags
      \ matchgroup=svelteBrace
      \ transparent
      \ start="{"
      \ end="}\(}\)\@!"

syntax region svelteExpression 
      \ containedin=htmlTag
      \ contains=@simpleJavascriptExpression,svelteAtTags,svelteShortProp
      \ matchgroup=svelteBrace
      \ transparent
      \ start="{"
      \ end="}\(}\)\@!"

syntax match svelteAtTags '\v\@(html|debug)'
syntax match svelteShortProp '\v<\w+>'

syntax region svelteBlockBody
      \ containedin=htmlSvelteTemplate,htmlLink
      \ contains=@simpleJavascriptExpression,svelteBlockKeyword
      \ matchgroup=svelteBrace
      \ start="{:"
      \ end="}"

syntax region svelteBlockStart
      \ containedin=htmlSvelteTemplate,htmlLink
      \ contains=@simpleJavascriptExpression,svelteBlockKeyword
      \ matchgroup=svelteBrace
      \ start="{#"
      \ end="}"

syntax region svelteBlockEnd
      \ containedin=htmlSvelteTemplate,htmlLink
      \ contains=@simpleJavascriptExpression,svelteBlockKeyword
      \ matchgroup=svelteBrace
      \ start="{\/"
      \ end="}"

syntax keyword svelteBlockKeyword if else each await then catch as

syntax cluster simpleJavascriptExpression 
      \ contains=javaScriptStringS,javaScriptStringD,javaScriptTemplateString,javascriptNumber,javaScriptOperator

" Redefine JavaScript syntax
syntax region javaScriptStringS	
      \ start=+'+ skip=+\\\\\|\\'+ end=+'\|$+	contained
syntax region javaScriptStringD	
      \ start=+"+ skip=+\\\\\|\\"+ end=+"\|$+	contained
syntax region javaScriptTemplateString
      \ start=+`+ skip=+\\`+ end=+`+ contained
      \ contains=javaScriptTemplateExpression
syntax region javaScriptTemplateExpression
      \ matchgroup=Type
      \ start=+${+ end=+}+ keepend contained

syntax match javaScriptNumber '\v<-?\d+L?>|0[xX][0-9a-fA-F]+>' contained
syntax match javaScriptOperator '[-!|&+<>=%*~^]' contained
syntax match javaScriptOperator '\v(*)@<!/(/|*)@!' contained
syntax keyword javaScriptOperator delete instanceof typeof void new in of contained

highlight default link svelteAttr htmlTag
if s:highlight_svelte_attr
  highlight default link svelteKey Type
  highlight default link svelteValue None
else
  highlight default link svelteKey htmlArg
  highlight default link svelteValue String
endif

highlight default link svelteBrace Type
highlight default link svelteBlockKeyword Statement
highlight default link svelteComponentName htmlTagName
highlight default link javaScriptTemplateString String
highlight default link javaScriptStringS String
highlight default link javaScriptStringD String
highlight default link javaScriptNumber	Constant
highlight default link javaScriptOperator	Operator
highlight default link svelteAttr	htmlTag
highlight default link svelteAttrEqual htmlTag
highlight default link svelteShortProp htmlValue
"}}}
" vim: fdm=marker
