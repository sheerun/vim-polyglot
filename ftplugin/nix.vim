if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nix') == -1
  
if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin=1

setlocal comments=
setlocal commentstring=#\ %s

" Nixpkgs indent settings
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab

endif
