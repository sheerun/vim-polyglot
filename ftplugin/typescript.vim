if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

" set Vi-incompatible, compiler and commentstring

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo-=C

compiler typescript
setlocal commentstring=//\ %s

" Set 'formatoptions' to break comment lines but not other lines,
" " and insert the comment leader when hitting <CR> or using "o".
setlocal formatoptions-=t formatoptions+=croql

" setlocal foldmethod=syntax

let &cpo = s:cpo_save
unlet s:cpo_save

function! TsIncludeExpr(file)
  if (filereadable(a:file))
    return l:file
  else
    let l:file2=substitute(a:file,'$','/index.ts','g')
    return l:file2
  endif
endfunction

set path+=./node_modules/**,node_modules/**
set include=import\_s.\\zs[^'\"]*\\ze
set includeexpr=TsIncludeExpr(v:fname)
set suffixesadd+=.ts

"
" TagBar
"
let g:tagbar_type_typescript = {
    \ 'ctagstype' : 'typescript',
    \ 'kinds'     : [
      \ 'c:classes',
      \ 'a:abstract classes',
      \ 't:types',
      \ 'n:modules',
      \ 'f:functions',
      \ 'v:variables',
      \ 'l:varlambdas',
      \ 'm:members',
      \ 'i:interfaces',
      \ 'e:enums'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
      \ 'c' : 'classes',
      \ 'a' : 'abstract classes',
      \ 't' : 'types',
      \ 'f' : 'functions',
      \ 'v' : 'variables',
      \ 'l' : 'varlambdas',
      \ 'm' : 'members',
      \ 'i' : 'interfaces',
      \ 'e' : 'enums'
    \ },
    \ 'scope2kind' : {
      \ 'classes'    : 'c',
      \ 'abstract classes'    : 'a',
      \ 'types'      : 't',
      \ 'functions'  : 'f',
      \ 'variables'  : 'v',
      \ 'varlambdas' : 'l',
      \ 'members'    : 'm',
      \ 'interfaces' : 'i',
      \ 'enums'      : 'e'
    \ }
\ }

" In case you've updated/customized your ~/.ctags and prefer to use it.
if get(g:, 'typescript_use_builtin_tagbar_defs', 1)
  let g:tagbar_type_typescript.deffile = expand('<sfile>:p:h:h') . '/ctags/typescript.ctags'
endif

endif
