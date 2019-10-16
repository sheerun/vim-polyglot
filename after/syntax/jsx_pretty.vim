if !exists('g:polyglot_disabled') || !(index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'jsx') != -1)

let s:highlight_close_tag = get(g:, 'vim_jsx_pretty_highlight_close_tag', 0)

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
      \ end=+\(/\_s*>\)\@=+
      \ contained
      \ contains=jsxOpenTag,jsxEscapeJs,jsxAttrib,jsComment,@javascriptComments,javaScriptLineComment,javaScriptComment,typescriptLineComment,typescriptComment,jsxSpreadOperator
      \ keepend
      \ extend

" <tag></tag>
" ~~~~~~~~~~~
" and fragment
" <></>
" ~~~~~
" and self close tag
" <tag />
" ~~~~~~~
syntax region jsxElement
      \ start=+<\_s*\(>\|\${\|\z(\<[-:_\.\$0-9A-Za-z]\+\>\)\)+
      \ end=+/\_s*>+
      \ end=+<\_s*/\_s*\z1\_s*>+
      \ contains=jsxElement,jsxEscapeJs,jsxTag,jsxComment,jsxCloseString,jsxCloseTag,@Spell
      \ keepend
      \ extend
      \ contained
      \ fold

" detect jsx region
syntax region jsxRegion
      \ start=+\(\(\_[([,?:=+\-*/<>{}]\|&&\|||\|=>\|\<return\|\<default\|\<await\|\<yield\)\_s*\)\@<=<\_s*\(>\|\z(\(script\)\@!\<[_\$A-Za-z][-:_\.\$0-9A-Za-z]*\>\)\(\_s*\([-+*)\]}&|?,]\|/\([/*]\|\_s*>\)\@!\)\)\@!\)+
      \ end=++
      \ contains=jsxElement

" <tag key={this.props.key}>
"          ~~~~~~~~~~~~~~~~
syntax region jsxEscapeJs
      \ start=+{+
      \ end=++
      \ extend
      \ contained
      \ contains=jsBlock,javascriptBlock,javaScriptBlockBuildIn,typescriptBlock

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
      \ skipempty ' .(s:highlight_close_tag ? 'transparent' : '')

" <foo.bar>
"     ~
syntax match jsxDot +\.+ contained display

" <foo:bar>
"     ~
syntax match jsxNamespace +:+ contained display

" <tag id="sample">
"        ~
syntax match jsxEqual +=+ contained display nextgroup=jsxString,jsxEscapeJs,jsxRegion skipwhite

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
      \ +\<[-A-Za-z_][-:_\$0-9A-Za-z]*\>+
      \ contained
      \ nextgroup=jsxEqual
      \ skipwhite
      \ skipempty
      \ contains=jsxAttribKeyword
      \ display

" <MyComponent ...>
"  ~~~~~~~~~~~
" NOT
" <someCamel ...>
"      ~~~~~
exe 'syntax match jsxComponentName
      \ +\<[A-Z][\$0-9A-Za-z]\+\>+
      \ contained
      \ display ' .(s:highlight_close_tag ? 'transparent' : '')

" <tag key={this.props.key}>
"  ~~~
exe 'syntax match jsxTagName
      \ +\<[-:_\.\$0-9A-Za-z]\+\>+
      \ contained
      \ contains=jsxComponentName,jsxDot,jsxNamespace
      \ nextgroup=jsxAttrib
      \ skipempty
      \ skipwhite
      \ display ' .(s:highlight_close_tag ? 'transparent' : '')

" <tag id="sample">
"         ~~~~~~~~
" and
" <tag id='sample'>
"         ~~~~~~~~
syntax region jsxString start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ contained contains=@Spell display

let s:tags = get(g:, 'vim_jsx_pretty_template_tags', ['html', 'raw'])
let s:enable_tagged_jsx = !empty(s:tags)

" add support to JSX inside the tagged template string
" https://github.com/developit/htm
if s:enable_tagged_jsx
  exe 'syntax region jsxTaggedRegion
        \ start=+\%('. join(s:tags, '\|') .'\)\@<=`+ms=s+1
        \ end=+`+me=e-1
        \ extend
        \ contained
        \ containedin=jsTemplateString,javascriptTemplate,javaScriptStringT,typescriptStringB
        \ contains=jsxElement'

  syntax region jsxEscapeJs
        \ start=+\${+
        \ end=++
        \ extend
        \ contained
        \ contains=jsTemplateExpression,javascriptTemplateSubstitution,javaScriptEmbed,typescriptInterpolation

  syntax region jsxOpenTag
        \ matchgroup=jsxOpenPunct
        \ start=+<\%(\${\)\@=+
        \ matchgroup=NONE
        \ end=++
        \ contained
        \ contains=jsxEscapeJs
        \ nextgroup=jsxAttrib,jsxSpreadOperator
        \ skipwhite
        \ skipempty

  syntax keyword jsxAttribKeyword class contained display

  syntax match jsxSpreadOperator +\.\.\.+ contained display nextgroup=jsxEscapeJs skipwhite

  syntax match jsxCloseTag +<//>+ display

  syntax match jsxComment +<!--\_.\{-}-->+ display
endif

" Highlight the tag name
highlight def link jsxTag Function
highlight def link jsxTagName Identifier
highlight def link jsxComponentName Function

highlight def link jsxAttrib Type
highlight def link jsxAttribKeyword jsxAttrib
highlight def link jsxEqual Operator
highlight def link jsxString String
highlight def link jsxDot Operator
highlight def link jsxNamespace Operator

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

highlight def link jsxComment Comment
highlight def link jsxSpreadOperator Operator

let s:vim_jsx_pretty_colorful_config = get(g:, 'vim_jsx_pretty_colorful_config', 0)

if s:vim_jsx_pretty_colorful_config == 1
  highlight def link jsObjectKey Label
  highlight def link jsArrowFuncArgs Type
  highlight def link jsFuncArgs Type
endif


endif
