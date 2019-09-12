if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vbnet') == -1

" Vim syntax file
" Language:     VB.NET
" Maintainer:   Tim Pope <vim@rebelongto.us>
" Last Change:  2006 Apr 28
" Filenames:    *.vb
" $Id: vbnet.vim,v 1.7 2006/04/28 06:00:29 tpope Exp $

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" 2. Lexical Grammar
syn case ignore
syn sync linebreaks=2
" 2.1.4 Comments
syn keyword vbTodo contained    TODO FIXME XXX NOTE
syn region  vbnetComment start="\<REM\>" end="$" contains=vbnetTodo
syn region  vbnetComment start="'" end="$" contains=vbnetTodo
syn cluster vbnetComments contains=vbnetComment,vbnetXmlComment
" 2.3 Keywords
syn keyword vbnetKeywordError   EndIf GoSub Let Variant Wend
" Every possible keyword (Version 8).  Used for certain errors below
syn keyword vbnetKeywordError   AddHandler AddressOf Alias And AndAlso As Boolean ByRef Byte ByVal Call Case Catch CBool CByte CChar CDate CDec CDbl Char CInt Class CLng CObj Const Continue CSByte CShort CSng CStr CType CUInt CULng CUShort Date Decimal Declare Default Delegate Dim DirectCast Do Double Each Else ElseIf End EndIf Enum Erase Error Event Exit False Finally For Friend Function Get GetType Global GoSub GoTo Handles If Implements Imports In Inherits Integer Interface Is IsNot Let Lib Like Long Loop Me Mod Module MustInherit MustOverride MyBase MyClass Namespace Narrowing New Next Not Nothing NotInheritable NotOverridable Object Of On Operator Option Optional Or OrElse Overloads Overridable Overrides ParamArray Partial Private Property Protected Public RaiseEvent ReadOnly ReDim RemoveHandler Resume Return SByte Select Set Shadows Shared Short Single Static Step Stop String Structure Sub SyncLock Then Throw To True Try TryCast TypeOf Variant Wend UInteger ULong UShort Using When While Widening With WithEvents WriteOnly contained
syn match   vbnetIdentifier     "\[\h\w*\]"
syn cluster vbnetStrict         contains=vbnetIdentifier,vbnetKeywordError
" 2.4 Literals
syn keyword vbnetBoolean        False True
syn match   vbnetNumber         "[+-]\=\(&O[0-7]*\|&H\x\+\|\<\d\+\)[SIL]\=\>"
syn match   vbnetNumber         "[+-]\=\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[FRD]\=\>"
syn match   vbnetNumber         "[+-]\=\<\d\+[eE][-+]\=\d\+[FRD]\=\>"
syn match   vbnetNumber         "[+-]\=\<\d\+\([eE][-+]\=\d\+\)\=[FRD]\>"
syn region  vbnetString         start=+"+ end=+"+ end=+$+ skip=+""+
syn match   vbnetCharacter      +"\([^"]\|""\)"c+
" 2.4.6 Date literals
syn match   vbnetDate           "1\=\d\([-/]\)[123]\=\d\1\d\{3,4\}" contained
" For simplicity, require at least an hour and a minute in a time, and require
" minutes and seconds to be two digits
syn match   vbnetDate           "\<[12]\=\d:\d\d\(:\d\d\)\=\s*\([AP]M\)\=\>" contained
syn match   vbnetDate           "\<_$" contained
" Avoid matching #directives
syn region  vbnetDateGroup      matchgroup=vbnetDate start="\(\S\s*\)\@<=#" skip="\<_$" end="\(\S\s*\)\@<=#" end="$" contains=vbnetDate,@vbnetStrict
syn keyword vbnetConstant       Nothing
syn cluster vbnetLiterals       contains=vbnetBoolean,vbnetNumber,vbnetString,vbnetCharacter,vbnetDateGroup,vbnetConstant

" 3. Preprocessing Directives
syn region  vbnetPreCondit
            \ start="^\s*#\s*\(If\|ElseIf\|Else\|End\s\+If\)\>" skip="\<_$"
            \ end="$" contains=@vbnetComments keepend
