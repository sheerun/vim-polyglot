if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'applescript') == -1

" Vim syntax file
" Language:    AppleScript
" Maintainer:  Jim Eberle <jim.eberle@fastnlight.com>
" Last Change: Mar 18, 2010
" URL:         http://www.fastnlight.com/syntax/applescript.vim

" Use :syn w/in a buffer to see language element breakdown

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" --- Statement ---
syn keyword scptStmt get set count copy run global local prop property
syn keyword scptStmt close put delete duplicate exists
syn keyword scptStmt launch open print quit make move reopen save
syn keyword scptStmt saving into
hi def link scptStmt Statement

" --- Type ---
syn keyword scptType text string number integer real color date
hi def link scptType Type

" --- Operator ---
syn keyword scptOp div mod not and or as
syn match   scptOp "[-+*/^&]"
" MacRoman single char :- (divide)
exec 'syn match scptOp "'.nr2char(214).'"'
syn match scptOp "\<\(a \)\?\(ref\( to\)\?\|reference to\)\>"
hi def link scptOp Operator

" Containment
syn match   scptIN "\<starts\? with\>"
syn match   scptIN "\<begins\? with\>"
syn match   scptIN "\<ends\? with\>"
syn match   scptIN "\<contains\>"
syn match   scptIN "\<does not contain\>"
syn match   scptIN "\<doesn't contain\>"
syn match   scptIN "\<is in\>"
syn match   scptIN "\<is contained by\>"
syn match   scptIN "\<is not in\>"
syn match   scptIN "\<is not contained by\>"
syn match   scptIN "\<isn't contained by\>"
hi def link scptIN scptOp

" Equals
syn match   scptEQ "="
syn match   scptEQ "\<equal\>"
syn match   scptEQ "\<equals\>"
syn match   scptEQ "\<equal to\>"
syn match   scptEQ "\<is\>"
syn match   scptEQ "\<is equal to\>"
hi def link scptEQ scptOp

" Not Equals
syn match   scptNE "\<does not equal\>"
syn match   scptNE "\<doesn't equal\>"
syn match   scptNE "\<is not\>"
syn match   scptNE "\<is not equal\( to\)\?\>"
syn match   scptNE "\<isn't\>"
syn match   scptNE "\<isn't equal\( to\)\?\>"
hi def link scptNE scptOp
" MacRoman single char /=
exec 'syn match scptNE "'.nr2char(173).'"'

" Less Than
syn match   scptLT "<"
syn match   scptLT "\<comes before\>"
syn match   scptLT "\(is \)\?less than"
syn match   scptLT "\<is not greater than or equal\( to\)\?\>"
syn match   scptLT "\<isn't greater than or equal\( to\)\?\>"
hi def link scptLT scptOp

" Greater Than
syn match   scptGT ">"
syn match   scptGT "\<comes after\>"
syn match   scptGT "\(is \)\?greater than"
syn match   scptGT "\<is not less than or equal\( to\)\?\>"
syn match   scptGT "\<isn't less than or equal\( to\)\?\>"
hi def link scptGT scptOp

" Less Than or Equals
syn match   scptLE "<="
syn match   scptLE "\<does not come after\>"
syn match   scptLE "\<doesn't come after\>"
syn match   scptLE "\(is \)\?less than or equal\( to\)\?"
syn match   scptLE "\<is not greater than\>"
syn match   scptLE "\<isn't greater than\>"
hi def link scptLE scptOp
" MacRoman single char <=
exec 'syn match scptLE "'.nr2char(178).'"'

" Greater Than or Equals
syn match   scptGE ">="
syn match   scptGE "\<does not come before\>"
syn match   scptGE "\<doesn't come before\>"
syn match   scptGE "\(is \)\?greater than or equal\( to\)\?"
syn match   scptGE "\<is not less than\>"
syn match   scptGE "\<isn't less than\>"
hi def link scptGE scptOp
" MacRoman single char >=
exec 'syn match scptGE "'.nr2char(179).'"'

" --- Constant String ---
syn region  scptString start=+"+ skip=+\\\\\|\\"+ end=+"+
hi def link scptString String

" --- Constant Number ---
syn match   scptNumber "\<-\?\d\+\>"
hi def link scptNumber Number

" --- Constant Float ---
syn match   scptFloat display contained "\d\+\.\d*\(e[-+]\=\d\+\)\="
syn match   scptFloat display contained "\.\d\+\(e[-+]\=\d\+\)\=\>"
syn match   scptFloat display contained "\d\+e[-+]\>"
hi def link scptFloat Float

" --- Constant Boolean ---
syn keyword scptBoolean true false yes no ask
hi def link scptBoolean Boolean

" --- Other Constants ---
syn keyword scptConst it me version pi result space tab anything
syn match   scptConst "\<missing value\>"

