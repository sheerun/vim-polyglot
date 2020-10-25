if !polyglot#util#IsEnabled('objc', expand('<sfile>:p'))
  finish
endif

" Use C++ style comment strings with commentary.vim
setl commentstring=//%s

" Search for include files inside frameworks (used for gf etc.)
setl includeexpr=substitute(v:fname,'\\([^/]\\+\\)/\\(.\\+\\)','/System/Library/Frameworks/\\1.framework/Headers/\\2','')

