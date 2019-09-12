if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'twig') == -1

" Vim filetype plugin
" Language: Twig
" Maintainer: F. Gabriel Gosselin <gabrielNOSPAM@evidens.ca>

if exists("b:did_ftplugin")
  finish
endif

setlocal comments=s:{#,ex:#}
setlocal formatoptions+=tcqln
" setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+

if exists('b:match_words')
    let b:twigMatchWords = [
                \ ['block', 'endblock'],
                \ ['for', 'endfor'],
                \ ['macro', 'endmacro'],
                \ ['if', 'elseif', 'else', 'endif'],
                \ ['set', 'endset']
                \]
    for s:element in b:twigMatchWords
        let s:pattern = ''
        for s:tag in s:element[:-2]
            if s:pattern != ''
                let s:pattern .= ':'
            endif
            let s:pattern .= '{%\s*\<' . s:tag . '\>\s*\%(.*=\)\@![^}]\{-}%}'
        endfor
        let s:pattern .= ':{%\s*\<' . s:element[-1:][0] . '\>\s*.\{-}%}'
        let b:match_words .= ',' . s:pattern
    endfor
endif

if exists("b:did_ftplugin")
  let b:undo_ftplugin .= "|setlocal comments< formatoptions<"
else
  let b:undo_ftplugin = "setlocal comments< formatoptions<"
endif

" vim:set sw=2:

endif
