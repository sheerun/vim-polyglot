if polyglot#init#is_disabled(expand('<sfile>:p'), 'caddyfile', 'syntax/caddyfile.vim')
  finish
endif

" Language:			Caddyfile
" Maintainer:		0az <0az@afzhou.com>
" Original Author:	Josh Glendenning <josh@isobit.io>

if exists("b:current_syntax")
	finish
endif

syn match caddyDirective "\v^\s*(\w\S*)" nextgroup=caddyDirectiveArgs skipwhite
syn region caddyDirectiveArgs start="" end="\({\|#\|$\)"me=s-1 oneline contained contains=caddyPlaceholder,caddyString,caddyNamedMatcher nextgroup=caddyDirectiveBlock skipwhite
syn region caddyDirectiveBlock start="{" skip="\\}" end="}" contained contains=caddySubdirective,caddyComment,caddyImport

syn match caddySubdirective "\v^\s*(\w\S*)" contained nextgroup=caddySubdirectiveArgs skipwhite
syn region caddySubdirectiveArgs start="" end="\(#\|$\)"me=s-1 oneline contained contains=caddyPlaceholder,caddyString,caddyNamedMatcher

" Needs priority over Directive
syn match caddyImport "\v^\s*<import>" nextgroup=caddyImportPattern skipwhite
syn match caddyImportPattern "\v\c\S+" contained nextgroup=caddyImportArgs skipwhite
syn region caddyImportArgs start="" end="$"me=s-1 oneline contained contains=caddyPlaceholder,caddyString,caddyNamedMatcher

syn match caddyHost "\v\c^\s*\zs(https?://)?(([0-9a-z-]+\.)([0-9a-z-]+\.?)+|[0-9a-z-]+)?(:\d{1,5})?" nextgroup=caddyHostBlock skipwhite
syn region caddyHostBlock start="{" skip="\\}" end="}" contained contains=caddyDirective,caddyComment,caddyNamedMatcherDef,caddyImport

" Needs priority over Host
syn region caddySnippetDef start="("rs=e+1 end=")"re=s-1 oneline keepend contains=caddySnippet
syn match caddySnippet "\v\w+" contained nextgroup=caddySnippetBlock skipwhite

syn match caddyNamedMatcher "\v^\s*\zs\@\S+" contained skipwhite
syn match caddyNamedMatcherDef "\v\s*\zs\@\S+" nextgroup=caddyNamedMatcherDefBlock
syn region caddyNamedMatcherDefBlock start="{" skip="\\}" end="}" contained contains=caddySubdirective,caddyComment,caddyImport

syn region caddyPlaceholder start="{" skip="\\}" end="}" oneline contained
syn region caddyString start='"' skip='\\\\\|\\"' end='"' oneline
syn region caddyComment start="#" end="$" oneline

hi link caddyDirective Keyword
hi link caddySubdirective Structure
hi link caddyHost Identifier
hi link caddyImport PreProc
hi link caddySnippetDef PreProc
hi link caddySnippet Identifier
hi link caddyPlaceholder Special
hi link caddyString String
hi link caddyComment Comment
hi link caddyNamedMatcherDef caddyNamedMatcher
hi link caddyNamedMatcher Identifier

let b:current_syntax = "caddyfile"
