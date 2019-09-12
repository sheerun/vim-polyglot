if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'graphql') == -1

" Vim filetype plugin
" Language: GraphQL
" Maintainer: Jon Parise <jon@indelible.org>

if (exists('b:did_ftplugin'))
  finish
endif
let b:did_ftplugin = 1

setlocal comments=:#
setlocal commentstring=#\ %s
setlocal formatoptions-=t
setlocal iskeyword+=$,@-@
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab

let b:undo_ftplugin = 'setlocal com< cms< fo< isk< sts< sw< et<'

endif
