if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'apex/apexlog/visualforce') == -1
  
" Vim filetype plugin file
" Language:	Visualforce
" Maintainer:	ViViDboarder <ViViDboarder@gmail.com>
" Last Change:  2015 April 24
" URL:		http://github.com/ViViDboarder/vim-forcedotcom

" This is heavily based on the html.vim filetype plugin by Dan Sharp
" http://dwsharp.users.sourceforge.net/vim/ftplugin

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

" Make sure the continuation lines below do not cause problems in
" compatibility mode.
let s:save_cpo = &cpo
set cpo-=C

setlocal matchpairs+=<:>
setlocal commentstring=<!--%s-->
setlocal comments=s:<!--,m:\ \ \ \ ,e:-->

if exists("g:ft_html_autocomment") && (g:ft_html_autocomment == 1)
    setlocal formatoptions-=t formatoptions+=croql
endif

if exists('&omnifunc')
  setlocal omnifunc=htmlcomplete#CompleteTags
  call htmlcomplete#DetectOmniFlavor()
endif

" HTML:  thanks to Johannes Zellner and Benji Fisher.
if exists("loaded_matchit")
    let b:match_ignorecase = 1
    let b:match_words = '<:>,' .
    \ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
    \ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
    \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
endif

if exists('loaded_tcomment')
    let g:tcommentGuessFileType_apex = 'html'
endif

" Undo the stuff we changed.
let b:undo_ftplugin = "setlocal commentstring< matchpairs< omnifunc< comments< formatoptions<" .
    \	" | unlet! b:match_ignorecase b:match_skip b:match_words"

" Restore the saved compatibility options.
let &cpo = s:save_cpo
unlet s:save_cpo

endif
