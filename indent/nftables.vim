if polyglot#init#is_disabled(expand('<sfile>:p'), 'nftables', 'indent/nftables.vim')
  finish
endif

" Only load this indent file when no other was loaded.
if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

setlocal cindent
setlocal cinoptions=L0,(0,Ws,J1,j1,+N
setlocal cinkeys=0{,0},!^F,o,O,0[,0]
" Don't think cinwords will actually do anything at all... never mind
setlocal cinwords=table,chain

" Some preliminary settings
setlocal nolisp         " Make sure lisp indenting doesn't supersede us
setlocal autoindent     " indentexpr isn't much help otherwise
" Also do indentkeys, otherwise # gets shoved to column 0 :-/
setlocal indentkeys=0{,0},!^F,o,O,0[,0]
