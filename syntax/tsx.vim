if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

if !exists("main_syntax")
  if exists("b:current_syntax") && b:current_syntax != 'typescript'
    finish
  endif
  let main_syntax = 'typescript.tsx'
endif

syntax region tsxTag
      \ start=+<\([^/!?<>="':]\+\)\@=+
      \ skip=+</[^ /!?<>"']\+>+
      \ end=+/\@<!>+
      \ end=+\(/>\)\@=+
      \ contained
      \ contains=tsxTagName,tsxIntrinsicTagName,tsxAttrib,tsxEscJs,
                \tsxCloseString,@tsxComment

syntax match tsxTag /<>/ contained


" <tag></tag>
" s~~~~~~~~~e
" and self close tag
" <tag/>
" s~~~~e
" A big start regexp borrowed from https://git.io/vDyxc
syntax region tsxRegion
      \ start=+<\_s*\z([a-zA-Z1-9\$_-]\+\(\.\k\+\)*\)+
      \ skip=+<!--\_.\{-}-->+
      \ end=+</\_s*\z1>+
      \ matchgroup=tsxCloseString end=+/>+
      \ fold
      \ contains=tsxRegion,tsxCloseString,tsxCloseTag,tsxTag,tsxCommentInvalid,tsxFragment,tsxEscJs,@Spell
      \ keepend
      \ extend

" <>   </>
" s~~~~~~e
" A big start regexp borrowed from https://git.io/vDyxc
syntax region tsxFragment
      \ start=+\(\((\|{\|}\|\[\|,\|&&\|||\|?\|:\|=\|=>\|\Wreturn\|^return\|\Wdefault\|^\|>\)\_s*\)\@<=<>+
      \ skip=+<!--\_.\{-}-->+
      \ end=+</>+
      \ fold
      \ contains=tsxRegion,tsxCloseString,tsxCloseTag,tsxTag,tsxCommentInvalid,tsxFragment,tsxEscJs,@Spell
      \ keepend
      \ extend

" </tag>
" ~~~~~~
syntax match tsxCloseTag
      \ +</\_s*[^/!?<>"']\+>+
      \ contained
      \ contains=tsxTagName,tsxIntrinsicTagName

syntax match tsxCloseTag +</>+ contained

syntax match tsxCloseString
      \ +/>+
      \ contained

" <!-- -->
" ~~~~~~~~
syntax match tsxCommentInvalid /<!--\_.\{-}-->/ display

syntax region tsxBlockComment
    \ contained
    \ start="/\*"
    \ end="\*/"

syntax match tsxLineComment
    \ "//.*$"
    \ contained
    \ display

syntax cluster tsxComment contains=tsxBlockComment,tsxLineComment

syntax match tsxEntity "&[^; \t]*;" contains=tsxEntityPunct
syntax match tsxEntityPunct contained "[&.;]"

" <tag key={this.props.key}>
"  ~~~
syntax match tsxTagName
    \ +[</]\_s*[^/!?<>"'* ]\++hs=s+1
    \ contained
    \ nextgroup=tsxAttrib
    \ skipwhite
    \ display
syntax match tsxIntrinsicTagName
    \ +[</]\_s*[a-z1-9-]\++hs=s+1
    \ contained
    \ nextgroup=tsxAttrib
    \ skipwhite
    \ display

" <tag key={this.props.key}>
"      ~~~
syntax match tsxAttrib
    \ +[a-zA-Z_][-0-9a-zA-Z_]*+
    \ nextgroup=tsxEqual skipwhite
    \ contained
    \ display

" <tag id="sample">
"        ~
syntax match tsxEqual +=+ display contained
  \ nextgroup=tsxString skipwhite

" <tag id="sample">
"         s~~~~~~e
syntax region tsxString contained start=+"+ end=+"+ contains=tsxEntity,@Spell display

" <tag key={this.props.key}>
"          s~~~~~~~~~~~~~~e
syntax region tsxEscJs
    \ contained
    \ contains=@typescriptValue,@tsxComment
    \ matchgroup=typescriptBraces
    \ start=+{+
    \ end=+}+
    \ extend

syntax cluster typescriptExpression add=tsxRegion,tsxFragment

highlight def link tsxTag htmlTag
highlight def link tsxTagName Function
highlight def link tsxIntrinsicTagName htmlTagName
highlight def link tsxString String
highlight def link tsxNameSpace Function
highlight def link tsxCommentInvalid Error
highlight def link tsxBlockComment Comment
highlight def link tsxLineComment Comment
highlight def link tsxAttrib Type
highlight def link tsxEscJs tsxEscapeJs
highlight def link tsxCloseTag htmlTag
highlight def link tsxCloseString Identifier

let b:current_syntax = "typescript.tsx"
if main_syntax == 'typescript.tsx'
  unlet main_syntax
endif

endif
