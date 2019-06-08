if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'tsx') != -1
  finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim syntax file
"
" Language: TSX (JavaScript)
" Maintainer: Ian Ker-Seymer <i.kerseymer@gmail.com>
" Depends: leafgarland/typescript-vim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists('b:current_syntax')
  let s:current_syntax=b:current_syntax
  unlet b:current_syntax
endif

syn include @XMLSyntax syntax/xml.vim

if exists('s:current_syntax')
  let b:current_syntax=s:current_syntax
endif

syn region embeddedTs
      \ matchgroup=NONE
      \ start=+{+
      \ end=+}+
      \ contains=@Spell,@typescriptAll,xmlEntity,tsxRegion
      \ contained

" Add embeddedTs to everything where xmlString is used to allow for
" both string highlighting and @typescriptAll highlighting
syn region   xmlTag
      \ matchgroup=xmlTag start=+<[^ /!?<>"']\@=+
      \ matchgroup=xmlTag end=+>+
      \ contained
      \ contains=xmlError,xmlTagName,xmlAttrib,xmlEqual,xmlString,@xmlStartTagHook,embeddedTs

syn region xmlProcessing
      \ matchgroup=xmlProcessingDelim
      \ start="<?"
      \ end="?>"
      \ contains=xmlAttrib,xmlEqual,xmlString,embeddedTs


if exists('g:xml_syntax_folding')
  " DTD -- we use dtd.vim here
  syn region  xmlDocType matchgroup=xmlDocTypeDecl
        \ start="<!DOCTYPE"he=s+2,rs=s+2
        \ end=">"
        \ fold
        \ contains=xmlDocTypeKeyword,xmlInlineDTD,xmlString,embeddedTs
else
  syn region  xmlDocType matchgroup=xmlDocTypeDecl
        \ start="<!DOCTYPE"he=s+2,rs=s+2
        \ end=">"
        \ contains=xmlDocTypeKeyword,xmlInlineDTD,xmlString,embeddedTs
endif


if exists('g:xml_syntax_folding')
  syn region xmlTag
        \ matchgroup=xmlTag start=+<[^ /!?<>"']\@=+
        \ matchgroup=xmlTag end=+>+
        \ contained
        \ contains=xmlError,xmlTagName,xmlAttrib,xmlEqual,xmlString,@xmlStartTagHook,embeddedTs
else
  syn region xmlTag
        \ matchgroup=xmlTag start=+<[^ /!?<>"']\@=+
        \ matchgroup=xmlTag end=+>+
        \ contains=xmlError,xmlTagName,xmlAttrib,xmlEqual,xmlString,@xmlStartTagHook,embeddedTs
endif


syn region tsxRegion
      \ contains=@Spell,@XMLSyntax,tsxRegion,@typescriptAll
      \ start=+\%(<\|\w\)\@<!<\z([a-zA-Z][a-zA-Z0-9:\-.]*\)+
      \ skip=+<!--\_.\{-}-->+
      \ end=+</\z1\_\s\{-}>+
      \ end=+/>+
      \ keepend
      \ extend

hi def link embeddedTs NONE

syn cluster @typescriptAll add=tsxRegion
