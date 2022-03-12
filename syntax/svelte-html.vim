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
syntax match htmlAttr '\v(\S|\<)@<![^\/\<\>[:blank:]]+'
      \ containedin=htmlTag
      \ contains=htmlString,svelteValue,htmlArg
syntax match htmlAttrEqual '\v\=' containedin=htmlAttr

syntax match svelteAttr
      \ '\(\S\)\@<!\w\+:[^=>[:blank:]]\+\(="[^"]*"\|={[^}]*}\)\?'
      \ containedin=htmlTag 
      \ contains=svelteKey,svelteValue
syntax match svelteValue contained '{[^}]*}'
syntax match svelteKey contained '\w\+:[^=>[:blank:]]\+'

syntax region svelteExpression 
      \ containedin=htmlH.*,htmlItalic
      \ matchgroup=svelteBrace
      \ start="{"
      \ end="}\(}\|;\)\@!"

" Multiple lines expressions are supposed to end with '}}'
syntax region svelteExpression 
      \ containedin=svelteValue,htmlValue,htmlAttr
      \ contains=@simpleJavascriptExpression
      \ matchgroup=svelteBrace
      \ start="{"
      \ end="\(}\)\@<=}"

syntax region svelteExpression 
      \ containedin=htmlSvelteTemplate,svelteValue,htmlString,htmlArg,htmlTag,htmlAttr,htmlValue,htmlAttr
      \ contains=@simpleJavascriptExpression,svelteAtTags
      \ matchgroup=svelteBrace
      \ start="{"
      \ end="}\(}\|;\)\@!"
      \ oneline

syntax match svelteAtTags '@\(html\|debug\)'

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
syntax keyword javaScriptOperator contained
      \ delete instanceof typeof void new in of const let var
      \ return function

highlight default link svelteAttr htmlTag
if s:highlight_svelte_attr
  highlight default link svelteKey Type
  highlight default link svelteValue None
else
  highlight default link svelteKey htmlArg
  highlight default link svelteValue String
endif

highlight default link svelteExpression None
highlight default link svelteBrace Type
highlight default link svelteAtTags Type
highlight default link svelteBlockKeyword Statement
highlight default link svelteComponentName htmlTagName
highlight default link javaScriptTemplateString String
highlight default link javaScriptStringS String
highlight default link javaScriptStringD String
highlight default link javaScriptNumber	Constant
highlight default link javaScriptOperator	Operator
highlight default link svelteAttr	htmlTag
highlight default link svelteAttrEqual htmlTag
"}}}
" vim: fdm=marker
