if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'tmux') == -1
  
if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal comments=:#
setlocal commentstring=#\ %s

if v:version > 704 || v:version == 704 && has('patch32')
  let s:map_dict = maparg('K', 'n', 0, 1)
  if empty(s:map_dict) || ! s:map_dict['buffer']
    nnoremap <silent><buffer> K :call tmux#man()<CR>
  endif
elseif maparg('K','n') ==# ''
  nnoremap <silent><buffer> K :call tmux#man()<CR>
endif

nnoremap <silent> <Plug>TmuxExec :<C-U>set opfunc=tmux#filterop<CR>g@
xnoremap <silent> <Plug>TmuxExec :<C-U>call tmux#filterop(visualmode())<CR>
nmap <buffer> g! <Plug>TmuxExec
nmap <buffer> g!! <Plug>TmuxExec_
xmap <buffer> g! <Plug>TmuxExec

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8:

endif