"syn match      vbnetPreCondit "\(\s*#\s*\(Else\)\=If\>.*\)\@<=\<Then\>"
syn region  vbnetDefine     start="^\s*#\s*Const\>" skip="\<_$" end="$"
            \ contains=@vbnetComments keepend
syn region  vbnetInclude
            \ start="^\s*#\s*\(ExternalSource\|End\s\+ExternalSource\)\>"
            \ skip="\<_$" end="$" contains=@vbnetComments keepend
syn region  vbnetRegion matchgroup=vbnetPreProc start="^\s*#\s*Region\>" end="^\s*#\s*End\s\+Region\>" fold contains=TOP
syn cluster vbnetPreProc contains=vbnetPreCondit,vbnetDefine,vbnetInclude,vbnetRegion

" 4. General Concepts
syn keyword vbnetTypeAccess     Public Private Protected Friend contained
syn match   vbnetAccessModifier "\<\(Friend\|Private\|Protected\|Protected\s\+\Friend\|Public\)\>"
" This is from section 9 but must be here to lower the priority
syn match   vbnetModifier       "\<\(Shared\|Static\|ReadOnly\|WithEvents\|Shadows\)\>"

" 5. Attributes
"syn match   vbnetAttribute "<\(\s_\n\|[^<=>]\)\{-1,}>"
syn match   vbnetAttribute "<\s*\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\%(\s*([^()]*)\)\=\(\s*,\s*\%(_\n\s*\)\=\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\%(\s*([^()]*)\)\=\)\{-}\s*>"

" 6. Source Files and Namespaces
syn keyword vbnetImports        Imports
syn match   vbnetOption         "^\s*Option\s\+\(\(Explicit\|Strict\)\(\s\+On\|\s\+Off\)\=\|Compare\s\+\(Binary\|Text\)\)\s*$"
if ! exists("vbnet_no_code_folds")
    syn region   vbnetNamespaceBlock matchgroup=vbnetStorage start="\(\w\s*\)\@<!Namespace" end="\<End\s\+\Namespace\>" contains=TOP fold
else
    syn region   vbnetNamespaceBlock matchgroup=vbnetStorage start="\(\w\s*\)\@<!Namespace" end="\<End\s\+\Namespace\>" contains=TOP
endif

" 7. Types
" 7.2 Interface Implementation
syn keyword vbnetTypeImplementsKeyword Implements contained
syn match   vbnetTypeImplementsClause "\(^\|:\)\s*Implements\s\+\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\(\s*,\s*\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\)*" contains=vbnetTypeImplementsKeyword,@vbnetStrict contained skipwhite skipnl nextgroup=@vbnetTypeImplements
syn match   vbnetTypeImplementsComment "\s*\%('\|\<REM\>\).*$" contains=@vbnetComments,@vnetStrict contained skipwhite skipempty nextgroup=@vbnetTypeImplements
syn match   vbnetTypeImplementsPreProc "^\s*#.*$" contains=@vbnetPreProc,@vbnetStrict contained skipwhite skipempty nextgroup=@vbnetTypeImplements
syn cluster vbnetTypeImplements contains=vbnetTypeImplementsClause,vbnetTypeImplementsComment,vbnetTypeImplementsPreProc
" 7.3 Primitive Types
syn match   vbnetPossibleType   "\%(\<\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*" contained skipwhite nextgroup=vbnetGeneric
syn keyword vbnetBuiltinType    Boolean Byte Char Date Decimal Double Single Integer Long Object Short String skipwhite nextgroup=vbnetGeneric
syn match   vbnetSystemType    "\<System\.\(Boolean\|Byte\|SByte\|Char\|Decimal\|Double\|Single\|Int32\|UInt32\|Int64\|UInt64\|Int16\|UInt16\|Object\)\>" skipwhite nextgroup=vbnetGeneric
syn cluster vbnetType           contains=vbnetBuiltinType,vbnetSystemType
syn cluster vbnetAnyType        contains=@vbnetType,vbnetPossibleType
syn match   vbnetTypeSpecifier  "[a-zA-Z0-9]\@<=[\$%&#]"
syn match   vbnetTypeSpecifier  "[a-zA-Z0-9]\@<=!\([^a-zA-Z0-9]\|$\)"me=s+1
" 7.4 Enumerations
syn keyword vbnetEnumWords      Shadows Enum contained
syn cluster vbnetEnum           contains=vbnetTypeAccess,vbnetEnumWords,vbnetAsClause
syn match   vbnetEnumDeclaration "\<\(\w\+\s\+\)*\(\<End\>.*\)\@<!Enum\s\+\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\(\s\+As\s\+\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\)\=" contains=@vbnetEnum,@vbnetStrict containedin=vbnetEnumBlock
syn match   vbnetTypeEnd        "\<End\s\+Enum\>" containedin=vbnetEnumBlock
" 7.5 Classes
syn keyword vbnetClassWords     MustInherit NotInheritable Class contained
syn cluster vbnetClass          contains=vbnetTypeAccess,vbnetClassWords
syn match   vbnetClassGeneric   "\%(\w\s*\)\@<=(\s*Of\s\+[^)]*)" contained contains=vbnetGeneric,@vbnetStrict skipwhite skipempty nextgroup=@vbnetClassBase,@vbnetTypeImplements
syn match   vbnetClassDeclaration "\<\(\w\+\s\+\)*\(\<End\>.*\)\@<!Class\s\+\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*" contains=@vbnetClass,@vbnetStrict containedin=vbnetClassBlock skipwhite skipempty nextgroup=vbnetClassGeneric,@vbnetClassBase,@vbnetTypeImplements
syn match vbnetTypeEnd          "\<End\s\+Class\>" containedin=vbnetClassBlock
" 7.5.1 Class Base Specification
syn keyword vbnetInheritsKeyword Inherits contained
syn match   vbnetClassBase      "\(^\|:\)\s*Inherits\s\+\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*" contains=vbnetInheritsKeyword,@vbnetType,@vbnetStrict contained skipwhite skipempty nextgroup=@vbnetTypeImplements
syn match   vbnetClassBaseComment "\s*\%('\|\<REM\>\).*$" contains=@vbnetComments,@vbnetStrict contained skipwhite skipempty nextgroup=@vbnetClassBase,@vbnetTypeImplements
syn match   vbnetClassBasePreProc "^\s*#.*$" contains=@vbnetPreProc,@vbnetStrict contained skipwhite skipempty nextgroup=@vbnetClassBase,@vbnetTypeImplements
syn cluster vbnetClassBase      contains=vbnetClassBase,vbnetClassBaseComment,vbnetClassBasePreProc
" 7.6 Structures
syn keyword vbnetStructureWords Implements Structure contained
syn cluster vbnetStructure      contains=vbnetTypeAccess,vbnetStructureWords
syn match   vbnetStructureDeclaration "\<\(\w\+\s\+\)*\(\<End\>.*\)\@<!Structure\s\+\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*" contains=@vbnetStructure,@vbnetStrict containedin=vbnetStructureBlock skipwhite skipempty nextgroup=@vbnetTypeImplements
syn match   vbnetTypeEnd        "\<End\s\+Structure\>" containedin=vbnetStructureBlock
" 7.7 Modules
syn keyword vbnetModuleWords    Module contained
syn cluster vbnetModule         contains=vbnetTypeAccess,vbnetModuleWords
syn match   vbnetModuleDeclaration "\<\(\w\+\s\+\)*\(\<End\>.*\)\@<!Module\s\+\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*" contains=@vbnetModule,@vbnetStrict containedin=vbnetModuleBlock
syn match   vbnetTypeEnd        "\<End\s\+Module\>" containedin=vbnetModuleBlock
" 7.8 Interfaces
syn keyword vbnetInterfaceWords Shadows Inherits Interface contained
syn cluster vbnetInterface      contains=vbnetTypeAccess,vbnetInterfaceWords
syn match   vbnetInterfaceDeclaration "\<\(\w\+\s\+\)*\(\<End\>.*\)\@<!Interface\s\+\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*" contains=@vbnetInterface,@vbnetStrict containedin=vbnetInterfaceBlock skipwhite skipempty nextgroup=@vbnetInterfaceBase
syn match   vbnetTypeEnd        "\<End\s\+Interface\>" containedin=vbnetInterfaceBlock
" 7.8.1 Interface Inheritance
syn match   vbnetInterfaceBase  "\(^\|:\)\s*Inherits\s\+\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\(\s*,\s*\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\)*" contains=vbnetInheritsKeyword,@vbnetStrict contained skipwhite skipempty nextgroup=@vbnetInterfaceBase
syn match   vbnetInterfaceBaseComment "\s*\%('\|\<REM\>\).*$" contains=@vbnetComments,@vbnetStrict contained skipwhite skipempty nextgroup=@vbnetInterfaceBase
syn match   vbnetInterfaceBasePreProc "^\s*#.*$" contains=@vbnetPreProc,@vbnetStrict contained skipwhite skipempty nextgroup=@vbnetInterfaceBase
syn cluster vbnetInterfaceBase  contains=vbnetInterfaceBase,vbnetInterfaceBaseComment,vbnetInterfaceBasePreProc
" 7.10 Delegates
syn keyword vbnetStorage        Delegate

" 9. Type Members
" 9.1 Interface Method Implementation
syn keyword vbnetImplementsKeyword Implements contained
syn match   vbnetImplementsClause "\<Implements\s\+\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\(\s*,\s*\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\)*" contains=vbnetImplementsKeyword,@vbnetStrict contained
" 9.2 Methods
syn keyword vbnetProcedureWords Public Private Protected Friend Shadows Shared Overridable NotOverridable MustOverride Overrides Overloads Delegate contained
syn keyword vbnetSubWords       Sub New contained
syn keyword vbnetAsError        As contained
syn cluster vbnetSub            contains=vbnetProcedureWords,vbnetSubWords,vbnetParameter
syn keyword vbnetFunctionWords  Function contained
syn cluster vbnetFunction       contains=vbnetProcedureWords,vbnetFunctionWords,vbnetParameter
syn region  vbnetSubArguments   start="(" skip="([^)]*)\|\<_$" end=")" end="$" contains=vbnetParameter,vbnetAsClause,@vbnetLiterals,@vbnetStrict keepend skipwhite nextgroup=@vbnetHandlesOrImplements,vbnetAsError contained
syn match   vbnetSubDeclaration "\<\(\w\+\s\+\)*\(\<\(End\|Exit\)\>.*\)\@<!\<Sub\>\s\+\%(\h\w*\>\|\[\h\w*\]\)" contains=@vbnetSub,@vbnetStrict containedin=vbnetSubBlock skipwhite nextgroup=vbnetSubArguments,@vbnetHandlesOrImplements
syn match   vbnetProcedureEnd "\<End\s\+Sub\>" containedin=vbnetSubBlock
syn region  vbnetFunctionArguments  start="(" skip="([^)]*)\|\<_$" end=")" end="$" contains=vbnetParameter,vbnetAsClause,@vbnetLiterals,@vbnetStrict keepend skipwhite nextgroup=vbnetFunctionReturn,@vbnetHandlesOrImplements contained
syn match   vbnetFunctionReturn     "\<As\s\+[][(){}A-Za-z0-9_.]\+" contains=vbnetAsClause,@vbnetStrict skipwhite nextgroup=@vbnetHandlesOrImplements contained
syn match   vbnetFunctionDeclaration "\<\(\w\+\s\+\)*\(\<\(End\|Exit\)\>.*\)\@<!\<Function\>\s\+\%(\h\w*\>\|\[\h\w*\]\)" contains=@vbnetFunction,@vbnetStrict containedin=vbnetFunctionBlock skipwhite nextgroup=vbnetFunctionArguments,vbnetFunctionReturn,@vbnetHandlesOrImplements
syn match   vbnetProcedureEnd "\<End\s\+Function\>" containedin=vbnetFunctionBlock
" 9.2.2 External Method Declarations
syn keyword vbnetExternalProcedureWords Declare Ansi Unicode Auto Lib Alias contained
syn region  vbnetExternalSubArguments   start="(" skip="([^)]*)\|\<_$" end=")" end="$" contains=vbnetParameter,vbnetAsClause,@vbnetLiterals,@vbnetStrict keepend contained
syn match   vbnetExternalSubDeclaration #\<\(\w\+\s\+\)*\(\<\(End\|Exit\)\>.*\)\@<!Declare\(\s\+\%(Ansi\|Unicode\|Auto\)\)\=\s\+Sub\s\+\%(\h\w*\|\[\h\w*\]\)\s\+Lib\s\+"[^"]*"\(\s\+\<Alias\>\s\+"[^"]*"\)\=\s\+\(_\n\s*\)\=# contains=@vbnetSub,vbnetExternalProcedureWords,vbnetString,@vbnetStrict skipwhite nextgroup=vbnetExternalSubArguments
syn region  vbnetExternalFunctionArguments  start="(" skip="([^)]*)\|\<_$" end=")" end="$" contains=vbnetParameter,vbnetAsClause,@vbnetLiterals,@vbnetStrict keepend skipwhite nextgroup=vbnetAsClause contained
syn match   vbnetExternalFunctionDeclaration #\<\(\w\+\s\+\)*\(\<\(End\|Exit\)\>.*\)\@<!Declare\(\s\+\%(Ansi\|Unicode\|Auto\)\)\=\s\+Function\s\+\%(\h\w*\|\[\h\w*\]\)\s\+Lib\s\+"[^"]*"\(\s\+\<Alias\>\s\+"[^"]*"\)\=\s\+\(_\n\s*\)\=# contains=@vbnetFunction,vbnetExternalProcedureWords,vbnetString,@vbnetStrict skipwhite nextgroup=vbnetExternalFunctionArguments
" 9.2.5 Method Parameters
syn keyword vbnetParameter      ByVal ByRef Optional ParamArray contained
" 9.2.6 Event Handling
syn keyword vbnetHandlesKeyword Handles MyBase contained
syn match   vbnetHandlesClause  "\<Handles\s\+\h\w*\.\h\w*\(\s*,\s*\h\w*\.\h\w*\)*\>" contains=vbnetHandlesKeyword,@vbnetStrict contained
syn cluster vbnetHandlesOrImplements contains=vbnetHandlesClause,vbnetImplementsClause
" 9.4 Events
syn keyword vbnetEventWords     Public Private Protected Friend Shadows Shared Event contained
syn cluster vbnetEvent          contains=vbnetEventWords
syn region  vbnetEventArguments start="(" skip="([^)]*)\|\<_$" end=")" end="$" contains=vbnetParameter,vbnetAsClause,@vbnetLiterals,@vbnetStrict keepend skipwhite nextgroup=vbnetImplementsClause,vbnetAsError contained
syn match   vbnetEventDeclaration "\<\(\w\+\s\+\)*\(\<\(End\|Exit\)\>.*\)\@<!\<Event\>\s\+\%(\h\w*\>\|\[\h\w*\]\)" contains=@vbnetEvent,@vbnetStrict skipwhite nextgroup=vbnetEventArguments,vbnetImplementsClause
" 9.5 Constants
syn keyword vbnetStatement      Const
" 9.6 Instance and Shared Variables
syn keyword vbnetStatement      Dim
syn keyword vbnetAsClause       As skipwhite nextgroup=@vbnetAnyType,@vbnetStrict contained
syn keyword vbnetAsNewClause    As skipwhite nextgroup=vbnetNewClause,@vbnetAnyType,@vbnetStrict
"syn keyword vbnetVarMemberWords Public Private Protected Friend Shadows Shared ReadOnly WithEvents Dim As contained
"syn match vbnetVarMemberDef         "\<\(\(Public\|Private\|Protected\|Friend\|Shadows\|Shared\|ReadOnly\|WithEvents\|Dim\)\s\+\)\+\h\w*\(\s\+As\s\+\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\|[\$%&#!]\)\=\(\s*=\s*[^,]*\)\=\(\s*,\s*\h\w*\(\s\+As\s\+\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\|[\$%&#!]\)\=\)*" contains=vbnetVarMemberWords,vbnetAsClause,vbnetTypeSpecifier
" 9.7 Properties
syn keyword vbnetPropertyWords  Property Default ReadOnly WriteOnly contained
syn cluster vbnetProperty       contains=vbnetProcedureWords,vbnetPropertyWords,vbnetParameter
syn match   vbnetPropertyDeclaration "\<\(\w\+\s\+\)*\(\<\(End\|Exit\)\>.*\)\@<!\<Property\>\s\+\%(\h\w*\>\|\[\h\w*\]\)" contains=@vbnetProperty,@vbnetStrict containedin=vbnetReadWritePropertyBlock,vbnetReadOnlyPropertyBlock,vbnetWriteOnlyPropertyBlock skipwhite nextgroup=vbnetPropertyArguments,vbnetPropertyReturn,vbnetImplementsClause
syn region  vbnetPropertyArguments start="(" skip="([^)]*)\|\<_$" end=")" end="$" contains=vbnetParameter,vbnetAsClause,@vbnetLiterals,@vbnetStrict keepend skipwhite nextgroup=vbnetPropertyReturn,vbnetImplementsClause contained
syn match   vbnetPropertyReturn     "\<As\s\+\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\>" contains=vbnetAsClause,@vbnetStrict skipwhite nextgroup=vbnetImplementsClause contained
syn match   vbnetProcedureEnd "\<End\s\+Property\>" containedin=vbnetReadWritePropertyBlock,vbnetReadOnlyPropertyBlock,vbnetWriteOnlyPropertyBlock
syn keyword vbnetGetterWords    Get Public Protected Private Friend contained
syn cluster vbnetGetter         contains=vbnetGetterWords
syn match   vbnetGetterDeclaration  "\<\(\w\+\s\+\)*\(\<End\>.*\)\@<!\<Get\>" contains=@vbnetGetter,@vbnetStrict contained containedin=vbnetGetterBlock
syn keyword vbnetSetterWords    Set ByVal Public Protected Private Friend contained
syn cluster vbnetSetter         contains=vbnetSetterWords
syn match   vbnetSetterDeclaration  "\<\(\w\+\s\+\)*\(\<End\>.*\)\@<!\<Set\s*\(([^)]*)\)\=" contains=@vbnetSetter,vbnetAsClause,vbnetTypeSpecifier,@vbnetStrict contained containedin=vbnetSetterBlock

" 10. Statements
" 10.1 Blocks
syn match   vbnetLabel          "^\h\w*:"me=e-1
" 10.3 With Statement
syn match   vbnetStatement      "\<\(End\s\+\)\=With\>"
" 10.4 SyncLock Statement
syn match   vbnetStatement      "\<\(End\s\+\)\=SyncLock\>"
" 10.5 Event Statements
syn keyword vbnetEvent          AddHandler RemoveHandler RaiseEvent
syn keyword vbnetStatement      Call
" 10.8 Conditional Statements
syn keyword vbnetConditional    Then ElseIf Else
syn match   vbnetConditional    "\<\(End\s\+\)\=If\>"
syn match   vbnetConditional    "\<\(Select\(\s\+Case\)\|\(End\|Exit\)\s\+Select\)\>"
syn keyword vbnetLabel          Case
" 10.9 Loop Statements
syn keyword vbnetRepeat         To Step Each In Next Loop Until
syn match   vbnetRepeat         "\<\(End\s\+\|Exit\s\+\)\=While\>"
syn match   vbnetRepeat         "\<\(Exit\s\+\)\=\(Do\|For\)\>"
" 10.10 Exception-Handling Statements
syn keyword vbnetException      Catch When Finally Resume Throw
syn match   vbnetException      "\<\(On\s\+Error\|\(End\s\+\|Exit\s\+\)\=Try\)\>"
" 10.11 Branch Statements
syn keyword vbnetBranch         GoTo Stop Return
syn match   vbnetBranch         "\<Exit\s\+\(Sub\|Function\|Property\)\>"
" 10.12 Array-Handling Statements
syn keyword vbnetArrayHandler   Erase
syn match   vbnetArrayHandler   "\<ReDim\(\s\+Preserve\)\=\>"

" 11. Expressions
" 11.4.3 Instance Expressions
syn keyword vbnetStatement      Me MyBase MyClass
" 11.4.5 AddressOf Expressions
syn keyword vbnetStorage        AddressOf
" 11.10 New Expressions
syn keyword vbnetNewClause      New skipwhite nextgroup=@vbnetAnyType
" 11.11 Cast Expressions
syn keyword vbnetCast           CBool CByte CChar CDate CDbl CDec Char CInt CLng CObj CShort CSng CStr CType DirectCast
syn keyword vbnetOperator       And Or Not Xor Mod In Is Imp Eqv Like AndAlso OrElse GetType TypeOf

"
" Folding
"

if ! exists("vbnet_no_code_folds")
    "syn region   vbnetNamespaceBlock    start="\(\w\s*\)\@<!\<\(\w\+\s\+\)*\(\<End\>.*\)\@<!\<Namespace\>"rs=s end="\<\End\s\+Namespace\>"re=e contains=TOP fold
    syn region   vbnetEnumBlock         start="\(\w\s*\)\@<!\<\(\w\+\s\+\)*\(\<End\>.*\|\.\)\@<!\<Enum\s"rs=s matchgroup=vbnetEnumWords end="\<\End\s\+Enum\>" contains=vbnetEnumDeclaration,vbnetAttribute,@vbnetComments,@vbnetPreProc,@vbnetLiterals fold
    syn region   vbnetClassBlock        start="\(\w\s*\)\@<!\<\(\w\+\s\+\)*\(\<End\>.*\)\@<!\<Class\>"rs=s matchgroup=vbnetClassWords end="\<\End\s\+Class\>" contains=TOP fold
    syn region   vbnetStructureBlock    start="\(\w\s*\)\@<!\<\(\w\+\s\+\)*\(\<End\>.*\)\@<!\<Structure\>"rs=s matchgroup=vbnetStructureWords end="\<\End\s\+Structure\>" contains=TOP fold
    syn region   vbnetModuleBlock       start="\(\w\s*\)\@<!\<\(\w\+\s\+\)*\(\<End\>.*\)\@<!\<Module\>"rs=s matchgroup=vbnetModuleWords end="\<\End\s\+Module\>" contains=TOP fold
    syn region   vbnetInterfaceBlock    start="\(\w\s*\)\@<!\<\(\w\+\s\+\)*\(\<End\>.*\)\@<!\<Interface\>"rs=s matchgroup=vbnetInterfaceWords end="\<\End\s\+Interface\>" contains=vbnetInterfaceDeclaration,vbnetAttribute,@vbnetComments,@vbnetPreProc,vbnetSubDeclaration,vbnetFunctionDeclaration,vbnetPropertyDeclaration,vbnetEventDeclaration fold
    syn region  vbnetSubBlock           start="\(\w\s*\)\@<!\<\(\w\+\s\+\)*\(\<\(End\|Exit\|Declare\|MustOverride\|Delegate\)\>.*\)\@<!\<Sub\>"rs=s matchgroup=vbnetProcedure end="\<End\s\+Sub\>" contains=TOP fold
    syn region  vbnetFunctionBlock      start="\(\w\s*\)\@<!\<\(\w\+\s\+\)*\(\<\(End\|Exit\|Declare\|MustOverride\|Delegate\)\>.*\)\@<!\<Function\>"rs=s matchgroup=vbnetProcedure end="\<End\s\+Function\>" contains=TOP fold
    syn region  vbnetReadWritePropertyBlock start="\(\w\s*\)\@<!\<\(\w\+\s\+\)*\(\<\(End\|Exit\|ReadOnly\|WriteOnly\)\>.*\)\@<!\<Property\>"rs=s matchgroup=vbnetProcedure end="\<End\s\+Property\>" contains=vbnetPropertyDeclaration,vbnetGetterBlock,vbnetSetterBlock,@vbnetComments,@vbnetPreProc fold
    syn region  vbnetReadOnlyPropertyBlock  start="\(\w\s*\)\@<!\<\(.*\<ReadOnly\>\&\(\w\+\s\+\)*\)Property\>"rs=s matchgroup=vbnetProcedure end="\<End\s\+Property\>" contains=vbnetPropertyDeclaration,vbnetGetterBlock,vbnetSetterErrorBlock,@vbnetComments,@vbnetPreProc fold
    syn region  vbnetWriteOnlyPropertyBlock start="\(\w\s*\)\@<!\<\(.*\<WriteOnly\>\&\(\w\+\s\+\)*\)Property\>"rs=s matchgroup=vbnetProcedure end="\<End\s\+Property\>" contains=vbnetPropertyDeclaration,vbnetGetterErrorBlock,vbnetSetterBlock,@vbnetComments,@vbnetPreProc fold
    syn region vbnetGetterBlock  start="\(\w\s*\)\@<!\<\(\w\+\s\+\)*\(\<End\>.*\)\@<!\<Get\>"rs=s matchgroup=vbnetProcedure end="\<End\s\+Get\>" contains=TOP contained fold
    syn region vbnetSetterBlock  start="\(\w\s*\)\@<!\<\(\w\+\s\+\)*\(\<End\>.*\)\@<!\<Set\>"rs=s matchgroup=vbnetProcedure end="\<End\s\+Set\>" contains=TOP contained fold
    syn region vbnetGetterErrorBlock matchgroup=vbnetError start="\<Get\>" end="\<End\s\+Get\>" contains=TOP contained fold
    syn region vbnetSetterErrorBlock matchgroup=vbnetError start="\<Set\>" end="\<End\s\+Set\>" contains=TOP contained fold
else
    syn region  vbnetReadWritePropertyBlock start="\(\w\s*\)\@<!\<\(\w\+\s\+\)*\(\<\(End\|Exit\|ReadOnly\|WriteOnly\)\>.*\)\@<!\<Property\>"rs=s matchgroup=vbnetProcedure end="\<End\s\+Property\>" contains=vbnetPropertyDeclaration,vbnetGetterBlock,vbnetSetterBlock,@vbnetComments,@vbnetPreProc
    syn region  vbnetReadOnlyPropertyBlock  start="\(\w\s*\)\@<!\<\(.*\<ReadOnly\>\&\(\w\+\s\+\)*\)Property\>"rs=s matchgroup=vbnetProcedure end="\<End\s\+Property\>" contains=vbnetPropertyDeclaration,vbnetGetterBlock,vbnetSetterErrorBlock,@vbnetComments,@vbnetPreProc
    syn region  vbnetWriteOnlyPropertyBlock start="\(\w\s*\)\@<!\<\(.*\<WriteOnly\>\&\(\w\+\s\+\)*\)Property\>"rs=s matchgroup=vbnetProcedure end="\<End\s\+Property\>" contains=vbnetPropertyDeclaration,vbnetGetterErrorBlock,vbnetSetterBlock,@vbnetComments,@vbnetPreProc
    syn region vbnetGetterBlock  start="\(\w\s*\)\@<!\<\(\w\+\s\+\)*\(\<End\>.*\)\@<!\<Get\>"rs=s matchgroup=vbnetProcedure end="\<End\s\+Get\>" contains=TOP contained
    syn region vbnetSetterBlock  start="\(\w\s*\)\@<!\<\(\w\+\s\+\)*\(\<End\>.*\)\@<!\<Set\>"rs=s matchgroup=vbnetProcedure end="\<End\s\+Set\>" contains=TOP contained
    syn region vbnetGetterErrorBlock matchgroup=vbnetError start="\<Get\>" end="\<End\s\+Get\>" contains=TOP contained
    syn region vbnetSetterErrorBlock matchgroup=vbnetError start="\<Set\>" end="\<End\s\+Set\>" contains=TOP contained
endif

"let vbnet_v7 = 1
if ! exists("vbnet_v7")
    " 4.7 Type and Namespace Names
    syn keyword vbnetStatement          Global
    " 4.9 Generic Types and Methods
    syn keyword vbnetOfClause           Of skipwhite nextgroup=@vbnetAnyType contained
    syn match   vbnetGeneric            "(Of\s\+\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\(\s\+As\(\s\+\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\|\s*{\s*\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\(\s*,\s*\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\)*\s*}\)*\)\=)" contains=vbnetAsClause,vbnetOfClause,vbnetGenericTypeList,@vbnetStrict contained
    syn match   vbnetGenericTypeList    "{\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\(\s*,\s*\%(\h\w*\|\[\h\w*\]\)\%(\.\h\w*\|\.\[\h\w*\]\)*\)*}" contains=@vbnetType contained
    " 7.3 Primitive Types
    syn keyword vbnetBuiltinType        SByte UShort UInteger ULong
    " 7.11 Partial Types
    "syn keyword vbnetClassModifier      Partial
    syn keyword vbnetClassWords         Partial contained
    " 9.8 Operators
    "syn match   vbnetProcedure          "\<\(End\s\+\|Exit\s\+\)\=Operator\>"
    syn keyword vbnetOperatorWords Public Shared Operator Widening Narrowing ByVal IsTrue IsFalse CType contained
    "syn keyword vbnetParameter      ByVal contained
    syn match   vbnetOperatorDeclaration "\<\(.*\<Shared\>\&\(\w\+\s\+\)*\)\(\<\(End\|Exit\)\>.*\)\@<!\<Operator\>\s\+[A-Za-z&*+/\\^<=>-]*([^)]*)" contains=vbnetOperatorWords,vbnetAsClause,vbnetTypeSpecifier,@vbnetStrict containedin=vbnetOperatorBlock skipwhite nextgroup=vbnetAsClause
    syn match vbnetProcedureEnd "\<End\s\+Operator\>" containedin=vbnetOperatorBlock
    syn match   vbnetBranch         "\<Exit\s\+\(Operator\)\>"
    if ! exists("vbnet_no_code_folds")
        syn region  vbnetOperatorBlock start="\(^\|:\)\s*\zs\<\(\w\+\s\+\)*\(\<\(End\|Exit\)\>.*\)\@<!\<Operator\>"rs=s matchgroup=vbnetProcedure end="\<End\s\+Operator\>" contains=TOP fold
    endif
    " 10.9 Loop Statements
    syn match   vbnetRepeat             "\<Continue\s\+\(Do\|For\|While\)\>"
    " 10.13 Using Statement
    syn match   vbnetStatement          "\<\(End\s\+\)\=Using\>"
    " 11.5.3 Is Expressions
    syn keyword vbnetOperator           IsNot
    " 11.11 Cast Expressions
    syn keyword vbnetCast               CSByte CUShort CUInt CULng TryCast
    " 12. Documentation Comments
    syn match   vbnetXmlCommentLeader   +'''+    contained
    syn match   vbnetXmlComment         +'''.*$+ contains=vbnetXmlCommentLeader,@vbnetXml
    syn include @vbnetXml syntax/xml.vim
endif

if ! exists("vbnet_no_functions")
    " From the Microsoft.VisualBasic namespace.
    " Extracted from the Mono sources; let me know if I missed any.
    syn keyword vbnetMSConversion ErrorToString Fix Hex Int Oct Str Val
    syn keyword vbnetMSDateAndTime DateAdd DateDiff DatePart DateSerial DateValue Day Hour Minute Month MonthName Second TimeSerial TimeValue Weekday WeekdayName Year DatePart DateString Now TimeOfDay Timer TimeString Today
    syn keyword vbnetMSFileSystem ChDir ChDrive CurDir Dir EOF FileAttr FileClose FileCopy FileDateTime FileGet FileGetObject FileLen FileOpen FilePut FilePutObject FileWidth FreeFile GetAttr Input InputString Kill LineInput Loc Lock LOF MkDir Print PrintLine Rename Reset RmDir Seek SetAttr SPC TAB Unlock Write WriteLine
    syn keyword vbnetMSFinancial DDB FV IPmt IRR MIRR NPer NPV Pmt PPmt PV Rate SLN SYD
    syn keyword vbnetMSGlobals ScriptEngineBuildVersion ScriptEngineMajorVersion ScriptEngineMinorVersion ScriptEngine 
    syn keyword vbnetMSInformation Erl Err IsArray IsDate IsDBNull IsError IsNothing IsNumeric IsReference LBound QBColor RGB SystemTypeName TypeName UBound VarType VbTypeName
    syn keyword vbnetMSInteraction AppActivate Beep CallByName Choose Command CreateObject DeleteSetting Environ GetAllSettings GetObject GetSetting IIf InputBox MsgBox Partition SaveSetting Shell Switch
    syn keyword vbnetMSStrings Asc AscW Chr ChrW Filter Format FormatCurrency FormatDateTime FormatNumber FormatPercent GetChar InStr InStrRev Join LCase Left Len LSet LTrim Mid Replace Right RSet RTrim Space Split StrComp StrConv StrDup StrReverse Trim UCase
    syn keyword vbnetMSVBMath Randomize Rnd
    syn match   vbnetMSFunction "\<Microsoft\.VisualBasic\."
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_vbnet_syntax_inits")
    if version < 508
        let did_vbnet_syntax_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    " 2. Lexical Grammar
    HiLink vbnetTodo                    Todo
    HiLink xmlRegion                    vbnetXmlComment
    HiLink vbnetXmlCommentLeader        vbnetXmlComment
    HiLink vbnetXmlComment              vbnetComment
    HiLink vbnetComment                 Comment
    HiLink vbnetKeywordError            vbnetError
    HiLink vbnetAsError                 vbnetError
    HiLink vbnetError                   Error
    HiLink vbnetBoolean                 Boolean
    HiLink vbnetNumber                  Number
    HiLink vbnetCharacter               Character
    HiLink vbnetString                  String
    HiLink vbnetDate                    Constant
    HiLink vbnetConstant                Constant

    " 3. Preprocessing Directives
    HiLink vbnetPreCondit               PreCondit
    HiLink vbnetDefine                  Define
    HiLink vbnetInclude                 Include
    HiLink vbnetPreProc                 PreProc

    " 4. General Concepts
    HiLink vbnetTypeAccess              vbnetType
    HiLink vbnetAccessModifier          vbnetModifier

    " 5. Attributes
    HiLink vbnetAttribute               Special

    " 6. Source Files and Namespaces
    HiLink vbnetStorage                 vbnetStorageClass
    HiLink vbnetOption                  vbnetPreProc
    HiLink vbnetImports                 vbnetInclude

    " 7. Types
    HiLink vbnetTypeSpecifier           vbnetType
    HiLink vbnetBuiltinType             vbnetType
    HiLink vbnetSystemType              vbnetType
    HiLink vbnetType                    Type
    HiLink vbnetClassModifier           vbnetStorageClass
    HiLink vbnetEnumWords               vbnetStorageClass
    HiLink vbnetModuleWords             vbnetStorageClass
    HiLink vbnetClassWords              vbnetStorageClass
    HiLink vbnetStructureWords          vbnetStorageClass
    HiLink vbnetInterfaceWords          vbnetStorageClass
    HiLink vbnetTypeImplementsKeyword   vbnetStorageClass
    HiLink vbnetInheritsKeyword         vbnetStorageClass
    HiLink vbnetTypeEnd                 vbnetStorageClass
    HiLink vbnetStorageClass            StorageClass

    " 9. Type Members
    HiLink vbnetAsNewClause             vbnetAsClause
    HiLink vbnetAsClause                vbnetStorageClass
    HiLink vbnetOfClause                vbnetStorageClass
    HiLink vbnetProcedureEnd            Statement
    HiLink vbnetProcedure               Statement
    HiLink vbnetModifier                vbnetStorageClass
    HiLink vbnetPropertyWords           vbnetStatement
    HiLink vbnetGetterWords             vbnetStatement
    HiLink vbnetSetterWords             vbnetStatement
    HiLink vbnetExternalProcedureWords  vbnetStatement
    HiLink vbnetProcedureWords          vbnetStatement
    HiLink vbnetSubWords                vbnetStatement
    HiLink vbnetFunctionWords           vbnetStatement
    HiLink vbnetOperatorWords           vbnetStatement
    HiLink vbnetVarMemberWords          vbnetStatement
    HiLink vbnetHandlesKeyword          vbnetStatement
    HiLink vbnetImplementsKeyword       vbnetStatement
    HiLink vbnetEventWords              vbnetStatement

    " 10. Statements
    HiLink vbnetStatement               Statement
    HiLink vbnetLabel                   Label
    HiLink vbnetParameter               Keyword
    HiLink vbnetEvent                   vbnetStatement
    HiLink vbnetConditional             Conditional
    HiLink vbnetRepeat                  Repeat
    HiLink vbnetException               Exception
    HiLink vbnetBranch                  Keyword
    HiLink vbnetArrayHandler            Statement

    " 11. Expressions
    HiLink vbnetCast                    vbnetType
    HiLink vbnetOperator                Operator
    HiLink vbnetNewClause               Keyword

    " Functions
    HiLink vbnetMSConstants             vbnetMSFunction
    HiLink vbnetMSConversion            vbnetMSFunction
    HiLink vbnetMSDateAndTime           vbnetMSFunction
    HiLink vbnetMSFileSystem            vbnetMSFunction
    HiLink vbnetMSFinancial             vbnetMSFunction
    HiLink vbnetMSGlobals               vbnetMSFunction
    HiLink vbnetMSInformation           vbnetMSFunction
    HiLink vbnetMSInteraction           vbnetMSFunction
    HiLink vbnetMSStrings               vbnetMSFunction
    HiLink vbnetMSVBMath                vbnetMSFunction
    HiLink vbnetMSVBUtils               vbnetMSFunction
    HiLink vbnetMSFunction              Function

    delcommand HiLink
endif

let b:current_syntax = "vbnet"

" vim:set ft=vim sts=4 sw=4:

endif
