" Vim filetype plugin
" Language:     Puppet
" Maintainer:   Todd Zullinger <tmz@pobox.com>
" Last Change:  2009 Aug 19
" vim: set sw=4 sts=4:

if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

if !exists("no_plugin_maps") && !exists("no_puppet_maps")
    if !hasmapto("<Plug>AlignRange")
        map <buffer> <LocalLeader>= <Plug>AlignRange
    endif
endif

noremap <buffer> <unique> <script> <Plug>AlignArrows :call <SID>AlignArrows()<CR>
noremap <buffer> <unique> <script> <Plug>AlignRange :call <SID>AlignRange()<CR>

iabbrev => =><C-R>=<SID>AlignArrows('=>')<CR>
iabbrev +> +><C-R>=<SID>AlignArrows('+>')<CR>

if exists('*s:AlignArrows')
    finish
endif

let s:arrow_re = '[=+]>'
let s:selector_re = '[=+]>\s*\$.*\s*?\s*{\s*$'

" set keywordprg to 'pi' (alias for puppet describe)
" this lets K invoke pi for word under cursor
setlocal keywordprg=puppet\ describe

function! s:AlignArrows(op)
    let cursor_pos = getpos('.')
    let lnum = line('.')
    let line = getline(lnum)
    if line !~ s:arrow_re
        return
    endif
    let pos = stridx(line, a:op)
    let start = lnum
    let end = lnum
    let pnum = lnum - 1
    while 1
        let pline = getline(pnum)
        if pline !~ s:arrow_re || pline =~ s:selector_re
            break
        endif
        let start = pnum
        let pnum -= 1
    endwhile
    let cnum = end
    while 1
        let cline = getline(cnum)
        if cline !~ s:arrow_re ||
                \ (indent(cnum) != indent(cnum+1) && getline(cnum+1) !~ '\s*}')
            break
        endif
        let end = cnum
        let cnum += 1
    endwhile
    call s:AlignSection(start, end)
    let cursor_pos[2] = stridx(getline('.'), a:op) + strlen(a:op) + 1
    call setpos('.', cursor_pos)
    return ''
endfunction

function! s:AlignRange() range
    call s:AlignSection(a:firstline, a:lastline)
endfunction

" AlignSection and AlignLine are from the vim wiki:
" http://vim.wikia.com/wiki/Regex-based_text_alignment
function! s:AlignSection(start, end)
    let extra = 1
    let sep = s:arrow_re
    let maxpos = 0
    let section = getline(a:start, a:end)
    for line in section
        let pos = match(line, ' *'.sep)
        if maxpos < pos
            let maxpos = pos
        endif
    endfor
    call map(section, 's:AlignLine(v:val, sep, maxpos, extra)')
    call setline(a:start, section)
endfunction

function! s:AlignLine(line, sep, maxpos, extra)
    let m = matchlist(a:line, '\(.\{-}\) \{-}\('.a:sep.'.*\)')
    if empty(m)
        return a:line
    endif
    let spaces = repeat(' ', a:maxpos - strlen(m[1]) + a:extra)
    return m[1] . spaces . m[2]
endfunction

" detect if we are in a module and set variables for classpath (autoloader),
" modulename, modulepath, and classname
" useful to use in templates
function! s:SetModuleVars()

  " set these to any dirs you want to stop searching on
  " useful to stop vim from spinning disk looking all over for init.pp
  " probably only a macosx problem with /tmp since it's really /private/tmp
  " but it's here if you find vim spinning on new files in certain places
  if !exists("g:puppet_stop_dirs")
    let g:puppet_stop_dirs = '/tmp;/private/tmp'
  endif

  " search path for init.pp
  let b:search_path = './**'
  let b:search_path = b:search_path . ';' . getcwd() . ';' . g:puppet_stop_dirs
  
  " find what we assume to be our module dir
  let b:initpp = findfile("init.pp", b:search_path) " find an init.pp up or down
  let b:module_path = fnamemodify(b:initpp, ":p:h:h") " full path to module name
  let b:module_name = fnamemodify(b:module_path, ":t") " just the module name

  " sub out the full path to the module with the name and replace slashes with ::
  let b:classpath = fnamemodify(expand("%:p:r"), ':s#' . b:module_path . '/manifests#' . b:module_name . '#'. ":gs?/?::?")
  let b:classname = expand("%:t:r")

  " if we don't start with a word we didn't replace the module_path 
  " probably b/c we couldn't find an init.pp / not a module
  " so we assume that root of the filename is the class (sane for throwaway
  " manifests
  if b:classpath =~ '^::'
    let b:classpath = b:classname
  endif
endfunction

if exists("g:puppet_module_detect")
  call s:SetModuleVars()
endif
