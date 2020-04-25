if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'latex') == -1

" vimtex - LaTeX plugin for Vim
"
" Maintainer: Karl Yngve Lervåg
" Email:      karl.yngve@gmail.com
"

function! vimtex#syntax#p#csquotes#load() abort " {{{1
  if has_key(b:vimtex_syntax, 'csquotes') | return | endif
  let b:vimtex_syntax.csquotes = 1

  call vimtex#syntax#p#biblatex#load()
endfunction

" }}}1

endif
