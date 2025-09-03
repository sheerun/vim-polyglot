if polyglot#init#is_disabled(expand('<sfile>:p'), 'just', 'syntax/just.vim')
  finish
endif

" Vim syntax file
" Language:	Justfile
" Maintainer:	Noah Bogart <noah.bogart@hey.com>
" URL:		https://github.com/NoahTheDuke/vim-just.git
" Last Change:	2023 Aug 05

if exists('b:current_syntax')
  finish
endif

let b:current_syntax = 'just'
syn sync fromstart

syn match justNoise ","

syn match justComment "\v#%([^!].*)?$" contains=@Spell,justCommentTodo
syn keyword justCommentTodo TODO FIXME XXX contained
syn match justShebang "#!.*$" contains=justInterpolation
syn match justName "\h[a-zA-Z0-9_-]*" contained
syn match justFunction "\h[a-zA-Z0-9_-]*" contained

syn match justPreBodyComment "\v%(\s|\\\n)*#%([^!].*)?\n%(\t+| +)@=" transparent contained contains=justComment
      \ nextgroup=@justBodies skipnl
syn match justPreBodyCommentError "\v^%(%(\\\n)@3<!#|(\\\n)@3<!%( +\t+|\t+ +)#).*$" contained

syn region justBacktick start=/`/ end=/`/
syn region justBacktick start=/```/ end=/```/
syn region justRawString start=/'/ end=/'/
syn region justRawString start=/'''/ end=/'''/
syn region justString start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=justLineContinuation,justStringEscapeSequence
syn region justString start=/"""/ skip=/\\\\\|\\"/ end=/"""/ contains=justLineContinuation,justStringEscapeSequence
syn cluster justAllStrings contains=justBacktick,justRawString,justString

syn match justRegexReplacement /\v,%(\_s|\\\n)*%('\_[^']*'|'''%(\_.%(''')@!)*\_.?''')%(\_s|\\\n)*\)/me=e-1 transparent contained contains=@justExpr,@justStringsWithRegexCapture
syn match justRegexReplacement /\v,%(\_s|\\\n)*%("%(\_[^"]|\\")*"|"""%(\_.%(""")@!)*\_.?""")%(\_s|\\\n)*\)/me=e-1 transparent contained contains=@justExpr,@justStringsWithRegexCapture
syn region justRawStrRegexRepl start=/\v'/ end=/'/ contained contains=justRegexCapture
syn region justRawStrRegexRepl start=/\v'''/ end=/'''/ contained contains=justRegexCapture
syn region justStringRegexRepl start=/\v"/ skip=/\\\\\|\\"/ end=/"/ contained contains=justLineContinuation,justStringEscapeSequence,justRegexCapture
syn region justStringRegexRepl start=/\v"""/ skip=/\\\\\|\\"/ end=/"""/ contained contains=justLineContinuation,justStringEscapeSequence,justRegexCapture
syn match justRegexCapture '\v%(\$@1<!\$)@3<!\$%(\w+|\{\w+\})' contained
syn cluster justStringsWithRegexCapture contains=justRawStrRegexRepl,justStringRegexRepl

syn cluster justRawStrings contains=justRawString,justRawStrRegexRepl

syn region justStringInsideBody start=/\v\\@1<!'/ end=/'/ contained contains=justLineContinuation,justInterpolation,@justOtherCurlyBraces,justIndentError
syn region justStringInsideBody start=/\v\\@1<!"/ skip=/\v\\@1<!\\"/ end=/"/ contained contains=justLineContinuation,justInterpolation,@justOtherCurlyBraces,justIndentError
syn region justStringInShebangBody start=/\v\\@1<!'/ end=/'/ contained contains=justLineContinuation,justInterpolation,@justOtherCurlyBraces,justShebangIndentError
syn region justStringInShebangBody start=/\v\\@1<!"/ skip=/\v\\@1<!\\"/ end=/"/ contained contains=justLineContinuation,justInterpolation,@justOtherCurlyBraces,justShebangIndentError

syn match justStringEscapeSequence '\v\\[tnr"\\]' contained

syn match justAssignmentOperator ":=" contained

