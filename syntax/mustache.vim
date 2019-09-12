if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'handlebars') == -1

" Mustache & Handlebars syntax
" Language:	Mustache, Handlebars
" Maintainer:	Juvenn Woo <machese@gmail.com>
" Screenshot:   http://imgur.com/6F408
" Version:	6
" Last Change:  Jul 16 2019
" Remark:
"   It lexically hilights embedded mustaches (exclusively) in html file.
"   While it was written for Ruby-based Mustache template system, it should
"   work for Google's C-based *ctemplate* as well as Erlang-based *et*. All
"   of them are, AFAIK, based on the idea of ctemplate.
" References:
"   [Mustache](http://github.com/defunkt/mustache)
"   [Handlebars](https://github.com/wycats/handlebars.js)
"   [ctemplate](http://code.google.com/p/google-ctemplate/)
"   [ctemplate doc](http://google-ctemplate.googlecode.com/svn/trunk/doc/howto.html)
"   [et](http://www.ivan.fomichev.name/2008/05/erlang-template-engine-prototype.html)
" TODO: Feedback is welcomed.


" Read the HTML syntax to start with
if version < 600
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Standard HiLink will not work with included syntax files
if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif

syntax match mustacheError '}}}\?'
syntax match mustacheInsideError '{{[{$#<>=!\/]\?'

" Ember angle bracket syntax syntax starts with a capital letter:
" https://github.com/emberjs/rfcs/blob/master/text/0311-angle-bracket-invocation.md
syntax case match
syntax region mustacheAngleComponent start=/<\/\?[[:upper:]]/ end=/>/ keepend containedin=TOP,@htmlMustacheContainer
syntax case ignore
syntax match mustacheAngleBrackets '</\?\|/\?>' contained containedin=mustacheAngleComponent
syntax match mustacheAngleComponentName '</[[:alnum:]]\+'hs=s+2 contained containedin=mustacheAngleBrackets
syntax match mustacheAngleComponentName '<[[:alnum:]]\+'hs=s+1 contained containedin=mustacheAngleBrackets

syntax region mustacheHbsComponent start=/{{[^!][$#^/]\?/ end=/}}}\?/ keepend containedin=TOP,@htmlMustacheContainer

syntax cluster mustacheInside add=mustacheHbsComponent,mustacheAngleComponent

syntax match mustacheOperators '=\|\.\|/^>' contained containedin=@mustacheInside,mustacheParam
syntax region mustacheHtmlValue start=/={{[^!][$#^/]\?/rs=s+1,hs=s+1 end=/}}/ oneline keepend contained containedin=htmlTag contains=@mustacheInside
syntax region mustachePartial start=/{{[<>]/lc=2 end=/}}/me=e-2 contained containedin=@mustacheInside,@htmlMustacheContainer
syntax region mustacheMarkerSet start=/{{=/lc=2 end=/=}}/me=e-2 contained containedin=@mustacheInside,@htmlMustacheContainer
syntax match mustacheHandlebars '{{\|}}' contained containedin=@mustacheInside
syntax match mustacheUnescape '{{{\|}}}' contained containedin=@mustacheInside
syntax match mustacheConditionals '\([/#]\?\<\(if\|unless\)\|\<else\)\>' contained containedin=@mustacheInside
syntax match mustacheHelpers '[/#]\?\<\(with\|link\-to\|each\(\-in\)\?\|let\)\>' contained containedin=@mustacheInside
syntax match mustacheHelpers 'else \(if\|unless\|with\|link\-to\|each\(\-in\)\?\)' contained containedin=@mustacheInside
syntax match mustacheParam /[a-z@_-]\+=/he=e-1 contained containedin=@mustacheInside
syntax region mustacheComment      start=/{{!/rs=s+2   skip=/{{.\{-}}}/ end=/}}/re=e-2   contains=Todo contained containedin=TOP,@mustacheInside,@htmlMustacheContainer
syntax region mustacheBlockComment start=/{{!--/rs=s+2 skip=/{{.\{-}}}/ end=/--}}/re=e-2 contains=Todo contained extend containedin=TOP,@mustacheInside,@htmlMustacheContainer
syntax region mustacheQString start=/'/ skip=/\\'/ end=/'/ contained containedin=@mustacheInside
syntax region mustacheDQString start=/"/ skip=/\\"/ end=/"/ contained containedin=@mustacheInside

" Clustering
syntax cluster htmlMustacheContainer add=htmlHead,htmlTitle,htmlString,htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6,htmlLink,htmlBold,htmlUnderline,htmlItalic,htmlValue


" Hilighting
" mustacheInside hilighted as Number, which is rarely used in html
" you might like change it to Function or Identifier
HtmlHiLink mustacheVariable Number
HtmlHiLink mustacheVariableUnescape Number
HtmlHiLink mustachePartial Number
HtmlHiLink mustacheMarkerSet Number
HtmlHiLink mustacheParam htmlArg
HtmlHiLink mustacheAngleComponentName htmlTag

HtmlHiLink mustacheComment Comment
HtmlHiLink mustacheBlockComment Comment
HtmlHiLink mustacheError Error
HtmlHiLink mustacheInsideError Error

HtmlHiLink mustacheHandlebars Special
HtmlHiLink mustacheAngleBrackets htmlTagName
HtmlHiLink mustacheUnescape Identifier
HtmlHiLink mustacheOperators Operator
HtmlHiLink mustacheConditionals Conditional
HtmlHiLink mustacheHelpers Repeat
HtmlHiLink mustacheQString String
HtmlHiLink mustacheDQString String

syn region mustacheScriptTemplate start=+<script [^>]*type *=[^>]*text/\(mustache\|x-handlebars-template\)[^>]*>+
\                       end=+</script>+me=s-1 keepend
\                       contains=mustacheInside,@htmlMustacheContainer,htmlTag,htmlEndTag,htmlTagName,htmlSpecialChar

let b:current_syntax = "mustache"
delcommand HtmlHiLink

endif
