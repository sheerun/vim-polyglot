if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'ftplugin/typescriptreact.vim')
  finish
endif

" modified from mxw/vim-jsx from html.vim
if exists("loaded_matchit") && !exists('b:tsx_match_words')
  let b:match_ignorecase = 0
  let b:tsx_match_words = '(:),\[:\],{:},<:>,' .
        \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(/\@<!>\|$\):<\@<=/\1>'
  let b:match_words = exists('b:match_words')
    \ ? b:match_words . ',' . b:tsx_match_words
    \ : b:tsx_match_words
endif

" Comment formatting
setlocal comments=s1:/*,mb:*,ex:*/,://
setlocal formatoptions-=t formatoptions+=croql

set suffixesadd+=.tsx
