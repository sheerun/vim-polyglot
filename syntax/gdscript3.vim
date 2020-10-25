if has_key(g:polyglot_is_disabled, 'gdscript')
  finish
endif

" Syntax file for GDScript

if exists("b:current_syntax")
    finish
endif
let b:current_syntax = "gdscript3"

let s:save_cpo = &cpo
set cpo&vim

syn keyword gdConditional if elif else match
syn keyword gdRepeat      for while
syn keyword gdOperator    and or not is in
syn match   gdOperator    "\V&&\|||\|!\|&\|^\||\|~\|*\|/\|%\|+\|-\|=\|<\|>"
syn match   gdDelimiter   "\V(\|)\|[\|]\|{\|}"
syn keyword gdStatement   break continue pass return
syn keyword gdKeyword     extends tool signal self
                        \ const enum var onready export setget
syn match   gdKeyword     "\v^\s*((static\s*)=func|class)"
                        \ nextgroup=gdFunction skipwhite
syn keyword gdBoolean     true false

syn match   gdMember   "\v<(\.)@<=[a-z_]+\w*>"
syn match   gdFunction "\v<\w*>(\()@="
syn match   gdSignal "\v(<signal>\s+)@<=<\w+>"
syn match   gdSetGet "\v(<setget>\s+)@<=<\w+>"
syn match   gdSetGet "\v(<setget>\s+\w*\s*,\s*)@<=<\w+>"

syn keyword gdNull      null
syn keyword gdClass     int float bool
syn match   gdClass     "\v<\u\w+>"
syn match   gdConstant  "\v<[A-Z_]+[A-Z0-9_]*>"
syn keyword gdClass     AABB IP JSON OS RID
syn match   gdNode      "\v\$\a+\w*"

syn region  gdString      start='\v\"' end='\v\"'
syn region  gdString      start='\v\'' end='\v\''
syn match   gdEscapeError "\v\\."              containedin=gdString
syn match   gdEscapeError "\v\\u.{,3}"         containedin=gdString
syn match   gdEscape      "\v\\[abfnrtv\\'"]"  containedin=gdString
syn match   gdEscape      "\v\\u[0-9]{4}"      containedin=gdString

syn match   gdFormat "\v\%\%" containedin=gdString
syn match   gdFormat "\v\%[+-]=(\d*|\*)=\.=(\d*|\*)=[scdoxXf]" containedin=gdString

syn match   gdNumber      "\v<\d+(\.)@!>"
syn match   gdNumber      "\v<0x\x+(\.)@!>"
syn match   gdFloat       "\v<\d*\.\d+(\.)@!>"
syn match   gdFloat       "\v<\d*\.=\d+(e-=\d+)@="
syn match   gdExponent    "\v(\d*\.=\d+)@<=e-=\d+>"

syn match   gdComment "\v#.*$"
syn keyword gdTodo    TODO FIXME XXX NOTE BUG HACK OPTIMIZE containedin=gdComment

syn region gdFunctionFold
  \ start="\v^\z(\s*)%(%(static\s+)=func|class)>"
  \ end="\v\ze%(\s*\n)+%(\z1\s)@!."
  \ fold transparent

syn region gdFold
  \ matchgroup=gdComment
  \ start='#.*{{{.*$'
  \ end='#.*}}}.*$'
  \ fold transparent

hi def link gdConditional Conditional
hi def link gdRepeat      Repeat
hi def link gdOperator    Operator
hi def link gdDelimiter   Delimiter
hi def link gdStatement   Statement
hi def link gdKeyword     Keyword
hi def link gdBoolean     Boolean

hi def link gdMember   Identifier
hi def link gdFunction Function
hi def link gdSignal   Function
hi def link gdSetGet   Function

hi def link gdNull     Constant
hi def link gdClass    Type
hi def link gdConstant Constant
hi def link gdNode     Identifier

hi def link gdString   String
hi def link gdEscape   Special
hi def link gdFormat   Special
hi def link gdNumber   Number
hi def link gdFloat    Float
hi def link gdExponent Special

hi def link gdEscapeError Error

hi def link gdComment Comment
hi def link gdTodo    Todo

let &cpo = s:save_cpo
unlet s:save_cpo
