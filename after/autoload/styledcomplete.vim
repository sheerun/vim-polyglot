if exists('g:polyglot_disabled')
  \ && index(g:polyglot_disabled, 'javascript') != -1
  \ && index(g:polyglot_disabled, 'jsx') != -1
  finish
endif

" Vim completion script
" Language:   styled-components (js/ts)
" Maintainer: Karl Fleischmann <fleischmann.karl@gmail.com>
" URL:        https://github.com/styled-components/vim-styled-components

fun! styledcomplete#CompleteSC(findstart, base)
  if IsStyledDefinition(line('.'))
    return csscomplete#CompleteCSS(a:findstart, a:base)
  endif

  " Only trigger original omnifunc if it was set in the first place
  if exists('b:prevofu')
    " create a funcref to call with the previous omnicomplete function
    let s:funcref = function(b:prevofu)
    return s:funcref(a:findstart, a:base)
  endif
endfun
