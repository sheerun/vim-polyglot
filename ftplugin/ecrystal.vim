if has_key(g:polyglot_is_disabled, 'crystal')
  finish
endif

" Filetype plugin for https://crystal-lang.org/api/0.35.1/ECR.html
if exists('b:did_ftplugin')
  finish
endif

" Define some defaults in case the included ftplugins don't set them.
let s:comments = ''
let s:shiftwidth = ''
let s:undo_ftplugin = ''
let s:browsefilter = 'All Files (*.*)\t*.*\n'
let s:match_words = ''

call ecrystal#SetSubtype()

if b:ecrystal_subtype !=# ''
  exe 'runtime! ftplugin/'.b:ecrystal_subtype.'.vim ftplugin/'.b:ecrystal_subtype.'_*.vim ftplugin/'.b:ecrystal_subtype.'/*.vim'
  unlet! b:did_ftplugin

  " Keep the comments for this filetype
  let s:comments = escape(&comments, ' \')

  " Keep the shiftwidth for this filetype
  let s:shiftwidth = &shiftwidth

  " Override our defaults if these were set by an included ftplugin.
  if exists('b:undo_ftplugin')
    let s:undo_ftplugin = b:undo_ftplugin
    unlet b:undo_ftplugin
  endif
  if exists('b:browsefilter')
    let s:browsefilter = b:browsefilter
    unlet b:browsefilter
  endif
  if exists('b:match_words')
    let s:match_words = b:match_words
    unlet b:match_words
  endif
endif

runtime! ftplugin/crystal.vim ftplugin/crystal_*.vim ftplugin/crystal/*.vim
let b:did_ftplugin = 1

" Combine the new set of values with those previously included.
if exists('b:undo_ftplugin')
  let s:undo_ftplugin = b:undo_ftplugin . ' | ' . s:undo_ftplugin
endif
if exists ('b:browsefilter')
  let s:browsefilter = substitute(b:browsefilter,'\cAll Files (\*\.\*)\t\*\.\*\n','','') . s:browsefilter
endif
if exists('b:match_words')
  let s:match_words = b:match_words . ',' . s:match_words
endif

" Change the browse dialog on Win32 to show mainly eCrystal-related files
if has('gui_win32')
  let b:browsefilter='eCrystal Files (*.ecr)\t*.ecr\n' . s:browsefilter
endif

" Load the combined list of match_words for matchit.vim
if exists('loaded_matchit')
  let b:match_words = s:match_words
endif

" Define additional pairs for jiangmiao/auto-pairs
if exists('AutoPairsLoaded')
  let b:AutoPairs = {
        \ '<%': '%>',
        \ '<%=': '%>',
        \ '<%#': '%>',
        \ '<%-': '-%>',
        \ '<%-=': '-%>',
        \ '<%-#': '-%>',
        \ }

  call extend(b:AutoPairs, g:AutoPairs, 'force')
endif

" Load the subtype's vim-endwise settings
if exists('loaded_endwise') && b:ecrystal_subtype !=# ''
  exec 'doautocmd endwise FileType ' . b:ecrystal_subtype
endif

" Start RagTag
if exists('loaded_ragtag')
  call RagtagInit()
endif

exec 'setlocal comments='.s:comments
exec 'setlocal shiftwidth='.s:shiftwidth
setlocal commentstring=<%#%s%>

setlocal suffixesadd=.ecr

let b:undo_ftplugin = 'setlocal comments< commentstring< shiftwidth<' .
      \ '| unlet! b:browsefilter b:match_words ' .
      \ '| unlet! b:AutoPairs ' .
      \ '| ' . s:undo_ftplugin
