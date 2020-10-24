let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/objc.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'objc') == -1

" Use C++ style comment strings with commentary.vim
setl commentstring=//%s

" Search for include files inside frameworks (used for gf etc.)
setl includeexpr=substitute(v:fname,'\\([^/]\\+\\)/\\(.\\+\\)','/System/Library/Frameworks/\\1.framework/Headers/\\2','')


endif
