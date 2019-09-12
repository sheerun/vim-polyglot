if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ion') == -1

if v:version < 600
  syntax clear
elseif exists('b:current_syntax')
  finish
endif

syn region ionDoubleQuote start='"' skip='\'' end='"' contains=ionArrayVar,ionVariable,ionProcess
syn region ionSingleQuote start='\'' skip='"' end='\''
syn region ionArrayVar start="@{" end="}"
syn match ionArrayVar "@[a-zA-Z0-9_]\+"
syn region ionVariable start="${" end="}"
syn match ionVariable "$[a-zA-Z0-9_]\+"
syn region ionProcess start="$(" end=")" transparent
syn region ionProcess start="@(" end=")" transparent
syn match ionNumber '[+-]\?\([0-9]*[.]\)\?[0-9]\+'
syn match ionComment '[#].*$'
syn match ionOperator '&'
syn match ionOperator '&&'
syn match ionOperator '||'
syn match ionOperator '[|<>&]'
syn match ionFlag '[ ]\([-]\)\w\+'

syntax keyword ionKeyword .
syntax keyword ionKeyword ..
syntax keyword ionKeyword alias
syntax keyword ionKeyword and
syntax keyword ionKeyword bg
syntax keyword ionKeyword break
syntax keyword ionKeyword calc
syntax keyword ionKeyword case
syntax keyword ionKeyword cd
syntax keyword ionKeyword complete
syntax keyword ionKeyword continue
syntax keyword ionKeyword count
syntax keyword ionKeyword dirs
syntax keyword ionKeyword disown
syntax keyword ionKeyword drop
syntax keyword ionKeyword echo
syntax keyword ionKeyword else
syntax keyword ionKeyword end
syntax keyword ionKeyword eval
syntax keyword ionKeyword exec
syntax keyword ionKeyword exit
syntax keyword ionKeyword false
syntax keyword ionKeyword fg
syntax keyword ionKeyword fn
syntax keyword ionKeyword for
syntax keyword ionKeyword help
syntax keyword ionKeyword history
syntax keyword ionKeyword if
syntax keyword ionKeyword in
syntax keyword ionKeyword jobs
syntax keyword ionKeyword let
syntax keyword ionKeyword match
syntax keyword ionKeyword matches
syntax keyword ionKeyword mkdir
syntax keyword ionKeyword not
syntax keyword ionKeyword or
syntax keyword ionKeyword popd
syntax keyword ionKeyword pushd
syntax keyword ionKeyword pwd
syntax keyword ionKeyword read
syntax keyword ionKeyword set
syntax keyword ionKeyword source
syntax keyword ionKeyword status
syntax keyword ionKeyword suspend
syntax keyword ionKeyword test
syntax keyword ionKeyword time
syntax keyword ionKeyword true
syntax keyword ionKeyword unalias
syntax keyword ionKeyword wait
syntax keyword ionKeyword while

hi def link ionKeyword Keyword
hi def link ionArrayVar Constant
hi def link ionVariable Identifier
hi def link ionNumber Number
hi def link ionDoubleQuote String
hi def link ionSingleQuote String
hi def link ionProcess PreProc
hi def link ionComment Comment
hi def link ionOperator Operator
hi def link ionFlag Boolean

endif
