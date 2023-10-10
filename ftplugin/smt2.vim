if polyglot#init#is_disabled(expand('<sfile>:p'), 'smt2', 'ftplugin/smt2.vim')
  finish
endif

setlocal iskeyword+=-,:,#,',$
setlocal commentstring=;%s

" ------------------------------------------------------------------------------
" Mappings for solver functionality
" ------------------------------------------------------------------------------
nnoremap <silent> <buffer> <Plug>Smt2Run :call smt2#solver#Run()<cr>
if !hasmapto('<Plug>Smt2Run', 'n')
    nmap <silent> <localleader>r <Plug>Smt2Run
endif

nnoremap <silent> <buffer> <Plug>Smt2RunAndShowResult :call smt2#solver#RunAndShowResult()<cr>
if !hasmapto('<Plug>Smt2RunAndShowResult', 'n')
    nmap <silent> <localleader>R <Plug>Smt2RunAndShowResult
endif

nnoremap <silent> <Plug>Smt2PrintVersion :call smt2#solver#PrintVersion()<CR>
if !hasmapto('<Plug>Smt2PrintVersion', 'n')
    nmap <silent> <localleader>v <Plug>Smt2PrintVersion
endif

" ------------------------------------------------------------------------------
" Mappings for formatting functionality
" ------------------------------------------------------------------------------
nnoremap <silent> <buffer> <Plug>Smt2FormatCurrentParagraph :call smt2#formatter#FormatCurrentParagraph()<cr>
if !hasmapto('<Plug>Smt2FormatCurrentParagraph', 'n') && (mapcheck('<localleader>f', 'n') == '')
    nmap <silent> <localleader>f <Plug>Smt2FormatCurrentParagraph
endif

" Alternative function to put on <localleader>f
nnoremap <silent> <buffer> <Plug>Smt2FormatOutermostSExpr :call smt2#formatter#FormatOutermostSExpr()<cr>

nnoremap <silent> <buffer> <Plug>Smt2FormalFile :call smt2#formatter#FormatFile()<cr>
if !hasmapto('<Plug>Smt2FormalFile', 'n')
    nmap <silent> <localleader>F <Plug>Smt2FormalFile
endif
