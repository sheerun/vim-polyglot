if polyglot#init#is_disabled(expand('<sfile>:p'), 'cjsx', 'after/ftplugin/coffee.vim')
  finish
endif

if exists("loaded_matchit")
  let b:match_ignorecase = 0
  let b:match_words = '(:),\[:\],{:},<:>,' .
    \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
endif
