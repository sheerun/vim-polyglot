if polyglot#init#is_disabled(expand('<sfile>:p'), 'sqlite', 'syntax/sqlite.vim')
  finish
endif

" Vim syntax file
" Language:     SQLite
" Maintainer:   Dirk Reinemann <dreinemann@tutamail.com>
" Last Change:  2026-02-03
" Filenames:    *.sqlite
" Note:         The keywords have been taken from the official sqlite website.
"               https://sqlite.org/lang_keywords.html
"               https://sqlite.org/lang_corefunc.html
"               https://www.sqlite.org/datatype3.html

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Always ignore case
syn case ignore

" General keywords which don't fall into other categories
syn keyword sqlKeyword abort action add after all alter always analyze and
syn keyword sqlKeyword as asc attach autoincrement before begin between by
syn keyword sqlKeyword cascade case cast check collate column commit conflict
syn keyword sqlKeyword constraint create cross current current_date
syn keyword sqlKeyword current_time current_timestamp database default
syn keyword sqlKeyword deferrable deferred delete desc detach distinct do
syn keyword sqlKeyword drop each else end escape except exclude exclusive
syn keyword sqlKeyword exists explain fail filter first following for foreign
syn keyword sqlKeyword from full generated glob group groups having if ignore
syn keyword sqlKeyword immediate in index indexed initially inner insert
syn keyword sqlKeyword instead intersect into is isnull join key last left
syn keyword sqlKeyword like limit match materialized natural no not nothing
syn keyword sqlKeyword notnull null nulls of offset on or order others outer
syn keyword sqlKeyword over partition plan pragma preceding primary query
syn keyword sqlKeyword raise range recursive references regexp reindex
syn keyword sqlKeyword release rename replace restrict returning right
syn keyword sqlKeyword rollback row rows savepoint select set table temp
syn keyword sqlKeyword temporary then ties to transaction trigger unbounded
syn keyword sqlKeyword union unique update using vacuum values view virtual
syn keyword sqlKeyword when where window with without

" Datatypes
syn keyword sqlType null integer real text blob

" Strings
syn region sqlString start=+"+ end=+"+
syn region sqlString start=+'+ end=+'+

" Numbers
syn match sqlNumber "-\=\<\d*\.\=[0-9_]\>"

" Comments
syn region sqlComment start="/\*" end="\*/"
syn match sqlComment "--.*$"

" Functions
syn region sqlFunction start="abs(" end=")" contains=ALL
syn region sqlFunction start="changes(" end=")" contains=ALL
syn region sqlFunction start="char(" end=")" contains=ALL
syn region sqlFunction start="coalesce(" end=")" contains=ALL
syn region sqlFunction start="concat(" end=")" contains=ALL
syn region sqlFunction start="concat_ws(" end=")" contains=ALL
syn region sqlFunction start="format(" end=")" contains=ALL
syn region sqlFunction start="glob(" end=")" contains=ALL
syn region sqlFunction start="hex(" end=")" contains=ALL
syn region sqlFunction start="if(" end=")" contains=ALL
syn region sqlFunction start="ifnull(" end=")" contains=ALL
syn region sqlFunction start="iif(" end=")" contains=ALL
syn region sqlFunction start="instr(" end=")" contains=ALL
syn region sqlFunction start="last_insert_rowid(" end=")" contains=ALL
syn region sqlFunction start="length(" end=")" contains=ALL
syn region sqlFunction start="like(" end=")" contains=ALL
syn region sqlFunction start="likelihood(" end=")" contains=ALL
syn region sqlFunction start="likely(" end=")" contains=ALL
syn region sqlFunction start="load_extension(" end=")" contains=ALL
syn region sqlFunction start="lower(" end=")" contains=ALL
syn region sqlFunction start="ltrim(" end=")" contains=ALL
syn region sqlFunction start="max(" end=")" contains=ALL
syn region sqlFunction start="min(" end=")" contains=ALL
syn region sqlFunction start="nullif(" end=")" contains=ALL
syn region sqlFunction start="octet_length(" end=")" contains=ALL
syn region sqlFunction start="printf(" end=")" contains=ALL
syn region sqlFunction start="quote(" end=")" contains=ALL
syn region sqlFunction start="random(" end=")" contains=ALL
syn region sqlFunction start="randomblob(" end=")" contains=ALL
syn region sqlFunction start="replace(" end=")" contains=ALL
syn region sqlFunction start="round(" end=")" contains=ALL
syn region sqlFunction start="rtrim(" end=")" contains=ALL
syn region sqlFunction start="sign(" end=")" contains=ALL
syn region sqlFunction start="soundex(" end=")" contains=ALL
syn region sqlFunction start="sqlite_compileoption_get(" end=")" contains=ALL
syn region sqlFunction start="sqlite_compileoption_used(" end=")" contains=ALL
syn region sqlFunction start="sqlite_offset(" end=")" contains=ALL
syn region sqlFunction start="sqlite_source_id(" end=")" contains=ALL
syn region sqlFunction start="sqlite_version(" end=")" contains=ALL
syn region sqlFunction start="subdate(" end=")" contains=ALL
syn region sqlFunction start="substr(" end=")" contains=ALL
syn region sqlFunction start="substring(" end=")" contains=ALL
syn region sqlFunction start="total_changes(" end=")" contains=ALL
syn region sqlFunction start="trim(" end=")" contains=ALL
syn region sqlFunction start="typeof(" end=")" contains=ALL
syn region sqlFunction start="unhex(" end=")" contains=ALL
syn region sqlFunction start="unicode(" end=")" contains=ALL
syn region sqlFunction start="unistr(" end=")" contains=ALL
syn region sqlFunction start="unistr_quote(" end=")" contains=ALL
syn region sqlFunction start="unlikely(" end=")" contains=ALL
syn region sqlFunction start="upper(" end=")" contains=ALL
syn region sqlFunction start="zeroblob(" end=")" contains=ALL

" Define the default highlighting.
hi def link sqlKeyword  Statement
hi def link sqlString   String
hi def link sqlNumber   Number
hi def link sqlComment  Comment
hi def link sqlType     Type
hi def link sqlFunction Function

let b:current_syntax = "sqlite"
