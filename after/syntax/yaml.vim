if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'yaml') == -1

" To make this file do stuff, add something like the following (without the
" leading ") to your ~/.vimrc:
" au BufNewFile,BufRead *.yaml,*.yml so ~/src/PyYaml/YAML.vim

" Vim syntax/macro file
" Language:	YAML
" Author:	Igor Vergeichik <iverg@mail.ru>
" Sponsor: Tom Sawyer <transami@transami.net>
" Stayven: Ryan King <jking@panoptic.com>
" Copyright (c) 2002 Tom Saywer

" Add an item to a gangly list:
"map , o<bs><bs><bs><bs>-<esc>o
" Convert to Canonical form:
"map \c :%!python -c 'from yaml.redump import redump; import sys; print redump(sys.stdin.read()).rstrip()'

if version < 600
  syntax clear
endif
syntax clear

syn match yamlInline "[\[\]\{\}]"
syn match yamlBlock "[>|]\d\?[+-]"

syn region yamlComment	start="\#" end="$"
syn match yamlIndicator	"#YAML:\S\+"

syn region yamlString	start="\(^\|\s\|\[\|\,\|\-\)\@<='" end="'" skip="\\'"
syn region yamlString	start='"' end='"' skip='\\"' contains=yamlEscape
syn region yamlString	matchgroup=yamlBlock start=/[>|]\s*\n\+\z(\s\+\)\S/rs=s+1 skip=/^\%(\z1\S\|^$\)/ end=/^\z1\@!.*/me=s-1
syn region yamlString	matchgroup=yamlBlock start=/[>|]\(\d\|[+-]\)\s*\n\+\z(\s\+\)\S/rs=s+2 skip=/^\%(\z1\S\|^$\)/ end=/^\z1\@!.*/me=s-1
syn region yamlString	matchgroup=yamlBlock start=/[>|]\d\(\d\|[+-]\)\s*\n\+\z(\s\+\)\S/rs=s+3 skip=/^\%(\z1\S\|^$\)/ end=/^\z1\@!.*/me=s-1
syn match  yamlEscape	+\\[abfnrtv'"\\]+ contained
syn match  yamlEscape	"\\\o\o\=\o\=" contained
syn match  yamlEscape	"\\x\x\+" contained

syn match  yamlType	"!\S\+"

syn keyword yamlConstant NULL Null null NONE None none NIL Nil nil
syn keyword yamlConstant TRUE True true YES Yes yes ON On on
syn keyword yamlConstant FALSE False false NO No no OFF Off off

syn match  yamlKey	"^\s*\zs[^ \t\"]\+\ze\s*:"
syn match  yamlKey	"^\s*-\s*\zs[^ \t\"\']\+\ze\s*:"
syn match  yamlAnchor	"&\S\+"
syn match  yamlAlias	"*\S\+"

" Setup the highlighting links

hi link yamlConstant Keyword
hi link yamlIndicator PreCondit
hi link yamlAnchor	Function
hi link yamlAlias	Function
hi link yamlKey		Identifier
hi link yamlType	Type

hi link yamlComment	Comment
hi link yamlInline	Operator
hi link yamlBlock	Operator
hi link yamlString	String
hi link yamlEscape	Special

endif
