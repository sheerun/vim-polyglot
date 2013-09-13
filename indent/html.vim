" Description:      HTML5 and inline SVG indenter
" Changed By: HT de Beer <H.T.de.Beer@gmail.com>
" Last Change: 20121013
"   Added the SVG elements to the list of indenting element. SVG elements
"   taken from http://www.w3.org/TR/SVG/eltindex.html
"   
" Description:        html5 (and html4) indenter
" Changed By:        Brian Gershon <brian.five@gmail.com>
" Last Change:        30 Jan 2011
" 
"   1. Started with vim72 html indent file authored by Johannes Zellner (below)
"   2. Added html5 list as described here:
"      http://stackoverflow.com/questions/3232518/how-to-update-vim-to-color-code-new-html-elements
"   3. Added this to a fork of https://github.com/othree/html5.vim
"      which already provides nice html5 syntax highlighting.
"
" Description:        html indenter
" Author:        Johannes Zellner <johannes@zellner.org>
" Last Change:        Mo, 05 Jun 2006 22:32:41 CEST
"                 Restoring 'cpo' and 'ic' added by Bram 2006 May 5
" Globals:
" let g:html_indent_tags = 'html\|p\|time'
" let g:html_exclude_tags = ['html', 'style', 'script', 'body']


" Only load this indent file when no other was loaded.
if exists("b:did_indent")
    finish
endif
runtime! indent/javascript.vim
let s:jsindent = &indentexpr
unlet b:did_indent
runtime! indent/css.vim
let s:cssindent = &indentexpr
let b:did_indent = 1

" [-- local settings (must come before aborting the script) --]
setlocal indentexpr=HtmlIndentGet(v:lnum)
setlocal indentkeys=o,O,*<Return>,<>>,{,}


let s:tags = []

" [-- <ELEMENT ? - - ...> --]
call add(s:tags, 'a')
call add(s:tags, 'abbr')
call add(s:tags, 'acronym')
call add(s:tags, 'address')
call add(s:tags, 'b')
call add(s:tags, 'bdo')
call add(s:tags, 'big')
call add(s:tags, 'blockquote')
call add(s:tags, 'button')
call add(s:tags, 'caption')
call add(s:tags, 'center')
call add(s:tags, 'cite')
call add(s:tags, 'code')
call add(s:tags, 'colgroup')
call add(s:tags, 'del')
call add(s:tags, 'dfn')
call add(s:tags, 'dir')
call add(s:tags, 'div')
call add(s:tags, 'dl')
call add(s:tags, 'em')
call add(s:tags, 'fieldset')
call add(s:tags, 'font')
call add(s:tags, 'form')
call add(s:tags, 'frameset')
call add(s:tags, 'h1')
call add(s:tags, 'h2')
call add(s:tags, 'h3')
call add(s:tags, 'h4')
call add(s:tags, 'h5')
call add(s:tags, 'h6')
call add(s:tags, 'i')
call add(s:tags, 'iframe')
call add(s:tags, 'ins')
call add(s:tags, 'kbd')
call add(s:tags, 'label')
call add(s:tags, 'legend')
call add(s:tags, 'li')
call add(s:tags, 'map')
call add(s:tags, 'menu')
call add(s:tags, 'noframes')
call add(s:tags, 'noscript')
call add(s:tags, 'object')
call add(s:tags, 'ol')
call add(s:tags, 'optgroup')
call add(s:tags, 'p')
" call add(s:tags, 'pre')
call add(s:tags, 'q')
call add(s:tags, 's')
call add(s:tags, 'samp')
call add(s:tags, 'script')
call add(s:tags, 'select')
call add(s:tags, 'small')
call add(s:tags, 'span')
call add(s:tags, 'strong')
call add(s:tags, 'style')
call add(s:tags, 'sub')
call add(s:tags, 'sup')
call add(s:tags, 'table')
call add(s:tags, 'textarea')
call add(s:tags, 'title')
call add(s:tags, 'tt')
call add(s:tags, 'u')
call add(s:tags, 'ul')
call add(s:tags, 'var')

