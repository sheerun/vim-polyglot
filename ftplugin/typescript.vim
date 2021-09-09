if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'ftplugin/typescript.vim')
  finish
endif

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

if !&l:formatexpr && !&l:formatprg
    setlocal formatexpr=Fixedgq(v:lnum,v:count)
endif

" setlocal foldmethod=syntax

let &cpo = s:cpo_save
unlet s:cpo_save

function! Fixedgq(lnum, count)
    let l:tw = &tw ? &tw : 80

    let l:count = a:count
    let l:first_char = indent(a:lnum) + 1

    if mode() == 'i' " gq was not pressed, but tw was set
        return 1
    endif

    " This gq is only meant to do code with strings, not comments
    if yats#IsLineComment(a:lnum, l:first_char) || yats#IsInMultilineComment(a:lnum, l:first_char)
        return 1
    endif

    if len(getline(a:lnum)) < l:tw && l:count == 1 " No need for gq
        return 1
    endif

    " Put all the lines on one line and do normal splitting after that
    if l:count > 1
        while l:count > 1
            let l:count -= 1
            normal! J
        endwhile
    endif

    let l:winview = winsaveview()

    call cursor(a:lnum, l:tw + 1)
    let orig_breakpoint = searchpairpos(' ', '', '\.', 'bcW', '', a:lnum)
    call cursor(a:lnum, l:tw + 1)
    let breakpoint = searchpairpos(' ', '', '\.', 'bcW', s:skip_expr, a:lnum)

    " No need for special treatment, normal gq handles edgecases better
    if breakpoint[1] == orig_breakpoint[1]
        call winrestview(l:winview)
        return 1
    endif

    " Try breaking after string
    if breakpoint[1] <= indent(a:lnum)
        call cursor(a:lnum, l:tw + 1)
        let breakpoint = searchpairpos('\.', '', ' ', 'cW', s:skip_expr, a:lnum)
    endif


    if breakpoint[1] != 0
        call feedkeys("r\<CR>")
    else
        let l:count = l:count - 1
    endif

    " run gq on new lines
    if l:count == 1
        call feedkeys("gqq")
    endif

    return 0
endfunction

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
