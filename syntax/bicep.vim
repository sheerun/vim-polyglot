if polyglot#init#is_disabled(expand('<sfile>:p'), 'bicep', 'syntax/bicep.vim')
  finish
endif

if exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

if has('patch-7.4.1142')
    syn iskeyword a-z,A-Z,48-57,_,-
endif

syn case match


syn keyword bicepDataType  array bool int object string contained

syn keyword bicepStatement var module targetScope

syn keyword bicepStatement     param nextgroup=bicepParameterName skipwhite
syn match   bicepParameterName /\h\w*/ nextgroup=bicepDataType skipwhite contained

syn keyword bicepStatement  output nextgroup=bicepOutputName skipwhite
syn match   bicepOutputName /\h\w*/ nextgroup=bicepDataType skipwhite contained

syn keyword bicepStatement      resource nextgroup=bicepResourceName skipwhite
syn match   bicepResourceName   /\h\w*/ nextgroup=bicepResourceString skipwhite contained
syn region  bicepResourceString start=/'/ skip=/\\\\\|\\'/ end=/'/ contains=bicepStringInterp nextgroup=bicepExisting skipwhite
syn keyword bicepExisting       existing contained

syn match bicepDecoratorName /@\s*\h\%(\w\|\.\)*/ contains=bicepDecorator
syn match bicepDecorator     /@/ contained

syn region  bicepComment start="/\*" end="\*/" contains=bicepTodo,@Spell
syn region  bicepComment start="//" end="$" contains=bicepTodo,@Spell
syn keyword bicepTodo    TODO FIXME XXX BUG contained

syn keyword bicepValueBool true false
syn keyword bicepValueNull null
syn match   bicepValueDec  /\<[0-9]\+\([kKmMgG]b\?\)\?\>/

syn region bicepValueString  start=/'/ skip=/\\\\\|\\'/ end=/'/ contains=bicepStringInterp,bicepEscape
syn region bicepStringInterp start=/${/ end=/}/ contained
syn match  bicepEscape       /\\n/ contained
syn match  bicepEscape       /\\r/ contained

syn keyword bicepRepeat      for in
syn keyword bicepConditional if

syn match bicepBraces /[{}\[\]]/


hi def link bicepDataType          Type
hi def link bicepStatement         Statement
hi def link bicepResourceString    String
hi def link bicepExisting          Label

hi def link bicepDecorator         Define

hi def link bicepComment           Comment
hi def link bicepTodo              Todo

hi def link bicepValueBool         Boolean
hi def link bicepValueDec          Number
hi def link bicepValueNull         Constant

hi def link bicepValueString       String
hi def link bicepStringInterp      Identifier
hi def link bicepEscape            Special

hi def link bicepRepeat            Repeat
hi def link bicepConditional       Conditional

hi def link bicepBraces            Delimiter


let b:current_syntax = 'bicep'

let &cpoptions = s:cpo_save
unlet s:cpo_save
