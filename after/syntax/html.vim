if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'coffee-script') == -1
  
" Language:    CoffeeScript
" Maintainer:  Mick Koch <mick@kochm.co>
" URL:         http://github.com/kchmck/vim-coffee-script
" License:     WTFPL

" Syntax highlighting for text/coffeescript script tags
syn include @htmlCoffeeScript syntax/coffee.vim
syn region coffeeScript start=#<script [^>]*type="text/coffeescript"[^>]*>#
\                       end=#</script>#me=s-1 keepend
\                       contains=@htmlCoffeeScript,htmlScriptTag,@htmlPreproc
\                       containedin=htmlHead

endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'glsl') == -1
  
" Language: OpenGL Shading Language
" Maintainer: Sergey Tikhomirov <sergey@tikhomirov.io>

syn include @GLSL syntax/glsl.vim
syn region ShaderScript
      \ start="<script [^>]*type=\('\|\"\)x-shader/x-\(vertex\|fragment\)\('\|\"\)[^>]*>"
      \ keepend
      \ end="</script>"me=s-1
      \ contains=@GLSL,htmlScriptTag,@htmlPreproc

endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'less') == -1
  
if !exists("g:less_html_style_tags")
  let g:less_html_style_tags = 1
endif

if !g:less_html_style_tags
  finish
endif

" Unset (but preserve) so that less will run.
if exists("b:current_syntax")
   let s:pre_less_cur_syn = b:current_syntax
   unlet b:current_syntax
endif

" Inspired by code from github.com/kchmck/vim-coffee-script
" and the html syntax file included with vim 7.4.

syn include @htmlLess syntax/less.vim

" We have to explicitly add to htmlHead (containedin) as that region specifies 'contains'.
syn region lessStyle start=+<style [^>]*type *=[^>]*text/less[^>]*>+ keepend end=+</style>+ contains=@htmlLess,htmlTag,htmlEndTag,htmlCssStyleComment,@htmlPreproc containedin=htmlHead

" Reset since 'less' isn't really the current_syntax.
if exists("s:pre_less_cur_syn")
   let b:current_syntax = s:pre_less_cur_syn
endif

endif
