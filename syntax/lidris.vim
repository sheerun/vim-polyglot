if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'idris') == -1

" Vim syntax file
" Language:    Literate Idris
" Maintainer:  Idris Hackers (https://github.com/idris-hackers/idris-vim)
" Last Change: 2014 Mar 4
" Version:     0.1
"
" This is just a minimal adaption of the Literate Haskell syntax file.


" Read Idris highlighting.
if version < 600
    syntax include @idrisTop <sfile>:p:h/idris.vim
else
    syntax include @idrisTop syntax/idris.vim
endif

" Recognize blocks of Bird tracks, highlight as Idris.
syntax region lidrisBirdTrackBlock start="^>" end="\%(^[^>]\)\@=" contains=@idrisTop,lidrisBirdTrack
syntax match  lidrisBirdTrack "^>" contained
hi def link   lidrisBirdTrack Comment

let b:current_syntax = "lidris"

endif
