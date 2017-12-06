if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'kotlin') == -1
  
" Vim syntax file
" Language: Kotlin
" Maintainer: Alexander Udalov
" Latest Revision: 23 November 2017

if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "kotlin"

syn keyword ktStatement break continue return
syn keyword ktConditional if else when
syn keyword ktRepeat do for while
syn keyword ktOperator as in is by
syn keyword ktKeyword get set out super this where
syn keyword ktException try catch finally throw

syn keyword ktInclude import package

syn keyword ktType Any Boolean Byte Char Double Float Int Long Nothing Short Unit
syn keyword ktModifier annotation companion enum inner internal private protected public abstract final open override sealed vararg dynamic header impl expect actual
syn keyword ktStructure class object interface typealias fun val var constructor init

syn keyword ktReservedKeyword typeof

syn keyword ktBoolean true false
syn keyword ktConstant null

syn keyword ktModifier data tailrec lateinit reified external inline noinline crossinline const operator infix suspend

syn keyword ktTodo TODO FIXME XXX contained
syn match ktShebang "\v^#!.*$"
syn match ktLineComment "\v//.*$" contains=ktTodo,@Spell
syn region ktComment matchgroup=ktCommentMatchGroup start="/\*" end="\*/" contains=ktComment,ktTodo,@Spell

syn match ktSpecialCharError "\v\\." contained
syn match ktSpecialChar "\v\\([tbnr'"$\\]|u\x{4})" contained
syn region ktString start='"' skip='\\"' end='"' contains=ktSimpleInterpolation,ktComplexInterpolation,ktSpecialChar,ktSpecialCharError
syn region ktString start='"""' end='""""*' contains=ktSimpleInterpolation,ktComplexInterpolation,ktSpecialChar,ktSpecialCharError
syn match ktCharacter "\v'[^']*'" contains=ktSpecialChar,ktSpecialCharError
syn match ktCharacter "\v'\\''" contains=ktSpecialChar
syn match ktCharacter "\v'[^\\]'"

" TODO: highlight label in 'this@Foo'
syn match ktAnnotation "\v(\w)@<!\@[[:alnum:]_.]*(:[[:alnum:]_.]*)?"
syn match ktLabel "\v\w+\@"

syn match ktSimpleInterpolation "\v\$\h\w*" contained
syn region ktComplexInterpolation matchgroup=ktComplexInterpolationBrace start="\v\$\{" end="\v\}" contains=ALLBUT,ktSimpleInterpolation

syn match ktNumber "\v<\d+[_[:digit:]]*[LFf]?"
syn match ktNumber "\v<0[Xx]\x+[_[:xdigit:]]*L?"
syn match ktNumber "\v<0[Bb][01]+[_01]*L?"
syn match ktFloat "\v<\d*(\d[eE][-+]?\d+|\.\d+([eE][-+]?\d+)?)[Ff]?"

syn match ktEscapedName "\v`.*`"

syn match ktExclExcl "!!"
syn match ktArrow "->"



hi link ktStatement Statement
hi link ktConditional Conditional
hi link ktRepeat Repeat
hi link ktOperator Operator
hi link ktKeyword Keyword
hi link ktException Exception
hi link ktReservedKeyword Error

hi link ktInclude Include

hi link ktType Type
hi link ktModifier StorageClass
hi link ktStructure Structure
hi link ktTypedef Typedef

hi link ktBoolean Boolean
hi link ktConstant Constant

hi link ktTodo Todo
hi link ktShebang Comment
hi link ktLineComment Comment
hi link ktComment Comment
hi link ktCommentMatchGroup Comment

hi link ktSpecialChar SpecialChar
hi link ktSpecialCharError Error
hi link ktString String
hi link ktCharacter Character

hi link ktAnnotation Identifier
hi link ktLabel Identifier

hi link ktSimpleInterpolation Identifier
hi link ktComplexInterpolationBrace Identifier

hi link ktNumber Number
hi link ktFloat Float

hi link ktExclExcl Special
hi link ktArrow Structure

endif
