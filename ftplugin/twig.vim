" Vim filetype plugin
" Language: Twig
" Maintainer: F. Gabriel Gosselin <gabrielNOSPAM@evidens.ca>

if exists("b:did_ftplugin")
  finish
endif

runtime! ftplugin/html.vim ftplugin/html*.vim ftplugin/html/*.vim
unlet! b:did_ftplugin

setlocal comments=s:{#,ex:#}
setlocal formatoptions+=tcqln
" setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+

let b:undo_ftplugin .= "|setl cms< com< fo<"

" vim:set sw=2:
