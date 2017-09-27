if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vim') == -1
  
" Vim filetype plugin
" Language:	less
" Maintainer:	Alessandro Vioni <jenoma@gmail.com>
" URL: https://github.com/genoma/vim-less
" Last Change:	2014 November 24

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = "setl cms< def< inc< inex< ofu< sua<"

setlocal formatoptions-=t formatoptions+=croql

setlocal comments=:// commentstring=//\ %s

setlocal omnifunc=csscomplete#CompleteCSS
setlocal suffixesadd=.less

endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'less') == -1
  
" Vim filetype plugin
" Language:	    LessCSS
" Author:	    Tim Pope <vimNOSPAM@tpope.org>
" Maintainer:   Leonard Ehrenfried <leonard.ehrenfried@web.de>
" Last Change:  2011 Sep 30

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = "setl cms< def< inc< inex< ofu< sua<"

setlocal iskeyword+=-
setlocal commentstring=//%s
setlocal define=^\\s*\\%(@mixin\\\|=\\)
setlocal includeexpr=substitute(v:fname,'\\%(.*/\\\|^\\)\\zs','_','')
setlocal omnifunc=csscomplete#CompleteCSS
setlocal suffixesadd=.less
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,://
setlocal fo=croql

let &l:include = '^\s*@import\s\+\%(url(\)\=["'']\='

" vim:set sw=2:

endif
