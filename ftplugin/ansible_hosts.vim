let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/ansible_hosts.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ansible') == -1

if exists("b:did_ftplugin")
  finish
else
  let b:did_ftplugin = 1
endif

setlocal comments=:# commentstring=#\ %s formatoptions-=t formatoptions-=c

let b:undo_ftplugin = "setl comments< commentstring< formatoptions<"

endif
