if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elixir') == -1
  
if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1


" Matchit support
if exists("loaded_matchit") && !exists("b:match_words")
  let b:match_ignorecase = 0

  let b:match_words = '\:\@<!\<\%(do\|fn\)\:\@!\>' .
        \ ':' .
        \ '\<\%(else\|elsif\|catch\|after\|rescue\)\:\@!\>' .
        \ ':' .
        \ '\:\@<!\<end\>' .
        \ ',{:},\[:\],(:)'
endif

setlocal comments=:#
setlocal commentstring=#\ %s

endif
