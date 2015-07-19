if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  
" Vim syntax file
" Language:     JavaScript
" Maintainer:   Kao Wei-Ko(othree) <othree@gmail.com>
" Last Change:  2015-05-11
" Version:      1.5
" Changes:      Go to https://github.com/othree/yajs.vim for recent changes.
" Origin:       https://github.com/jelera/vim-javascript-syntax
" Credits:      Jose Elera Campana, Zhao Yi, Claudio Fleiner, Scott Shattuck 
"               (This file is based on their hard work), gumnos (From the #vim 
"               IRC Channel in Freenode)


" if exists("b:yajs_loaded")
  " finish
" else
  " let b:yajs_loaded = 1
" endif
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'javascript'
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_javascript_syn_inits")
  let did_javascript_hilink = 1
  if version < 508
    let did_javascript_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
else
  finish
endif

"Dollar sign is permitted anywhere in an identifier
setlocal iskeyword-=$
if &filetype =~ 'javascript'
  setlocal iskeyword+=$
  syntax cluster htmlJavaScript                 contains=TOP
endif

syntax sync fromstart

"Syntax coloring for Node.js shebang line
syntax match   shellbang "^#!.*node\>"
syntax match   shellbang "^#!.*iojs\>"

syntax match   javascriptOpSymbols            /:\ze\_[^+\-*/%\^=!<>&|?:]/ nextgroup=@javascriptStatement,javascriptCase skipwhite skipempty
syntax match   javascriptOpSymbols            /[+\-*/%\^=!<>&|?:]\+/ contains=javascriptOpSymbol nextgroup=@javascriptExpression skipwhite skipempty

"JavaScript comments
syntax keyword javascriptCommentTodo           contained TODO FIXME XXX TBD
syntax match   javascriptLineComment           "//.*" contains=@Spell,javascriptCommentTodo
syntax region  javascriptComment               start="/\*"  end="\*/" contains=@Spell,javascriptCommentTodo extend
syntax cluster javascriptComments              contains=javascriptDocComment,javascriptComment,javascriptLineComment

"JSDoc
syntax case ignore

syntax region  javascriptDocComment            start="/\*\*"  end="\*/" contains=javascriptDocNotation,javascriptCommentTodo,@Spell fold keepend
syntax match   javascriptDocNotation           contained / @/ nextgroup=javascriptDocTags

syntax keyword javascriptDocTags               contained constant constructor constructs function ignore inner private public readonly static
syntax keyword javascriptDocTags               contained const dict expose inheritDoc interface nosideeffects override protected struct
syntax keyword javascriptDocTags               contained example global

" syntax keyword javascriptDocTags               contained ngdoc nextgroup=javascriptDocNGDirective
syntax keyword javascriptDocTags               contained ngdoc scope priority animations
syntax keyword javascriptDocTags               contained ngdoc restrict methodOf propertyOf eventOf eventType nextgroup=javascriptDocParam skipwhite
syntax keyword javascriptDocNGDirective        contained overview service object function method property event directive filter inputType error

syntax keyword javascriptDocTags               contained abstract virtual access augments

syntax keyword javascriptDocTags               contained arguments callback lends memberOf name type kind link mixes mixin tutorial nextgroup=javascriptDocParam skipwhite
syntax keyword javascriptDocTags               contained variation nextgroup=javascriptDocNumParam skipwhite

syntax keyword javascriptDocTags               contained author class classdesc copyright default defaultvalue nextgroup=javascriptDocDesc skipwhite
syntax keyword javascriptDocTags               contained deprecated description external host nextgroup=javascriptDocDesc skipwhite
syntax keyword javascriptDocTags               contained file fileOverview overview namespace requires since version nextgroup=javascriptDocDesc skipwhite
syntax keyword javascriptDocTags               contained summary todo license preserve nextgroup=javascriptDocDesc skipwhite

