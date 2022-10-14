if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/basic/keyword.vim')
  finish
endif

"Import
syntax keyword typescriptImport                from as
syntax keyword typescriptImport                import
  \ nextgroup=typescriptImportType,typescriptTypeBlock,typescriptDefaultImportName
  \ skipwhite
syntax keyword typescriptImportType            type
  \ contained
syntax keyword typescriptExport                export
  \ nextgroup=typescriptExportType
  \ skipwhite
syntax match typescriptExportType              /\<type\s*{\@=/
  \ contained skipwhite skipempty skipnl
syntax keyword typescriptModule                namespace module


syntax keyword typescriptCastKeyword           as satisfies
  \ nextgroup=@typescriptType
  \ skipwhite

syntax keyword typescriptVariable              let var
  \ nextgroup=@typescriptVariableDeclarations
  \ skipwhite skipempty

syntax keyword typescriptVariable const
  \ nextgroup=typescriptEnum,@typescriptVariableDeclarations
  \ skipwhite skipempty

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

syntax keyword typescriptIdentifier            arguments  nextgroup=@afterIdentifier
syntax match typescriptDefaultImportName /\v\h\k*( |,)/
  \ contained
  \ nextgroup=typescriptTypeBlock
  \ skipwhite skipempty

syntax region  typescriptTypeBlock
  \ matchgroup=typescriptBraces
  \ start=/{/ end=/}/
  \ contained
  \ contains=typescriptIdentifierName,typescriptImportType
  \ fold

"Program Keywords
exec 'syntax keyword typescriptNull null '.(exists('g:typescript_conceal_null') ? 'conceal cchar='.g:typescript_conceal_null : '').' nextgroup=@typescriptSymbols skipwhite skipempty'
exec 'syntax keyword typescriptNull undefined '.(exists('g:typescript_conceal_undefined') ? 'conceal cchar='.g:typescript_conceal_undefined : '').' nextgroup=@typescriptSymbols skipwhite skipempty'
"this
exec 'syntax keyword typescriptIdentifier this '.(exists('g:typescript_conceal_this') ? 'conceal cchar='.g:typescript_conceal_this : '').' nextgroup=@afterIdentifier'
exec 'syntax keyword typescriptIdentifier super '.(exists('g:typescript_conceal_super') ? 'conceal cchar='.g:typescript_conceal_super : '').' nextgroup=@afterIdentifier'
"JavaScript Prototype
exec 'syntax keyword typescriptPrototype prototype '.(exists('g:typescript_conceal_prototype') ? 'conceal cchar='.g:typescript_conceal_prototype : '').' nextgroup=@afterIdentifier'
exec 'syntax keyword typescriptStatementKeyword return '.(exists('g:typescript_conceal_return') ? 'conceal cchar='.g:typescript_conceal_return : '').' skipwhite contained nextgroup=@typescriptValue containedin=typescriptBlock'
