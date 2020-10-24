let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'autoload/vital/_crystal.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'crystal') == -1

let s:_plugin_name = expand('<sfile>:t:r')

function! vital#{s:_plugin_name}#new() abort
  return vital#{s:_plugin_name[1:]}#new()
endfunction

function! vital#{s:_plugin_name}#function(funcname) abort
  silent! return function(a:funcname)
endfunction

endif
