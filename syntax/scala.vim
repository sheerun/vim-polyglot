if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let b:current_syntax = "scala"

syn case match
syn sync minlines=200 maxlines=1000

syn keyword scalaKeyword catch do else final finally for forSome if
syn keyword scalaKeyword match return throw try while yield
syn keyword scalaKeyword class trait object extends with type nextgroup=scalaInstanceDeclaration skipwhite
syn keyword scalaKeyword case nextgroup=scalaCaseFollowing skipwhite
syn keyword scalaKeyword val nextgroup=scalaNameDefinition,scalaQuasiQuotes skipwhite
syn keyword scalaKeyword def var nextgroup=scalaNameDefinition skipwhite
hi link scalaKeyword Keyword

syn match scalaNameDefinition /\<[_A-Za-z0-9$]\+\>/ contained
syn match scalaNameDefinition /`[^`]\+`/ contained
hi link scalaNameDefinition Function

syn match scalaInstanceDeclaration /\<[_\.A-Za-z0-9$]\+\>/ contained
syn match scalaInstanceDeclaration /`[^`]\+`/ contained
hi link scalaInstanceDeclaration Special

syn match scalaCaseFollowing /\<[_\.A-Za-z0-9$]*\>/ contained
syn match scalaCaseFollowing /`[^`]\+`/ contained
hi link scalaCaseFollowing Special

syn keyword scalaKeywordModifier abstract override final implicit lazy private protected sealed null require super
hi link scalaKeywordModifier Function

syn keyword scalaSpecial this true false package import
syn keyword scalaSpecial new nextgroup=scalaInstanceDeclaration skipwhite
syn match scalaSpecial "\%(=>\|⇒\|<-\|←\|->\|→\)"
syn match scalaSpecial /`[^`]*`/  " Backtick literals
hi link scalaSpecial PreProc

syn region scalaString start=/"/ skip=/\\"/ end=/"/
hi link scalaString String

syn region scalaSString matchgroup=Special start=/s"/ skip=/\\"/ end=/"/ contains=scalaInterpolation
syn match scalaInterpolation /\$[a-zA-Z0-9_$]\+/ contained
syn match scalaInterpolation /\${[^}]\+}/ contained
hi link scalaSString String
hi link scalaInterpolation Function

syn region scalaFString matchgroup=Special start=/f"/ skip=/\\"/ end=/"/ contains=scalaInterpolation,scalaFInterpolation
syn match scalaFInterpolation /\$[a-zA-Z0-9_$]\+%[-A-Za-z0-9\.]\+/ contained
syn match scalaFInterpolation /\${[^}]\+}%[-A-Za-z0-9\.]\+/ contained
hi link scalaFString String
hi link scalaFInterpolation Function

syn region scalaQuasiQuotes matchgroup=Type start=/\<q"/ skip=/\\"/ end=/"/ contains=scalaInterpolation
syn region scalaQuasiQuotes matchgroup=Type start=/\<[tcp]q"/ skip=/\\"/ end=/"/ contains=scalaInterpolation
hi link scalaQuasiQuotes String

syn region scalaTripleQuasiQuotes matchgroup=Type start=/\<q"""/ end=/"""/ contains=scalaInterpolation
syn region scalaTripleQuasiQuotes matchgroup=Type start=/\<[tcp]q"""/ end=/"""/ contains=scalaInterpolation
hi link scalaTripleQuasiQuotes String

syn region scalaTripleString start=/"""/ end=/"""/
syn region scalaTripleSString matchgroup=PreProc start=/s"""/ end=/"""/
syn region scalaTripleFString matchgroup=PreProc start=/f"""/ end=/"""/
hi link scalaTripleString String
hi link scalaTripleSString String
hi link scalaTripleFString String

syn match scalaNumber /\<0[dDfFlL]\?\>/
syn match scalaNumber /\<[1-9]\d*[dDfFlL]\?\>/
syn match scalaNumber /\<0[xX][0-9a-fA-F]\+[dDfFlL]\?\>/
syn match scalaNumber "\%(\<\d\+\.\d*\|\.\d\+\)\%([eE][-+]\=\d\+\)\=[fFdD]\="
syn match scalaNumber "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syn match scalaNumber "\<\d\+\%([eE][-+]\=\d\+\)\=[fFdD]\>"
hi link scalaNumber Number

syn region scalaSquareBrackets matchgroup=Type start="\[" end="\]" contains=scalaSpecial,scalaTypeParameter,scalaSquareBrackets,scalaTypeOperator
syn match scalaTypeAnnotation /\%(:\s*\)\@<=[_\.A-Za-z0-9$]\+/
syn match scalaTypeParameter /[_\.A-Za-z0-9$]\+/ contained
syn match scalaTypeOperator /[=:<>]\+/ contained
hi link scalaTypeAnnotation Type
hi link scalaTypeParameter Type
hi link scalaTypeOperator Type

syn region scalaMultilineComment start="/\*" end="\*/" contains=scalaMultilineComment,scalaDocLinks,scalaParameterAnnotation,scalaCommentAnnotation,scalaCommentCodeBlock,@scalaHtml keepend
syn match scalaCommentAnnotation "@[_A-Za-z0-9$]\+" contained
syn match scalaParameterAnnotation "@param" nextgroup=scalaParamAnnotationValue skipwhite contained
syn match scalaParamAnnotationValue /[`_A-Za-z0-9$]\+/ contained
syn region scalaDocLinks start="\[\[" end="\]\]" contained
syn region scalaCommentCodeBlock matchgroup=Keyword start="{{{" end="}}}" contained
hi link scalaMultilineComment Comment
hi link scalaDocLinks Function
hi link scalaParameterAnnotation Function
hi link scalaParamAnnotationValue Keyword
hi link scalaCommentAnnotation Function
hi link scalaCommentCodeBlock String

syn match scalaAnnotation /@\<[`_A-Za-z0-9$]\+\>/
hi link scalaAnnotation PreProc

syn match scalaTrailingComment "//.*$"
hi link scalaTrailingComment Comment