syn match justRecipeAt "^@" contained
syn match justRecipeColon ":" contained

syn match justRecipeAttr '^\v\[%(\s|\\\n)*%(no-%(cd|exit-message)|linux|macos|unix|windows|private)%(%(\s|\\\n)*,%(\s|\\\n)*%(no-%(cd|exit-message)|linux|macos|unix|windows|private))*%(\s|\\\n)*\]'

syn match justRecipeDeclSimple "\v^\@?\h[a-zA-Z0-9_-]*%(%(\s|\\\n)*:\=@!)@="
      \ transparent contains=justRecipeName
      \ nextgroup=justRecipeNoDeps,justRecipeDeps

syn region justRecipeDeclComplex start="\v^\@?\h[a-zA-Z0-9_-]*%(\s|\\\n)+%([+*$]+%(\s|\\\n)*)*\h" end="\v%(:\=@!)@=|$"
      \ transparent
      \ contains=justRecipeName,justParameter
      \ nextgroup=justRecipeNoDeps,justRecipeDeps

syn match justRecipeName "\v^\@?\h[a-zA-Z0-9_-]*" transparent contained contains=justRecipeAt,justFunction

syn match justParameter "\v%(\s|\\\n)@3<=%(%([*+]%(\s|\\\n)*)?%(\$%(\s|\\\n)*)?|\$%(\s|\\\n)*[*+]%(\s|\\\n)*)\h[a-zA-Z0-9_-]*"
      \ transparent contained
      \ contains=justName,justVariadicPrefix,justParamExport,justVariadicPrefixError
      \ nextgroup=justParamValue,justPreParamValue

syn match justPreParamValue '\v%(\s*\\\n)*' contained transparent nextgroup=justParamValue

syn region justParamValue contained transparent
      \ start="\v\s*\="
      \ skip="\\\n"
      \ end="\v%(\s|^)%([*+$:]|\h)@=|:@=|\)|$"
      \ contains=justParameterOperator,@justAllStrings,justRecipeParenDefault
      \ nextgroup=justParameterError
syn match justParamValue "\v%(\s|\\\n)*\=%(\s|\\\n)*\h[a-zA-Z0-9_-]*%(\s|\\\n)*" contained transparent
      \ contains=justParameterOperator
      \ nextgroup=justParameterError
syn match justParamValue "\v%(\s|\\\n)*\=%(\s|\\\n)*%(\w+%(\s|\\\n)*\()@=" contained transparent
      \ contains=justParameterOperator nextgroup=@justBuiltInFunctionsParamValue
syn match justParameterOperator "\V=" contained

syn match justVariadicPrefix "\v%(\s|\\\n)@3<=[*+]%(%(\s|\\\n)*\$?%(\s|\\\n)*\h)@=" contained
syn match justParamExport '\V$' contained
syn match justVariadicPrefixError "\v\$%(\s|\\\n)*[*+]" contained

syn match justParameterError "\v%(%([+*$]+%(\s|\\\n)*)*\h[a-zA-Z0-9_-]*)@>%(%(\s|\\\n)*\=)@!" contained

syn region justRecipeParenDefault
      \ matchgroup=justRecipeDepParamsParen start='\v%(\=%(\s|\\\n)*)@<=\(' end='\V)'
      \ contained
      \ contains=@justExpr,justParenInner
syn region justParenInner start='\V(' end='\V)' contained contains=justParenInner,@justExpr

syn match justRecipeSubsequentDeps '&&' contained

syn match justRecipeNoDeps '\v:%(\s|\\\n)*\n|:#@=|:%(\s|\\\n)+#@='
      \ transparent contained
      \ contains=justRecipeColon
      \ nextgroup=justPreBodyComment,justPreBodyCommentError,@justBodies
syn region justRecipeDeps start="\v:%(\s|\\\n)*%([a-zA-Z_(]|\&\&)" skip='\\\n' end="\v#@=|\\@1<!\n"
      \ transparent contained
      \ contains=justFunction,justRecipeColon,justRecipeSubsequentDeps,justRecipeParamDep
      \ nextgroup=justPreBodyComment,justPreBodyCommentError,@justBodies

