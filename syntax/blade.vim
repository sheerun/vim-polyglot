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
    syn iskeyword @,48-57,_,192-255,@-@,:
else
    setlocal iskeyword+=@-@
endif

syn region  bladeEcho       matchgroup=bladeDelimiter start="@\@<!{{" end="}}"  contains=@bladePhp,bladePhpParenBlock  containedin=ALLBUT,@bladeExempt keepend
syn region  bladeEcho       matchgroup=bladeDelimiter start="{!!" end="!!}"  contains=@bladePhp,bladePhpParenBlock  containedin=ALLBUT,@bladeExempt keepend
syn region  bladeComment    matchgroup=bladeDelimiter start="{{--" end="--}}"  contains=bladeTodo  containedin=ALLBUT,@bladeExempt keepend

syn keyword bladeKeyword @if @elseif @foreach @forelse @for @while @can @cannot @elsecan @elsecannot @include
    \ @includeIf @each @inject @extends @section @stack @push @unless @yield @parent @hasSection @break @continue
    \ @unset @lang @choice @component @slot @prepend @json @isset @auth @guest @switch @case @includeFirst @empty
    \ @includeWhen
    \ nextgroup=bladePhpParenBlock skipwhite containedin=ALLBUT,@bladeExempt

syn keyword bladeKeyword @else @endif @endunless @endfor @endforeach @endforelse @endwhile @endcan
    \ @endcannot @stop @append @endsection @endpush @show @overwrite @verbatim @endverbatim @endcomponent
    \ @endslot @endprepend @endisset @endempty @endauth @endguest @endswitch
    \ containedin=ALLBUT,@bladeExempt

if exists('g:blade_custom_directives')
    exe "syn keyword bladeKeyword @" . join(g:blade_custom_directives, ' @') . " nextgroup=bladePhpParenBlock skipwhite containedin=ALLBUT,@bladeExempt"
endif
if exists('g:blade_custom_directives_pairs')
    exe "syn keyword bladeKeyword @" . join(keys(g:blade_custom_directives_pairs), ' @') . " nextgroup=bladePhpParenBlock skipwhite containedin=ALLBUT,@bladeExempt"
    exe "syn keyword bladeKeyword @" . join(values(g:blade_custom_directives_pairs), ' @') . " containedin=ALLBUT,@bladeExempt"
endif

syn region  bladePhpRegion  matchgroup=bladeKeyword start="\<@php\>\s*(\@!" end="\<@endphp\>"  contains=@bladePhp  containedin=ALLBUT,@bladeExempt keepend
syn match   bladeKeyword "@php\ze\s*(" nextgroup=bladePhpParenBlock skipwhite containedin=ALLBUT,@bladeExempt

syn region  bladePhpParenBlock  matchgroup=bladeDelimiter start="\s*(" end=")" contains=@bladePhp,bladePhpParenBlock skipwhite contained

syn cluster bladePhp contains=@phpClTop
syn cluster bladeExempt contains=bladeComment,bladePhpRegion,bladePhpParenBlock,@htmlTop

syn cluster htmlPreproc add=bladeEcho,bladeComment,bladePhpRegion

syn case ignore
syn keyword bladeTodo todo fixme xxx note  contained

hi def link bladeDelimiter      PreProc
hi def link bladeComment        Comment
hi def link bladeTodo           Todo
hi def link bladeKeyword        Statement

let b:current_syntax = 'blade'

if exists('main_syntax') && main_syntax == 'blade'
    unlet main_syntax
endif

endif
