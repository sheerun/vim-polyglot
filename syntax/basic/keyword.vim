if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

"Import
syntax keyword typescriptImport                from as import
syntax keyword typescriptExport                export
syntax keyword typescriptModule                namespace module

"this

"JavaScript Prototype
syntax keyword typescriptPrototype             prototype
  \ nextgroup=@afterIdentifier

syntax keyword typescriptCastKeyword           as
  \ nextgroup=@typescriptType
  \ skipwhite

"Program Keywords
syntax keyword typescriptIdentifier            arguments this super
  \ nextgroup=@afterIdentifier

syntax keyword typescriptVariable              let var
  \ nextgroup=typescriptVariableDeclaration
  \ skipwhite skipempty skipnl

syntax keyword typescriptVariable const
  \ nextgroup=typescriptEnum,typescriptVariableDeclaration
  \ skipwhite

syntax match typescriptVariableDeclaration /[A-Za-z_$]\k*/
  \ nextgroup=typescriptTypeAnnotation,typescriptAssign
  \ contained skipwhite skipempty skipnl

syntax region typescriptEnum matchgroup=typescriptEnumKeyword start=/enum / end=/\ze{/
  \ nextgroup=typescriptBlock
  \ skipwhite

syntax keyword typescriptKeywordOp
  \ contained in instanceof nextgroup=@typescriptValue
syntax keyword typescriptOperator              delete new typeof void
  \ nextgroup=@typescriptValue
  \ skipwhite skipempty

syntax keyword typescriptForOperator           contained in of
syntax keyword typescriptBoolean               true false nextgroup=@typescriptSymbols skipwhite skipempty
syntax keyword typescriptNull                  null undefined nextgroup=@typescriptSymbols skipwhite skipempty
syntax keyword typescriptMessage               alert confirm prompt status
  \ nextgroup=typescriptDotNotation,typescriptFuncCallArg
syntax keyword typescriptGlobal                self top parent
  \ nextgroup=@afterIdentifier

"Statement Keywords
syntax keyword typescriptConditional           if else switch
  \ nextgroup=typescriptConditionalParen
  \ skipwhite skipempty skipnl
syntax keyword typescriptConditionalElse       else
syntax keyword typescriptRepeat                do while for nextgroup=typescriptLoopParen skipwhite skipempty
syntax keyword typescriptRepeat                for nextgroup=typescriptLoopParen,typescriptAsyncFor skipwhite skipempty
syntax keyword typescriptBranch                break continue containedin=typescriptBlock
syntax keyword typescriptCase                  case nextgroup=@typescriptPrimitive skipwhite containedin=typescriptBlock
syntax keyword typescriptDefault               default containedin=typescriptBlock nextgroup=@typescriptValue,typescriptClassKeyword,typescriptInterfaceKeyword skipwhite oneline
syntax keyword typescriptStatementKeyword      with
syntax keyword typescriptStatementKeyword      yield skipwhite nextgroup=@typescriptValue containedin=typescriptBlock
syntax keyword typescriptStatementKeyword      return skipwhite contained nextgroup=@typescriptValue containedin=typescriptBlock

syntax keyword typescriptTry                   try
syntax keyword typescriptExceptions            catch throw finally
syntax keyword typescriptDebugger              debugger

syntax keyword typescriptAsyncFor              await nextgroup=typescriptLoopParen skipwhite skipempty contained

syntax region  typescriptLoopParen             contained matchgroup=typescriptParens
  \ start=/(/ end=/)/
  \ contains=typescriptVariable,typescriptForOperator,typescriptEndColons,@typescriptValue,@typescriptComments
  \ nextgroup=typescriptBlock
  \ skipwhite skipempty
syntax region  typescriptConditionalParen             contained matchgroup=typescriptParens
  \ start=/(/ end=/)/
  \ contains=@typescriptValue,@typescriptComments
  \ nextgroup=typescriptBlock
  \ skipwhite skipempty
syntax match   typescriptEndColons             /[;,]/ contained

syntax keyword typescriptAmbientDeclaration declare nextgroup=@typescriptAmbients
  \ skipwhite skipempty

syntax cluster typescriptAmbients contains=
  \ typescriptVariable,
  \ typescriptFuncKeyword,
  \ typescriptClassKeyword,
  \ typescriptAbstract,
  \ typescriptEnumKeyword,typescriptEnum,
  \ typescriptModule

endif
