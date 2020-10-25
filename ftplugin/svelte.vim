if has_key(g:polyglot_is_disabled, 'svelte')
  finish
endif

" Vim filetype plugin
" Language:   Svelte 3 (HTML/JavaScript)
" Author:     Evan Lecklider <evan@lecklider.com>
" Maintainer: Evan Lecklide <evan@lecklider.com>
" URL:        https://github.com/evanleck/vim-svelte
if (exists('b:did_ftplugin'))
  finish
endif
let b:did_ftplugin = 1

" Matchit support
if exists('loaded_matchit') && !exists('b:match_words')
  let b:match_ignorecase = 0

  " In order:
  "
  " 1. Svelte control flow keywords.
  " 2. Parens.
  " 3-5. HTML tags pulled from Vim itself.
  "
  " https://github.com/vim/vim/blob/5259275347667a90fb88d8ea74331f88ad68edfc/runtime/ftplugin/html.vim#L29-L35
  let b:match_words =
        \ '#\%(if\|await\|each\)\>:\:\%(else\|catch\|then\)\>:\/\%(if\|await\|each\)\>,' .
        \ '{:},' .
        \ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
        \ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
        \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
endif

" ALE fixing and linting.
if exists('g:loaded_ale')
  if !exists('b:ale_fixers')
    let b:ale_fixers = ['eslint', 'prettier', 'prettier_standard']
  endif

  if !exists('b:ale_linter_aliases')
    let b:ale_linter_aliases = ['css', 'javascript']
  endif

  if !exists('b:ale_linters')
    let b:ale_linters = ['stylelint', 'eslint']
  endif
endif
