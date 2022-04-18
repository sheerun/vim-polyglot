if polyglot#init#is_disabled(expand('<sfile>:p'), 'svelte', 'syntax/svelte.vim')
  finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim syntax file
"
" Language: Svelte
" Maintainer: leaf <leafvocation@gmail.com>
"
" CREDITS: Inspired by mxw/vim-jsx.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists("b:current_syntax") && b:current_syntax == 'svelte'
  finish
endif

" For advanced users, this variable can be used to avoid overload
let b:current_loading_main_syntax = 'svelte'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Config {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:load_full_syntax = svelte#GetConfig('load_full_syntax', 0)
let s:use_pug = svelte#GetConfig('use_pug', 0)
let s:use_less = svelte#GetConfig('use_less', 0)
let s:use_sass = svelte#GetConfig('use_sass', 0)
let s:use_coffee = svelte#GetConfig('use_coffee', 0)
let s:use_typescript = svelte#GetConfig('use_typescript', 0)
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Functions {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:LoadSyntax(group, type)
  if s:load_full_syntax
    call s:LoadFullSyntax(a:group, a:type)
  else
    call s:LoadDefaultSyntax(a:group, a:type)
  endif
endfunction

function! s:LoadDefaultSyntax(group, type)
  unlet! b:current_syntax
  let syntaxPaths = ['$VIMRUNTIME', '$VIM/vimfiles', '$HOME/.vim']
  for path in syntaxPaths
    let file = expand(path).'/syntax/'.a:type.'.vim'
    if filereadable(file)
      execute 'syntax include '.a:group.' '.file
    endif
  endfor
endfunction

function! s:LoadFullSyntax(group, type)
  call s:SetCurrentSyntax(a:type)
  exec 'syntax include '.a:group.' syntax/'.a:type.'.vim'
endfunction

" Settings to avoid syntax overload
function! s:SetCurrentSyntax(type)
  if a:type == 'coffee'
    syntax cluster coffeeJS contains=@htmlJavaScript

    " Avoid overload of `javascript.vim`
    let b:current_syntax = 'svelte'
  else
    unlet! b:current_syntax
  endif
endfunction
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Load main syntax {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load syntax/html.vim to syntax group, which loads full JavaScript and CSS
" syntax. It defines group htmlJavaScript and htmlCss.
call s:LoadSyntax('@HTMLSyntax', 'html')

" Load svelte-html syntax
syntax include syntax/svelte-html.vim

" Avoid overload
if !hlexists('cssTagName')
  call s:LoadSyntax('@htmlCss', 'css')
endif

" Avoid overload
if !hlexists('javaScriptComment')
  call s:LoadSyntax('@htmlJavaScript', 'javascript')
endif
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Load pre-processors syntax {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" If pug is enabled, load vim-pug syntax
if s:use_pug
  call s:LoadFullSyntax('@PugSyntax', 'pug')
endif

" If less is enabled, load less syntax 
if s:use_less
  call s:LoadSyntax('@LessSyntax', 'less')
  runtime! after/syntax/less.vim
endif

" If sass is enabled, load sass syntax 
if s:use_sass
  call s:LoadSyntax('@SassSyntax', 'sass')
  runtime! after/syntax/sass.vim
endif

" If CoffeeScript is enabled, load the syntax. Keep name consistent with
" vim-coffee-script/after/html.vim
if s:use_coffee
  call s:LoadFullSyntax('@htmlCoffeeScript', 'coffee')
endif

" If TypeScript is enabled, load the syntax.
if s:use_typescript
  call s:LoadFullSyntax('@TypeScript', 'typescript')
endif
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Syntax highlight {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" All start with html/javascript/css for emmet-vim in-file type detection
" Normal tag template
syntax region htmlSvelteTemplate fold
      \ start=+<[-:a-zA-Z0-9]\+[^>]*>$+ 
      \ end=+^</[-:a-zA-Z0-9]\+>+ 
      \ keepend contains=@HTMLSyntax
" Start tag across multiple lines or Empty tag across multiple lines
syntax region htmlSvelteTemplate fold
      \ start=+<[-:a-zA-Z0-9]\+[^>]*$+ 
      \ end=+^\(<\/[-:a-zA-Z0-9]\+>\)\|^\([^<]*\/>\)+ 
      \ keepend contains=@HTMLSyntax
" Tag in one line
syntax match htmlSvelteTemplate fold
      \ +<[-:a-zA-Z0-9]\+[^>]*>.*</[-:a-zA-Z0-9]\+>+ 
      \ contains=@HTMLSyntax
" Empty tag in one line
syntax match htmlSvelteTemplate fold
      \ +<[-:a-zA-Z0-9]\+[^>]*/>+ 
      \ contains=@HTMLSyntax
" @html,@debug tag in one line
syntax match htmlSvelteTemplate fold
      \ +{@\(html\|debug\)[^}]*}+ 
      \ contains=@HTMLSyntax
" Control blocks like {#if ...}, {#each ...}
syntax region htmlSvelteTemplate fold
      \ start=+{#[-a-zA-Z0-9]\+[^}]*}+ 
      \ end=+^{/[-a-zA-Z0-9]\+}+ 
      \ keepend contains=@HTMLSyntax

syntax region javascriptSvelteScript fold
      \ start=+<script[^>]*>+ 
      \ end=+</script>+ 
      \ keepend 
      \ contains=@htmlJavaScript,jsImport,jsExport,svelteTag,svelteKeyword

syntax region cssSvelteStyle fold
      \ start=+<style[^>]*>+ 
      \ end=+</style>+ 
      \ keepend contains=@htmlCss,svelteTag

" Preprocessors syntax
syntax region pugSvelteTemplate fold
      \ start=+<template[^>]*lang="pug"[^>]*>+
      \ end=+</template>+
      \ keepend contains=@PugSyntax,svelteTag

syntax region coffeeSvelteScript fold 
      \ start=+<script[^>]*lang="coffee"[^>]*>+
      \ end=+</script>+
      \ keepend contains=@htmlCoffeeScript,jsImport,jsExport,svelteTag

syntax region typescriptSvelteScript fold
      \ start=+<script[^>]*lang="\(ts\|typescript\)"[^>]*>+
      \ end=+</script>+
      \ keepend contains=@TypeScript,svelteTag

syntax region cssLessSvelteStyle fold
      \ start=+<style[^>]*lang="less"[^>]*>+ 
      \ end=+</style>+ 
      \ keepend contains=@LessSyntax,svelteTag
syntax region cssSassSvelteStyle fold
      \ start=+<style[^>]*lang="sass"[^>]*>+ 
      \ end=+</style>+ 
      \ keepend contains=@SassSyntax,svelteTag
syntax region cssScssSvelteStyle fold
      \ start=+<style[^>]*lang="scss"[^>]*>+ 
      \ end=+</style>+ 
      \ keepend contains=@SassSyntax,svelteTag

syntax region svelteTag 
      \ start=+^<[^/]+ end=+>+  skip=+></+
      \ contained contains=htmlTagN,htmlString,htmlArg fold
syntax region svelteTag 
      \ start=+^</+ end=+>+ 
      \ contained contains=htmlTagN,htmlString,htmlArg
syntax keyword svelteKeyword $ contained

highlight default link svelteTag htmlTag
highlight default link svelteKeyword Keyword
highlight default link cssUnitDecorators2 Number
highlight default link cssKeyFrameProp2 Constant
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Syntax patch {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Patch 7.4.1142
if has("patch-7.4-1142")
  if has("win32")
    syn iskeyword @,48-57,_,128-167,224-235,$
  else
    syn iskeyword @,48-57,_,192-255,$
  endif
endif

" Style
" Redefine (less|sass)Definition to highlight <style> correctly and 
" enable emmet-vim css type.
if s:use_less
  silent! syntax clear lessDefinition
  syntax region cssLessDefinition matchgroup=cssBraces 
        \ contains=@LessSyntax,cssLessDefinition
        \ contained containedin=cssLessSvelteStyle
        \ start="{" end="}" 
endif
if s:use_sass
  silent! syntax clear sassDefinition
  syntax region cssSassDefinition matchgroup=cssBraces 
        \ contains=@SassSyntax,cssSassDefinition
        \ contained containedin=cssScssSvelteStyle,cssSassSvelteStyle
        \ start="{" end="}" 
endif

" Avoid css syntax interference
silent! syntax clear cssUnitDecorators
" Have to use a different name
syntax match cssUnitDecorators2 
      \ /\(#\|-\|+\|%\|mm\|cm\|in\|pt\|pc\|em\|ex\|px\|ch\|rem\|vh\|vw\|vmin\|vmax\|dpi\|dppx\|dpcm\|Hz\|kHz\|s\|ms\|deg\|grad\|rad\)\ze\(;\|$\)/
      \ contained
      \ containedin=cssAttrRegion,sassCssAttribute,lessCssAttribute

silent! syntax clear cssKeyFrameProp
syn match cssKeyFrameProp2 /\d*%\|from\|to/ 
      \ contained nextgroup=cssDefinition
      \ containedin=cssAttrRegion,sassCssAttribute,lessCssAttribute

" HTML
" Clear htmlHead that may cause highlighting out of bounds
silent! syntax clear htmlHead

" JavaScript
" Number with minus
syntax match javaScriptNumber '\v<-?\d+L?>|0[xX][0-9a-fA-F]+>' 
      \ containedin=@javascriptSvelteScript display

" TypeScript
" Fix template string `...` breaking syntax highlighting
syntax region  typescriptTemplate
  \ start=/`/  skip=/\\\\\|\\`\|\n/  end=/`\|$/
  \ contains=typescriptTemplateSubstitution,typescriptSpecial,@Spell
  \ containedin=typescriptObjectLiteral
  \ nextgroup=@typescriptSymbols
  \ skipwhite skipempty

" html5 data-*
syntax match htmlArg '\v<data(-[.a-z0-9]+)+>' containedin=@HTMLSyntax
"}}}

let b:current_syntax = 'svelte'
" vim: fdm=marker
