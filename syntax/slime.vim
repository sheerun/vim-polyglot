if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'slime') == -1

" Vim syntax file
" Language: slime
" Maintainer: Andrew Stone <andy@stonean.com>
" Version:  1
" Last Change:  2010 Sep 25
" TODO: Feedback is welcomed.

" Quit when a syntax file is already loaded.
if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'slime'
endif

" Allows a per line syntax evaluation.
let b:elixir_no_expensive = 1

" Include Elixir syntax highlighting
syn include @slimeElixirTop syntax/elixir.vim
unlet! b:current_syntax
" Include Haml syntax highlighting
syn include @slimeHaml syntax/haml.vim
unlet! b:current_syntax

syn match slimeBegin  "^\s*\(&[^= ]\)\@!" nextgroup=slimeTag,slimeClassChar,slimeIdChar,slimeElixir

syn region  elixirCurlyBlock start="{" end="}" contains=@slimeElixirTop contained
syn cluster slimeElixirTop    add=elixirCurlyBlock

syn cluster slimeComponent contains=slimeClassChar,slimeIdChar,slimeWrappedAttrs,slimeElixir,slimeAttr,slimeInlineTagChar

syn keyword slimeDocType        contained html 5 1.1 strict frameset mobile basic transitional
syn match   slimeDocTypeKeyword "^\s*\(doctype\)\s\+" nextgroup=slimeDocType

syn keyword slimeTodo        FIXME TODO NOTE OPTIMIZE XXX contained
syn keyword htmlTagName     contained script

syn match slimeTag           "\w\+[><]*"         contained contains=htmlTagName nextgroup=@slimeComponent
syn match slimeIdChar        "#{\@!"        contained nextgroup=slimeId
syn match slimeId            "\%(\w\|-\)\+" contained nextgroup=@slimeComponent
syn match slimeClassChar     "\."           contained nextgroup=slimeClass
syn match slimeClass         "\%(\w\|-\)\+" contained nextgroup=@slimeComponent
syn match slimeInlineTagChar "\s*:\s*"      contained nextgroup=slimeTag,slimeClassChar,slimeIdChar

syn region slimeWrappedAttrs matchgroup=slimeWrappedAttrsDelimiter start="\s*{\s*" skip="}\s*\""  end="\s*}\s*"  contained contains=slimeAttr nextgroup=slimeElixir
syn region slimeWrappedAttrs matchgroup=slimeWrappedAttrsDelimiter start="\s*\[\s*" end="\s*\]\s*" contained contains=slimeAttr nextgroup=slimeElixir
syn region slimeWrappedAttrs matchgroup=slimeWrappedAttrsDelimiter start="\s*(\s*"  end="\s*)\s*"  contained contains=slimeAttr nextgroup=slimeElixir

syn match slimeAttr /\s*\%(\w\|-\)\+\s*=/me=e-1 contained contains=htmlArg nextgroup=slimeAttrAssignment
syn match slimeAttrAssignment "\s*=\s*" contained nextgroup=slimeWrappedAttrValue,slimeAttrString

syn region slimeWrappedAttrValue start="[^"']" end="\s\|$" contained contains=slimeAttrString,@slimeElixirTop nextgroup=slimeAttr,slimeElixir,slimeInlineTagChar
syn region slimeWrappedAttrValue matchgroup=slimeWrappedAttrValueDelimiter start="{" end="}" contained contains=slimeAttrString,@slimeElixirTop nextgroup=slimeAttr,slimeElixir,slimeInlineTagChar
syn region slimeWrappedAttrValue matchgroup=slimeWrappedAttrValueDelimiter start="\[" end="\]" contained contains=slimeAttrString,@slimeElixirTop nextgroup=slimeAttr,slimeElixir,slimeInlineTagChar
syn region slimeWrappedAttrValue matchgroup=slimeWrappedAttrValueDelimiter start="(" end=")" contained contains=slimeAttrString,@slimeElixirTop nextgroup=slimeAttr,slimeElixir,slimeInlineTagChar

syn region slimeAttrString start=+\s*"+ skip=+\%(\\\\\)*\\"+ end=+"\s*+ contained contains=slimeInterpolation,slimeInterpolationEscape nextgroup=slimeAttr,slimeElixir,slimeInlineTagChar
syn region slimeAttrString start=+\s*'+ skip=+\%(\\\\\)*\\"+ end=+'\s*+ contained contains=slimeInterpolation,slimeInterpolationEscape nextgroup=slimeAttr,slimeElixir,slimeInlineTagChar

syn region slimeInnerAttrString start=+\s*"+ skip=+\%(\\\\\)*\\"+ end=+"\s*+ contained contains=slimeInterpolation,slimeInterpolationEscape nextgroup=slimeAttr
syn region slimeInnerAttrString start=+\s*'+ skip=+\%(\\\\\)*\\"+ end=+'\s*+ contained contains=slimeInterpolation,slimeInterpolationEscape nextgroup=slimeAttr

syn region slimeInterpolation matchgroup=slimeInterpolationDelimiter start="#{" end="}" contains=@slimeElixirTop containedin=javascriptStringS,javascriptStringD,slimeWrappedAttrs
syn region slimeInterpolation matchgroup=slimeInterpolationDelimiter start="#{{" end="}}" contains=@slimeElixirTop containedin=javascriptStringS,javascriptStringD,slimeWrappedAttrs
syn match  slimeInterpolationEscape "\\\@<!\%(\\\\\)*\\\%(\\\ze#{\|#\ze{\)"

syn region slimeElixir matchgroup=slimeElixirOutputChar start="\s*[=]\==[']\=" skip="\%\(,\s*\|\\\)$" end="$" contained contains=@slimeElixirTop keepend
syn region slimeElixir matchgroup=slimeElixirChar       start="\s*-"           skip="\%\(,\s*\|\\\)$" end="$" contained contains=@slimeElixirTop keepend

syn match slimeComment /^\(\s*\)[/].*\(\n\1\s.*\)*/ contains=slimeTodo
syn match slimeText    /^\(\s*\)[`|'].*\(\n\1\s.*\)*/ contains=slimeInterpolation

syn match slimeFilter /\s*\w\+:\s*/                            contained
syn match slimeHaml   /^\(\s*\)\<haml:\>.*\(\n\1\s.*\)*/       contains=@slimeHaml,slimeFilter

syn match slimeIEConditional "\%(^\s*/\)\@<=\[\s*if\>[^]]*]" contained containedin=slimeComment

hi def link slimeAttrString                String
hi def link slimeBegin                     String
hi def link slimeClass                     Type
hi def link slimeAttr                      Type
hi def link slimeClassChar                 Type
hi def link slimeComment                   Comment
hi def link slimeDocType                   Identifier
hi def link slimeDocTypeKeyword            Keyword
hi def link slimeFilter                    Keyword
hi def link slimeIEConditional             SpecialComment
hi def link slimeId                        Identifier
hi def link slimeIdChar                    Identifier
hi def link slimeInnerAttrString           String
hi def link slimeInterpolationDelimiter    Delimiter
hi def link slimeElixirChar                  Special
hi def link slimeElixirOutputChar            Special
hi def link slimeText                      String
hi def link slimeTodo                      Todo
hi def link slimeWrappedAttrValueDelimiter Delimiter
hi def link slimeWrappedAttrsDelimiter     Delimiter
hi def link slimeInlineTagChar             Delimiter

let b:current_syntax = "slime"

endif
