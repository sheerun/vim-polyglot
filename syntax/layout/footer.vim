if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" highlight

hi link ngxComment Comment
hi link ngxVariable Identifier
hi link ngxVariableString PreProc
hi link ngxString String
hi link ngxLocationPath String
hi link ngxLocationNamedLoc Identifier

hi link ngxBoolean Boolean
hi link ngxRewriteFlag Boolean
hi link ngxDirectiveBlock Statement
hi link ngxDirectiveImportant Type
hi link ngxDirectiveControl Keyword
hi link ngxDirectiveError Constant
hi link ngxDirectiveDeprecated Error
hi link ngxDirective Identifier
hi link ngxDirectiveThirdParty Special

let b:current_syntax = "nginx"


endif
