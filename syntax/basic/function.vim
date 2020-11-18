if has_key(g:polyglot_is_disabled, 'typescript')
  finish
endif

syntax keyword typescriptAsyncFuncKeyword      async
  \ nextgroup=typescriptFuncKeyword,typescriptArrowFuncDef
  \ skipwhite

syntax keyword typescriptAsyncFuncKeyword      await
  \ nextgroup=@typescriptValue
  \ skipwhite

syntax keyword typescriptFuncKeyword           function
  \ nextgroup=typescriptAsyncFunc,typescriptFuncName,@typescriptCallSignature
  \ skipwhite skipempty

syntax match   typescriptAsyncFunc             contained /*/
  \ nextgroup=typescriptFuncName,@typescriptCallSignature
  \ skipwhite skipempty

syntax match   typescriptFuncName              contained /\K\k*/
  \ nextgroup=@typescriptCallSignature
  \ skipwhite

syntax match   typescriptArrowFuncDef          contained /\K\k*\s*=>/
  \ contains=typescriptArrowFuncArg,typescriptArrowFunc
  \ nextgroup=@typescriptExpression,typescriptBlock
  \ skipwhite skipempty

syntax match   typescriptArrowFuncDef          contained /(\%(\_[^()]\+\|(\_[^()]*)\)*)\_s*=>/
  \ contains=typescriptArrowFuncArg,typescriptArrowFunc
  \ nextgroup=@typescriptExpression,typescriptBlock
  \ skipwhite skipempty

syntax region  typescriptArrowFuncDef          contained start=/(\%(\_[^()]\+\|(\_[^()]*)\)*):/ end=/=>/
  \ contains=typescriptArrowFuncArg,typescriptArrowFunc,typescriptTypeAnnotation
  \ nextgroup=@typescriptExpression,typescriptBlock
  \ skipwhite skipempty keepend

syntax match   typescriptArrowFunc             /=>/
syntax match   typescriptArrowFuncArg          contained /\K\k*/
syntax region  typescriptArrowFuncArg          contained start=/<\|(/ end=/\ze=>/ contains=@typescriptCallSignature

syntax region typescriptReturnAnnotation contained start=/:/ end=/{/me=e-1 contains=@typescriptType nextgroup=typescriptBlock


syntax region typescriptFuncImpl contained start=/function\>/ end=/{/me=e-1
  \ contains=typescriptFuncKeyword
  \ nextgroup=typescriptBlock

syntax cluster typescriptCallImpl contains=typescriptGenericImpl,typescriptParamImpl
syntax region typescriptGenericImpl matchgroup=typescriptTypeBrackets
  \ start=/</ end=/>/ skip=/\s*,\s*/
  \ contains=typescriptTypeParameter
  \ nextgroup=typescriptParamImpl
  \ contained skipwhite
syntax region typescriptParamImpl matchgroup=typescriptParens
  \ start=/(/ end=/)/
  \ contains=typescriptDecorator,@typescriptParameterList,@typescriptComments
  \ nextgroup=typescriptReturnAnnotation,typescriptBlock
  \ contained skipwhite skipnl
