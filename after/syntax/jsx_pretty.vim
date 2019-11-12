if !exists('g:polyglot_disabled') || !(index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'jsx') != -1)

let s:highlight_close_tag = get(g:, 'vim_jsx_pretty_highlight_close_tag', 0)

" detect jsx region
syntax region jsxRegion
      \ start=+\%(\%(\_[([,?:=+\-*/>{}]\|<\s\+\|&&\|||\|=>\|\<return\|\<default\|\<await\|\<yield\)\_s*\)\@<=<\_s*\%(>\|\z(\%(script\|T\s*>\s*(\)\@!\<[_$A-Za-z][-:._$A-Za-z0-9]*\>\)\%(\_s*\%([-+*)\]}&|?,]\|/\%([/*]\|\_s*>\)\@!\)\)\@!\)+
      \ end=++
      \ contains=jsxElement

" <tag id="sample">
" ~~~~~~~~~~~~~~~~~
" and self close tag
" <tag id="sample"   />
" ~~~~~~~~~~~~~~~~~~~
syntax region jsxTag
      \ start=+<+
      \ matchgroup=jsxOpenPunct
      \ end=+>+
      \ matchgroup=NONE
      \ end=+\%(/\_s*>\)\@=+
      \ contained
      \ contains=jsxOpenTag,jsxAttrib,jsxEscapeJs,jsxSpreadOperator,jsComment,@javascriptComments,javaScriptLineComment,javaScriptComment,typescriptLineComment,typescriptComment
      \ keepend
      \ extend
      \ skipwhite
      \ skipempty
      \ nextgroup=jsxCloseString

" <tag></tag>
" ~~~~~~~~~~~
" and fragment
" <></>
" ~~~~~
" and self close tag
" <tag />
" ~~~~~~~
syntax region jsxElement
      \ start=+<\_s*\%(>\|\${\|\z(\<[-:._$A-Za-z0-9]\+\>\)\)+
      \ end=+/\_s*>+
      \ end=+<\_s*/\_s*\z1\_s*>+
      \ contains=jsxElement,jsxTag,jsxEscapeJs,jsxComment,jsxCloseTag,@Spell
      \ keepend
      \ extend
      \ contained
      \ fold

" <tag key={this.props.key}>
" ~~~~
" and fragment start tag
" <>
" ~~
exe 'syntax region jsxOpenTag
      \ matchgroup=jsxOpenPunct
      \ start=+<+
      \ end=+>+
      \ matchgroup=NONE
      \ end=+\>+
      \ contained
      \ contains=jsxTagName
      \ nextgroup=jsxAttrib
      \ skipwhite
      \ skipempty
      \ ' .(s:highlight_close_tag ? 'transparent' : '')


" <tag key={this.props.key}>
"          ~~~~~~~~~~~~~~~~
syntax region jsxEscapeJs
      \ matchgroup=jsxBraces
      \ start=+{+
      \ end=+}+
      \ contained
      \ extend
      \ contains=@jsExpression,jsSpreadExpression,@javascriptExpression,javascriptSpreadOp,@javaScriptEmbededExpr,@typescriptExpression,typescriptObjectSpread

" <foo.bar>
"     ~
syntax match jsxDot +\.+ contained

" <foo:bar>
"     ~
syntax match jsxNamespace +:+ contained

" <tag id="sample">
"        ~
syntax match jsxEqual +=+ contained skipwhite skipempty nextgroup=jsxString,jsxEscapeJs,jsxRegion

" <tag />
"      ~~
syntax match jsxCloseString +/\_s*>+ contained

" </tag>
" ~~~~~~
" and fragment close tag
" </>
" ~~~
syntax region jsxCloseTag
      \ matchgroup=jsxClosePunct
      \ start=+<\_s*/+
      \ end=+>+
      \ contained
      \ contains=jsxTagName

" <tag key={this.props.key}>
"      ~~~
syntax match jsxAttrib
      \ +\<[_$A-Za-z][-:_$A-Za-z0-9]*\>+
      \ contained
      \ nextgroup=jsxEqual
      \ skipwhite
      \ skipempty
      \ contains=jsxAttribKeyword,jsxNamespace

" <MyComponent ...>
"  ~~~~~~~~~~~
" NOT
" <someCamel ...>
"      ~~~~~
exe 'syntax match jsxComponentName
      \ +\<[_$]\?[A-Z][-_$A-Za-z0-9]*\>+
      \ contained
      \ ' .(s:highlight_close_tag ? 'transparent' : '')

" <tag key={this.props.key}>
"  ~~~
exe 'syntax match jsxTagName
      \ +\<[-:._$A-Za-z0-9]\+\>+
      \ contained
      \ contains=jsxComponentName,jsxDot,jsxNamespace
      \ nextgroup=jsxAttrib
      \ skipempty
      \ skipwhite
      \ ' .(s:highlight_close_tag ? 'transparent' : '')

" <tag id="sample">
"         ~~~~~~~~
" and
" <tag id='sample'>
"         ~~~~~~~~
syntax region jsxString start=+\z(["']\)+  skip=+\\\\\|\\\z1\|\\\n+  end=+\z1+ contained contains=@Spell

let s:tags = get(g:, 'vim_jsx_pretty_template_tags', ['html', 'jsx'])
let s:enable_tagged_jsx = !empty(s:tags)

" add support to JSX inside the tagged template string
" https://github.com/developit/htm
if s:enable_tagged_jsx
  exe 'syntax match jsxRegion +\%(' . join(s:tags, '\|') . '\)\%(\_s*`\)\@=+ contains=jsTemplateStringTag,jsTaggedTemplate,javascriptTagRef skipwhite skipempty nextgroup=jsxTaggedRegion'

  syntax region jsxTaggedRegion
        \ matchgroup=jsxBackticks
        \ start=+`+
        \ end=+`+
        \ extend
        \ contained
        \ contains=jsxElement,jsxEscapeJs
        \ transparent

  syntax region jsxEscapeJs
        \ matchgroup=jsxBraces
        \ start=+\${+
        \ end=+}+
        \ extend
        \ contained
        \ contains=@jsExpression,jsSpreadExpression,@javascriptExpression,javascriptSpreadOp,@javaScriptEmbededExpr,@typescriptExpression,typescriptObjectSpread

  syntax region jsxOpenTag
        \ matchgroup=jsxOpenPunct
        \ start=+<\%(\${\)\@=+
        \ matchgroup=NONE
        \ end=+}\@1<=+
        \ contained
        \ contains=jsxEscapeJs
        \ skipwhite
        \ skipempty
        \ nextgroup=jsxAttrib,jsxSpreadOperator

  syntax keyword jsxAttribKeyword class contained

  syntax match jsxSpreadOperator +\.\.\.+ contained nextgroup=jsxEscapeJs skipwhite

  syntax match jsxCloseTag +<//>+ contained

  syntax match jsxComment +<!--\_.\{-}-->+
endif

" Highlight the tag name
highlight def link jsxTag Function
highlight def link jsxTagName Identifier
highlight def link jsxComponentName Function

highlight def link jsxAttrib Type
highlight def link jsxAttribKeyword jsxAttrib
highlight def link jsxString String
highlight def link jsxComment Comment

highlight def link jsxDot Operator
highlight def link jsxNamespace Operator
highlight def link jsxEqual Operator
highlight def link jsxSpreadOperator Operator
highlight def link jsxBraces Special

if s:highlight_close_tag
  highlight def link jsxCloseString Identifier
  highlight def link jsxOpenPunct jsxTag
else
  " Highlight the jsxCloseString (i.e. />), jsxPunct (i.e. <,>) and jsxCloseTag (i.e. <//>)
  highlight def link jsxCloseString Comment
  highlight def link jsxOpenPunct jsxPunct
endif

highlight def link jsxPunct jsxCloseString
highlight def link jsxClosePunct jsxPunct
highlight def link jsxCloseTag jsxCloseString

let s:vim_jsx_pretty_colorful_config = get(g:, 'vim_jsx_pretty_colorful_config', 0)

if s:vim_jsx_pretty_colorful_config == 1
  highlight def link jsObjectKey Label
  highlight def link jsArrowFuncArgs Type
  highlight def link jsFuncArgs Type
endif

endif
