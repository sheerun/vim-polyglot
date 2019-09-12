if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'emberscript') == -1

" Language:    ember-script
" Maintainer:  Yulij Andreevich Lesov <yalesov@gmail.com>>
" URL:         http://github.com/yalesov/vim-ember-script
" Version:     1.0.4
" Last Change: 2016 Jul 6
" License:     ISC

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal smarttab
setlocal expandtab
setlocal smartindent

if v:version < 703
  setlocal formatoptions-=t formatoptions+=croql
else
  setlocal formatoptions-=t formatoptions+=croqlj
endif
setlocal comments=:#
setlocal commentstring=#\ %s

endif
