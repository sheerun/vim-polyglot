if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'git') == -1

" Vim filetype plugin
" Language:	git rebase --interactive
" Maintainer:	Tim Pope <vimNOSPAM@tpope.org>
" Last Change:	2010 May 21

" Only do this when not done yet for this buffer
if (exists("b:did_ftplugin"))
  finish
endif

runtime! ftplugin/git.vim
let b:did_ftplugin = 1

setlocal comments=:# commentstring=#\ %s formatoptions-=t
setlocal nomodeline
if !exists("b:undo_ftplugin")
  let b:undo_ftplugin = ""
endif
let b:undo_ftplugin = b:undo_ftplugin."|setl com< cms< fo< ml<"

function! s:choose(word)
  s/^\(\w\+\>\)\=\(\s*\)\ze\x\{4,40\}\>/\=(strlen(submatch(1)) == 1 ? a:word[0] : a:word) . substitute(submatch(2),'^$',' ','')/e
endfunction

function! s:cycle()
  call s:choose(get({'s':'edit','p':'squash','e':'reword','r':'fixup'},getline('.')[0],'pick'))
endfunction

command! -buffer -bar -range Pick   :<line1>,<line2>call s:choose('pick')
command! -buffer -bar -range Squash :<line1>,<line2>call s:choose('squash')
command! -buffer -bar -range Edit   :<line1>,<line2>call s:choose('edit')
command! -buffer -bar -range Reword :<line1>,<line2>call s:choose('reword')
command! -buffer -bar -range Fixup  :<line1>,<line2>call s:choose('fixup')
command! -buffer -bar -range Drop   :<line1>,<line2>call s:choose('drop')
command! -buffer -bar Cycle  :call s:cycle()
" The above are more useful when they are mapped; for example:
"nnoremap <buffer> <silent> S :Cycle<CR>

if exists("g:no_plugin_maps") || exists("g:no_gitrebase_maps")
  finish
endif

nnoremap <buffer> <expr> K col('.') < 7 && expand('<Lt>cword>') =~ '\X' && getline('.') =~ '^\w\+\s\+\x\+\>' ? 'wK' : 'K'

let b:undo_ftplugin = b:undo_ftplugin . "|nunmap <buffer> K"

endif
