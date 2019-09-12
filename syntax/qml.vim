if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'qml') == -1

" Vim syntax file
" Language:     QML
" Maintainer:   Peter Hoeg <peter@hoeg.com>
" Updaters:     Refer to CONTRIBUTORS.md
" URL:          https://github.com/peterhoeg/vim-qml
" Changes:      `git log` is your friend
" Last Change:  2017-11-11
"
" This file is bassed on the original work done by Warwick Allison
" <warwick.allison@nokia.com> whose did about 99% of the work here.

" Based on javascript syntax (as is QML)

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'qml'
endif

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("qml_fold")
  unlet qml_fold
endif

syn case ignore

syn cluster qmlExpr              contains=qmlStringD,qmlString,SqmlCharacter,qmlNumber,qmlObjectLiteralType,qmlBoolean,qmlType,qmlJsType,qmlNull,qmlGlobal,qmlFunction
syn keyword qmlCommentTodo       TODO FIXME XXX TBD contained
syn match   qmlLineComment       "\/\/.*" contains=@Spell,qmlCommentTodo
syn match   qmlCommentSkip       "^[ \t]*\*\($\|[ \t]\+\)"
syn region  qmlComment           start="/\*"  end="\*/" contains=@Spell,qmlCommentTodo fold
syn match   qmlSpecial           "\\\d\d\d\|\\."
syn region  qmlStringD           start=+"+  skip=+\\\\\|\\"\|\\$+  end=+"+  keepend  contains=qmlSpecial,@htmlPreproc,@Spell
syn region  qmlStringS           start=+'+  skip=+\\\\\|\\'\|\\$+  end=+'+  keepend  contains=qmlSpecial,@htmlPreproc,@Spell

syn match   qmlCharacter         "'\\.'"
syn match   qmlNumber            "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn region  qmlRegexpString      start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gi]\{0,2\}\s*$+ end=+/[gi]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline
syn match   qmlObjectLiteralType "[A-Za-z][_A-Za-z0-9]*\s*\({\)\@="
syn region  qmlTernaryColon   start="?" end=":" contains=@qmlExpr,qmlBraces,qmlParens
syn match   qmlBindingProperty   "\<[A-Za-z][_A-Za-z.0-9]*\s*:"

syn keyword qmlConditional       if else switch
syn keyword qmlRepeat            while for do in
syn keyword qmlBranch            break continue
syn keyword qmlOperator          new delete instanceof typeof
syn keyword qmlJsType            Array Boolean Date Function Number Object String RegExp
syn keyword qmlType              action alias bool color date double enumeration font int list point real rect size string time url variant vector3d
syn keyword qmlStatement         return with
syn keyword qmlBoolean           true false
syn keyword qmlNull              null undefined
syn keyword qmlIdentifier        arguments this var
syn keyword qmlLabel             case default
syn keyword qmlException         try catch finally throw
syn keyword qmlMessage           alert confirm prompt status
syn keyword qmlGlobal            self
syn keyword qmlDeclaration       property signal readonly
syn keyword qmlReserved          abstract boolean byte char class const debugger enum export extends final float goto implements import interface long native package pragma private protected public short static super synchronized throws transient volatile

if get(g:, 'qml_fold', 0)
  syn match   qmlFunction      "\<function\>"
  syn region  qmlFunctionFold  start="\<function\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

  syn sync match qmlSync  grouphere qmlFunctionFold "\<function\>"
  syn sync match qmlSync  grouphere NONE "^}"

  setlocal foldmethod=syntax
  setlocal foldtext=getline(v:foldstart)
else
  syn keyword qmlFunction function
  syn match   qmlBraces   "[{}\[\]]"
  syn match   qmlParens   "[()]"
endif

syn sync fromstart
syn sync maxlines=100

if main_syntax == "qml"
  syn sync ccomment qmlComment
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_qml_syn_inits")
  if version < 508
    let did_qml_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink qmlComment           Comment
  HiLink qmlLineComment       Comment
  HiLink qmlCommentTodo       Todo
  HiLink qmlSpecial           Special
  HiLink qmlStringS           String
  HiLink qmlStringD           String
  HiLink qmlCharacter         Character
  HiLink qmlNumber            Number
  HiLink qmlConditional       Conditional
  HiLink qmlRepeat            Repeat
  HiLink qmlBranch            Conditional
  HiLink qmlOperator          Operator
  HiLink qmlJsType            Type
  HiLink qmlType              Type
  HiLink qmlObjectLiteralType Type
  HiLink qmlStatement         Statement
  HiLink qmlFunction          Function
  HiLink qmlBraces            Function
  HiLink qmlError             Error
  HiLink qmlNull              Keyword
  HiLink qmlBoolean           Boolean
  HiLink qmlRegexpString      String

  HiLink qmlIdentifier        Identifier
  HiLink qmlLabel             Label
  HiLink qmlException         Exception
  HiLink qmlMessage           Keyword
  HiLink qmlGlobal            Keyword
  HiLink qmlReserved          Keyword
  HiLink qmlDebug             Debug
  HiLink qmlConstant          Label
  HiLink qmlBindingProperty   Label
  HiLink qmlDeclaration       Function

  delcommand HiLink
endif

let b:current_syntax = "qml"
if main_syntax == 'qml'
  unlet main_syntax
endif

endif
