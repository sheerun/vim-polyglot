if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'sbt') == -1

" Vim syntax file
" Language:     sbt
" Maintainer:   Derek Wyatt <derek@{myfirstname}{mylastname}.org>
" Last Change:  2013 Oct 20

if exists("b:current_syntax")
  finish
endif

runtime! syntax/scala.vim

syn region sbtString start="\"[^"]" skip="\\\"" end="\"" contains=sbtStringEscape
syn match sbtStringEscape "\\u[0-9a-fA-F]\{4}" contained
syn match sbtStringEscape "\\[nrfvb\\\"]" contained

syn match sbtIdentitifer "^\S\+\ze\s*\(:=\|++=\|+=\|<<=\|<+=\)"
syn match sbtBeginningSeq "^[Ss]eq\>"
syn match sbtAddPlugin "^addSbtPlugin\>"

syn match sbtSpecial "\(:=\|++=\|+=\|<<=\|<+=\)"

syn match sbtLineComment "//.*"
syn region sbtComment start="/\*" end="\*/"
syn region sbtDocComment start="/\*\*" end="\*/" keepend

hi link sbtString String
hi link sbtIdentitifer Keyword
hi link sbtBeginningSeq Keyword
hi link sbtAddPlugin Keyword
hi link sbtSpecial Special
hi link sbtComment Comment
hi link sbtLineComment Comment
hi link sbtDocComment Comment

endif
