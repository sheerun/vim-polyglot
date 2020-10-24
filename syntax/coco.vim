let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/coco.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'coco') == -1

" Vim syntax file
" Language:     Coco/R
" Maintainer:   Ashish Shukla <wahjava@gmail.com>
" Last Change:  2007 Aug 10
" Remark:       Coco/R syntax partially implemented.
" License:      Vim license

" quit when a syntax file was already loaded
if exists("b:current_syntax")
	finish
endif

syn keyword cocoKeywords ANY CHARACTERS COMMENTS COMPILER CONTEXT END FROM IF IGNORE IGNORECASE NESTED PRAGMAS PRODUCTIONS SYNC TO TOKENS WEAK
syn match   cocoUnilineComment    #//.*$#
syn match   cocoIdentifier        /[[:alpha:]][[:alnum:]]*/
syn region  cocoMultilineComment  start=#/[*]# end=#[*]/#
syn region  cocoString            start=/"/ skip=/\\"\|\\\\/ end=/"/
syn region  cocoCharacter         start=/'/ skip=/\\'\|\\\\/ end=/'/
syn match   cocoOperator          /+\||\|\.\.\|-\|(\|)\|{\|}\|\[\|\]\|=\|<\|>/
syn region  cocoProductionCode    start=/([.]/ end=/[.])/
syn match   cocoPragma            /[$][[:alnum:]]*/

hi def link cocoKeywords         Keyword
hi def link cocoUnilineComment   Comment 
hi def link cocoMultilineComment Comment
hi def link cocoIdentifier       Identifier
hi def link cocoString           String
hi def link cocoCharacter        Character
hi def link cocoOperator         Operator
hi def link cocoProductionCode   Statement
hi def link cocoPragma           Special


endif
