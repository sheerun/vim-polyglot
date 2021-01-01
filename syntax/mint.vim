if polyglot#init#is_disabled(expand('<sfile>:p'), 'mint', 'syntax/mint.vim')
  finish
endif

if exists('b:current_syntax')
  let s:current_syntax = b:current_syntax
  silent! unlet b:current_syntax
endif

syntax include @JSSyntax syntax/javascript.vim
silent! unlet b:current_syntax
syntax include @XMLSyntax syntax/xml.vim
silent! unlet b:current_syntax
syntax include @CSSSyntax syntax/css.vim
silent! unlet b:current_syntax

syntax case match
if exists('s:current_syntax')
  let b:current_syntax = s:current_syntax
endif

syntax keyword mintBlock
      \ do sequence parallel if else case try catch

syntax keyword mintCompoundType
      \ Result Maybe Promise Array

syntax keyword mintLiteralType
      \ Number Bool String Object Time Html Void Never Tuple

syntax keyword mintDeclarator
      \ component module routes

syntax keyword mintStructureDeclarator
      \ enum record store provider const

syntax keyword mintInitializer
      \ fun let where next state property

syntax keyword mintKeyword
      \ decode encode return connect use

syntax keyword mintOperator
      \ "<{" "}>" "::" "=>" "|>" "<|"

syntax keyword mintSpecifier
      \ as break return using get exposing ok error just nothing void

" String
syntax region mintString matchgroup=mintStringDelimiter start=/"/ skip=/\\"/ end=/"/ oneline
" String interpolation
syntax region mintStringInterpolation matchgroup=mintInterpolationDelimiter start="#{" end="}" contained containedin=mintString contains=@mintAll

" Numbers
syntax match mintNumber "\v<\d+(\.\d+)?>"

" Pascal-cased types
syntax match mintDefinedType "\v<[A-Z][A-Za-z0-9]*(\.[A-Z][A-Za-z0-9]*)*>"


syntax cluster mintAll contains=mintBlock,mintCompoundType,mintDeclarator,mintInitializer,mintKeyword,mintOperator,mintSpecifier,mintString

syntax region mintEmbeddedHtmlRegion
      \ start=+<\z([^ /!?<>"'=:]\+\)+
      \ start=+<\z(\s\{0}\)>+
      \ skip=+<!--\_.\{-}-->+
      \ end=+</\z1\_s\{-}>+
      \ end=+/>+
      \ fold
      \ contains=@Spell,@XMLSyntax,@mintAll
      \ keepend

syntax region mintEmbeddedJsRegion
      \ matchgroup=mintJsInterpolationQuotes
      \ start="`"
      \ end="`"
      \ skip="\\`"
      \ keepend
      \ contains=mintInterpolation,@jsExpression

hi link mintJsInterpolationQuotes Delimiter

syntax match mintBraces /[{}]/
syntax keyword mintStyleKeyword style skipwhite nextgroup=mintStyleIdentifier
syntax match mintStyleIdentifier /\<\k\k*/ contained skipwhite skipempty nextgroup=mintStyleBlock
syntax region mintStyleBlock contained matchgroup=mintBraces start="{" end="}" contains=@mintAll,cssDefinition,cssTagName,cssAttributeSelector,cssClassName,cssIdentifier,cssAtRule,cssAttrRegion,css.*Prop,cssComment,cssValue.*,cssColor,cssURL,cssImportant,cssCustomProp,cssError,cssStringQ,cssStringQQ,cssFunction,cssUnicodeEscape,cssVendor,cssDefinition,cssHacks,cssNoise

" Colour links
hi link mintKeyword                Keyword
hi link mintOperator               Operator

hi link mintBlock                  Statement
hi link mintDeclarator             PreProc
hi link mintStructureDeclarator    Structure
hi link mintInitializer            PreProc
hi link mintSpecifier              Statement

hi link mintString                 String
hi link mintNumber                 Number

hi link mintCompoundType           Type
hi link mintLiteralType            Type
hi link mintDefinedType            Type

hi link mintStringDelimiter        Delimiter
hi link mintInterpolationDelimiter Special

hi link mintStyleKeyword           Type
hi link mintStyleIdentifier        Statement
