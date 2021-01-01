if polyglot#init#is_disabled(expand('<sfile>:p'), 'ansible', 'ftplugin/ansible_hosts.vim')
  finish
endif

if exists("b:did_ftplugin")
  finish
else
  let b:did_ftplugin = 1
endif

setlocal comments=:# commentstring=#\ %s formatoptions-=t formatoptions-=c

let b:undo_ftplugin = "setl comments< commentstring< formatoptions<"
