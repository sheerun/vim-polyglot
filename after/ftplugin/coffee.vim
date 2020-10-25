if has_key(g:polyglot_is_disabled, 'cjsx')
  finish
endif

if exists("loaded_matchit")
  let b:match_ignorecase = 0
  let b:match_words = '(:),\[:\],{:},<:>,' .
    \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
endif
