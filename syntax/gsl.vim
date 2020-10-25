if has_key(g:polyglot_is_disabled, 'gdscript')
  finish
endif

" Syntax file for Godot Shading Language

if exists("b:current_syntax")
    finish
endif
let b:current_syntax = "gsl"

let s:save_cpo = &cpo
set cpo&vim

syn keyword gslConditional if else
syn keyword gslRepeat      for while
syn match   gslOperator    "\V&&\|||\|!\|&\|^\||\|~\|*\|/\|%\|+\|-\|=\|<\|>\|;"
syn match   gslDelimiter   "\V(\|)\|[\|]\|{\|}"
syn keyword gslStatement   return discard
syn keyword gslBoolean     true false

syn keyword gslKeyword shader_type render_mode varying flat noperspective smooth
                     \ uniform lowp mediump highp in out inout

syn keyword gslType void bool bvec2 bvec3 bvec4 int ivec2 ivec3 ivec4
                  \ uint uvec2 uvec3 uvec4 float vec2 vec3 vec4
                  \ mat2 mat3 mat4 sampler2D isampler2D usampler2D samplerCube

syn match   gslMember   "\v<(\.)@<=[a-z_]+\w*>"
syn match   gslConstant  "\v<[A-Z_]+[A-Z0-9_]*>"
syn match   gslFunction "\v<\w*>(\()@="

syn match   gslNumber   "\v<\d+(\.)@!>"
syn match   gslFloat    "\v<\d*\.\d+(\.)@!>"
syn match   gslFloat    "\v<\d*\.=\d+(e-=\d+)@="
syn match   gslExponent "\v(\d*\.=\d+)@<=e-=\d+>"

syn match   gslComment "\v//.*$"
syn region  gslComment start="/\*" end="\*/"
syn keyword gslTodo    TODO FIXME XXX NOTE BUG HACK OPTIMIZE containedin=gslComment

hi def link gslConditional Conditional
hi def link gslRepeat      Repeat
hi def link gslOperator    Operator
hi def link gslDelimiter   Delimiter
hi def link gslStatement   Statement
hi def link gslBoolean     Boolean

hi def link gslKeyword  Keyword
hi def link gslMember   Identifier
hi def link gslConstant Constant
hi def link gslFunction Function
hi def link gslType     Type

hi def link gslNumber   Number
hi def link gslFloat    Float
hi def link gslExponent Special

hi def link gslComment Comment
hi def link gslTodo    Todo

let &cpo = s:save_cpo
unlet s:save_cpo
