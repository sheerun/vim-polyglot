let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/gitconfig.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'git') == -1

" Vim indent file
" Language:	git config file
" Maintainer:	Tim Pope <vimNOSPAM@tpope.org>
" Last Change:	2017 Jun 13

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal autoindent
setlocal indentexpr=GetGitconfigIndent()
setlocal indentkeys=o,O,*<Return>,0[,],0;,0#,=,!^F

let b:undo_indent = 'setl ai< inde< indk<'

" Only define the function once.
if exists("*GetGitconfigIndent")
  finish
endif

function! GetGitconfigIndent()
  let sw    = shiftwidth()
  let line  = getline(prevnonblank(v:lnum-1))
  let cline = getline(v:lnum)
  if line =~  '\\\@<!\%(\\\\\)*\\$'
    " odd number of slashes, in a line continuation
    return 2 * sw
  elseif cline =~ '^\s*\['
    return 0
  elseif cline =~ '^\s*\a'
    return sw
  elseif cline == ''       && line =~ '^\['
    return sw
  else
    return -1
  endif
endfunction

endif
