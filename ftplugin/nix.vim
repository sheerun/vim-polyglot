if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nix') == -1
  
" Vim filetype plugin
" Language:    Nix
" Maintainer:  Daiderd Jordan <daiderd@gmail.com>
" URL:         https://github.com/LnL7/vim-nix

if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1


setlocal
    \ comments=:#
    \ commentstring=#\ %s
    \ shiftwidth=2
    \ softtabstop=2
    \ expandtab
    \ iskeyword+=-

endif
