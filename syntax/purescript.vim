if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'purescript') == -1

" syntax highlighting for purescript
"
" Heavily modified version of the purescript syntax
" highlighter to support purescript.
"
" author: raichoo (raichoo@googlemail.com)

if exists("b:current_syntax")
  finish
endif

" Values
syn match purescriptIdentifier "\<[_a-z]\(\w\|\'\)*\>"
syn match purescriptNumber "0[xX][0-9a-fA-F]\+\|0[oO][0-7]\|[0-9]\+"
syn match purescriptFloat "[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\="
syn keyword purescriptBoolean true false

" Delimiters
syn match purescriptDelimiter "[,;|.()[\]{}]"

" Type
syn match purescriptType "\%(\<class\s\+\)\@15<!\<\u\w*\>" contained
  \ containedin=purescriptTypeAlias
  \ nextgroup=purescriptType,purescriptTypeVar skipwhite
syn match purescriptTypeVar "\<[_a-z]\(\w\|\'\)*\>" contained
  \ containedin=purescriptData,purescriptNewtype,purescriptTypeAlias,purescriptFunctionDecl
syn region purescriptTypeExport matchgroup=purescriptType start="\<[A-Z]\(\S\&[^,.]\)*\>("rs=e-1 matchgroup=purescriptDelimiter end=")" contained extend
  \ contains=purescriptConstructor,purescriptDelimiter

" Constructor
syn match purescriptConstructor "\%(\<class\s\+\)\@15<!\<\u\w*\>"
syn region purescriptConstructorDecl matchgroup=purescriptConstructor start="\<[A-Z]\w*\>" end="\(|\|$\)"me=e-1,re=e-1 contained
  \ containedin=purescriptData,purescriptNewtype
  \ contains=purescriptType,purescriptTypeVar,purescriptDelimiter,purescriptOperatorType,purescriptOperatorTypeSig,@purescriptComment


