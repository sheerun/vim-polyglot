let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'extras/ngdoc.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1

syntax match  jsDocTags         contained /@\(link\|method[oO]f\|ngdoc\|ng[iI]nject\|restrict\)/ nextgroup=jsDocParam skipwhite
syntax match  jsDocType         contained "\%(#\|\$\|\w\|\"\|-\|\.\|:\|\/\)\+" nextgroup=jsDocParam skipwhite
syntax match  jsDocParam        contained "\%(#\|\$\|\w\|\"\|-\|\.\|:\|{\|}\|\/\|\[\|]\|=\)\+"

endif