syn region justRecipeParamDep contained transparent
      \ start="("
      \ matchgroup=justRecipeDepParamsParen end=")"
      \ contains=justRecipeDepParamsParen,@justExpr
syn match justRecipeDepParamsParen '\v\(%(\s|\\\n)*\h[a-zA-Z0-9_-]*' contained contains=justFunction

syn keyword justBoolean true false contained

syn match justAssignment "\v^\h[a-zA-Z0-9_-]*%(\s|\\\n)*:\=" transparent contains=justAssignmentOperator

syn match justSet '\v^set%(\s|\\\n)@=' contained
syn match justSetKeywords "allow-duplicate-recipes\|dotenv-load\|export\|fallback\|ignore-comments\|positional-arguments\|tempdir\|shell\|windows-shell" contained
syn match justSetDeprecatedKeywords 'windows-powershell' contained
syn match justBooleanSet "\v^set%(\s|\\\n)+%(allow-duplicate-recipes|dotenv-load|export|fallback|ignore-comments|positional-arguments|windows-powershell)%(%(\s|\\\n)*:\=%(\s|\\\n)*%(true|false))?$"
      \ contains=justSet,justSetKeywords,justSetDeprecatedKeywords,justAssignmentOperator,justBoolean
      \ transparent

syn match justStringSet '\v^set%(\s|\\\n)+%(tempdir)%(\s|\\\n)*:\=%(\s|\\\n)*%(['"])@=' transparent contains=justSet,justSetKeywords,justAssignmentOperator

syn region justShellSet
      \ start="\v^set%(\s|\\\n)+%(windows-)?shell%(\s|\\\n)*:\=%(\s|\\\n)*\["
      \ end="]"
      \ contains=justSet,justSetKeywords,justAssignmentOperator,justString,justRawString,justNoise,justSetError
      \ transparent skipwhite

syn match justSetError '\v%(%(\[|,)\_s*)@<=[^'"\][:space:]][^,\][:space:]]*|\[\_s*\]' contained

syn match justAlias '\v^alias%(\s|\\\n)@=' contained
syn match justAliasDecl "\v^alias%(\s|\\\n)+\h[a-zA-Z0-9_-]*%(\s|\\\n)*:\=%(\s|\\\n)*"
      \ transparent
      \ contains=justAlias,justFunction,justAssignmentOperator
      \ nextgroup=justAliasRes
syn match justAliasRes '\v\h[a-zA-Z0-9_-]*%(\s|\\\n)*%(#@=|$)' contained transparent contains=justFunction

syn match justExportedAssignment "\v^export%(\s|\\\n)+\h[a-zA-Z0-9_-]*\s*:\=" transparent
      \ contains=justExport,justAssignmentOperator

syn match justExport '\v^export%(\s|\\\n)@=' contained

syn keyword justConditional if else

syn match justLineLeadingSymbol "\v^%(\\\n)@3<!\s+\zs%(\@-|-\@|\@|-)"
syn match justLineContinuation "\\$" containedin=ALLBUT,justComment,justShebang,@justRawStrings,justBuiltInFunctionsError,justPreBodyCommentError

