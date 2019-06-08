if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'rego') != -1
  finish
endif

" Vim syntax file
" Language: Rego (http://github.com/open-policy-agent/opa)
" Maintainers: Torin Sandall <torinsandall@gmail.com>

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

syn case match

" language keywords
syn keyword regoKeyword package import as not with default else some

" comments
syn match regoComment "#.*$" contains=regoTodo,@Spell
syn keyword regoTodo FIXME XXX TODO contained

" data types
syn keyword regoNull null
syn keyword regoBoolean true false
syn match regoNumber "\<\(0[0-7]*\|0[xx]\x\+\|\d\+\)[ll]\=\>"
syn match regoNumber "\(\<\d\+\.\d*\|\.\d\+\)\([ee][-+]\=\d\+\)\=[ffdd]\="
syn match regoNumber "\<\d\+[ee][-+]\=\d\+[ffdd]\=\>"
syn match regoNumber "\<\d\+\([ee][-+]\=\d\+\)\=[ffdd]\>"
syn region regoString start="\"[^"]" skip="\\\"" end="\"" contains=regoStringEscape
syn match regoStringEscape "\\u[0-9a-fA-F]\{4}" contained
syn match regoStringEscape "\\[nrfvb\\\"]" contained

" rules
syn match regoRuleName "^\(\w\+\)"
syn region regoBody start="{" end="}" transparent

" operators
syn match regoEquality "="
syn match regoInequality "[<>!]"
syn match regoArith "[+-/*&|]"
syn match regoBuiltin "\w\+(" nextgroup=regoBuiltinArgs contains=regoBuiltinArgs
syn region regoBuiltinArgs start="(" end=")" contained contains=regoNull,regoBoolean,regoNumber,regoString

" highlighting
hi link regoKeyword Keyword
hi link regoNull Function
hi link regoBoolean Boolean
hi link regoNumber Number
hi link regoString String

hi link regoRuleName Function

hi link regoEquality Keyword
hi link regoInequality Keyword
hi link regoArith Keyword
hi link regoBuiltin Type

hi link regoComment Comment
hi link regoTodo Todo
