"
" Support for Tagbar -- https://github.com/majutsushi/tagbar
"
" Hat tip to Leonard Ehrenfried for the built-in ctags deffile:
"    https://leonard.io/blog/2013/04/editing-scala-with-vim/
"
if !exists(':Tagbar')
  finish
endif

let g:tagbar_type_scala = {
    \ 'ctagstype' : 'scala',
    \ 'kinds'     : [
      \ 'p:packages:1',
      \ 'V:values',
      \ 'v:variables',
      \ 'T:types',
      \ 't:traits',
      \ 'o:objects',
      \ 'a:aclasses',
      \ 'c:classes',
      \ 'r:cclasses',
      \ 'm:methods'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'T' : 'type',
        \ 't' : 'trait',
        \ 'o' : 'object',
        \ 'a' : 'abstract class',
        \ 'c' : 'class',
        \ 'r' : 'case class'
    \ },
    \ 'scope2kind' : {
      \ 'type' : 'T',
      \ 'trait' : 't',
      \ 'object' : 'o',
      \ 'abstract class' : 'a',
      \ 'class' : 'c',
      \ 'case class' : 'r'
    \ }
\ }

" In case you've updated/customized your ~/.ctags and prefer to use it.
if get(g:, 'scala_use_builtin_tagbar_defs', 1)
  let g:tagbar_type_scala.deffile = expand('<sfile>:p:h:h:h') . '/ctags/scala.ctags'
endif