syn region justBody
      \ start=/\v^\z( +|\t+)%(#!)@!\S/
      \ skip='\\\n' end="\v\n\z1@!"
      \ contains=justInterpolation,@justOtherCurlyBraces,justLineLeadingSymbol,justLineContinuation,justComment,justStringInsideBody,justIndentError
      \ contained

syn region justShebangBody
      \ start="\v^\z( +|\t+)#!"
      \ skip='\\\n' end="\v\n\z1@!"
      \ contains=justInterpolation,@justOtherCurlyBraces,justLineContinuation,justComment,justShebang,justStringInShebangBody,justShebangIndentError
      \ contained

syn cluster justBodies contains=justBody,justShebangBody

syn match justIndentError '\v^%(\\\n)@3<!%( +\zs\t|\t+\zs )\s*'
syn match justShebangIndentError '\v^ +\zs\t\s*'

syn region justInterpolation
      \ matchgroup=justInterpolationDelim
      \ start="\v%(^\z(\s+)@>.*)@<=\{\{\{@!" end="\v%(%(\\\n\z1|\S)\s*)@<=\}\}|$"
      \ contained
      \ contains=justName,@justExprBase,@justBuiltInFunctionsInInterp

syn match justBadCurlyBraces '\v\{{3}\ze[^{]' contained
syn match justCurlyBraces '\v\{{4}' contained
syn match justBadCurlyBraces '\v\{{5}\ze[^{]' contained
syn cluster justOtherCurlyBraces contains=justCurlyBraces,justBadCurlyBraces

syn region justBuiltInFunction
      \ transparent end=')'
      \ matchgroup=justFunction start="\v%(a%(bsolute_pat|rc)h|c%(apitalize|lean)|e%(nv%(_var%(_or_default)?)?|xtension)|file_%(name|stem)|j%(oin|ust%(_executable|file%(_directory)?))|kebabcase|lowerca%(melca)?se|pa%(rent_directory|th_exists)|quote|replace|s%(h%(a256%(_file)?|outy%(kebab|snake)case)|nakecase)|t%(itlecase|rim%(_%(end|start)%(_match%(es)?)?)?)|u%(pperca%(melca)?se|uid)|without_extension|invocation_directory%(_native)?|num_cpus|os%(_family)?)%(%(\s|\\\n)*\()@="
      \ matchgroup=justUserDefinedError start="\verror%(%(\s|\\\n)*\()@="
      \ matchgroup=justBuiltInFunctionsError start="\v\h[a-zA-Z0-9_-]*%(\s|\\\n)*\("
      \ contains=justNoise,@justExpr

syn region justBuiltInFuncParamValue
      \ transparent end=')'
      \ matchgroup=justFunction start="\v%(a%(bsolute_pat|rc)h|c%(apitalize|lean)|e%(nv%(_var%(_or_default)?)?|xtension)|file_%(name|stem)|j%(oin|ust%(_executable|file%(_directory)?))|kebabcase|lowerca%(melca)?se|pa%(rent_directory|th_exists)|quote|replace|s%(h%(a256%(_file)?|outy%(kebab|snake)case)|nakecase)|t%(itlecase|rim%(_%(end|start)%(_match%(es)?)?)?)|u%(pperca%(melca)?se|uid)|without_extension|invocation_directory%(_native)?|num_cpus|os%(_family)?)%(%(\s|\\\n)*\()@="
      \ matchgroup=justUserDefinedError start="\verror%(%(\s|\\\n)*\()@="
      \ matchgroup=justBuiltInFunctionsError start="\v\h[a-zA-Z0-9_-]*%(\s|\\\n)*\("
      \ contained
      \ contains=justNoise,@justExpr
      \ nextgroup=justParameterError,justParameterLineContinuation

syn region justBuiltInFuncInInterp
      \ transparent end=')'
      \ matchgroup=justFunction start="\v%(a%(bsolute_pat|rc)h|c%(apitalize|lean)|e%(nv%(_var%(_or_default)?)?|xtension)|file_%(name|stem)|j%(oin|ust%(_executable|file%(_directory)?))|kebabcase|lowerca%(melca)?se|pa%(rent_directory|th_exists)|quote|replace|s%(h%(a256%(_file)?|outy%(kebab|snake)case)|nakecase)|t%(itlecase|rim%(_%(end|start)%(_match%(es)?)?)?)|u%(pperca%(melca)?se|uid)|without_extension|invocation_directory%(_native)?|num_cpus|os%(_family)?)%(%(\s|\\\n)*\()@="
      \ matchgroup=justUserDefinedError start="\verror%(%(\s|\\\n)*\()@="
      \ matchgroup=justBuiltInFunctionsError start="\v\h[a-zA-Z0-9_-]*%(\s|\\\n)*\("
      \ contained
      \ contains=justNoise,@justExprBase,@justBuiltInFunctionsInInterp,justName

syn region justReplaceRegex
      \ transparent end=')'
      \ matchgroup=justFunction start='\vreplace_regex%(%(\s|\\\n)*\()@='
      \ contains=justNoise,@justExpr,justRegexReplacement
syn region justReplaceRegexParamValue
      \ transparent end=')'
      \ matchgroup=justFunction start='\vreplace_regex%(%(\s|\\\n)*\()@='
      \ contained
      \ contains=justNoise,@justExpr,justRegexReplacement
      \ nextgroup=justParameterError,justParameterLineContinuation
syn region justReplaceRegexInInterp
      \ transparent end=')'
      \ matchgroup=justFunction start='\vreplace_regex%(%(\s|\\\n)*\()@='
      \ contained
      \ contains=justNoise,@justExprBase,justRegexReplacement,@justBuiltInFunctionsInInterp,justName

syn match justBuiltInFunctionsError "\v%(arch|invocation_directory%(_native)?|just%(_executable|file%(_directory)?)|num_cpus|os%(_family)?|uuid)%(\s|\\\n)*\(%(\_s|\\\n)*%(%([^)[:space:]\\]|\\\n@!)%(\_s|\\\n)*)+\)"
syn match justBuiltInFuncErrorParamValue "\v%(arch|invocation_directory%(_native)?|just%(_executable|file%(_directory)?)|num_cpus|os%(_family)?|uuid)%(\s|\\\n)*\(%(\_s|\\\n)*%(%([^)[:space:]\\]|\\\n@!)%(\_s|\\\n)*)+\)"
      \ contained nextgroup=justParameterError,justParameterLineContinuation

syn match justParameterLineContinuation '\v%(\s|\\\n)*' contained nextgroup=justParameterError

syn cluster justBuiltInFunctions contains=justBuiltInFunction,justReplaceRegex,justBuiltInFunctionsError
syn cluster justBuiltInFunctionsParamValue contains=justBuiltInFuncParamValue,justReplaceRegexParamValue,justBuiltInFuncErrorParamValue
syn cluster justBuiltInFunctionsInInterp contains=justBuiltInFuncInInterp,justReplaceRegexInInterp,justBuiltInFunctionsError

syn match justOperator "\v\=[=~]|!\=|[+/]"

syn cluster justExprBase contains=@justAllStrings,justConditional,justOperator
syn cluster justExpr contains=@justExprBase,@justBuiltInFunctions,justBuiltInFunctionArgs,justReplaceRegex

syn match justInclude "^!include\s\+.*$"

hi def link justAlias                 Statement
hi def link justAssignmentOperator    Operator
hi def link justBacktick              Special
hi def link justBadCurlyBraces        Error
hi def link justBody                  Number
hi def link justBoolean               Boolean
hi def link justBuiltInFunctionsError Error
hi def link justComment               Comment
hi def link justCommentTodo           Todo
hi def link justConditional           Conditional
hi def link justCurlyBraces           Special
hi def link justExport                Statement
hi def link justFunction              Function
hi def link justInclude               Include
hi def link justIndentError           Error
hi def link justInterpolation         Normal
hi def link justInterpolationDelim    Delimiter
hi def link justLineContinuation      Special
hi def link justLineLeadingSymbol     Special
hi def link justName                  Identifier
hi def link justOperator              Operator
hi def link justParameterError        Error
hi def link justParameterOperator     Operator
hi def link justParamExport           Statement
hi def link justPreBodyCommentError   Error
hi def link justRawString             String
hi def link justRawStrRegexRepl       String
hi def link justRecipeAt              Special
hi def link justRecipeAttr            Type
hi def link justRecipeColon           Operator
hi def link justRecipeDepParamsParen  Delimiter
hi def link justRecipeSubsequentDeps  Operator
hi def link justRegexCapture          Constant
hi def link justSet                   Statement
hi def link justSetDeprecatedKeywords Underlined
hi def link justSetError              Error
hi def link justSetKeywords           Keyword
hi def link justShebang               SpecialComment
hi def link justShebangBody           Number
hi def link justShebangIndentError    Error
hi def link justString                String
hi def link justStringEscapeSequence  Special
hi def link justStringInShebangBody   String
hi def link justStringInsideBody      String
hi def link justStringRegexRepl       String
hi def link justUserDefinedError      Exception
hi def link justVariadicPrefix        Statement
hi def link justVariadicPrefixError   Error
