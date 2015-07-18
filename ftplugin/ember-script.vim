if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'emberscript') == -1
  
" Language:    ember-script
" Maintainer:  heartsentwined <heartsentwined@cogito-lab.com>
" URL:         http://github.com/heartsentwined/vim-ember-script
" Version:     1.0.1
" Last Change: 2013 Apr 17
" License:     GPL-3.0

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal smarttab
setlocal expandtab
setlocal smartindent

setlocal formatoptions-=t formatoptions+=croqlj
setlocal comments=:#
setlocal commentstring=#\ %s

endif