" Function
syn match purescriptFunction "\%(\<instance\s\+\|\<class\s\+\)\@18<!\<[_a-z]\(\w\|\'\)*\>" contained
" syn match purescriptFunction "\<[_a-z]\(\w\|\'\)*\>" contained
syn match purescriptFunction "(\%(\<class\s\+\)\@18<!\(\W\&[^(),\"]\)\+)" contained extend
syn match purescriptBacktick "`[_A-Za-z][A-Za-z0-9_\.]*`"

" Class
syn region purescriptClassDecl start="^\%(\s*\)class\>"ms=e-5 end="\<where\>\|$"
  \ contains=purescriptClass,purescriptClassName,purescriptOperatorType,purescriptOperator,purescriptType,purescriptWhere
  \ nextgroup=purescriptClass
  \ skipnl
syn match purescriptClass "\<class\>" containedin=purescriptClassDecl contained
  \ nextgroup=purescriptClassName
  \ skipnl
syn match purescriptClassName "\<[A-Z]\w*\>" containedin=purescriptClassDecl contained

" Module
syn match purescriptModuleName "\(\u\w\*\.\?\)*" contained excludenl
syn match purescriptModuleKeyword "\<module\>"
syn match purescriptModule "^module\>\s\+\<\(\w\+\.\?\)*\>"
  \ contains=purescriptModuleKeyword,purescriptModuleName
  \ nextgroup=purescriptModuleParams
  \ skipwhite
  \ skipnl
  \ skipempty
syn region purescriptModuleParams start="(" skip="([^)]\{-})" end=")" fold contained keepend
  \ contains=purescriptClassDecl,purescriptClass,purescriptClassName,purescriptDelimiter,purescriptType,purescriptTypeExport,purescriptStructure,purescriptModuleKeyword,@purescriptComment
  \ nextgroup=purescriptImportParams skipwhite

" Import
syn match purescriptImportKeyword "\<\(foreign\|import\|qualified\)\>"
syn match purescriptImport "\<import\>\s\+\(qualified\s\+\)\?\<\(\w\+\.\?\)*"
  \ contains=purescriptImportKeyword,purescriptModuleName
  \ nextgroup=purescriptImportParams,purescriptImportAs,purescriptImportHiding
  \ skipwhite
syn region purescriptImportParams
  \ start="("
  \ skip="([^)]\{-})"
  \ end=")"
  \ contained
  \ contains=purescriptClass,purescriptClass,purescriptStructure,purescriptType,purescriptIdentifier
  \ nextgroup=purescriptImportAs
  \ skipwhite
syn keyword purescriptAsKeyword as contained
syn match purescriptImportAs "\<as\>\_s\+\u\w*"
  \ contains=purescriptAsKeyword,purescriptModuleName
  \ nextgroup=purescriptModuleName
syn keyword purescriptHidingKeyword hiding contained
syn match purescriptImportHiding "hiding"
  \ contained
  \ contains=purescriptHidingKeyword
  \ nextgroup=purescriptImportParams
  \ skipwhite

" Function declaration
syn region purescriptFunctionDecl
  \ excludenl start="^\z(\s*\)\(\(foreign\s\+import\)\_s\+\)\?[_a-z]\(\w\|\'\)*\_s\{-}\(::\|∷\)"
  \ end="^\z1\=\S"me=s-1,re=s-1 keepend
  \ contains=purescriptFunctionDeclStart,purescriptForall,purescriptOperatorType,purescriptOperatorTypeSig,purescriptType,purescriptTypeVar,purescriptDelimiter,@purescriptComment
syn region purescriptFunctionDecl
  \ excludenl start="^\z(\s*\)where\z(\s\+\)[_a-z]\(\w\|\'\)*\_s\{-}\(::\|∷\)"
  \ end="^\(\z1\s\{5}\z2\)\=\S"me=s-1,re=s-1 keepend
  \ contains=purescriptFunctionDeclStart,purescriptForall,purescriptOperatorType,purescriptOperatorTypeSig,purescriptType,purescriptTypeVar,purescriptDelimiter,@purescriptComment
syn region purescriptFunctionDecl
  \ excludenl start="^\z(\s*\)let\z(\s\+\)[_a-z]\(\w\|\'\)*\_s\{-}\(::\|∷\)"
  \ end="^\(\z1\s\{3}\z2\)\=\S"me=s-1,re=s-1 keepend
  \ contains=purescriptFunctionDeclStart,purescriptForall,purescriptOperatorType,purescriptOperatorTypeSig,purescriptType,purescriptTypeVar,purescriptDelimiter,@purescriptComment
syn match purescriptFunctionDeclStart "^\s*\(\(foreign\s\+import\|let\|where\)\_s\+\)\?\([_a-z]\(\w\|\'\)*\)\_s\{-}\(::\|∷\)" contained
  \ contains=purescriptImportKeyword,purescriptWhere,purescriptLet,purescriptFunction,purescriptOperatorType
syn keyword purescriptForall forall
syn match purescriptForall "∀"

" Keywords
syn keyword purescriptConditional if then else
syn keyword purescriptStatement do case of in ado
syn keyword purescriptLet let
syn keyword purescriptWhere where
syn match purescriptStructure "\<\(data\|newtype\|type\|kind\)\>"
  \ nextgroup=purescriptType skipwhite
syn keyword purescriptStructure derive
syn keyword purescriptStructure instance
  \ nextgroup=purescriptFunction skipwhite

" Infix
syn match purescriptInfixKeyword "\<\(infix\|infixl\|infixr\)\>"
syn match purescriptInfix "^\(infix\|infixl\|infixr\)\>\s\+\([0-9]\+\)\s\+\(type\s\+\)\?\(\S\+\)\s\+as\>"
  \ contains=purescriptInfixKeyword,purescriptNumber,purescriptAsKeyword,purescriptConstructor,purescriptStructure,purescriptFunction,purescriptBlockComment
  \ nextgroup=purescriptFunction,purescriptOperator,@purescriptComment

" Operators
syn match purescriptOperator "\([-!#$%&\*\+/<=>\?@\\^|~:]\|\<_\>\)"
syn match purescriptOperatorType "\%(\<instance\>.*\)\@40<!\(::\|∷\)"
  \ nextgroup=purescriptForall,purescriptType skipwhite skipnl skipempty
syn match purescriptOperatorFunction "\(->\|<-\|[\\→←]\)"
syn match purescriptOperatorTypeSig "\(->\|<-\|=>\|<=\|::\|[∷∀→←⇒⇐]\)" contained
  \ nextgroup=purescriptType skipwhite skipnl skipempty

" Type definition
syn region purescriptData start="^data\s\+\([A-Z]\w*\)" end="^\S"me=s-1,re=s-1 transparent
syn match purescriptDataStart "^data\s\+\([A-Z]\w*\)" contained
  \ containedin=purescriptData
  \ contains=purescriptStructure,purescriptType,purescriptTypeVar
syn match purescriptForeignData "\<foreign\s\+import\s\+data\>"
  \ contains=purescriptImportKeyword,purescriptStructure
  \ nextgroup=purescriptType skipwhite

syn region purescriptNewtype start="^newtype\s\+\([A-Z]\w*\)" end="^\S"me=s-1,re=s-1 transparent
syn match purescriptNewtypeStart "^newtype\s\+\([A-Z]\w*\)" contained
  \ containedin=purescriptNewtype
  \ contains=purescriptStructure,purescriptType,purescriptTypeVar

syn region purescriptTypeAlias start="^type\s\+\([A-Z]\w*\)" end="^\S"me=s-1,re=s-1 transparent
syn match purescriptTypeAliasStart "^type\s\+\([A-Z]\w*\)" contained
  \ containedin=purescriptTypeAlias
  \ contains=purescriptStructure,purescriptType,purescriptTypeVar

" String
syn match purescriptChar "'[^'\\]'\|'\\.'\|'\\u[0-9a-fA-F]\{4}'"
syn region purescriptString start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell
syn region purescriptMultilineString start=+"""+ end=+"""+ fold contains=@Spell

" Comment
syn match purescriptLineComment "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$" contains=@Spell
syn region purescriptBlockComment start="{-" end="-}" fold
  \ contains=purescriptBlockComment,@Spell
syn cluster purescriptComment contains=purescriptLineComment,purescriptBlockComment,@Spell

syn sync minlines=50

" highlight links
highlight def link purescriptModule Include
highlight def link purescriptImport Include
highlight def link purescriptModuleKeyword purescriptKeyword
highlight def link purescriptImportAs Include
highlight def link purescriptModuleName Include
highlight def link purescriptModuleParams purescriptDelimiter
highlight def link purescriptImportKeyword purescriptKeyword
highlight def link purescriptAsKeyword purescriptKeyword
highlight def link purescriptHidingKeyword purescriptKeyword

highlight def link purescriptConditional Conditional
highlight def link purescriptWhere purescriptKeyword
highlight def link purescriptInfixKeyword purescriptKeyword

highlight def link purescriptBoolean Boolean
highlight def link purescriptNumber Number
highlight def link purescriptFloat Float

highlight def link purescriptDelimiter Delimiter

highlight def link purescriptOperatorTypeSig purescriptOperatorType
highlight def link purescriptOperatorFunction purescriptOperatorType
highlight def link purescriptOperatorType purescriptOperator

highlight def link purescriptConstructorDecl purescriptConstructor
highlight def link purescriptConstructor purescriptFunction

highlight def link purescriptTypeVar Identifier
highlight def link purescriptForall purescriptStatement

highlight def link purescriptChar String
highlight def link purescriptBacktick purescriptOperator
highlight def link purescriptString String
highlight def link purescriptMultilineString String

highlight def link purescriptLineComment purescriptComment
highlight def link purescriptBlockComment purescriptComment

" purescript general highlights
highlight def link purescriptClass purescriptKeyword
highlight def link purescriptClassName Type
highlight def link purescriptStructure purescriptKeyword
highlight def link purescriptKeyword Keyword
highlight def link purescriptStatement Statement
highlight def link purescriptLet Statement
highlight def link purescriptOperator Operator
highlight def link purescriptFunction Function
highlight def link purescriptType Type
highlight def link purescriptComment Comment

let b:current_syntax = "purescript"

endif
