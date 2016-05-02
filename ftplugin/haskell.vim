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
