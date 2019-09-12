if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'mdx') == -1


" based on mxw/vim-jsx

if exists('b:current_syntax')
  let s:current_syntax=b:current_syntax
  unlet b:current_syntax
endif
syn include @XMLSyntax syntax/xml.vim
if exists('s:current_syntax')
  let b:current_syntax=s:current_syntax
endif

" JSX attributes should color as JS.  Note the trivial end pattern; we let
" jsBlock take care of ending the region.
syn region xmlString contained start=+{+ end=++ contains=jsBlock,javascriptBlock

" JSX child blocks behave just like JSX attributes, except that (a) they are
" syntactically distinct, and (b) they need the syn-extend argument, or else
" nested XML end-tag patterns may end the outer jsxRegion.
syn region jsxChild contained start=+{+ end=++ contains=jsBlock,javascriptBlock
  \ extend

" Highlight JSX regions as XML; recursively match.
"
" Note that we prohibit JSX tags from having a < or word character immediately
" preceding it, to avoid conflicts with, respectively, the left shift operator
" and generic Flow type annotations (http://flowtype.org/).
syn region jsxRegion
  \ contains=@Spell,@XMLSyntax,jsxRegion,jsxChild,jsBlock,javascriptBlock
  \ start=+\%(<\|\w\)\@<!<\z([a-zA-Z][a-zA-Z0-9:\-.]*\)+
  \ skip=+<!--\_.\{-}-->+
  \ end=+</\z1\_\s\{-}>+
  \ end=+/>+
  \ keepend
  \ extend

" Add jsxRegion to the lowest-level JS syntax cluster.
syn cluster jsExpression add=jsxRegion

" Allow jsxRegion to contain reserved words.
syn cluster javascriptNoReserved add=jsxRegion

endif
