if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'blade') == -1
  
" Vim syntax file
" Language:     Blade (Laravel)
" Maintainer:   Jason Walton <jwalton512@gmail.com>
" Filenames:    *.blade.php

if exists('b:current_syntax')
    finish
endif

if !exists("main_syntax")
    let main_syntax = 'blade'
endif

runtime! syntax/html.vim
unlet! b:current_syntax
runtime! syntax/php.vim
unlet! b:current_syntax

syn case match
syn clear htmlError

if has('patch-7.4.1142')
    syn iskeyword @,48-57,_,192-255,@-@
else
    setlocal iskeyword+=@-@
endif

syn region  bladeEcho       matchgroup=bladeDelimiter start="@\@<!{{" end="}}"  contains=@bladePhp,bladePhpParenBlock  containedin=ALLBUT,@bladeExempt keepend
syn region  bladeEcho       matchgroup=bladeDelimiter start="{!!" end="!!}"  contains=@bladePhp,bladePhpParenBlock  containedin=ALLBUT,@bladeExempt keepend
syn region  bladeComment    matchgroup=bladeDelimiter start="{{--" end="--}}"  contains=bladeTodo  containedin=ALLBUT,@bladeExempt keepend

syn keyword bladeKeyword    @if @elseif @foreach @forelse @for @while @can @include @each @inject @extends @section @stack @push @unless @yield @parent @hasSection nextgroup=bladePhpParenBlock skipwhite containedin=ALLBUT,@bladeExempt
syn keyword bladeKeyword    @else @endif @endunless @endfor @endforeach @empty @endforelse @endwhile @endcan @stop @append @endsection @endpush @show containedin=ALLBUT,@bladeExempt

syn region  bladePhpParenBlock  matchgroup=bladeDelimiter start="\s*(" end=")" contains=@bladePhp,bladePhpParenBlock skipwhite contained

syn cluster bladePhp contains=@phpClTop
syn cluster bladeExempt contains=bladeComment,@htmlTop

syn cluster htmlPreproc add=bladeEcho,bladeComment

syn keyword bladeTodo todo fixme xxx  contained

hi def link bladeDelimiter      PreProc
hi def link bladeComment        Comment
hi def link bladeTodo           Todo
hi def link bladeKeyword        Statement

let b:current_syntax = 'blade'

if exists('main_syntax') && main_syntax == 'blade'
    unlet main_syntax
endif

endif
