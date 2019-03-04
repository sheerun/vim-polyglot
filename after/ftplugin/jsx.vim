if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'jsx') != -1
  finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim ftplugin file
"
" Language: JSX (JavaScript)
" Maintainer: Max Wang <mxawng@gmail.com>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" modified from html.vim
if exists("loaded_matchit")
  let b:match_ignorecase = 0
  let s:jsx_match_words = '<\([a-zA-Z0-9.]\+\)\(>\|$\|\s\):<\/\1>'

  if !exists('b:loaded_jsx_match_words')
    let b:loaded_jsx_match_words = 0
  endif

  if b:loaded_jsx_match_words == 0
    let b:match_words = exists('b:match_words')
      \ ? b:match_words . ',' . s:jsx_match_words
      \ : s:jsx_match_words
  endif

  let b:loaded_jsx_match_words = 1
endif

setlocal suffixesadd+=.jsx
