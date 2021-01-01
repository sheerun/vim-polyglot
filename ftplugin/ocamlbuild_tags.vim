if polyglot#init#is_disabled(expand('<sfile>:p'), 'ocaml', 'ftplugin/ocamlbuild_tags.vim')
  finish
endif


setlocal comments=:#
setlocal commentstring=#\ %s
