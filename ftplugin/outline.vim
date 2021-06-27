if polyglot#init#is_disabled(expand('<sfile>:p'), 'org', 'ftplugin/outline.vim')
  finish
endif

" Vim filetype plugin for GNU Emacs' Outline mode
"
" Maintainer:   Alex Vear <alex@vear.uk>
" License:      Vim (see `:help license`)
" Location:     ftplugin/outline.vim
" Website:      https://github.com/axvr/org.vim
" Last Change:  2020-01-04
"
" Reference Specification: GNU Emacs Manual, section 'Outline Mode'
"   GNU Info: `$ info Emacs Outline Mode`
"   Web: <https://www.gnu.org/software/emacs/manual/html_node/emacs/Outline-Mode.html>

setlocal foldexpr=org#fold_expr()
setlocal foldmethod=expr

if org#option('org_clean_folds', 0)
    setlocal foldtext=org#fold_text()
    setlocal fillchars-=fold:-
endif
