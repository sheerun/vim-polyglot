if has_key(g:polyglot_is_disabled, 'jsx')
  finish
endif

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

let b:jsx_pretty_old_cms = &l:commentstring

augroup jsx_comment
  autocmd! CursorMoved <buffer>
  autocmd CursorMoved <buffer> call jsx_pretty#comment#update_commentstring(b:jsx_pretty_old_cms)
augroup end

setlocal suffixesadd+=.tsx
