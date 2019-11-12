if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

" Define the default highlighting.
" For version 5.8 and later: only when an item doesn't have highlighting yet
let did_typescript_hilink = 1

syntax sync fromstart
command -nargs=+ HiLink hi def link <args>

"Dollar sign is permitted anywhere in an identifier
setlocal iskeyword-=$
if main_syntax == 'typescript' || main_syntax == 'typescriptreact'
  setlocal iskeyword+=$
  " syntax cluster htmlJavaScript                 contains=TOP
endif

" lowest priority on least used feature
syntax match   typescriptLabel                /[a-zA-Z_$]\k*:/he=e-1 contains=typescriptReserved nextgroup=@typescriptStatement skipwhite skipempty

" other keywords like return,case,yield uses containedin
syntax region  typescriptBlock                 matchgroup=typescriptBraces start=/{/ end=/}/ contains=@typescriptStatement,@typescriptComments fold


runtime syntax/basic/identifiers.vim
runtime syntax/basic/literal.vim
runtime syntax/basic/object.vim

runtime syntax/basic/symbols.vim
" runtime syntax/basic/reserved.vim
runtime syntax/basic/keyword.vim
runtime syntax/basic/doc.vim
runtime syntax/basic/type.vim

" extension
if get(g:, 'yats_host_keyword', 1)
  runtime syntax/yats.vim
endif

" patch
runtime syntax/basic/patch.vim
runtime syntax/basic/members.vim
runtime syntax/basic/class.vim
runtime syntax/basic/cluster.vim
runtime syntax/basic/function.vim
runtime syntax/basic/decorator.vim

if exists("did_typescript_hilink")
  HiLink typescriptReserved             Error

  HiLink typescriptEndColons            Exception
  HiLink typescriptSymbols              Normal
  HiLink typescriptBraces               Function
  HiLink typescriptParens               Normal
  HiLink typescriptComment              Comment
  HiLink typescriptLineComment          Comment
  HiLink typescriptDocComment           Comment
  HiLink typescriptCommentTodo          Todo
  HiLink typescriptRef                  Include
  HiLink typescriptDocNotation          SpecialComment
  HiLink typescriptDocTags              SpecialComment
  HiLink typescriptDocNGParam           typescriptDocParam
  HiLink typescriptDocParam             Function
  HiLink typescriptDocNumParam          Function
  HiLink typescriptDocEventRef          Function
  HiLink typescriptDocNamedParamType    Type
  HiLink typescriptDocParamName         Type
  HiLink typescriptDocParamType         Type
  HiLink typescriptString               String
  HiLink typescriptSpecial              Special
  HiLink typescriptStringLiteralType    String
  HiLink typescriptStringMember         String
  HiLink typescriptTemplate             String
  HiLink typescriptEventString          String
  HiLink typescriptASCII                Special
  HiLink typescriptTemplateSB           Label
  HiLink typescriptRegexpString         String
  HiLink typescriptGlobal               Constant
  HiLink typescriptTestGlobal           Function
  HiLink typescriptPrototype            Type
  HiLink typescriptConditional          Conditional
  HiLink typescriptConditionalElse      Conditional
  HiLink typescriptCase                 Conditional
  HiLink typescriptDefault              typescriptCase
  HiLink typescriptBranch               Conditional
  HiLink typescriptIdentifier           Structure
  HiLink typescriptVariable             Identifier
  HiLink typescriptEnumKeyword          Identifier
  HiLink typescriptRepeat               Repeat
  HiLink typescriptForOperator          Repeat
  HiLink typescriptStatementKeyword     Statement
  HiLink typescriptMessage              Keyword
  HiLink typescriptOperator             Identifier
  HiLink typescriptKeywordOp            Identifier
  HiLink typescriptCastKeyword          Special
  HiLink typescriptType                 Type
  HiLink typescriptNull                 Boolean
  HiLink typescriptNumber               Number
  HiLink typescriptExponent             Number
  HiLink typescriptBoolean              Boolean
  HiLink typescriptObjectLabel          typescriptLabel
  HiLink typescriptLabel                Label
  HiLink typescriptStringProperty       String
  HiLink typescriptImport               Special
  HiLink typescriptAmbientDeclaration   Special
  HiLink typescriptExport               Special
  HiLink typescriptModule               Special
  HiLink typescriptTry                  Special
  HiLink typescriptExceptions           Special

  HiLink typescriptMember              Function
  HiLink typescriptMethodAccessor       Operator

  HiLink typescriptAsyncFuncKeyword     Keyword
  HiLink typescriptAsyncFor             Keyword
  HiLink typescriptFuncKeyword          Keyword
  HiLink typescriptAsyncFunc            Keyword
  HiLink typescriptArrowFunc            Type
  HiLink typescriptFuncName             Function
  HiLink typescriptFuncArg              PreProc
  HiLink typescriptArrowFuncArg         PreProc
  HiLink typescriptFuncComma            Operator

  HiLink typescriptClassKeyword         Keyword
  HiLink typescriptClassExtends         Keyword
  " HiLink typescriptClassName            Function
  HiLink typescriptAbstract             Special
  " HiLink typescriptClassHeritage        Function
  " HiLink typescriptInterfaceHeritage    Function
  HiLink typescriptClassStatic          StorageClass
  HiLink typescriptReadonlyModifier     Keyword
  HiLink typescriptInterfaceKeyword     Keyword
  HiLink typescriptInterfaceExtends     Keyword
  HiLink typescriptInterfaceName        Function

  HiLink shellbang                      Comment

  HiLink typescriptTypeParameter         Identifier
  HiLink typescriptConstraint            Keyword
  HiLink typescriptPredefinedType        Type
  HiLink typescriptReadonlyArrayKeyword  Keyword
  HiLink typescriptUnion                 Operator
  HiLink typescriptFuncTypeArrow         Function
  HiLink typescriptConstructorType       Function
  HiLink typescriptTypeQuery             Keyword
  HiLink typescriptAccessibilityModifier Keyword
  HiLink typescriptOptionalMark          PreProc
  HiLink typescriptFuncType              Special
  HiLink typescriptMappedIn              Special
  HiLink typescriptCall                  PreProc
  HiLink typescriptParamImpl             PreProc
  HiLink typescriptConstructSignature    Identifier
  HiLink typescriptAliasDeclaration      Identifier
  HiLink typescriptAliasKeyword          Keyword
  HiLink typescriptUserDefinedType       Keyword
  HiLink typescriptTypeReference         Identifier
  HiLink typescriptConstructor           Keyword
  HiLink typescriptDecorator             Special
  HiLink typescriptAssertType            Keyword

  highlight link typeScript             NONE

  delcommand HiLink
  unlet did_typescript_hilink
endif

endif
