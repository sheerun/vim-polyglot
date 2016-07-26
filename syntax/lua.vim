if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'lua') == -1
  
" Vim syntax file
" Language: Lua
" URL: https://github.com/tbastos/vim-lua

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'lua'
endif

syntax sync fromstart

" Clusters
syntax cluster luaBase contains=luaComment,luaCommentLong,luaConstant,luaNumber,luaString,luaStringLong,luaBuiltIn
syntax cluster luaExpr contains=@luaBase,luaTable,luaParen,luaBracket,luaSpecialTable,luaSpecialValue,luaOperator,luaEllipsis,luaComma,luaFunc,luaFuncCall,luaError
syntax cluster luaStat contains=@luaExpr,luaIfThen,luaBlock,luaLoop,luaGoto,luaLabel,luaLocal,luaStatement,luaSemiCol

syntax match luaNoise /\%(\.\|,\|:\|\;\)/

" Symbols
syntax region luaTable   transparent matchgroup=luaBraces   start="{" end="}" contains=@luaExpr fold
syntax region luaParen   transparent matchgroup=luaParens   start='(' end=')' contains=@luaExpr
syntax region luaBracket transparent matchgroup=luaBrackets start="\[" end="\]" contains=@luaExpr
syntax match  luaComma ","
syntax match  luaSemiCol ";"
syntax match  luaOperator "[#<>=~^&|*/%+-]\|\.\."
syntax match  luaEllipsis "\.\.\."

" Catch errors caused by unbalanced brackets and keywords
syntax match luaError ")"
syntax match luaError "}"
syntax match luaError "\]"
syntax match luaError "\<\%(end\|else\|elseif\|then\|until\)\>"

" Shebang at the start
syntax match luaComment "\%^#!.*"

" Comments
syntax keyword luaCommentTodo contained TODO FIXME XXX TBD
syntax match   luaComment "--.*$" contains=luaCommentTodo,luaDocTag,@Spell
syntax region  luaCommentLong matchgroup=luaCommentLongTag start="--\[\z(=*\)\[" end="\]\z1\]" contains=luaCommentTodo,luaDocTag,@Spell fold
syntax match   luaDocTag contained "\s@\k\+"

