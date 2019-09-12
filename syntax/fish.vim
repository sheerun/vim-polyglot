if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'fish') == -1

if exists('b:current_syntax')
    finish
endif

syntax case match

syntax keyword fishKeyword begin function end
syntax keyword fishConditional if else switch
syntax keyword fishRepeat while for in
syntax keyword fishLabel case

syntax match fishComment /#.*/
syntax match fishSpecial /\\$/
syntax match fishIdentifier /\$[[:alnum:]_]\+/
syntax region fishString start=/'/ skip=/\\'/ end=/'/
syntax region fishString start=/"/ skip=/\\"/ end=/"/ contains=fishIdentifier
syntax match fishCharacter /\v\\[abefnrtv *?~%#(){}\[\]<>&;"']|\\[xX][0-9a-f]{1,2}|\\o[0-7]{1,2}|\\u[0-9a-f]{1,4}|\\U[0-9a-f]{1,8}|\\c[a-z]/
syntax match fishStatement /\v;\s*\zs\k+>/
syntax match fishCommandSub /\v\(\s*\zs\k+>/

syntax region fishLineContinuation matchgroup=fishStatement
            \ start='\v^\s*\zs\k+>' skip='\\$' end='$'
            \ contains=fishSpecial,fishIdentifier,fishString,fishCharacter,fishStatement,fishCommandSub,fishComment

highlight default link fishKeyword Keyword
highlight default link fishConditional Conditional
highlight default link fishRepeat Repeat
highlight default link fishLabel Label
highlight default link fishComment Comment
highlight default link fishSpecial Special
highlight default link fishIdentifier Identifier
highlight default link fishString String
highlight default link fishCharacter Character
highlight default link fishStatement Statement
highlight default link fishCommandSub fishStatement

let b:current_syntax = 'fish'

endif
