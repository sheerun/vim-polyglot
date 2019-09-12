if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1

" Vim compiler plugin
" Language:     JavaScript
" Maintainer:   vim-javascript community
" URL:          https://github.com/pangloss/vim-javascript

if exists("current_compiler")
  finish
endif
let current_compiler = "eslint"

if exists(":CompilerSet") != 2
  command! -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=eslint\ -f\ compact\ %
CompilerSet errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m

endif
