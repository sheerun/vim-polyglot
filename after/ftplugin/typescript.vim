if !exists('g:polyglot_disabled') || !(index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'jsx') != -1)

" modified from html.vim
" For matchit plugin

if get(g:, 'vim_jsx_pretty_disable_tsx', 0)
  finish
endif

if exists("loaded_matchit")
  let b:match_ignorecase = 0
  let b:match_words = '(:),\[:\],{:},<:>,' .
        \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
endif

" For andymass/vim-matchup plugin
if exists("loaded_matchup")
  setlocal matchpairs=(:),{:},[:],<:>
  let b:match_words = '<\@<=\([^/][^ \t>]*\)\g{hlend}[^>]*\%(/\@<!>\|$\):<\@<=/\1>'
  let b:match_skip = 's:comment\|string'
endif

let b:original_commentstring = &l:commentstring

augroup jsx_comment
  autocmd! CursorMoved <buffer>
  autocmd CursorMoved <buffer> call jsx_pretty#comment#update_commentstring(b:original_commentstring)
augroup end

setlocal suffixesadd+=.tsx

endif
