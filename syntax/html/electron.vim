if polyglot#init#is_disabled(expand('<sfile>:p'), 'html5', 'syntax/html/electron.vim')
  finish
endif

" Vim syntax file
" Language:     Electron
" Maintainer:   othree <othree@gmail.com>
" URL:          https://github.com/othree/html5.vim
" Last Change:  2017-03-15
" License:      MIT

" <webview> https://electron.atom.io/docs/api/webview-tag/
syn keyword htmlTagName contained webview

syn keyword htmlArg contained autosize nodeintegration plugins preload httpreferrer
syn keyword htmlArg contained useragent disablewebsecurity partition allowpopups 
syn keyword htmlArg contained webpreferences blinkfeatures disableblinkfeatures
syn keyword htmlArg contained guestinstance disableguestresize 

