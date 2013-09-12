" File:        php.vim
" Description: PHP Integration for VIM plugin
" 			   This file is a considerable fork of the original 
" 			   PDV written by Tobias Schlitt <toby@php.net>.
" Maintainer:  Steve Francia <piv@spf13.com> <http://spf13.com>
" Version:     0.9
" Last Change: 7th January 2012
" 
" 
" Section: script init stuff {{{1
if exists("loaded_piv")
    finish
endif
let loaded_piv = 1

"
" Function: s:InitVariable() function {{{2
" This function is used to initialise a given variable to a given value. The
" variable is only initialised if it does not exist prior
"
" Args:
"   -var: the name of the var to be initialised
"   -value: the value to initialise var to
"
" Returns:
"   1 if the var is set, 0 otherwise
function s:InitVariable(var, value)
    if !exists(a:var)
        exec 'let ' . a:var . ' = ' . "'" . a:value . "'"
        return 1
    endif
    return 0
endfunction


" {{{ Settings
" First the global PHP configuration
let php_sql_query=1 " to highlight SQL syntax in strings
let php_htmlInStrings=1 " to highlight HTML in string
let php_noShortTags = 1 " to disable short tags 
let php_folding = 1  "to enable folding for classes and functions
let PHP_autoformatcomment = 1
let php_sync_method = -1

" Section: variable init calls {{{2
call s:InitVariable("g:load_doxygen_syntax", 1)
call s:InitVariable("g:syntax_extra_php", 'doxygen')
call s:InitVariable("g:syntax_extra_inc", 'doxygen')
call s:InitVariable("g:PIVCreateDefaultMappings", 1)
call s:InitVariable("g:PIVPearStyle", 0)
call s:InitVariable("g:PIVAutoClose", 0)

" Auto expand tabs to spaces
setlocal expandtab
setlocal autoindent " Auto indent after a {
setlocal smartindent

" Linewidth to 79, because of the formatoptions this is only valid for
" comments
setlocal textwidth=79

setlocal nowrap     " Do not wrap lines automatically

" Correct indentation after opening a phpdocblock and automatic * on every
" line
setlocal formatoptions=qroct

" Use php syntax check when doing :make
setlocal makeprg=php\ -l\ %

" Use errorformat for parsing PHP error output
setlocal errorformat=%m\ in\ %f\ on\ line\ %l

" Switch syntax highlighting on, if it was not
if !exists("g:syntax_on") | syntax on | endif

"setlocal keywordprg=pman " Use pman for manual pages

" }}} Settings

" {{{ Command mappings
nnoremap <silent> <plug>PIVphpDocSingle :call PhpDocSingle()<CR>
vnoremap <silent> <plug>PIVphpDocRange :call PhpDocRange()<CR>
vnoremap <silent> <plug>PIVphpAlign :call PhpAlign()<CR>
"inoremap <buffer> <leader>d :call PhpDocSingle()<CR>i

" Map ; to "add ; to the end of the line, when missing"
"noremap <buffer> ; :s/\([^;]\)$/\1;/<cr>

" Map <ctrl>+p to single line mode documentation (in insert and command mode)
"inoremap <buffer> <leader>d :call PhpDocSingle()<CR>i
"nnoremap <buffer> <leader>d :call PhpDocSingle()<CR>
" Map <ctrl>+p to multi line mode documentation (in visual mode)
"vnoremap <buffer> <leader>d :call PhpDocRange()<CR>

" Map <CTRL>-H to search phpm for the function name currently under the cursor (insert mode only)
inoremap <buffer> <C-H> <ESC>:!phpm <C-R>=expand("<cword>")<CR><CR>

" }}}

" {{{ Automatic close char mapping
if g:PIVAutoClose
    if g:PIVPearStyle
        inoremap <buffer>  { {<CR>}<C-O>O
        inoremap <buffer> ( (  )<LEFT><LEFT>
    else
        inoremap  { {<CR>}<C-O>O
        inoremap ( ()<LEFT>
    endif

    inoremap <buffer> [ []<LEFT>
    inoremap <buffer> " ""<LEFT>
    inoremap <buffer> ' ''<LEFT>
endif
" }}} Automatic close char mapping


" {{{ Wrap visual selections with chars

vnoremap <buffer> ( "zdi(<C-R>z)<ESC>
vnoremap <buffer> { "zdi{<C-R>z}<ESC>
vnoremap <buffer> [ "zdi[<C-R>z]<ESC>
vnoremap <buffer> ' "zdi'<C-R>z'<ESC>
" Removed in favor of register addressing
" :vnoremap " "zdi"<C-R>z"<ESC>

" }}} Wrap visual selections with chars

" {{{ Dictionary completion
setlocal dictionary-=$VIMRUNTIME/bundle/PIV/misc/funclist.txt dictionary+=$VIMRUNTIME/bundle/PIV/misc/funclist.txt

" Use the dictionary completion
setlocal complete-=k complete+=k

" }}} Dictionary completion

" {{{ Alignment

func! PhpAlign() range
    let l:paste = &g:paste
    let &g:paste = 0

    let l:line        = a:firstline
    let l:endline     = a:lastline
    let l:maxlength = 0
    while l:line <= l:endline
		" Skip comment lines
		if getline (l:line) =~ '^\s*\/\/.*$'
			let l:line = l:line + 1
			continue
		endif
		" \{-\} matches ungreed *
        let l:index = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\S\{0,1}=\S\{0,1\}\s.*$', '\1', "") 
        let l:indexlength = strlen (l:index)
        let l:maxlength = l:indexlength > l:maxlength ? l:indexlength : l:maxlength
        let l:line = l:line + 1
    endwhile
    
	let l:line = a:firstline
	let l:format = "%s%-" . l:maxlength . "s %s %s"
    
	while l:line <= l:endline
		if getline (l:line) =~ '^\s*\/\/.*$'
			let l:line = l:line + 1
			continue
		endif
        let l:linestart = substitute (getline (l:line), '^\(\s*\).*', '\1', "")
        let l:linekey   = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\1', "")
        let l:linesep   = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\2', "")
        let l:linevalue = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\3', "")

        let l:newline = printf (l:format, l:linestart, l:linekey, l:linesep, l:linevalue)
        call setline (l:line, l:newline)
        let l:line = l:line + 1
    endwhile
    let &g:paste = l:paste
endfunc

" }}}   

function! s:CreateNMap(target, combo)
    if !hasmapto(a:target, 'n')
        exec 'nmap ' . a:combo . ' ' . a:target
    endif
endfunction

function! s:CreateVMap(target, combo)
    if !hasmapto(a:target, 'v')
        exec 'vmap ' . a:combo . ' ' . a:target
    endif
endfunction

function! s:CreateMaps(target, combo)
	call s:CreateNMap(a:target,a:combo)
	call s:CreateVMap(a:target,a:combo)
endfunction

if g:PIVCreateDefaultMappings
    call s:CreateNMap('<plug>PIVphpDocSingle', 		   ',pd')
    call s:CreateVMap('<plug>PIVphpDocRange',     	   ',pd')
    call s:CreateMaps('<plug>PIVphpAlign ', 		   ',pa')
endif
