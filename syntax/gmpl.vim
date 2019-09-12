if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'gmpl') == -1

" Vim syntax file
" Language: GMPL
" Maintainer: Mark Mba Wright
" Latest Revision: 9 July 2012

if exists("b:current_syntax")
  finish
endif

syn sync fromstart


syn match gmplArithmeticSetOperator "\.\."

" Integer with - + or nothing in front
syn match gmplNumber '\d\+'
syn match gmplNumber '[-+]\d\+'

" Floating point gmplNumber with decimal no E or e (+,-)
syn match gmplNumber '\d*\.\d\+'
syn match gmplNumber '[-+]\d*\.\d\+'

" Floating point like gmplNumber with E and no decimal point (+,-)
syn match gmplNumber '[-+]\=\d[[:digit:]]*[eE][\-+]\=\d\+'
syn match gmplNumber '\d[[:digit:]]*[eE][\-+]\=\d\+'

" Floating point like gmplNumber with E and decimal point (+,-)
syn match gmplNumber '[-+]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'
syn match gmplNumber '\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'
syn match gmplIndex   /\<\%(in\>\)\@!\w*/ contained contains=gmplKeyword,gmplNumber
syn match gmplLabel  '[a-zA-Z][a-zA-Z0-9_]*'
syn match gmplArithmeticOperator	"[-+]"
syn match gmplArithmeticOperator	"\.\=[*/\\^]"
syn match gmplRelationalOperator	"[=~]="
syn match gmplRelationalOperator	"[<>]=\="
" syn match gmplLogicalOperator		"[&|~]

" match indeces

" comments
syn match gmplComment /\/\*.\{-}\*\//
syn region gmplComment start="/\*"  end="\*/"
syn match gmplComment '#.\{-}$'

" strings
syn region gmplString start="\"" end="\""
syn region gmplString start="\'" end="\'" contains=gmplStringToken
syn match gmplStringToken '\%[a-z]' contained

" Keywords
syn keyword gmplKeyword and else by if cross in diff inter div less mod union not within or symdiff then 
syn keyword gmplKeyword minimize maximize solve
syn keyword gmplType set var param nextgroup=gmplLabel skipwhite

" Regions
syn region gmplIndexExpression start="{" end="}" transparent contains=gmplIndex,gmplIndexExpression
syn region gmplIndexGroup start="\[" end="\]" transparent contains=gmplIndex
" syn region gmplParen start="(" end=")"  

"" catch errors caused by wrong parenthesis
syn match   gmplParensError    ")\|}\|\]"
syn match   gmplParensErrA     contained "\]"
syn match   gmplParensErrC     contained "}"


hi level1c  ctermfg=brown       guifg=brown              
hi level2c  ctermfg=darkgreen   guifg=darkgreen   gui=bold
hi level3c  ctermfg=Darkblue    guifg=Darkblue            
hi level4c  ctermfg=darkmagenta guifg=darkmagenta gui=bold
hi level5c  ctermfg=darkcyan    guifg=darkcyan            
hi level6c  ctermfg=white       guifg=white       gui=bold
hi level7c  ctermfg=darkred     guifg=darkred
hi level8c  ctermfg=blue        guifg=blue        gui=bold 
hi level9c  ctermfg=darkgray    guifg=darkgray                 
hi level10c ctermfg=brown       guifg=brown       gui=bold 
hi level11c ctermfg=darkgreen   guifg=darkgreen         
hi level12c ctermfg=Darkblue    guifg=Darkblue    gui=bold 
hi level13c ctermfg=darkmagenta guifg=darkmagenta            
hi level14c ctermfg=darkcyan    guifg=darkcyan    gui=bold 
hi level15c ctermfg=gray       guifg=gray          

" These are the regions for each pair.
" This could be improved, perhaps, by makeing them match [ and { also,
" but I'm not going to take the time to figure out haw to make the
" end pattern match only the proper type.
syn region level1 matchgroup=level1c start=/(/ end=/)/ contains=TOP,level1,level2,level3,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, NoInParens
syn region level2 matchgroup=level2c start=/(/ end=/)/ contains=TOP,level2,level3,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, NoInParens
syn region level3 matchgroup=level3c start=/(/ end=/)/ contains=TOP,level3,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, NoInParens
syn region level4 matchgroup=level4c start=/(/ end=/)/ contains=TOP,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, NoInParens
syn region level5 matchgroup=level5c start=/(/ end=/)/ contains=TOP,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, NoInParens
syn region level6 matchgroup=level6c start=/(/ end=/)/ contains=TOP,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, NoInParens
syn region level7 matchgroup=level7c start=/(/ end=/)/ contains=TOP,level7,level8,level9,level10,level11,level12,level13,level14,level15, NoInParens
syn region level8 matchgroup=level8c start=/(/ end=/)/ contains=TOP,level8,level9,level10,level11,level12,level13,level14,level15, NoInParens
syn region level9 matchgroup=level9c start=/(/ end=/)/ contains=TOP,level9,level10,level11,level12,level13,level14,level15, NoInParens
syn region level10 matchgroup=level10c start=/(/ end=/)/ contains=TOP,level10,level11,level12,level13,level14,level15, NoInParens
syn region level11 matchgroup=level11c start=/(/ end=/)/ contains=TOP,level11,level12,level13,level14,level15, NoInParens
syn region level12 matchgroup=level12c start=/(/ end=/)/ contains=TOP,level12,level13,level14,level15, NoInParens
syn region level13 matchgroup=level13c start=/(/ end=/)/ contains=TOP,level13,level14,level15, NoInParens
syn region level14 matchgroup=level14c start=/(/ end=/)/ contains=TOP,level14,level15, NoInParens
syn region level15 matchgroup=level15c start=/(/ end=/)/ contains=TOP,level15, NoInParens

let b:current_syntax = "gmpl"

hi def link gmplKeyword Keyword
hi def link gmplParensError Error
hi def link gmplParensErrA Error
hi def link gmplParensErrB Error
hi def link gmplParensErrC Error
" hi def link gmplIndexExpression Label
" hi def link gmplParen Label
" hi def link gmplIndexGroup Label
hi def link gmplIndex Identifier
hi def link gmplNumber Number
hi def link gmplComment Comment
hi def link gmplType Type
hi def link gmplLabel Keyword
hi def link gmplString String
hi def link gmplStringToken Special 

endif
