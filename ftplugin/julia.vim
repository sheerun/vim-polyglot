if polyglot#init#is_disabled(expand('<sfile>:p'), 'julia', 'ftplugin/julia.vim')
  finish
endif

" Vim filetype plugin file
" Language:	Julia
" Maintainer:	Carlo Baldassi <carlobaldassi@gmail.com>
" Last Change:	2014 may 29

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo-=C

setlocal include=^\\s*\\%(reload\\\|include\\)\\>
setlocal suffixesadd=.jl
setlocal comments=:#
setlocal commentstring=#=%s=#
setlocal cinoptions+=#1
setlocal define=^\\s*macro\\>
setlocal fo-=t fo+=croql

let b:julia_vim_loaded = 1

let b:undo_ftplugin = "setlocal include< suffixesadd< comments< commentstring<"
      \ . " define< fo< shiftwidth< expandtab< indentexpr< indentkeys< cinoptions< completefunc<"
      \ . " | unlet! b:commentary_format"
      \ . " | unlet! b:smartcomment_force_linemode"
      \ . " | unlet! b:julia_vim_loaded"

" MatchIt plugin support
if exists("loaded_matchit")
  let b:match_ignorecase = 0

  " note: begin_keywords must contain all blocks, in order
  " for nested-structures-skipping to work properly
  " note: 'mutable struct' and 'struct' are defined separately because
  " using \? puts the cursor on 'struct' instead of 'mutable' for some reason
  let b:julia_begin_keywords = '\%(\.\s*\|@\)\@<!\<\%(function\|macro\|begin\|mutable\s\+struct\|\%(mutable\s\+\)\@<!struct\|\%(abstract\|primitive\)\s\+type\|let\|do\|\%(bare\)\?module\|quote\|if\|for\|while\|try\)\>'
  " note: the following regex not only recognizes macros, but also local/global keywords.
  " the purpose is recognizing things like `@inline myfunction()`
  " or `global myfunction(...)` etc, for matchit and block movement functionality
  let s:macro_regex = '\%(@\%([#(]\@!\S\)\+\|\<\%(local\|global\)\)\s\+'
  let s:nomacro = '\%(' . s:macro_regex . '\)\@<!'
  let s:yesmacro = s:nomacro . '\%('. s:macro_regex . '\)\+'
  let b:julia_begin_keywordsm = '\%(' . s:yesmacro . b:julia_begin_keywords . '\)\|'
        \ . '\%(' . s:nomacro . b:julia_begin_keywords . '\)'
  let b:julia_end_keywords = '\<end\>'

  " note: this function relies heavily on the syntax file
  function! JuliaGetMatchWords()
    let [l,c] = [line('.'),col('.')]
    let attr = synIDattr(synID(l, c, 1),"name")
    let c1 = c
    while attr == 'juliaMacro' || expand('<cword>') =~# '\<\%(global\|local\)\>'
      normal! W
      if line('.') > l || col('.') == c1
        call cursor(l, c)
        return ''
      endif
      let attr = synIDattr(synID(l, col('.'), 1),"name")
      let c1 = col('.')
    endwhile
    call cursor(l, c)
    if attr == 'juliaConditional'
      return b:julia_begin_keywordsm . ':\<\%(elseif\|else\)\>:' . b:julia_end_keywords
    elseif attr =~# '\<\%(juliaRepeat\|juliaRepKeyword\)\>'
      return b:julia_begin_keywordsm . ':\<\%(break\|continue\)\>:' . b:julia_end_keywords
    elseif attr == 'juliaBlKeyword'
      return b:julia_begin_keywordsm . ':' . b:julia_end_keywords
    elseif attr == 'juliaException'
      return b:julia_begin_keywordsm . ':\<\%(catch\|finally\)\>:' . b:julia_end_keywords
    endif
    return '\<\>:\<\>'
  endfunction

  let b:match_words = 'JuliaGetMatchWords()'

  " we need to skip everything within comments, strings and
  " the 'begin' and 'end' keywords when they are used as a range rather than as
  " the delimiter of a block
  let b:match_skip = 'synIDattr(synID(line("."),col("."),0),"name") =~# '
        \ . '"\\<julia\\%(Comprehension\\%(For\\|If\\)\\|RangeKeyword\\|Comment\\%([LM]\\|Delim\\)\\|\\%([bs]\\|Shell\\|Printf\\|Doc\\)\\?String\\|StringPrefixed\\|DocStringM\\(Raw\\)\\?\\|RegEx\\|SymbolS\\?\\|Dotted\\)\\>"'

  let b:undo_ftplugin = b:undo_ftplugin
        \ . " | unlet! b:match_words b:match_skip b:match_ignorecase"
        \ . " | unlet! b:julia_begin_keywords b:julia_end_keywords"
        \ . " | delfunction JuliaGetMatchWords"
        \ . " | call julia_blocks#remove_mappings()"

  if get(g:, "julia_blocks", 1)
    call julia_blocks#init_mappings()
    let b:undo_ftplugin .= " | call julia_blocks#remove_mappings()"
  endif

endif

" Some plugin-specific tweaks for commenting
let b:commentary_format = "# %s"           " for tpope/vim-commentary
let b:smartcomment_force_linemode = 1      " for carlobaldassi/vim-smartcomment

if has("gui_win32")
  let b:browsefilter = "Julia Source Files (*.jl)\t*.jl\n"
  let b:undo_ftplugin = b:undo_ftplugin . " | unlet! b:browsefilter"
endif

" Lookup documents
nnoremap <silent><buffer> <Plug>(JuliaDocPrompt) :<C-u>call julia#doc#prompt()<CR>
command! -nargs=1 -buffer -complete=customlist,julia#doc#complete JuliaDoc call julia#doc#open(<q-args>)
command! -nargs=1 -buffer JuliaDocKeywordprg call julia#doc#keywordprg(<q-args>)
setlocal keywordprg=:JuliaDocKeywordprg
let b:undo_ftplugin .= " | setlocal keywordprg<"
let b:undo_ftplugin .= " | delcommand JuliaDoc | delcommand JuliaDocKeywordprg"

let &cpo = s:save_cpo
unlet s:save_cpo
