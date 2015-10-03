" Vim ftplugin file
" Language: Haskell
" Maintainer: Tristan Ravitch

" I don't fully understand what the vim-default ftplugin does, but I do know
" that the three-part comment entry really messes up this indenter (I also
" hate the leading '-'s it puts in on each line).  Disable it here.
setlocal comments&
setlocal comments=:--