" New HTML 5 elements
call add(s:tags, 'article')
call add(s:tags, 'aside')
call add(s:tags, 'audio')
call add(s:tags, 'canvas')
call add(s:tags, 'datalist')
call add(s:tags, 'details')
call add(s:tags, 'figcaption')
call add(s:tags, 'figure')
call add(s:tags, 'footer')
call add(s:tags, 'header')
call add(s:tags, 'hgroup')
call add(s:tags, 'main')
call add(s:tags, 'mark')
call add(s:tags, 'meter')
call add(s:tags, 'nav')
call add(s:tags, 'output')
call add(s:tags, 'progress')
call add(s:tags, 'rp')
call add(s:tags, 'rt')
call add(s:tags, 'ruby')
call add(s:tags, 'section')
call add(s:tags, 'summary')
call add(s:tags, 'template')
call add(s:tags, 'time')
call add(s:tags, 'video')
call add(s:tags, 'bdi')
call add(s:tags, 'data')

" Common inline used SVG elements
call add(s:tags, 'clipPath')
call add(s:tags, 'defs')
call add(s:tags, 'desc')
call add(s:tags, 'filter')
call add(s:tags, 'foreignObject')
call add(s:tags, 'g')
call add(s:tags, 'linearGradient')
call add(s:tags, 'marker')
call add(s:tags, 'mask')
call add(s:tags, 'pattern')
call add(s:tags, 'radialGradient')
call add(s:tags, 'svg')
call add(s:tags, 'switch')
call add(s:tags, 'symbol')
call add(s:tags, 'text')
call add(s:tags, 'textPath')
call add(s:tags, 'tref')
call add(s:tags, 'tspan')

call add(s:tags, 'html')
call add(s:tags, 'head')
call add(s:tags, 'body')

call add(s:tags, 'thead')
call add(s:tags, 'tbody')
call add(s:tags, 'tfoot')
call add(s:tags, 'tr')
call add(s:tags, 'th')
call add(s:tags, 'td')

if exists('g:html_exclude_tags')
    for tag in g:html_exclude_tags
        call remove(s:tags, index(s:tags, tag))
    endfor
endif
let s:html_indent_tags = join(s:tags, '\|')
if exists('g:html_indent_tags')
    let s:html_indent_tags = s:html_indent_tags.'\|'.g:html_indent_tags
endif

let s:cpo_save = &cpo
set cpo-=C

" [-- count indent-increasing tags of line a:lnum --]
fun! <SID>HtmlIndentOpen(lnum, pattern)
    let s = substitute('x'.getline(a:lnum),
    \ '.\{-}\(\(<\)\('.a:pattern.'\)\>\)', "\1", 'g')
    let s = substitute(s, "[^\1].*$", '', '')
    return strlen(s)
endfun

" [-- count indent-decreasing tags of line a:lnum --]
fun! <SID>HtmlIndentClose(lnum, pattern)
    let s = substitute('x'.getline(a:lnum),
    \ '.\{-}\(\(<\)/\('.a:pattern.'\)\>>\)', "\1", 'g')
    let s = substitute(s, "[^\1].*$", '', '')
    return strlen(s)
endfun

" [-- count indent-increasing '{' of (java|css) line a:lnum --]
fun! <SID>HtmlIndentOpenAlt(lnum)
    return strlen(substitute(getline(a:lnum), '[^{]\+', '', 'g'))
endfun

" [-- count indent-decreasing '}' of (java|css) line a:lnum --]
fun! <SID>HtmlIndentCloseAlt(lnum)
    return strlen(substitute(getline(a:lnum), '[^}]\+', '', 'g'))
endfun