" Considering and Ignoring
syn match   scptConst "\<application responses\>"
syn match   scptConst "\<current application\>"
syn match   scptConst "\<white space\>"
syn keyword scptConst case diacriticals expansion hyphens punctuation
hi def link scptConst Constant

" Style
syn match   scptStyle "\<all caps\>"
syn match   scptStyle "\<all lowercase\>"
syn match   scptStyle "\<small caps\>"
syn keyword scptStyle bold condensed expanded hidden italic outline plain
syn keyword scptStyle shadow strikethrough subscript superscript underline
hi def link scptStyle scptConst

" Day
syn keyword scptDay Mon Tue Wed Thu Fri Sat Sun
syn keyword scptDay Monday Tuesday Wednesday Thursday Friday Saturday Sunday
syn keyword scptDay weekday
hi def link scptDay scptConst

" Month
syn keyword scptMonth Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
syn keyword scptMonth January February March
syn keyword scptMonth April May June
syn keyword scptMonth July August September
syn keyword scptMonth October November December
syn keyword scptMonth month
hi def link scptMonth scptConst

" Time
syn keyword scptTime minutes hours days weeks
hi def link scptTime scptConstant

" --- Conditional ---
syn keyword scptCond if then else
syn match   scptCond "\<end if\>"
hi def link scptCond Conditional

" --- Repeat ---
syn keyword scptRepeat repeat with from to by continue 
syn match   scptRepeat "\<repeat while\>"
syn match   scptRepeat "\<repeat until\>"
syn match   scptRepeat "\<repeat with\>"
syn match   scptRepeat "\<end repeat\>"
hi def link scptRepeat Repeat

" --- Exception ---
syn keyword scptException try error
syn match   scptException "\<on error\>"
syn match   scptException "\<end try\>"
syn match   scptException "\<end error\>"
hi def link scptException Exception

" --- Keyword ---
syn keyword scptKeyword end tell times exit 
syn keyword scptKeyword application file alias activate
syn keyword scptKeyword script on return without given
syn keyword scptKeyword considering ignoring items delimiters
syn keyword scptKeyword some each every whose where id index item its
syn keyword scptKeyword first second third fourth fifth sixth seventh
syn keyword scptKeyword eighth ninth tenth container
syn match   scptKeyword "\d\+\(st\|nd\|rd\|th\)"
syn keyword scptKeyword last front back middle named thru through
syn keyword scptKeyword before after in of the
syn match   scptKeyword "\<text \>"
syn match   scptKeyword "\<partial result\>"
syn match   scptKeyword "\<but ignoring\>"
syn match   scptKeyword "\<but considering\>"
syn match   scptKeyword "\<with timeout\>"
syn match   scptKeyword "\<with transaction\>"
syn match   scptKeyword "\<do script\>"
syn match   scptKeyword "\<POSIX path\>"
syn match   scptKeyword "\<quoted form\>"
syn match   scptKeyword "'s"
hi def link scptKeyword Keyword

" US Units
syn keyword scptUnitUS quarts gallons ounces pounds inches feet yards miles
syn match   scptUnitUS "\<square feet\>"
syn match   scptUnitUS "\<square yards\>"
syn match   scptUnitUS "\<square miles\>"
syn match   scptUnitUS "\<cubic inches\>"
syn match   scptUnitUS "\<cubic feet\>"
syn match   scptUnitUS "\<cubic yards\>"
syn match   scptUnitUS "\<degrees Fahrenheit\>"
hi def link scptUnitUS scptKey

" British Units
syn keyword scptUnitBT litres centimetres metres kilometres
syn match   scptUnitBT "\<square metres\>"
syn match   scptUnitBT "\<square kilometres\>"
syn match   scptUnitBT "\<cubic centimetres\>"
syn match   scptUnitBT "\<cubic metres\>"
hi def link scptUnitBT scptKey

" Metric Units
syn keyword scptUnitMT liters centimeters meters kilometers grams kilograms 
syn match   scptUnitMT "\<square meters\>"
syn match   scptUnitMT "\<square kilometers\>"
syn match   scptUnitMT "\<cubic centimeters\>"
syn match   scptUnitMT "\<cubic meters\>"
syn match   scptUnitMT "\<degrees Celsius\>"
syn match   scptUnitMT "\<degrees Kelvin\>"
hi def link scptUnitMT scptKey

" --- Comment ---
syn match   scptComment "--.*"
syn match   scptComment "#.*"
syn region  scptComment start="(\*" end="\*)"
hi def link scptComment Comment

" --- Todo ---
syn keyword scptTodo contained TODO FIXME XXX
hi def link scptTodo Todo

let b:current_syntax = "applescript"


endif
