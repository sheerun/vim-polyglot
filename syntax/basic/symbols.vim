let files = filter(globpath(&rtp, 'syntax/basic/symbols.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

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

endif
