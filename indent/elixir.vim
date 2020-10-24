let files = filter(globpath(&rtp, 'indent/elixir.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elixir') == -1

if exists("b:did_indent")
  finish
end
let b:did_indent = 1

setlocal indentexpr=elixir#indent(v:lnum)

setlocal indentkeys+==after,=catch,=do,=else,=end,=rescue,
setlocal indentkeys+=*<Return>,=->,=\|>,=<>,0},0],0)

" TODO: @jbodah 2017-02-27: all operators should cause reindent when typed

function! elixir#indent(lnum)
  return elixir#indent#indent(a:lnum)
endfunction

endif
