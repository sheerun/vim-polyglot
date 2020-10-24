let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/caddyfile.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'caddyfile') == -1

" Language: Caddyfile
" Author:   Josh Glendenning <josh@isobit.io>

if exists("b:current_syntax")
	finish
endif

syn match caddyDirective "^\s*\([a-zA-Z0-9_]\+\)" nextgroup=caddyDirectiveArgs skipwhite
syn region caddyDirectiveArgs start="" end="\({\|#\|$\)"me=s-1 oneline contained contains=caddyPlaceholder,caddyString nextgroup=caddyDirectiveBlock skipwhite
syn region caddyDirectiveBlock start="{" skip="\\}" end="}" contained contains=caddySubdirective,caddyComment

syn match caddySubdirective "^\s*\([a-zA-Z0-9_]\+\)" contained nextgroup=caddySubdirectiveArgs skipwhite
syn region caddySubdirectiveArgs start="" end="\(#\|$\)"me=s-1 oneline contained contains=caddyPlaceholder,caddyString

syn match caddyHost "\(https\?:\/\/\)\?\(\(\w\{1,}\.\)\(\w\{2,}\.\?\)\+\|localhost\)\(:[0-9]\{1,5}\)\?" nextgroup=caddyHostBlock skipwhite
syn region caddyHostBlock start="{" skip="\\}" end="}" contained contains=caddyDirective,caddyComment

syn region caddyPlaceholder start="{" skip="\\}" end="}" oneline contained
syn region caddyString start='"' skip='\\\\\|\\"' end='"' oneline
syn match caddyComment "#.*$"

hi link caddyDirective Keyword
hi link caddySubdirective Structure
hi link caddyHost Identifier
hi link caddyPlaceholder Special
hi link caddyString String
hi link caddyComment Comment

let b:current_syntax = "caddyfile"

endif