syntax keyword javascriptDocTags               contained borrows exports nextgroup=javascriptDocA skipwhite
syntax keyword javascriptDocTags               contained param arg argument property prop module nextgroup=javascriptDocNamedParamType,javascriptDocParamName skipwhite
syntax keyword javascriptDocTags               contained type nextgroup=javascriptDocParamType skipwhite
syntax keyword javascriptDocTags               contained define enum extends implements this typedef nextgroup=javascriptDocParamType skipwhite
syntax keyword javascriptDocTags               contained return returns throws exception nextgroup=javascriptDocParamType,javascriptDocParamName skipwhite
syntax keyword javascriptDocTags               contained see nextgroup=javascriptDocRef skipwhite

"syntax for event firing
syntax keyword javascriptDocTags               contained emits fires nextgroup=javascriptDocEventRef skipwhite

syntax keyword javascriptDocTags               contained function func method nextgroup=javascriptDocName skipwhite
syntax match   javascriptDocName               contained /\h\w*/

syntax keyword javascriptDocTags               contained fires event nextgroup=javascriptDocEventRef skipwhite
syntax match   javascriptDocEventRef           contained /\h\w*#\(\h\w*\:\)\?\h\w*/

syntax match   javascriptDocNamedParamType     contained /{.\+}/ nextgroup=javascriptDocParamName skipwhite
syntax match   javascriptDocParamName          contained /\[\?[0-9a-zA-Z_\.]\+=\?[0-9a-zA-Z_\.]*\]\?/ nextgroup=javascriptDocDesc skipwhite
syntax match   javascriptDocParamType          contained /{.\+}/ nextgroup=javascriptDocDesc skipwhite
syntax match   javascriptDocA                  contained /\%(#\|\w\|\.\|:\|\/\)\+/ nextgroup=javascriptDocAs skipwhite
syntax match   javascriptDocAs                 contained /\s*as\s*/ nextgroup=javascriptDocB skipwhite
syntax match   javascriptDocB                  contained /\%(#\|\w\|\.\|:\|\/\)\+/
syntax match   javascriptDocParam              contained /\%(#\|\w\|\.\|:\|\/\|-\)\+/
syntax match   javascriptDocNumParam           contained /\d\+/
syntax match   javascriptDocRef                contained /\%(#\|\w\|\.\|:\|\/\)\+/
syntax region  javascriptDocLinkTag            contained matchgroup=javascriptDocLinkTag start=/{/ end=/}/ contains=javascriptDocTags

syntax cluster javascriptDocs                  contains=javascriptDocParamType,javascriptDocNamedParamType,javascriptDocParam

if main_syntax == "javascript"
  syntax sync clear
  syntax sync ccomment javascriptComment minlines=200
endif

syntax case match

syntax cluster javascriptAfterIdentifier       contains=javascriptDotNotation,javascriptFuncCallArg,javascriptComputedProperty,javascriptWSymbols,@javascriptSymbols

syntax match   javascriptIdentifierName        /\<[^=<>!?+\-*\/%|&,;:. ~@#`"'\[\]\(\)\{\}\^0-9][^=<>!?+\-*\/%|&,;:. ~@#`"'\[\]\(\)\{\}\^]*/ nextgroup=@javascriptAfterIdentifier contains=@_semantic

"Block VariableStatement EmptyStatement ExpressionStatement IfStatement IterationStatement ContinueStatement BreakStatement ReturnStatement WithStatement LabelledStatement SwitchStatement ThrowStatement TryStatement DebuggerStatement

syntax cluster javascriptStatement             contains=javascriptBlock,javascriptVariable,@javascriptExpression,javascriptConditional,javascriptRepeat,javascriptBranch,javascriptLabel,javascriptStatementKeyword,javascriptTry,javascriptDebugger

"Syntax in the JavaScript code
" syntax match   javascriptASCII                 contained /\\\d\d\d/
syntax region  javascriptTemplateSubstitution  contained matchgroup=javascriptTemplateSB start=/\${/ end=/}/ contains=javascriptTemplateSBlock,javascriptTemplateSString 
syntax region  javascriptTemplateSBlock        contained start=/{/ end=/}/ contains=javascriptTemplateSBlock,javascriptTemplateSString transparent
syntax region  javascriptTemplateSString       contained start=/\z(["']\)/  skip=/\\\\\|\\\z1\|\\\n/  end=/\z1\|$/ extend contains=javascriptTemplateSStringRB transparent
syntax match   javascriptTemplateSStringRB     /}/ contained 
syntax region  javascriptString                start=/\z(["']\)/  skip=/\\\\\|\\\z1\|\\\n/  end=/\z1\|$/ nextgroup=@javascriptSymbols skipwhite skipempty
syntax region  javascriptTemplate              start=/`/  skip=/\\\\\|\\`\|\n/  end=/`\|$/ contains=javascriptTemplateSubstitution nextgroup=@javascriptSymbols skipwhite skipempty
" syntax match   javascriptTemplateTag           /\k\+/ nextgroup=javascriptTemplate
syntax region  javascriptArray                 matchgroup=javascriptBraces start=/\[/ end=/]/ contains=@javascriptValue,javascriptForComprehension,@javascriptComments nextgroup=@javascriptSymbols,@javascriptComments skipwhite skipempty

syntax match   javascriptNumber                /\<0[bB][01]\+\>/ nextgroup=@javascriptSymbols skipwhite skipempty
syntax match   javascriptNumber                /\<0[oO][0-7]\+\>/ nextgroup=@javascriptSymbols skipwhite skipempty
syntax match   javascriptNumber                /\<0[xX][0-9a-fA-F]\+\>/ nextgroup=@javascriptSymbols skipwhite skipempty
syntax match   javascriptNumber                /[+-]\=\%(\d\+\.\d\+\|\d\+\|\.\d\+\)\%([eE][+-]\=\d\+\)\=\>/ nextgroup=@javascriptSymbols skipwhite skipempty

syntax cluster javascriptTypes                 contains=javascriptString,javascriptTemplate,javascriptRegexpString,javascriptNumber,javascriptBoolean,javascriptNull,javascriptArray
syntax cluster javascriptValue                 contains=@javascriptTypes,@javascriptExpression,javascriptFuncKeyword,javascriptClassKeyword,javascriptObjectLiteral,javascriptIdentifier,javascriptIdentifierName,javascriptOperator,@javascriptSymbols

syntax match   javascriptLabel                 /[a-zA-Z_$]\k*\_s*:/he=e-1 nextgroup=@javascriptValue,@javascriptStatement skipwhite skipempty
syntax match   javascriptObjectLabel           contained /\k\+\_s*:/he=e-1 contains=javascriptObjectLabelColon nextgroup=@javascriptValue,@javascriptStatement skipwhite skipempty
syntax match   javascriptObjectLabelColon      contained /:/ nextgroup=@javascriptValue,@javascriptStatement skipwhite skipempty
" syntax match   javascriptPropertyName          contained /"[^"]\+"\s*:/he=e-1 nextgroup=@javascriptValue skipwhite skipempty
" syntax match   javascriptPropertyName          contained /'[^']\+'\s*:/he=e-1 nextgroup=@javascriptValue skipwhite skipempty
syntax region  javascriptPropertyName          contained start=/\z(["']\)/  skip=/\\\\\|\\\z1\|\\\n/  end=/\z1\|$/ nextgroup=javascriptObjectLabelColon skipwhite skipempty
syntax region  javascriptComputedPropertyName  contained matchgroup=javascriptPropertyName start=/\[/rs=s+1 end=/]/ contains=@javascriptValue nextgroup=javascriptObjectLabelColon skipwhite skipempty
syntax region  javascriptComputedProperty      contained matchgroup=javascriptProperty start=/\[/rs=s+1 end=/]/ contains=@javascriptValue,@javascriptSymbols nextgroup=@javascriptAfterIdentifier skipwhite skipempty
" Value for object, statement for label statement

syntax cluster javascriptTemplates             contains=javascriptTemplate,javascriptTemplateSubstitution,javascriptTemplateSBlock,javascriptTemplateSString,javascriptTemplateSStringRB,javascriptTemplateSB
syntax cluster javascriptStrings               contains=javascriptProp,javascriptString,@javascriptTemplates,@javascriptComments,javascriptDocComment,javascriptRegexpString,javascriptPropertyName

"this

"JavaScript Prototype
syntax keyword javascriptPrototype             prototype

"Program Keywords
syntax keyword javascriptIdentifier            arguments this nextgroup=@javascriptAfterIdentifier
syntax keyword javascriptVariable              let var const
syntax keyword javascriptOperator              delete new instanceof typeof void in nextgroup=@javascriptValue,@javascriptTypes skipwhite skipempty
syntax keyword javascriptForOperator           contained in of
syntax keyword javascriptBoolean               true false nextgroup=@javascriptSymbols skipwhite skipempty
syntax keyword javascriptNull                  null undefined nextgroup=@javascriptSymbols skipwhite skipempty
syntax keyword javascriptMessage               alert confirm prompt status
syntax keyword javascriptGlobal                self top parent

"Statement Keywords
syntax keyword javascriptConditional           if else switch
syntax keyword javascriptConditionalElse       else
syntax keyword javascriptRepeat                do while for nextgroup=javascriptLoopParen skipwhite skipempty
syntax keyword javascriptBranch                break continue
syntax keyword javascriptCase                  case nextgroup=@javascriptTypes skipwhite
syntax keyword javascriptDefault               default
syntax keyword javascriptStatementKeyword      return with yield
syntax keyword javascriptReturn                return nextgroup=@javascriptValue skipwhite
syntax keyword javascriptYield                 yield

syntax keyword javascriptTry                   try
syntax keyword javascriptExceptions            catch throw finally
syntax keyword javascriptDebugger              debugger

syntax match   javascriptProp                  contained /[a-zA-Z_$][a-zA-Z0-9_$]*/ contains=@props,@_semantic transparent nextgroup=@javascriptAfterIdentifier
syntax match   javascriptMethod                contained /[a-zA-Z_$][a-zA-Z0-9_$]*\ze(/ contains=@props transparent nextgroup=javascriptFuncCallArg
syntax match   javascriptDotNotation           /\./ nextgroup=javascriptProp,javascriptMethod
syntax match   javascriptDotStyleNotation      /\.style\./ nextgroup=javascriptDOMStyle transparent

runtime syntax/yajs/javascript.vim
runtime syntax/yajs/es6-number.vim
runtime syntax/yajs/es6-string.vim
runtime syntax/yajs/es6-array.vim
runtime syntax/yajs/es6-object.vim
runtime syntax/yajs/es6-symbol.vim
runtime syntax/yajs/es6-function.vim
runtime syntax/yajs/es6-math.vim
runtime syntax/yajs/es6-date.vim
runtime syntax/yajs/es6-json.vim
runtime syntax/yajs/es6-regexp.vim
runtime syntax/yajs/es6-map.vim
runtime syntax/yajs/es6-set.vim
runtime syntax/yajs/es6-proxy.vim
runtime syntax/yajs/es6-promise.vim
runtime syntax/yajs/node.vim
runtime syntax/yajs/web.vim

let javascript_props = 1

runtime syntax/yajs/event.vim
syntax region  javascriptEventString           contained start=/\z(["']\)/  skip=/\\\\\|\\\z1\|\\\n/  end=/\z1\|$/ contains=javascriptASCII,@events

"Import
syntax region  javascriptImportDef             start=/import/ end=/;\|\n/ contains=javascriptImport,javascriptString,javascriptEndColons
syntax keyword javascriptImport                contained from as import
syntax keyword javascriptExport                export module

syntax region  javascriptBlock                 matchgroup=javascriptBraces start=/\([\^:]\s\*\)\=\zs{/ end=/}/ contains=@htmlJavaScript

syntax region  javascriptMethodDef             contained start=/\(\(\(set\|get\)\_s\+\)\?\)[a-zA-Z_$]\k*\_s*(/ end=/)/ contains=javascriptMethodAccessor,javascriptMethodName,javascriptFuncArg nextgroup=javascriptBlock skipwhite keepend
syntax region  javascriptMethodArgs            contained start=/(/ end=/)/ contains=javascriptFuncArg,@javascriptComments nextgroup=javascriptBlock skipwhite keepend
syntax match   javascriptMethodName            contained /[a-zA-Z_$]\k*/ nextgroup=javascriptMethodArgs skipwhite skipempty
syntax match   javascriptMethodAccessor        contained /\(set\|get\)\s\+\ze\k/ contains=javascriptMethodAccessorWords
syntax keyword javascriptMethodAccessorWords   contained get set
syntax region  javascriptMethodName            contained matchgroup=javascriptPropertyName start=/\[/ end=/]/ contains=@javascriptValue nextgroup=javascriptMethodArgs skipwhite skipempty

syntax keyword javascriptAsyncFuncKeyword      async await
" syntax keyword javascriptFuncKeyword           function nextgroup=javascriptFuncName,javascriptFuncArg skipwhite
syntax keyword javascriptFuncKeyword           function nextgroup=javascriptAsyncFunc,javascriptSyncFunc
syntax match   javascriptSyncFunc              contained // nextgroup=javascriptFuncName,javascriptFuncArg skipwhite skipempty
syntax match   javascriptAsyncFunc             contained /\s*\*\s*/ nextgroup=javascriptFuncName,javascriptFuncArg skipwhite skipempty
syntax match   javascriptFuncName              contained /[a-zA-Z_$]\k*/ nextgroup=javascriptFuncArg skipwhite
syntax match   javascriptFuncArg               contained /(\_[^()]*)/ contains=javascriptParens,javascriptFuncKeyword,javascriptFuncComma nextgroup=javascriptBlock skipwhite skipwhite skipempty
syntax match   javascriptFuncComma             contained /,/


"Class
syntax keyword javascriptClassKeyword          class nextgroup=javascriptClassName skipwhite
syntax keyword javascriptClassSuper            super
syntax match   javascriptClassName             contained /\k\+/ nextgroup=javascriptClassBlock,javascriptClassExtends skipwhite
syntax match   javascriptClassSuperName        contained /[a-zA-Z_$][a-zA-Z_$\[\]\.]*/ nextgroup=javascriptClassBlock skipwhite
syntax keyword javascriptClassExtends          contained extends nextgroup=javascriptClassSuperName skipwhite
syntax region  javascriptClassBlock            contained matchgroup=javascriptBraces start=/{/ end=/}/ contains=javascriptMethodName,javascriptMethodAccessor,javascriptClassStatic,@javascriptComments
syntax keyword javascriptClassStatic           contained static nextgroup=javascriptMethodName,javascriptMethodAccessor skipwhite


syntax keyword javascriptForComprehension      contained for nextgroup=javascriptForComprehensionTail skipwhite skipempty
syntax region  javascriptForComprehensionTail  contained matchgroup=javascriptParens start=/(/ end=/)/ contains=javascriptOfComprehension,@javascriptExpression nextgroup=javascriptForComprehension,javascriptIfComprehension,@javascriptExpression skipwhite skipempty
syntax keyword javascriptOfComprehension       contained of
syntax keyword javascriptIfComprehension       contained if nextgroup=javascriptIfComprehensionTail
syntax region  javascriptIfComprehensionTail   contained matchgroup=javascriptParens start=/(/ end=/)/ contains=javascriptExpression nextgroup=javascriptForComprehension,javascriptIfComprehension skipwhite skipempty

syntax region  javascriptObjectLiteral         contained matchgroup=javascriptBraces start=/{/ end=/}/ contains=@javascriptComments,javascriptObjectLabel,javascriptPropertyName,javascriptMethodDef,javascriptComputedPropertyName,@javascriptValue

" syntax match   javascriptBraces                /[\[\]]/
syntax match   javascriptParens                /[()]/
" syntax match   javascriptOpSymbols             /[^+\-*/%\^=!<>&|?]\@<=\(<\|>\|<=\|>=\|==\|!=\|===\|!==\|+\|-\|*\|%\|++\|--\|<<\|>>\|>>>\|&\||\|^\|!\|\~\|&&\|||\|?\|=\|+=\|-=\|*=\|%=\|<<=\|>>=\|>>>=\|&=\||=\|^=\|\/\|\/=\)\ze\_[^+\-*/%\^=!<>&|?]/ nextgroup=@javascriptExpression skipwhite
" syntax match   javascriptInvalidOp            contained /[+\-*/%\^=!<>&|?:]\+/ 
syntax match   javascriptOpSymbol              contained /\(<\|>\|<=\|>=\|==\|!=\|===\|!==\|+\|*\|%\|++\|--\|<<\|>>\|>>>\|&\||\|^\|!\|\~\|&&\|||\|?\|=\|+=\|-=\|*=\|%=\|<<=\|>>=\|>>>=\|&=\||=\|^=\|\/\|\/=\)\ze\_[^+\-*/%\^=!<>&|?:]/ nextgroup=javascriptInvalidOp skipwhite skipempty
syn region  htmlScriptTag     contained start=+<script+ end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent
syntax match   javascriptWOpSymbols            contained /\_s\+/ nextgroup=javascriptOpSymbols
syntax match   javascriptEndColons             /[;,]/
syntax match   javascriptLogicSymbols          /[^&|]\@<=\(&&\|||\)\ze\_[^&|]/ nextgroup=@javascriptExpression skipwhite skipempty
syntax cluster javascriptSymbols               contains=javascriptOpSymbols,javascriptLogicSymbols
syntax match   javascriptWSymbols              contained /\_s\+/ nextgroup=@javascriptSymbols

syntax region  javascriptRegexpString          start="\(^\|&\||\|=\|(\|{\|;\|:\|\[\|!\)\@<=\_s*/[^/*]"me=e-1 skip="\\\\\|[^\\]\@<=\\/" end="/[gimy]\{0,2\}" oneline

syntax cluster javascriptEventTypes            contains=javascriptEventString,javascriptTemplate,javascriptNumber,javascriptBoolean,javascriptNull
syntax cluster javascriptOps                   contains=javascriptOpSymbols,javascriptLogicSymbols,javascriptOperator
syntax region  javascriptParenExp              matchgroup=javascriptParens start=/(/ end=/)/ contains=@javascriptExpression nextgroup=@javascriptSymbols skipwhite skipempty
syntax cluster javascriptExpression            contains=javascriptArrowFuncDef,javascriptParenExp,@javascriptValue,javascriptObjectLiteral,javascriptFuncKeyword,javascriptYield,javascriptIdentifierName,javascriptRegexpString,@javascriptTypes,@javascriptOps,javascriptGlobal,jsxRegion
syntax cluster javascriptEventExpression       contains=javascriptArrowFuncDef,javascriptParenExp,@javascriptValue,javascriptObjectLiteral,javascriptFuncKeyword,javascriptIdentifierName,javascriptRegexpString,@javascriptEventTypes,@javascriptOps,javascriptGlobal,jsxRegion

syntax region  javascriptLoopParen             contained matchgroup=javascriptParens start=/(/ end=/)/ contains=javascriptVariable,javascriptForOperator,javascriptEndColons,@javascriptExpression nextgroup=javascriptBlock skipwhite skipempty

" syntax match   javascriptFuncCall              contained /[a-zA-Z]\k*\ze(/ nextgroup=javascriptFuncCallArg
syntax region  javascriptFuncCallArg           contained matchgroup=javascriptParens start=/(/ end=/)/ contains=@javascriptExpression,@javascriptComments nextgroup=@javascriptAfterIdentifier
syntax cluster javascriptSymbols               contains=javascriptOpSymbols,javascriptLogicSymbols
syntax match   javascriptWSymbols              contained /\_s\+/ nextgroup=@javascriptSymbols
syntax region  javascriptEventFuncCallArg      contained matchgroup=javascriptParens start=/(/ end=/)/ contains=@javascriptEventExpression,@javascriptComments

syntax match   javascriptArrowFuncDef          contained /([^)]*)\_s*=>/ contains=javascriptFuncArg,javascriptArrowFunc nextgroup=javascriptBlock skipwhite skipempty
syntax match   javascriptArrowFuncDef          contained /[a-zA-Z_$][a-zA-Z0-9_$]*\_s*=>/ contains=javascriptArrowFuncArg,javascriptArrowFunc nextgroup=javascriptBlock skipwhite skipempty
syntax match   javascriptArrowFunc             /=>/
syntax match   javascriptArrowFuncArg          contained /[a-zA-Z_$]\k*/

runtime syntax/semhl.vim

if exists("did_javascript_hilink")
  HiLink javascriptEndColons            Exception
  HiLink javascriptOpSymbols            Normal
  HiLink javascriptLogicSymbols         Boolean
  HiLink javascriptBraces               Function
  HiLink javascriptParens               Normal
  HiLink javascriptComment              Comment
  HiLink javascriptLineComment          Comment
  HiLink javascriptDocComment           Comment
  HiLink javascriptCommentTodo          Todo
  HiLink javascriptDocNotation          SpecialComment
  HiLink javascriptDocTags              SpecialComment
  HiLink javascriptDocNGParam           javascriptDocParam
  HiLink javascriptDocParam             Function
  HiLink javascriptDocNumParam          Function
  HiLink javascriptDocEventRef          Function
  HiLink javascriptDocNamedParamType    Type
  HiLink javascriptDocParamName         Type
  HiLink javascriptDocParamType         Type
  HiLink javascriptString               String
  HiLink javascriptTemplate             String
  HiLink javascriptEventString          String
  HiLink javascriptASCII                Label
  HiLink javascriptTemplateSubstitution Label
  " HiLink javascriptTemplateSBlock       Label
  " HiLink javascriptTemplateSString      Label
  HiLink javascriptTemplateSStringRB    javascriptTemplateSubstitution
  HiLink javascriptTemplateSB           javascriptTemplateSubstitution
  HiLink javascriptRegexpString         String
  HiLink javascriptGlobal               Constant
  HiLink javascriptCharacter            Character
  HiLink javascriptPrototype            Type
  HiLink javascriptConditional          Conditional
  HiLink javascriptConditionalElse      Conditional
  HiLink javascriptCase                 Conditional
  HiLink javascriptDefault              javascriptCase
  HiLink javascriptBranch               Conditional
  HiLink javascriptIdentifier           Structure
  HiLink javascriptVariable             Identifier
  HiLink javascriptRepeat               Repeat
  HiLink javascriptForComprehension     Repeat
  HiLink javascriptIfComprehension      Repeat
  HiLink javascriptOfComprehension      Repeat
  HiLink javascriptForOperator          Repeat
  HiLink javascriptStatementKeyword     Statement
  HiLink javascriptReturn               Statement
  HiLink javascriptYield                Statement
  HiLink javascriptMessage              Keyword
  HiLink javascriptOperator             Identifier
  " HiLink javascriptType                 Type
  HiLink javascriptNull                 Boolean
  HiLink javascriptNumber               Number
  HiLink javascriptBoolean              Boolean
  HiLink javascriptObjectLabel          javascriptLabel
  HiLink javascriptLabel                Label
  HiLink javascriptPropertyName         Label
  HiLink javascriptImport               Special
  HiLink javascriptExport               Special
  HiLink javascriptTry                  Special
  HiLink javascriptExceptions           Special

  HiLink javascriptMethodName           Function
  HiLink javascriptMethodAccessor       Operator

  HiLink javascriptAsyncFuncKeyword     Keyword
  HiLink javascriptFuncKeyword          Keyword
  HiLink javascriptAsyncFunc            Keyword
  HiLink javascriptArrowFunc            Type
  HiLink javascriptFuncName             Function
  HiLink javascriptFuncArg              Special
  HiLink javascriptArrowFuncArg         javascriptFuncArg
  HiLink javascriptFuncComma            Operator

  HiLink javascriptClassKeyword         Keyword
  HiLink javascriptClassExtends         Keyword
  HiLink javascriptClassName            Function
  HiLink javascriptClassSuperName       Function
  HiLink javascriptClassStatic          StorageClass
  HiLink javascriptClassSuper           keyword

  HiLink shellbang                      Comment

  highlight link javaScript             NONE

  delcommand HiLink
  unlet did_javascript_hilink
endif

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
  unlet main_syntax
endif


endif
