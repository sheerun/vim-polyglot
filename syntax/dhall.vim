if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dhall') == -1

scriptencoding utf-8

if exists('b:current_syntax')
    finish
endif

syntax match dhallInterpolation "\v\$\{[^\}]*\}"
syntax keyword dhallTodo TODO FIXME
syntax match dhallBrackets "[<>|]"
syntax match dhallOperator "+\|*\|#"
syntax match dhallOperator "//\|⫽"
syntax match dhallOperator "/\\\|∧"
syntax match dhallOperator "//\\\\\|⩓"
syntax match dhallNumber "\v[0-9]"
syntax match dhallNumber "\v\+[0-9]"
syntax match dhallIndex "\v\@[0-9]+" contains=dhallNumber
syntax match dhallLambda "∀\|λ\|→\|->\|\\"
syntax match dhallType "\v[A-Z][a-z0-9A-Z_]*"
syntax match dhallSpecialLabel "\v`[A-Z][a-z]*`"
syntax match dhallLabel "\v[A-Z][a-z]*/[a-z_][A-Za-z0-9\.\-]*"
syntax match dhallLabel "\v[a-z_][A-Za-z0-9\-]*"
syntax match dhallType "\v[a-zA-Z]+\.[A-Z][a-z0-9A-Z_]*"
syntax match dhallParens "(\|)\|\[\|\]\|,"
syntax match dhallRecord "{\|}\|:"
syntax keyword dhallKeyword let in forall constructors if then else merge env as
syntax match dhallEsc +\\["\\abfnrtv$/]+
syntax match dhallSingleSpecial +'''+
syntax match dhallSingleSpecial +''${+
syntax match dhallComment '\v--.*$' contains=@Spell,dhallTodo
syntax region dhallMultilineComment start="{-" end="-}" contains=@Spell,dhallTodo,dhallMultilineComment
syntax match dhallUrl "https://[a-zA-Z0-9/.\-_\?\=\&]*"
syntax match dhallUrl "http://[a-zA-Z0-9/.\-_\?\=\&]*"
syntax match dhallUrl "/[a-zA-Z0-9/.\-_]*"
syntax match dhallUrl "\.\./[a-zA-Z0-9/.\-_]*"
syntax match dhallUrl "\./[a-zA-Z0-9/.\-_]*"
syntax region dhallString start=+''+ end=+''+ contains=@Spell,dhallInterpolation,dhallSingleSpecial
syntax region dhallString start=+"+ end=+"+ contains=dhallInterpolation,dhallEsc
syntax region dhallString start=+"/+ end=+"+ contains=dhallInterpolation,dhallEsc
syntax keyword dhallBool True False

highlight link dhallSingleSpecial Special
highlight link dhallIndex Special
highlight link dhallSpecialLabel Operator
highlight link dhallEsc Special
highlight link dhallInterpolation Special
highlight link dhallTodo Todo
highlight link dhallBrackets Operator
highlight link dhallBool Underlined
highlight link dhallUrl String
highlight link dhallOperator Operator
highlight link dhallNumber Number
highlight link dhallLambda Special
highlight link dhallString String
highlight link dhallLabel Identifier
highlight link dhallRecord Special
highlight link dhallKeyword Keyword
highlight link dhallType Structure
highlight link dhallParens Special
highlight link dhallComment Comment
highlight link dhallMultilineComment Comment

let b:current_syntax = 'dhall'

endif
