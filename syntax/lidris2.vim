if polyglot#init#is_disabled(expand('<sfile>:p'), 'idris2', 'syntax/lidris2.vim')
  finish
endif

" Vim syntax file
" Language:    Literate Idris 2
" Maintainer:  Idris Hackers (https://github.com/edwinb/idris2-vim)
" Last Change: 2020 May 19
" Version:     0.1
"
" This is just a minimal adaption of the Literate Haskell syntax file.


" Read Idris highlighting.
if version < 600
    syntax include @idrisTop <sfile>:p:h/idris2.vim
else
    syntax include @idrisTop syntax/idris2.vim
endif

" Recognize blocks of Bird tracks, highlight as Idris.
syntax region lidrisBirdTrackBlock start="^>" end="\%(^[^>]\)\@=" contains=@idrisTop,lidrisBirdTrack
syntax match  lidrisBirdTrack "^>" contained
hi def link   lidrisBirdTrack Comment

let b:current_syntax = "lidris2"
