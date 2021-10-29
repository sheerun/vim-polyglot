if polyglot#init#is_disabled(expand('<sfile>:p'), 'nginx', 'ftplugin/nginx.vim')
  finish
endif

setlocal comments=:#
setlocal commentstring=#\ %s
setlocal formatoptions+=croql formatoptions-=t

let b:undo_ftplugin = "setl fo< cms< com<"