" Function calls
syntax match luaFuncCall /\k\+\%(\s*[{('"]\)\@=/

" Functions
syntax region luaFunc transparent matchgroup=luaFuncKeyword start="\<function\>" end="\<end\>" contains=@luaStat,luaFuncSig fold
syntax region luaFuncSig contained transparent start="\(\<function\>\)\@<=" end=")" contains=luaFuncId,luaFuncArgs keepend
syntax match luaFuncId contained "[^(]*(\@=" contains=luaFuncTable,luaFuncName
syntax match luaFuncTable contained /\k\+\%(\s*[.:]\)\@=/
syntax match luaFuncName contained "[^(.:]*(\@="
syntax region luaFuncArgs contained transparent matchgroup=luaFuncParens start=/(/ end=/)/ contains=@luaBase,luaFuncArgName,luaFuncArgComma,luaEllipsis
syntax match luaFuncArgName contained /\k\+/
syntax match luaFuncArgComma contained /,/

" if ... then
syntax region luaIfThen transparent matchgroup=luaCond start="\<if\>" end="\<then\>"me=e-4 contains=@luaExpr nextgroup=luaThenEnd skipwhite skipempty

" then ... end
syntax region luaThenEnd contained transparent matchgroup=luaCond start="\<then\>" end="\<end\>" contains=@luaStat,luaElseifThen,luaElse fold

" elseif ... then
syntax region luaElseifThen contained transparent matchgroup=luaCond start="\<elseif\>" end="\<then\>" contains=@luaExpr

" else
syntax keyword luaElse contained else

" do ... end
syntax region luaBlock transparent matchgroup=luaRepeat start="\<do\>" end="\<end\>" contains=@luaStat fold

" repeat ... until
syntax region luaLoop transparent matchgroup=luaRepeat start="\<repeat\>" end="\<until\>" contains=@luaStat nextgroup=@luaExpr fold

" while ... do
syntax region luaLoop transparent matchgroup=luaRepeat start="\<while\>" end="\<do\>"me=e-2 contains=@luaExpr nextgroup=luaBlock skipwhite skipempty fold

" for ... do and for ... in ... do
syntax region luaLoop transparent matchgroup=luaRepeat start="\<for\>" end="\<do\>"me=e-2 contains=@luaExpr,luaIn nextgroup=luaBlock skipwhite skipempty
syntax keyword luaIn contained in

" goto and labels
syntax keyword luaGoto goto nextgroup=luaGotoLabel skipwhite
syntax match luaGotoLabel "\k\+" contained
syntax match luaLabel "::\k\+::"

" Other Keywords
syntax keyword luaConstant nil true false
syntax keyword luaBuiltIn _ENV self
syntax keyword luaLocal local
syntax keyword luaOperator and or not
syntax keyword luaStatement break return

" Strings
syntax match  luaStringSpecial contained #\\[\\abfnrtvz'"]\|\\x[[:xdigit:]]\{2}\|\\[[:digit:]]\{,3}#
syntax region luaStringLong matchgroup=luaStringLongTag start="\[\z(=*\)\[" end="\]\z1\]" contains=@Spell
syntax region luaString  start=+'+ end=+'+ skip=+\\\\\|\\'+ contains=luaStringSpecial,@Spell
syntax region luaString  start=+"+ end=+"+ skip=+\\\\\|\\"+ contains=luaStringSpecial,@Spell

" Decimal constant
syntax match luaNumber "\<\d\+\>"
" Hex constant
syntax match luaNumber "\<0[xX][[:xdigit:].]\+\%([pP][-+]\=\d\+\)\=\>"
" Floating point constant, with dot, optional exponent
syntax match luaFloat  "\<\d\+\.\d*\%([eE][-+]\=\d\+\)\=\>"
" Floating point constant, starting with a dot, optional exponent
syntax match luaFloat  "\.\d\+\%([eE][-+]\=\d\+\)\=\>"
" Floating point constant, without dot, with exponent
syntax match luaFloat  "\<\d\+[eE][-+]\=\d\+\>"

" Special names from the Standard Library
syntax keyword luaSpecialTable
\ bit32
\ coroutine
\ debug
\ io
\ math
\ os
\ package
\ string
\ table
\ utf8

syntax keyword luaSpecialValue
\ _G
\ _VERSION
\ assert
\ collectgarbage
\ dofile
\ error
\ getfenv
\ getmetatable
\ ipairs
\ load
\ loadfile
\ loadstring
\ module
\ next
\ pairs
\ pcall
\ print
\ rawequal
\ rawget
\ rawlen
\ rawset
\ require
\ select
\ setfenv
\ setmetatable
\ tonumber
\ tostring
\ type
\ unpack
\ xpcall

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_lua_syn_inits")
  if version < 508
    let did_lua_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink luaParens           Noise
  HiLink luaBraces           Structure
  HiLink luaBrackets         Noise
  HiLink luaBuiltIn          Special
  HiLink luaComment          Comment
  HiLink luaCommentLong      luaComment
  HiLink luaCommentTodo      Todo
  HiLink luaCond             Conditional
  HiLink luaConstant         Boolean
  HiLink luaDocTag           Underlined
  HiLink luaEllipsis         StorageClass
  HiLink luaElse             Conditional
  HiLink luaError            Error
  HiLink luaFloat            Float
  HiLink luaFuncTable        Function
  HiLink luaFuncArgName      Noise
  HiLink luaFuncCall         PreProc
  HiLink luaFuncId           Function
  HiLink luaFuncKeyword      Type
  HiLink luaFuncName         Function
  HiLink luaFuncParens       Noise
  HiLink luaGoto             luaStatement
  HiLink luaGotoLabel        Noise
  HiLink luaIn               Repeat
  HiLink luaLabel            Label
  HiLink luaLocal            Type
  HiLink luaNumber           Number
  HiLink luaOperator         Operator
  HiLink luaRepeat           Repeat
  HiLink luaSemiCol          Delimiter
  HiLink luaSpecialTable     Special
  HiLink luaSpecialValue     PreProc
  HiLink luaStatement        Statement
  HiLink luaString           String
  HiLink luaStringLong       luaString
  HiLink luaStringSpecial    SpecialChar

  delcommand HiLink
end

let b:current_syntax = "lua"
if main_syntax == 'lua'
  unlet main_syntax
endif

endif
