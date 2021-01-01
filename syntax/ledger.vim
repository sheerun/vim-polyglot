if polyglot#init#is_disabled(expand('<sfile>:p'), 'ledger', 'syntax/ledger.vim')
  finish
endif

" Vim syntax file
" filetype: ledger
" by Johann Klähn; Use according to the terms of the GPL>=2.
" by Stefan Karrmann; Use according to the terms of the GPL>=2.
" by Wolfgang Oertl; Use according to the terms of the GPL>=2.
" vim:ts=2:sw=2:sts=2:foldmethod=marker

scriptencoding utf-8

if exists('b:current_syntax')
  finish
endif

if !exists ('b:is_hledger')
  if exists('g:ledger_is_hledger')
    let b:is_hledger = 1
  else
    let b:is_hledger = 0
  endif
endif

" Force old regex engine (:help two-engines)
let s:oe = '\%#=1'
let s:lb1 = '\@1<='

let s:line_comment_chars = b:is_hledger ? ';*#' : ';|*#%'

let s:fb = get(g:, 'ledger_fold_blanks', 0)
let s:skip = s:fb > 0 ? '\|^\n' : ''
if s:fb == 1
  let s:skip .= '\n\@!'
endif

let s:ledgerAmount_contains = ''
if get(g:, 'ledger_commodity_spell', 0) == 0
    let s:ledgerAmount_contains .= '@NoSpell'
endif

" for debugging
syntax clear

" DATE[=EDATE] [*|!] [(CODE)] DESC <-- first line of transaction
"   ACCOUNT AMOUNT [; NOTE]  <-- posting

exe 'syn region ledgerTransaction start=/^[[:digit:]~=]/ '.
  \ 'skip=/^\s'. s:skip . '/ end=/^/ fold keepend transparent '.
  \ 'contains=ledgerTransactionDate,ledgerTransactionMetadata,ledgerPosting,ledgerTransactionExpression'
syn match ledgerTransactionDate /^\d\S\+/ contained
syn match ledgerTransactionExpression /^[=~]\s\+\zs.*/ contained
syn match ledgerPosting /^\s\+[^[:blank:];].*/
    \ contained transparent contains=ledgerAccount,ledgerAmount,ledgerValueExpression,ledgerPostingMetadata
" every space in an account name shall be surrounded by two non-spaces
" every account name ends with a tab, two spaces or the end of the line
exe 'syn match ledgerAccount '.
  \ '/'.s:oe.'^\s\+\zs\%(\S'.s:lb1.' \S\|\S\)\+\ze\%(  \|\t\|\s*$\)/ contained'
exe 'syn match ledgerAmount '.
  \ '/'.s:oe.'\S'.s:lb1.'\%(  \|\t\)\s*\zs\%([^();[:space:]]\|\s\+[^();[:space:]]\)\+/ contains='.s:ledgerAmount_contains.' contained'
exe 'syn match ledgerValueExpression '.
  \ '/'.s:oe.'\S'.s:lb1.'\%(  \|\t\)\s*\zs(\%([^;[:space:]]\|\s\+[^;[:space:]]\)\+)/ contains='.s:ledgerAmount_contains.' contained'

syn region ledgerPreDeclaration start=/^\(account\|payee\|commodity\|tag\)/ skip=/^\s/ end=/^/
    \ keepend transparent
    \ contains=ledgerPreDeclarationType,ledgerPreDeclarationName,ledgerPreDeclarationDirective
syn match ledgerPreDeclarationType /^\(account\|payee\|commodity\|tag\)/ contained
syn match ledgerPreDeclarationName /^\S\+\s\+\zs.*/ contained
syn match ledgerPreDeclarationDirective /^\s\+\zs\S\+/ contained

syn match ledgerDirective
  \ /^\%(alias\|assert\|bucket\|capture\|check\|define\|expr\|fixed\|include\|year\)\s/
syn match ledgerOneCharDirective /^\%(P\|A\|Y\|N\|D\|C\)\s/

syn region ledgerBlockComment start=/^comment/ end=/^end comment/
syn region ledgerBlockTest start=/^test/ end=/^end test/
exe 'syn match ledgerComment /^['.s:line_comment_chars.'].*$/'
" comments at eol must be preceded by at least 2 spaces / 1 tab
if b:is_hledger
	syn region ledgerTransactionMetadata start=/;/ end=/^/
				\ keepend contained contains=ledgerTags,ledgerValueTag,ledgerTypedTag
else
	syn region ledgerTransactionMetadata start=/\%(\s\s\|\t\|^\s\+\);/ end=/^/
				\ keepend contained contains=ledgerTags,ledgerValueTag,ledgerTypedTag
endif
syn region ledgerPostingMetadata start=/;/ end=/^/
    \ keepend contained contains=ledgerTags,ledgerValueTag,ledgerTypedTag
exe 'syn match ledgerTags '.
    \ '/'.s:oe.'\%(\%(;\s*\|^tag\s\+\)\)\@<='.
    \ ':[^:[:space:]][^:]*\%(::\?[^:[:space:]][^:]*\)*:\s*$/ '.
    \ 'contained contains=ledgerTag'
syn match ledgerTag /:\zs[^:]\+\ze:/ contained
exe 'syn match ledgerValueTag '.
  \ '/'.s:oe.'\%(\%(;\|^tag\)[^:]\+\)\@<=[^:]\+:\ze.\+$/ contained'
exe 'syn match ledgerTypedTag '.
  \ '/'.s:oe.'\%(\%(;\|^tag\)[^:]\+\)\@<=[^:]\+::\ze.\+$/ contained'

syn region ledgerApply
    \ matchgroup=ledgerStartApply start=/^apply\>/
    \ matchgroup=ledgerEndApply end=/^end\s\+apply\>/
    \ contains=ledgerApplyHead,ledgerApply,ledgerTransaction,ledgerComment
exe 'syn match ledgerApplyHead '.
  \ '/'.s:oe.'\%(^apply\s\+\)\@<=\S.*$/ contained'

syntax keyword ledgerTodo FIXME TODO
  \ contained containedin=ledgerComment,ledgerTransaction,ledgerTransactionMetadata,ledgerPostingMetadata

highlight default link ledgerComment Comment
highlight default link ledgerBlockComment Comment
highlight default link ledgerBlockTest Comment
highlight default link ledgerTransactionDate Constant
highlight default link ledgerTransactionExpression Statement
highlight default link ledgerTransactionMetadata Tag
highlight default link ledgerPostingMetadata Tag
highlight default link ledgerTypedTag Keyword
highlight default link ledgerValueTag Type
highlight default link ledgerTag Type
highlight default link ledgerStartApply Tag
highlight default link ledgerEndApply Tag
highlight default link ledgerApplyHead Type
highlight default link ledgerAccount Identifier
highlight default link ledgerAmount Number
highlight default link ledgerValueExpression Function
highlight default link ledgerPreDeclarationType Type
highlight default link ledgerPreDeclarationName Identifier
highlight default link ledgerPreDeclarationDirective Type
highlight default link ledgerDirective Type
highlight default link ledgerOneCharDirective Type
highlight default link ledgerTodo Todo
 
" syncinc is easy: search for the first transaction.
syn sync clear
syn sync match ledgerSync grouphere ledgerTransaction "^[[:digit:]~=]"
 
let b:current_syntax = b:is_hledger ? 'hledger' : 'ledger'
