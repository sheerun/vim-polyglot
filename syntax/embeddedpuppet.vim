if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'puppet') == -1

" Vim syntax plugin
" Language:             embedded puppet
" Maintainer:           Gabriel Filion <gabster@lelutin.ca>
" URL:                  https://github.com/rodjek/vim-puppet
" Last Change:          2019-09-01

" quit when a syntax file was already loaded {{{1
if exists("b:current_syntax")
  finish
endif

runtime! syntax/sh.vim
unlet! b:current_syntax

syn include @puppetTop syntax/puppet.vim

syn cluster ePuppetRegions contains=ePuppetBlock,ePuppetExpression,ePuppetComment

syn region  ePuppetBlock      matchgroup=ePuppetDelimiter start="<%%\@!-\=" end="[=-]\=%\@<!%>" contains=@puppetTop  containedin=ALLBUT,@ePuppetRegions keepend
syn region  ePuppetExpression matchgroup=ePuppetDelimiter start="<%=\{1,4}" end="[=-]\=%\@<!%>" contains=@puppetTop  containedin=ALLBUT,@ePuppetRegions keepend
syn region  ePuppetComment    matchgroup=ePuppetDelimiter start="<%-\=#"    end="[=-]\=%\@<!%>" contains=puppetTodo,@Spell containedin=ALLBUT,@ePuppetRegions keepend

" Define the default highlighting.

hi def link ePuppetDelimiter              PreProc
hi def link ePuppetComment                Comment

let b:current_syntax = "embeddedpuppet"


endif
