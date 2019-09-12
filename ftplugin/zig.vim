if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'zig') == -1

" Only do this when not done yet for this buffer
if (exists("b:did_ftplugin"))
  finish
endif

let b:did_ftplugin = 1

set expandtab
set tabstop=4
set shiftwidth=4

setlocal suffixesadd=.zig
setlocal commentstring=//\ %s
setlocal makeprg=zig\ build

endif
