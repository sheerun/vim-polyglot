" Vim indent file
" Language:     LaTeX
" Maintainer:   Johannes Tanzler <johannes.tanzler@gmail.com>
" Version: 	0.5
" Created:      Sat, 16 Feb 2002 16:50:19 +0100
" Last Change:	Mar, 27 Jun 2011 11:46:35 +0200
" Last Update:  18th feb 2002, by LH :
"               (*) better support for the option
"               (*) use some regex instead of several '||'.
"               Oct 9th, 2003, by JT:
"               (*) don't change indentation of lines starting with '%'
"               2005/06/15, Moshe Kaminsky <kaminsky@math.huji.ac.il>
"               (*) New variables:
"                   g:tex_items, g:tex_itemize_env, g:tex_noindent_env
"               2011/3/6, by Zhou Yi Chao <broken.zhou@gmail.com>
"               (*) Don't change indentation of lines starting with '%'
"                   I don't see any code with '%' and it doesn't work properly
"                   so I add some code.
"               (*) New features: Add smartindent-like indent
"                   for "{}" and  "[]".
"               (*) New variables: g:tex_indent_brace
"
" Options: {{{
"
" To set the following options (ok, currently it's just one), add a line like
"   let g:tex_indent_items = 1
" to your ~/.vimrc.
"
" * g:tex_indent_brace
"
"   If this variable is unset or non-zero, it will use smartindent-like style
"   for "{}" and "[]"
"
" * g:tex_indent_items
"
"   If this variable is set, item-environments are indented like Emacs does
"   it, i.e., continuation lines are indented with a shiftwidth.
"
"   NOTE: I've already set the variable below; delete the corresponding line
"   if you don't like this behaviour.
"
"   Per default, it is unset.
"
"              set                                unset
"   ----------------------------------------------------------------
"       \begin{itemize}                      \begin{itemize}
"         \item blablabla                      \item blablabla
"           bla bla bla                        bla bla bla
"         \item blablabla                      \item blablabla
"           bla bla bla                        bla bla bla
"       \end{itemize}                        \end{itemize}
"
"
" * g:tex_items
"
"   A list of tokens to be considered as commands for the beginning of an item
"   command. The tokens should be separated with '\|'. The initial '\' should
"   be escaped. The default is '\\bibitem\|\\item'.
"
" * g:tex_itemize_env
"
"   A list of environment names, separated with '\|', where the items (item
"   commands matching g:tex_items) may appear. The default is
"   'itemize\|description\|enumerate\|thebibliography'.
"
" * g:tex_noindent_env
"
"   A list of environment names. separated with '\|', where no indentation is
"   required. The default is 'document\|verbatim\|comment\|lstlisting'.
"
" }}}
"
" License: {{{
" Copyright (c) 2002-2011 Johannes Tanzler <johannes.tanzler@gmail.com>

" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be included
" in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
" IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
" CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
" TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
" SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

" Delete the next line to avoid the special indention of items
if !exists("g:tex_indent_items")
    let g:tex_indent_items = 1
endif
if !exists("g:tex_indent_brace")
    let g:tex_indent_brace = 1
endif
if g:tex_indent_items
    if !exists("g:tex_itemize_env")
        let g:tex_itemize_env = 'itemize\|description\|enumerate\|thebibliography'
    endif
    if !exists('g:tex_items')
        let g:tex_items = '\\bibitem\|\\item'
    endif
else
    let g:tex_items = ''
endif

if !exists("g:tex_noindent_env")
    let g:tex_noindent_env = 'document\|verbatim\|comment\|lstlisting'
endif

setlocal autoindent
setlocal nosmartindent
setlocal indentexpr=GetTeXIndent()
exec 'setlocal indentkeys+=},]' . substitute(g:tex_items, '^\|\(\\|\)', ',=', 'g')
let g:tex_items = '^\s*' . g:tex_items


" Only define the function once
if exists("*GetTeXIndent") | finish
endif



function GetTeXIndent()

    " Find a non-blank line above the current line.
    let lnum = prevnonblank(v:lnum - 1)

    " New code for comments: Comments is not what we need.
    while lnum != 0
        if getline(lnum) !~ '^\s*%'
            break
        endif
        let lnum = prevnonblank(lnum - 1)
    endwhile

    " At the start of the file use zero indent.
    if lnum == 0 | return 0
    endif

    let ind = indent(lnum)
    let line = getline(lnum)             " last line
    let cline = getline(v:lnum)          " current line

    " New code for comment: retain the indent of current line
    if cline =~ '^\s*%'
        return indent(v:lnum)
    endif

    " Add a 'shiftwidth' after beginning of environments.
    " Don't add it for environments identified by
    " g:tex_noindent_env
    " LH modification : \begin does not always start a line
    let current_regexp = '\\begin'
    while 1
        let match_list = matchlist(line, current_regexp.'\s*{\(.*\)}')
        if (empty(match_list))
            break
        endif
        let environment_type = get(match_list, 1)
        if environment_type !~ g:tex_noindent_env
            let ind = ind + &sw

            if g:tex_indent_items == 1
                " Add another sw for item-environments
                if line =~ g:tex_itemize_env
                    let ind = ind + &sw
                endif
            endif
        endif
        " Make the regexp match the following begin
        let current_regexp = current_regexp.'.*\\begin'
    endwhile

    " Subtract a 'shiftwidth' when an environment ends
    if cline =~ '^\s*\\end' && cline !~ g:tex_noindent_env

        if g:tex_indent_items == 1
            " Remove another sw for item-environments
            if cline =~ g:tex_itemize_env
                let ind = ind - &sw
            endif
        endif

        let ind = ind - &sw
    endif

    " Subtract a 'shiftwidth' when an environment ended
    " the previous line but the shiftwidth wasn't
    " applied because it didn't begin the line
    let current_regexp = '\\end'
    while 1
        let match_list = matchlist(line, current_regexp.'\s*{\(.*\)}')
        if (empty(match_list))
            break
        endif
        let environment_type = get(match_list, 1)
        if environment_type !~ g:tex_noindent_env
           \ && (current_regexp != '\\end' || line !~ '^\s*\\end')
           " If the end begin the line, the shift width has already
           " been subtracted at the previous line

            let ind = ind - &sw

            if g:tex_indent_items == 1
                " Add another sw for item-environments
                if line =~ g:tex_itemize_env
                    let ind = ind - &sw
                endif
            endif
        endif
        " Make the regexp match the following end
        let current_regexp = current_regexp.'.*\\end'
    endwhile

    if g:tex_indent_brace
      " Add a 'shiftwidth' after a "{" or "[" while there are not "}" and "]"
      " after them. \m for magic
        if line =~ '\m\(\(\[[^\]]*\)\|\({[^}]*\)\)$'
            let ind = ind + &sw
        endif
      " Remove a 'shiftwidth' after a "}" or "]" while there are not "{" and "["
      " before them. \m for magic
        if cline =~ '\m^\(\([^[]*\]\)\|\([^{]*}\)\)'
            let ind = ind - &sw
        endif
    endif


    " Special treatment for 'item'
    " ----------------------------

    if g:tex_indent_items

        " '\item' or '\bibitem' itself:
        if cline =~ g:tex_items
            let ind = ind - &sw
        endif

        " lines following to '\item' are intented once again:
        if line =~ g:tex_items
            let ind = ind + &sw
        endif

    endif

    return ind
endfunction

" vim: set sw=4 textwidth=78:
