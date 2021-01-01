if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/basic/symbols.vim')
  finish
endif

" + - ^ ~
syntax match typescriptUnaryOp /[+\-~!]/
 \ nextgroup=@typescriptValue
 \ skipwhite

syntax region typescriptTernary matchgroup=typescriptTernaryOp start=/?[.?]\@!/ end=/:/ contained contains=@typescriptValue,@typescriptComments nextgroup=@typescriptValue skipwhite skipempty

syntax match   typescriptAssign  /=/ nextgroup=@typescriptValue
  \ skipwhite skipempty

" 2: ==, ===
syntax match   typescriptBinaryOp contained /===\?/ nextgroup=@typescriptValue skipwhite skipempty
" 6: >>>=, >>>, >>=, >>, >=, >
syntax match   typescriptBinaryOp contained />\(>>=\|>>\|>=\|>\|=\)\?/ nextgroup=@typescriptValue skipwhite skipempty
" 4: <<=, <<, <=, <
syntax match   typescriptBinaryOp contained /<\(<=\|<\|=\)\?/ nextgroup=@typescriptValue skipwhite skipempty
" 3: ||, |=, |, ||=
syntax match   typescriptBinaryOp contained /||\?=\?/ nextgroup=@typescriptValue skipwhite skipempty
" 4: &&, &=, &, &&=
syntax match   typescriptBinaryOp contained /&&\?=\?/ nextgroup=@typescriptValue skipwhite skipempty
" 2: ??, ??=
syntax match   typescriptBinaryOp contained /??=\?/ nextgroup=@typescriptValue skipwhite skipempty
" 2: *=, *
syntax match   typescriptBinaryOp contained /\*=\?/ nextgroup=@typescriptValue skipwhite skipempty
" 2: %=, %
syntax match   typescriptBinaryOp contained /%=\?/ nextgroup=@typescriptValue skipwhite skipempty
" 2: /=, /
syntax match   typescriptBinaryOp contained +/\(=\|[^\*/]\@=\)+ nextgroup=@typescriptValue skipwhite skipempty
syntax match   typescriptBinaryOp contained /!==\?/ nextgroup=@typescriptValue skipwhite skipempty
" 2: !=, !==
syntax match   typescriptBinaryOp contained /+\(+\|=\)\?/ nextgroup=@typescriptValue skipwhite skipempty
" 3: +, ++, +=
syntax match   typescriptBinaryOp contained /-\(-\|=\)\?/ nextgroup=@typescriptValue skipwhite skipempty
" 3: -, --, -=

" exponentiation operator
" 2: **, **=
syntax match typescriptBinaryOp contained /\*\*=\?/ nextgroup=@typescriptValue

syntax cluster typescriptSymbols               contains=typescriptBinaryOp,typescriptKeywordOp,typescriptTernary,typescriptAssign,typescriptCastKeyword
