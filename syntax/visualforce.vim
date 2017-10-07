if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'apex/apexlog/visualforce') == -1
  
" Vim syntax file " Language:	  VisualForce
" Maintainer:	Eric Holmes <eric@ejholmes.net>
" URL:		https://github.com/ejholmes/vim-forcedotcom

if exists("b:current_syntax")
    finish
endif

runtime! syntax/html.vim

syn keyword htmlTagName        apex contained
syn keyword htmlTagName        c contained
syn region   htmlSpecialChar    start=+{!+ end=+}+ 

endif
