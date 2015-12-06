if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'swift') == -1
  
" File: swift.vim
" Author: Keith Smiley
" Description: Runtime files for Swift
" Last Modified: June 15, 2014

if exists("b:current_syntax")
  finish
endif

" Comments
" Shebang
syntax match swiftShebang "\v#!.*$"

" Comment contained keywords
syntax keyword swiftTodos contained TODO XXX FIXME NOTE
syntax keyword swiftMarker contained MARK
syntax match swiftDocString "\v^\s*-\s*parameter"hs=s+1 contained
syntax match swiftDocString "\v^\s*-\s*returns"hs=s+1 contained

" Literals
" Strings
syntax region swiftString start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=swiftInterpolatedWrapper
syntax region swiftInterpolatedWrapper start="\v[^\\]\\\(\s*" end="\v\s*\)" contained containedin=swiftString contains=swiftInterpolatedString
syntax match swiftInterpolatedString "\v\w+(\(\))?" contained containedin=swiftInterpolatedWrapper

" Numbers
syntax match swiftNumber "\v<\d+>"
syntax match swiftNumber "\v<(\d+_+)+\d+(\.\d+(_+\d+)*)?>"
syntax match swiftNumber "\v<\d+\.\d+>"
syntax match swiftNumber "\v<\d*\.?\d+([Ee]-?)?\d+>"
syntax match swiftNumber "\v<0x\x+([Pp]-?)?\x+>"
syntax match swiftNumber "\v<0b[01]+>"
syntax match swiftNumber "\v<0o\o+>"

" BOOLs
syntax keyword swiftBoolean
      \ true
      \ false


" Operators
syntax match swiftOperator "\v\~"
syntax match swiftOperator "\v\s+!"
syntax match swiftOperator "\v\%"
syntax match swiftOperator "\v\^"
syntax match swiftOperator "\v\&"
syntax match swiftOperator "\v\*"
syntax match swiftOperator "\v-"
syntax match swiftOperator "\v\+"
syntax match swiftOperator "\v\="
syntax match swiftOperator "\v\|"
syntax match swiftOperator "\v\/"
syntax match swiftOperator "\v\."
syntax match swiftOperator "\v\<"
syntax match swiftOperator "\v\>"
syntax match swiftOperator "\v\?\?"

" Methods/Functions
syntax match swiftMethod "\(\.\)\@<=\w\+\((\)\@="

" Swift closure arguments
syntax match swiftClosureArgument "\$\d\+\(\.\d\+\)\?"

syntax match swiftAvailability "\v((\*(\s*,\s*[a-zA-Z="0-9.]+)*)|(\w+\s+\d+(\.\d+(.\d+)?)?\s*,\s*)+\*)" contains=swiftString
syntax keyword swiftPlatforms OSX iOS watchOS OSXApplicationExtension iOSApplicationExtension contained containedin=swiftAvailability
syntax keyword swiftAvailabilityArg renamed unavailable introduced deprecated obsoleted message contained containedin=swiftAvailability

" Keywords {{{
syntax keyword swiftKeywords
      \ as
      \ atexit
      \ break
      \ case
      \ catch
      \ class
      \ continue
      \ convenience
      \ default
      \ defer
      \ deinit
      \ didSet
      \ do
      \ dynamic
      \ else
      \ extension
      \ fallthrough
      \ final
      \ for
      \ func
      \ get
      \ guard
      \ if
      \ import
      \ in
      \ indirect
      \ infix
      \ init
      \ inout
      \ internal
      \ is
      \ lazy
      \ let
      \ mutating
      \ nil
      \ nonmutating
      \ operator
      \ optional
      \ override
      \ postfix
      \ prefix
      \ private
      \ protocol
      \ public
      \ repeat
      \ required
      \ rethrows
      \ return
      \ self
      \ set
      \ static
      \ subscript
      \ super
      \ switch
      \ throw
      \ throws
      \ try
      \ typealias
      \ unowned
      \ var
      \ weak
      \ where
      \ while
      \ willSet
" }}}

" Names surrounded by backticks. This aren't limited to keywords because 1)
" Swift doesn't limit them to keywords and 2) I couldn't make the keywords not
" highlight at the same time
syntax region swiftEscapedReservedWord start="`" end="`" oneline

syntax keyword swiftAttributes
      \ @assignment
      \ @autoclosure
      \ @available
      \ @convention
      \ @exported
      \ @IBAction
      \ @IBDesignable
      \ @IBInspectable
      \ @IBOutlet
      \ @noescape
      \ @nonobjc
      \ @noreturn
      \ @NSApplicationMain
      \ @NSCopying
      \ @NSManaged
      \ @objc
      \ @testable
      \ @UIApplicationMain
      \ @warn_unused_result

syntax keyword swiftConditionStatement #available

syntax keyword swiftStructure
      \ struct
      \ enum

syntax region swiftTypeWrapper start="\v:\s*" skip="\s*,\s*$*\s*" end="$" contains=swiftString,swiftBoolean,swiftNumber,swiftType,swiftGenericsWrapper transparent
syntax region swiftGenericsWrapper start="\v\<" end="\v\>" contains=swiftType transparent oneline
syntax region swiftLiteralWrapper start="\v\=\s*" skip="\v[^\[\]]\(\)" end="\v(\[\]|\(\))" contains=swiftType,swiftString transparent oneline
syntax region swiftReturnWrapper start="\v-\>\s*" end="\v(\{|$)" contains=swiftType transparent oneline
syntax match swiftType "\v<\u\w*" contained containedin=swiftGenericsWrapper,swiftTypeWrapper,swiftLiteralWrapper,swiftGenericsWrapper

syntax keyword swiftImports import


" 'preprocesor' stuff
syntax keyword swiftPreprocessor
      \ #if
      \ #elseif
      \ #else
      \ #endif


" Comment patterns
syntax match swiftComment "\v\/\/.*$"
      \ contains=swiftTodos,swiftDocString,swiftMarker,@Spell oneline
syntax region swiftComment start="/\*" end="\*/"
      \ contains=swiftTodos,swiftDocString,swiftMarker,swiftComment,@Spell fold


" Set highlights
highlight default link swiftTodos Todo
highlight default link swiftDocString String
highlight default link swiftShebang Comment
highlight default link swiftComment Comment
highlight default link swiftMarker Comment

highlight default link swiftString String
highlight default link swiftInterpolatedWrapper Delimiter
highlight default link swiftNumber Number
highlight default link swiftBoolean Boolean

highlight default link swiftOperator Operator
highlight default link swiftKeywords Keyword
highlight default link swiftEscapedReservedWord Normal
highlight default link swiftClosureArgument Operator
highlight default link swiftAttributes PreProc
highlight default link swiftConditionStatement PreProc
highlight default link swiftStructure Structure
highlight default link swiftType Type
highlight default link swiftImports Include
highlight default link swiftPreprocessor PreProc
highlight default link swiftMethod Function

highlight default link swiftConditionStatement PreProc
highlight default link swiftAvailability Normal
highlight default link swiftAvailabilityArg Normal
highlight default link swiftPlatforms Keyword

" Force vim to sync at least x lines. This solves the multiline comment not
" being highlighted issue
syn sync minlines=100

let b:current_syntax = "swift"

endif
