if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vim') == -1
  
" Vim filetype plugin file
" Language:             Haskell
" Previous Maintainer:  Nikolai Weibull <now@bitwi.se>
" Latest Revision:      2008-07-09

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

let b:undo_ftplugin = "setl com< cms< fo<"

setlocal comments=s1fl:{-,mb:-,ex:-},:-- commentstring=--\ %s
setlocal formatoptions-=t formatoptions+=croql

let &cpo = s:cpo_save
unlet s:cpo_save

endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haskell') == -1
  
if exists("g:loaded_haskellvim_haskell")
  finish
endif

let g:loaded_haskellvim_haskell = 1

function! haskell#sortImports(line1, line2)
  exe a:line1 . "," . a:line2 . "sort /import\\s\\+\\(qualified\\s\\+\\)\\?/"
endfunction

function! haskell#formatImport(line1, line2)
  exec a:line1 . ",". a:line2 . "s/import\\s\\+\\([A-Z].*\\)/import           \\1"
endfunction

command! -buffer -range HaskellSortImports call haskell#sortImports(<line1>, <line2>)
command! -buffer -range HaskellFormatImport call haskell#formatImport(<line1>, <line2>)

endif
