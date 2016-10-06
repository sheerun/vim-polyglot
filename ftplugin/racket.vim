if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'racket') == -1

" Language:     Racket
" Maintainer:   Will Langstroth <will@langstroth.com>
" URL:          http://github.com/wlangstroth/vim-racket

setl iskeyword+=#,%,^
setl lispwords+=module,module*,module+,parameterize,let-values,let*-values,letrec-values,local
setl lispwords+=define-values,opt-lambda,case-lambda,syntax-rules,with-syntax,syntax-case,syntax-parse
setl lispwords+=define-signature,unit,unit/sig,compund-unit/sig,define-values/invoke-unit/sig
setl lispwords+=define-opt/c
setl lispwords+=struct

" Racket OOP
setl lispwords+=class,define/public,define/private

" kanren
setl lispwords+=fresh,run,run*,project,conde,condu

" loops
setl lispwords+=for,for/list,for/fold,for*,for*/list,for*/fold,for/or,for/and
setl lispwords+=for/hash,for/sum,for/flvector,for*/flvector,for/vector

setl lispwords+=match,match*,match/values,define/match,match-lambda,match-lambda*,match-lambda**
setl lispwords+=match-let,match-let*,match-let-values,match-let*-values
setl lispwords+=match-letrec,match-define,match-define-values
setl lisp

" Enable auto begin new comment line when continuing from an old comment line
setl comments+=:;
setl formatoptions+=r

setl makeprg=raco\ make\ --\ %

" Simply setting keywordprg like this works:
"    setl keywordprg=raco\ docs
" but then vim says:
"    "press ENTER or type a command to continue"
" We avoid the annoyance of having to hit enter by remapping K directly.
nnoremap <buffer> K :silent !raco docs <cword><cr>:redraw!<cr>

" For the visual mode K mapping, it's slightly more convoluted to get the 
" selected text:
function! s:Racket_visual_doc()
  try
    let l:old_a = @a
    normal! gv"ay
    call system("raco docs '". @a . "'")
    redraw!
    return @a
  finally
    let @a = l:old_a
  endtry
endfunction

vnoremap <buffer> K :call <SID>Racket_visual_doc()<cr>

nnoremap <buffer> <f9> :!racket -t %<cr>

"setl commentstring=;;%s
setl commentstring=#\|\ %s\ \|#

" Search installed racket documentation for key terms in default browser
command! -nargs=* RktDocs :silent execute "!raco docs" '<args>' | redraw!

" Build standalone executable against current file
command! RktExe  execute "!raco exe --vv %"

" Open a racket/base XREPL
command! RktREPL execute "!racket -l racket/base -e '(require xrepl)' -i"

" Make .zo from current file and use n number of tasks based on CPU cores to do so
command! RktMake execute "!raco make -j $(grep -c ^processor /proc/cpuinfo) -v %"

" Print current racket version and run current file
command! RktRun  execute "!racket --version && racket %"

" Run tests against current file
command! RktTest execute "!raco test -j $(grep -c ^processor /proc/cpuinfo) %"

endif
