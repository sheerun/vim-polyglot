if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'conky') == -1

  " Vim filetype detection file for Conky config files
  "
  au BufNewFile,BufRead *conkyrc set filetype=conkyrc
  au BufNewFile,BufRead conky.conf set filetype=conkyrc

endif
