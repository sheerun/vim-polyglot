if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'javascript') != -1
  finish
endif

" Vim filetype plugin file
" Language:     JavaScript
" Maintainer:   vim-javascript community
" URL:          https://github.com/pangloss/vim-javascript

setlocal iskeyword+=$ suffixesadd+=.js

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | setlocal iskeyword< suffixesadd<'
else
  let b:undo_ftplugin = 'setlocal iskeyword< suffixesadd<'
endif
if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'jsx') != -1
  finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim ftplugin file
"
" Language: javascript.jsx
" Maintainer: MaxMEllon <maxmellon1994@gmail.com>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" modified from html.vim
" For matchit plugin
if exists("loaded_matchit")
  let b:match_ignorecase = 0
  let b:match_words = '(:),\[:\],{:},<:>,' .
        \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
endif

" For andymass/vim-matchup plugin
if exists("loaded_matchup")
  setlocal matchpairs=(:),{:},[:],<:>
  let b:match_words = '<\@<=\([^/][^ \t>]*\)\g{hlend}[^>]*\%(/\@<!>\|$\):<\@<=/\1>'
  let b:match_skip = 's:comment\|string'
endif

let b:original_commentstring = &l:commentstring

augroup jsx_comment
  autocmd! CursorMoved <buffer>
  autocmd CursorMoved <buffer> call jsx_pretty#comment#update_commentstring(b:original_commentstring)
augroup end

setlocal suffixesadd+=.jsx
if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'styled-components') != -1
  finish
endif

" Vim filetype plugin file
" Language:   styled-components (js/ts)
" Maintainer: Karl Fleischmann <fleischmann.karl@gmail.com>
" URL:        https://github.com/styled-components/vim-styled-components

fu! s:GetSyntaxNames(lnum, cnum)
  return map(synstack(a:lnum, a:cnum), 'synIDattr(v:val, "name")')
endfu

" re-implement SynSOL of vim-jsx
fu! s:SynSOL(lnum)
  return s:GetSyntaxNames(a:lnum, 1)
endfu

"" Return whether the current line is a jsTemplateString
fu! IsStyledDefinition(lnum)
  " iterate through all syntax items in the given line
  for item in s:SynSOL(a:lnum)
    " if syntax-item is a jsTemplateString return 1 - true
    " `==#` is a match case comparison of the item
    if item ==# 'styledDefinition'
      return 1
    endif
  endfor

  " fallback to 0 - false
  return 0
endfu

if exists('&ofu')
  let b:prevofu=&ofu
  setl omnifunc=styledcomplete#CompleteSC
endif
