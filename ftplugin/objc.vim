if has_key(g:polyglot_is_disabled, 'objc')
  finish
endif

" Use C++ style comment strings with commentary.vim
setl commentstring=//%s

" Search for include files inside frameworks (used for gf etc.)
setl includeexpr=substitute(v:fname,'\\([^/]\\+\\)/\\(.\\+\\)','/System/Library/Frameworks/\\1.framework/Headers/\\2','')

