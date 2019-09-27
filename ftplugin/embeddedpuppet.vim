if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'puppet') == -1

" Vim filetype plugin
" Language:             embedded puppet
" Maintainer:           Gabriel Filion <gabster@lelutin.ca>
" URL:                  https://github.com/rodjek/vim-puppet
" Last Change:          2019-09-01

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

let s:save_cpo = &cpo
set cpo-=C

" Define some defaults in case the included ftplugins don't set them.
let s:undo_ftplugin = ""
let s:browsefilter = "All Files (*.*)\t*.*\n"
let s:match_words = ""

runtime! ftplugin/sh.vim
unlet! b:did_ftplugin

" Override our defaults if these were set by an included ftplugin.
if exists("b:undo_ftplugin")
  let s:undo_ftplugin = b:undo_ftplugin
  unlet b:undo_ftplugin
endif
if exists("b:browsefilter")
  let s:browsefilter = b:browsefilter
  unlet b:browsefilter
endif
if exists("b:match_words")
  let s:match_words = b:match_words
  unlet b:match_words
endif

let s:include = &l:include
let s:path = &l:path
let s:suffixesadd = &l:suffixesadd

runtime! ftplugin/puppet.vim
let b:did_ftplugin = 1

" Combine the new set of values with those previously included.
if exists("b:undo_ftplugin")
  let s:undo_ftplugin = b:undo_ftplugin . " | " . s:undo_ftplugin
endif
if exists ("b:browsefilter")
  let s:browsefilter = substitute(b:browsefilter,'\cAll Files (\*\.\*)\t\*\.\*\n','','') . s:browsefilter
endif
if exists("b:match_words")
  let s:match_words = b:match_words . ',' . s:match_words
endif

if len(s:include)
  let &l:include = s:include
endif
let &l:path = s:path . (s:path =~# ',$\|^$' ? '' : ',') . &l:path
let &l:suffixesadd = s:suffixesadd . (s:suffixesadd =~# ',$\|^$' ? '' : ',') . &l:suffixesadd
unlet s:include s:path s:suffixesadd

" Load the combined list of match_words for matchit.vim
if exists("loaded_matchit")
  let b:match_words = s:match_words
endif

" TODO: comments=
setlocal commentstring=<%#%s%>

let b:undo_ftplugin = "setl cms< "
      \ " | unlet! b:browsefilter b:match_words | " . s:undo_ftplugin

let &cpo = s:save_cpo
unlet s:save_cpo


endif
