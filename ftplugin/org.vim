if polyglot#init#is_disabled(expand('<sfile>:p'), 'org', 'ftplugin/org.vim')
  finish
endif

" Vim filetype plugin for GNU Emacs' Org mode
"
" Maintainer:   Alex Vear <alex@vear.uk>
" License:      Vim (see `:help license`)
" Location:     ftplugin/org.vim
" Website:      https://github.com/axvr/org.vim
" Last Change:  2020-02-15
"
" Reference Specification: Org mode manual
"   GNU Info: `$ info Org`
"   Web: <https://orgmode.org/manual/index.html>

setlocal commentstring=#%s
setlocal comments=fb:*,fb:-,fb:+,b:#,b:\:
setlocal formatoptions+=ncqlt
let &l:formatlistpat = '^\s*\(\d\+[.)]\|[+-]\)\s\+'

setlocal foldexpr=org#fold_expr()
setlocal foldmethod=expr

if org#option('org_clean_folds', 0)
    setlocal foldtext=org#fold_text()
    setlocal fillchars-=fold:-
endif
