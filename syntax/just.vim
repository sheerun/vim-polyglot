if polyglot#init#is_disabled(expand('<sfile>:p'), 'just', 'syntax/just.vim')
  finish
endif

" Vim syntax file
" Language:	Justfile
" Maintainer:	Noah Bogart <noah.bogart@hey.com>
" URL:		https://github.com/NoahTheDuke/vim-just.git
" Last Change:	2021 May 19

if exists('b:current_syntax')
  finish
endif

let b:current_syntax = 'just'
syntax sync minlines=20 maxlines=200

syntax match justNoise ","

syntax match justComment "\v#.*$" contains=@Spell
syntax match justName "[a-zA-Z_][a-zA-Z0-9_-]*" contained
syntax match justFunction "[a-zA-Z_][a-zA-Z0-9_-]*" contained

syntax region justBacktick start=/`/ skip=/\./ end=/`/ contains=justInterpolation
syntax region justRawString start=/'/ skip=/\./ end=/'/ contains=justInterpolation
syntax region justString start=/"/ skip=/\./ end=/"/ contains=justInterpolation
syntax cluster justAllStrings contains=justBacktick,justRawString,justString

syntax match justAssignmentOperator ":=" contained

syntax match justParameterOperator "=" contained
syntax match justVariadicOperator "*\|+\|\$" contained
syntax match justParameter "\v\s\zs%(\*|\+|\$)?[a-zA-Z_][a-zA-Z0-9_-]*\ze\=?" contained contains=justVariadicOperator,justParameterOperator

syntax match justNextLine "\\\n\s*"
syntax match justRecipeAt "^@" contained
syntax match justRecipeColon "\v:" contained

syntax region justRecipe
      \ matchgroup=justRecipeBody start="\v^\@?[a-zA-Z_]((:\=)@!.)*\ze:%(\s|\n)"
      \ matchgroup=justRecipeDeps end="\v:\zs.*\n"
      \ contains=justFunction,justRecipeColon

syntax match justRecipeBody "\v^\@?[a-zA-Z_]((:\=)@!.)*\ze:%(\s|\n)"
      \ contains=justRecipeAt,justRecipeColon,justParameter,justParameterOperator,justVariadicOperator,@justAllStrings,justComment

syntax match justRecipeDeps "\v:[^\=]?.*\n"
      \ contains=justComment,justFunction,justRecipeColon

syntax match justBoolean "\v(true|false)" contained
syntax match justKeywords "\v%(export|set)" contained

syntax match justAssignment "\v^[a-zA-Z_][a-zA-Z0-9_-]*\s+:\=" transparent contains=justAssignmentOperator

syntax match justSetKeywords "\v%(dotenv-load|export|positional-arguments|shell)" contained
syntax match justSetDefinition "\v^set\s+%(dotenv-load|export|positional-arguments)%(\s+:\=\s+%(true|false))?$"
      \ contains=justSetKeywords,justKeywords,justAssignmentOperator,justBoolean
      \ transparent

syntax match justSetBraces "\v[\[\]]" contained
syntax region justSetDefinition
      \ start="\v^set\s+shell\s+:\=\s+\["
      \ end="]"
      \ contains=justSetKeywords,justKeywords,justAssignmentOperator,@justAllStrings,justNoise,justSetBraces
      \ transparent skipwhite oneline

syntax region justAlias
      \ matchgroup=justAlias start="\v^alias\ze\s+[a-zA-Z_][a-zA-Z0-9_-]*\s+:\="
      \ end="$"
      \ contains=justKeywords,justFunction,justAssignmentOperator
      \ oneline skipwhite

syntax region justExport
      \ matchgroup=justExport start="\v^export\ze\s+[a-zA-Z_][a-zA-Z0-9_-]*%(\s+:\=)?"
      \ end="$"
      \ contains=justKeywords,justAssignmentOperator
      \ transparent oneline skipwhite

syntax keyword justConditional if else
syntax region justConditionalBraces start="\v[^{]\{[^{]" end="}" contained oneline contains=ALLBUT,justConditionalBraces,justBodyText

syntax match justBodyText "[^[:space:]#]\+" contained
syntax match justLineLeadingSymbol "\v^\s+\zs%(\@|-)" contained
syntax match justLineContinuation "\\$" contained

syntax region justBody transparent matchgroup=justLineLeadingSymbol start="\v^\s+\zs[@-]"hs=e-1 matchgroup=justBodyText start="\v^\s+\zs[^[:space:]@#-]"hs=e-1 end="\n" skipwhite oneline contains=justInterpolation,justBodyText,justLineLeadingSymbol,justLineContinuation,justComment

syntax region justInterpolation start="{{" end="}}" contained contains=ALLBUT,justInterpolation,justFunction,justBodyText

syntax match justBuiltInFunctionParens "[()]" contained
syntax match justBuiltInFunctions "\v%(arch|os|os_family|invocation_directory|justfile|justfile_directory|just_executable)\ze\(\)" contains=justBuiltInFunctions
syntax region justBuiltInFunctions transparent matchgroup=justBuiltInFunctions start="\v%(env_var_or_default|env_var)\ze\(" end=")" oneline contains=@justAllStrings,justBuiltInFunctionParens,justNoise

syntax match justBuiltInFunctionsError "\v%(arch|os|os_family|invocation_directory|justfile|justfile_directory|just_executable)\(.+\)"

syntax match justOperator "\v%(\=\=|!\=|\+)"

highlight default link justAlias                 Keyword
highlight default link justAssignmentOperator    Operator
highlight default link justBacktick              String
highlight default link justBodyText              Constant
highlight default link justBoolean               Boolean
highlight default link justBuiltInFunctions      Function
highlight default link justBuiltInFunctionsError Error
highlight default link justBuiltInFunctionParens Delimiter
highlight default link justComment               Comment
highlight default link justConditional           Conditional
highlight default link justConditionalBraces     Delimiter
highlight default link justExport                Keyword
highlight default link justFunction              Function
highlight default link justInterpolation         Delimiter
highlight default link justKeywords              Keyword
highlight default link justLineContinuation      Special
highlight default link justLineLeadingSymbol     Special
highlight default link justName                  Identifier
highlight default link justNextLine              Special
highlight default link justOperator              Operator
highlight default link justParameter             Identifier
highlight default link justParameterOperator     Operator
highlight default link justRawString             String
highlight default link justRecipe                Function
highlight default link justRecipeAt              Special
highlight default link justRecipeBody            Function
highlight default link justRecipeColon           Operator
highlight default link justSetDefinition         Keyword
highlight default link justSetKeywords           Keyword
highlight default link justString                String
highlight default link justVariadicOperator      Operator