" [-- return the sum of indents respecting the syntax of a:lnum --]
fun! <SID>HtmlIndentSum(lnum, style)
    if a:style == match(getline(a:lnum), '^\s*</')
        if a:style == match(getline(a:lnum), '^\s*</\<\('.s:html_indent_tags.'\)\>')
            let open = <SID>HtmlIndentOpen(a:lnum, s:html_indent_tags)
            let close = <SID>HtmlIndentClose(a:lnum, s:html_indent_tags)
            if 0 != open || 0 != close
                return open - close
            endif
        endif
    endif

    if '' != &syntax &&
        \ synIDattr(synID(a:lnum, 1, 1), 'name') =~ '\(css\|java\).*' &&
        \ synIDattr(synID(a:lnum, strlen(getline(a:lnum)), 1), 'name')
        \ =~ '\(css\|java\).*'
        if a:style == match(getline(a:lnum), '^\s*}')
            return <SID>HtmlIndentOpenAlt(a:lnum) - <SID>HtmlIndentCloseAlt(a:lnum)
        endif
    endif
    return 0
endfun

fun! HtmlIndentGet(lnum)
    " Find a non-empty line above the current line.
    let lnum = prevnonblank(a:lnum - 1)

    " Hit the start of the file, use zero indent.
    if lnum == 0
        return 0
    endif

    let restore_ic = &ic
    setlocal ic " ignore case

    " [-- special handling for <pre>: no indenting --]
    if getline(a:lnum) =~ '\c</pre>'
                \ || 0 < searchpair('\c<pre>', '', '\c</pre>', 'nWb')
                \ || 0 < searchpair('\c<pre>', '', '\c</pre>', 'nW')
        " we're in a line with </pre> or inside <pre> ... </pre>
        if restore_ic == 0
          setlocal noic
        endif
        return -1
    endif

    " [-- special handling for <javascript>: use cindent --]
    let js = '<script'
    let jse = '</script>'

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " by Tye Zdrojewski <zdro@yahoo.com>, 05 Jun 2006
    " ZDR: This needs to be an AND (we are 'after the start of the pair' AND
    "      we are 'before the end of the pair').  Otherwise, indentation
    "      before the start of the script block will be affected; the end of
    "      the pair will still match if we are before the beginning of the
    "      pair.
    "
    if   0 < searchpair(js, '', jse, 'nWb')
    \ && 0 < searchpair(js, '', jse, 'nW')
        " we're inside javascript
        if getline(searchpair(js, '', '</script>', 'nWb')) !~ '<script [^>]*type=["'']\?text\/\(html\|template\)'
        \ && getline(lnum) !~ js && getline(a:lnum) !~ jse
            if restore_ic == 0
              setlocal noic
            endif
            if s:jsindent == ''
              return cindent(a:lnum)
            else
              execute 'let ind = ' . s:jsindent
              return ind
            endif
        endif
        if getline(a:lnum) =~ jse
          return indent(searchpair(js, '', jse, 'nWb'))
        endif
    endif

    let css = '<style'
    let csse = '</style>'
    if   0 < searchpair(css, '', csse, 'nWb')
    \ && 0 < searchpair(css, '', csse, 'nW')
        " we're inside style
        if getline(lnum) !~ css && getline(a:lnum) !~ csse
            if restore_ic == 0
              setlocal noic
            endif
            if s:cssindent == ''
              return cindent(a:lnum)
            else
              execute 'let ind = ' . s:cssindent
              return ind
            endif
        endif
        if getline(a:lnum) =~ csse
          return indent(searchpair(css, '', csse, 'nWb'))
        endif
    endif

    if getline(lnum) =~ '\c</pre>'
        " line before the current line a:lnum contains
        " a closing </pre>. --> search for line before
        " starting <pre> to restore the indent.
        let preline = prevnonblank(search('\c<pre>', 'bW') - 1)
        if preline > 0
            if restore_ic == 0
              setlocal noic
            endif

            if 0 == match(getline(a:lnum), '^\s*</')
                return indent(preline) - (1*&sw)
            else
                return indent(preline)
            endif
        endif
    endif

    let ind = <SID>HtmlIndentSum(lnum, -1)
    let ind = ind + <SID>HtmlIndentSum(a:lnum, 0)

    " Fix for conditional comment
    if getline(a:lnum) =~ '\c<!--.*<\(html\|body\).*-->'
        let ind = ind - 1
    endif

    if restore_ic == 0
        setlocal noic
    endif

    return indent(lnum) + (&sw * ind)
endfun

let &cpo = s:cpo_save
unlet s:cpo_save

" [-- EOF <runtime>/indent/html.vim --]
