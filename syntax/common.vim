if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/common.vim')
  finish
endif

" Define the default highlighting.

syntax sync fromstart

"Dollar sign is permitted anywhere in an identifier
setlocal iskeyword-=$
if main_syntax == 'typescript' || main_syntax == 'typescriptreact'
  setlocal iskeyword+=$
  " syntax cluster htmlJavaScript                 contains=TOP
endif
" For private field added from TypeScript 3.8
setlocal iskeyword+=#

" lowest priority on least used feature
syntax match   typescriptLabel                /[a-zA-Z_$]\k*:/he=e-1 contains=typescriptReserved nextgroup=@typescriptStatement skipwhite skipempty

" other keywords like return,case,yield uses containedin
syntax region  typescriptBlock                 matchgroup=typescriptBraces start=/{/ end=/}/ contains=@typescriptStatement,@typescriptComments fold


runtime syntax/ts-common/identifiers.vim
runtime syntax/ts-common/literal.vim
runtime syntax/ts-common/object.vim

runtime syntax/ts-common/symbols.vim
" runtime syntax/ts-common/reserved.vim
runtime syntax/ts-common/keyword.vim
runtime syntax/ts-common/doc.vim
runtime syntax/ts-common/type.vim

" extension
if get(g:, 'yats_host_keyword', 1)
  runtime syntax/yats.vim
endif

" patch
runtime syntax/ts-common/patch.vim
runtime syntax/ts-common/members.vim
runtime syntax/ts-common/class.vim
runtime syntax/ts-common/cluster.vim
runtime syntax/ts-common/function.vim
runtime syntax/ts-common/decorator.vim

hi def link typescriptReserved              Error

hi def link typescriptEndColons             Exception
hi def link typescriptSymbols               Normal
hi def link typescriptBraces                Function
hi def link typescriptParens                Normal
hi def link typescriptComment               Comment
hi def link typescriptLineComment           Comment
hi def link typescriptDocComment            Comment
hi def link typescriptCommentTodo           Todo
hi def link typescriptMagicComment          SpecialComment
hi def link typescriptRef                   Include
hi def link typescriptDocNotation           SpecialComment
hi def link typescriptDocTags               SpecialComment
hi def link typescriptDocNGParam            typescriptDocParam
hi def link typescriptDocParam              Function
hi def link typescriptDocNumParam           Function
hi def link typescriptDocEventRef           Function
hi def link typescriptDocNamedParamType     Type
hi def link typescriptDocParamName          Type
hi def link typescriptDocParamType          Type
hi def link typescriptString                String
hi def link typescriptSpecial               Special
hi def link typescriptStringLiteralType     String
hi def link typescriptTemplateLiteralType   String
hi def link typescriptStringMember          String
hi def link typescriptTemplate              String
hi def link typescriptEventString           String
hi def link typescriptDestructureString     String
hi def link typescriptASCII                 Special
hi def link typescriptTemplateSB            Label
hi def link typescriptRegexpString          String
hi def link typescriptGlobal                Constant
hi def link typescriptTestGlobal            Function
hi def link typescriptPrototype             Type
hi def link typescriptConditional           Conditional
hi def link typescriptConditionalElse       Conditional
hi def link typescriptCase                  Conditional
hi def link typescriptDefault               typescriptCase
hi def link typescriptBranch                Conditional
hi def link typescriptIdentifier            Structure
hi def link typescriptVariable              Identifier
hi def link typescriptUsing                 Identifier
hi def link typescriptDestructureVariable   PreProc
hi def link typescriptEnumKeyword           Identifier
hi def link typescriptRepeat                Repeat
hi def link typescriptForOperator           Repeat
hi def link typescriptStatementKeyword      Statement
hi def link typescriptMessage               Keyword
hi def link typescriptOperator              Identifier
hi def link typescriptKeywordOp             Identifier
hi def link typescriptCastKeyword           Special
hi def link typescriptType                  Type
hi def link typescriptNull                  Boolean
hi def link typescriptNumber                Number
hi def link typescriptBoolean               Boolean
hi def link typescriptObjectLabel           typescriptLabel
hi def link typescriptDestructureLabel      Function
hi def link typescriptLabel                 Label
hi def link typescriptTupleLable            Label
hi def link typescriptStringProperty        String
hi def link typescriptImport                Special
hi def link typescriptImportType            Special
hi def link typescriptAmbientDeclaration    Special
hi def link typescriptExport                Special
hi def link typescriptExportType            Special
hi def link typescriptModule                Special
hi def link typescriptTry                   Special
hi def link typescriptExceptions            Special

hi def link typescriptMember                Function
hi def link typescriptMethodAccessor        Operator

hi def link typescriptAsyncFuncKeyword      Keyword
hi def link typescriptObjectAsyncKeyword    Keyword
hi def link typescriptAsyncFor              Keyword
hi def link typescriptFuncKeyword           Keyword
hi def link typescriptAsyncFunc             Keyword
hi def link typescriptArrowFunc             Type
hi def link typescriptFuncName              Function
hi def link typescriptFuncCallArg           PreProc
hi def link typescriptArrowFuncArg          PreProc
hi def link typescriptFuncComma             Operator

hi def link typescriptClassKeyword          Keyword
hi def link typescriptClassExtends          Keyword
" hi def link typescriptClassName             Function
hi def link typescriptAbstract              Special
" hi def link typescriptClassHeritage         Function
" hi def link typescriptInterfaceHeritage     Function
hi def link typescriptClassStatic           StorageClass
hi def link typescriptReadonlyModifier      Keyword
hi def link typescriptInterfaceKeyword      Keyword
hi def link typescriptInterfaceExtends      Keyword
hi def link typescriptInterfaceName         Function

hi def link shellbang                       Comment

hi def link typescriptTypeParameter         Identifier
hi def link typescriptConstraint            Keyword
hi def link typescriptPredefinedType        Type
hi def link typescriptReadonlyArrayKeyword  Keyword
hi def link typescriptUnion                 Operator
hi def link typescriptFuncTypeArrow         Function
hi def link typescriptConstructorType       Function
hi def link typescriptTypeQuery             Keyword
hi def link typescriptAccessibilityModifier Keyword
hi def link typescriptAutoAccessor          Keyword
hi def link typescriptOptionalMark          PreProc
hi def link typescriptFuncType              Special
hi def link typescriptMappedIn              Special
hi def link typescriptCall                  PreProc
hi def link typescriptParamImpl             PreProc
hi def link typescriptConstructSignature    Identifier
hi def link typescriptAliasDeclaration      Identifier
hi def link typescriptAliasKeyword          Keyword
hi def link typescriptUserDefinedType       Keyword
hi def link typescriptTypeReference         Identifier
hi def link typescriptConstructor           Keyword
hi def link typescriptDecorator             Special
hi def link typescriptAssertType            Keyword

hi def link typeScript                      NONE
