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

setlocal shiftwidth=2 softtabstop=2 expandtab iskeyword+=!,?
setlocal comments=:#
setlocal commentstring=#\ %s

let &l:path =
      \ join([
      \   'lib',
      \   'src',
      \   'deps/**/lib',
      \   'deps/**/src',
      \   &g:path
      \ ], ',')
setlocal includeexpr=elixir#util#get_filename(v:fname)
setlocal suffixesadd=.ex,.exs,.eex,.erl,.yrl,.hrl

silent! setlocal formatoptions-=t formatoptions+=croqlj

let b:undo_ftplugin = 'setlocal sw< sts< et< isk< com< cms< path< inex< sua< '.
      \ '| unlet! b:match_ignorecase b:match_words'

endif
