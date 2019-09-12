if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'livescript') == -1

" Language:    LiveScript
" Maintainer:  George Zahariev
" URL:         http://github.com/gkz/vim-ls
" License:     WTFPL

if exists('current_compiler')
  finish
endif

let current_compiler = 'ls'
" Pattern to check if livescript is the compiler
let s:pat = '^' . current_compiler

" Path to LiveScript compiler
if !exists('livescript_compiler')
  let livescript_compiler = 'lsc'
endif

if !exists('livescript_make_options')
  let livescript_make_options = ''
endif

" Get a `makeprg` for the current filename. This is needed to support filenames
" with spaces and quotes, but also not break generic `make`.
function! s:GetMakePrg()
  return g:livescript_compiler . ' -c ' . g:livescript_make_options . ' $* '
  \                      . fnameescape(expand('%'))
endfunction

" Set `makeprg` and return 1 if coffee is still the compiler, else return 0.
function! s:SetMakePrg()
  if &l:makeprg =~ s:pat
    let &l:makeprg = s:GetMakePrg()
  elseif &g:makeprg =~ s:pat
    let &g:makeprg = s:GetMakePrg()
  else
    return 0
  endif

  return 1
endfunction

" Set a dummy compiler so we can check whether to set locally or globally.
CompilerSet makeprg=ls
call s:SetMakePrg()

CompilerSet errorformat=%EFailed\ at:\ %f,
                       \%ECan't\ find:\ %f,
                       \%CSyntaxError:\ %m\ on\ line\ %l,
                       \%CError:\ Parse\ error\ on\ line\ %l:\ %m,
                       \%C,%C\ %.%#

" Compile the current file.
command! -bang -bar -nargs=* LiveScriptMake make<bang> <args>

" Set `makeprg` on rename since we embed the filename in the setting.
augroup LiveScriptUpdateMakePrg
  autocmd!

  " Update `makeprg` if livescript is still the compiler, else stop running this
  " function.
  function! s:UpdateMakePrg()
    if !s:SetMakePrg()
      autocmd! LiveScriptUpdateMakePrg
    endif
  endfunction

  " Set autocmd locally if compiler was set locally.
  if &l:makeprg =~ s:pat
    autocmd BufFilePost,BufWritePost <buffer> call s:UpdateMakePrg()
  else
    autocmd BufFilePost,BufWritePost          call s:UpdateMakePrg()
  endif
augroup END

endif
