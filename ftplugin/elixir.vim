" Vim filetype plugin
" Language:    Elixir
" Maintainer:  Carlos Galdino <carloshsgaldino@gmail.com>
" URL:         https://github.com/elixir-lang/vim-elixir

if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1


" Matchit support
if exists("loaded_matchit") && !exists("b:match_words")
  let b:match_ignorecase = 0

  let b:match_words = '\<\%(do\|fn\)\:\@!\>' .
        \ ':' .
        \ '\<\%(else\|elsif\|catch\|after\|rescue\)\:\@!\>' .
        \ ':' .
        \ '\:\@<!\<end\>' .
        \ ',{:},\[:\],(:)'
endif

setlocal comments=:#
setlocal commentstring=#\ %s
