if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cue') == -1

" Language:    Cue sheet
" Maintainer:  Matěj Grabovský
" URL:         http://github.com/mgrabovsky
" License:     MIT

" Bail if our syntax is already loaded.
if exists('b:current_syntax') && b:current_syntax == 'cuesheet'
  finish
endif

syn case match
setl conceallevel=2

syn region String matchgroup=cueString start=/"/ skip=/\\"/ end=/"/
      \ transparent contains=NONE
syn region Comment start=/^\s*REM / end=/$/ contains=specialComment
syn keyword SpecialComment COMMENT DATE DISCID GENRE
syn keyword Function CATALOG CDTEXTFILE FILE FLAGS INDEX ISRC PERFORMER POSTGAP
      \ PREGAP SONGWRITER TITLE TRACK
syn keyword StorageClass AIFF AUDIO MP3 WAVE
syn match Number /[+-]\=\<\d\+\%(\.\d\+\)\=\>/
syn match Number /\<\d\+\%(:\d\{2}\)\{2}\>/

let b:current_syntax='cuesheet'

" vim: nowrap sw=2 sts=2 ts=8:

endif
