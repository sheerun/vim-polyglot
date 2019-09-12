if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

" modified from mxw/vim-jsx from html.vim
if exists("loaded_matchit") && !exists('b:tsx_match_words')
  let b:match_ignorecase = 0
  let b:tsx_match_words = '(:),\[:\],{:},<:>,' .
        \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(/\@<!>\|$\):<\@<=/\1>'
  let b:match_words = exists('b:match_words')
    \ ? b:match_words . ',' . b:tsx_match_words
    \ : b:tsx_match_words
endif

set suffixesadd+=.tsx

endif
