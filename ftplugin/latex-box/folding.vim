if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'latex') == -1

" Folding support for LaTeX

"
" Options
" g:LatexBox_Folding         - Turn on/off folding
" g:LatexBox_fold_text       - Turn on/off LatexBox fold text function
" g:LatexBox_fold_preamble   - Turn on/off folding of preamble
" g:LatexBox_fold_parts      - Define parts (eq. appendix, frontmatter) to fold
" g:LatexBox_fold_sections   - Define section levels to fold
" g:LatexBox_fold_envs       - Turn on/off folding of environments
" g:LatexBox_fold_toc        - Turn on/off folding of TOC
" g:LatexBox_fold_toc_levels - Set max TOC fold level
"
" {{{1 Initialize options to default values.
if !exists('g:LatexBox_Folding')
	let g:LatexBox_Folding=0
endif
if !exists('g:LatexBox_fold_text')
    let g:LatexBox_fold_text=1
endif
if !exists('g:LatexBox_fold_preamble')
    let g:LatexBox_fold_preamble=1
endif
if !exists('g:LatexBox_fold_envs')
    let g:LatexBox_fold_envs=1
endif
if !exists('g:LatexBox_fold_envs_force')
    let g:LatexBox_fold_envs_force = []
endif
if !exists('g:LatexBox_fold_parts')
    let g:LatexBox_fold_parts=[
                \ "appendix",
                \ "frontmatter",
                \ "mainmatter",
                \ "backmatter"
                \ ]
endif
if !exists('g:LatexBox_fold_sections')
    let g:LatexBox_fold_sections=[
                \ "part",
                \ "chapter",
                \ "section",
                \ "subsection",
                \ "subsubsection"
                \ ]
endif
if !exists('g:LatexBox_fold_toc')
    let g:LatexBox_fold_toc=0
endif
if !exists('g:LatexBox_fold_toc_levels')
    let g:LatexBox_fold_toc_levels=1
endif
if !exists('g:LatexBox_fold_automatic')
	let g:LatexBox_fold_automatic=1
endif
" }}}1

if g:LatexBox_Folding == 0
    finish
endif

" {{{1 Set folding options for vim
setl foldexpr=LatexBox_FoldLevel(v:lnum)
if g:LatexBox_fold_text == 1
    setl foldtext=LatexBox_FoldText()
endif
if g:LatexBox_fold_automatic == 1
    setl foldmethod=expr

	"
	" The foldexpr function returns "=" for most lines, which means it can become
	" slow for large files.  The following is a hack that is based on this reply to
	" a discussion on the Vim Developer list:
	" http://permalink.gmane.org/gmane.editors.vim.devel/14100
	"
	augroup FastFold
		autocmd!
		autocmd InsertEnter *.tex if !&diff | setlocal foldmethod=manual | endif
		autocmd InsertLeave *.tex if !&diff | setlocal foldmethod=expr | endif
	augroup end
else
	setl foldmethod=manual
endif

function! LatexBox_FoldOnDemand()
	setl foldmethod=expr
	normal! zx
	setl foldmethod=manual
endfunction

command! LatexFold  call LatexBox_FoldOnDemand()

" {{{1 LatexBox_FoldLevel help functions

" This function parses the tex file to find the sections that are to be folded
" and their levels, and then predefines the patterns for optimized folding.
function! s:FoldSectionLevels()
    " Initialize
    let level = 1
    let foldsections = []

    " If we use two or more of the *matter commands, we need one more foldlevel
    let nparts = 0
    for part in g:LatexBox_fold_parts
        let i = 1
        while i < line("$")
            if getline(i) =~ '^\s*\\' . part . '\>'
                let nparts += 1
                break
            endif
            let i += 1
        endwhile
        if nparts > 1
            let level = 2
            break
        endif
    endfor

    " Combine sections and levels, but ignore unused section commands:  If we
    " don't use the part command, then chapter should have the highest
    " level.  If we don't use the chapter command, then section should be the
    " highest level.  And so on.
    let ignore = 1
    for part in g:LatexBox_fold_sections
        " For each part, check if it is used in the file.  We start adding the
        " part patterns to the fold sections array whenever we find one.
        let partpattern = '^\s*\(\\\|% Fake\)' . part . '\>'
        if ignore
            let i = 1
            while i < line("$")
                if getline(i) =~# partpattern
                    call insert(foldsections, [partpattern, level])
                    let level += 1
                    let ignore = 0
                    break
                endif
                let i += 1
            endwhile
        else
            call insert(foldsections, [partpattern, level])
            let level += 1
        endif
    endfor

    return foldsections
endfunction

" {{{1 LatexBox_FoldLevel

" Parse file to dynamically set the sectioning fold levels
let b:LatexBox_FoldSections = s:FoldSectionLevels()

" Optimize by predefine common patterns
let s:notbslash = '\%(\\\@<!\%(\\\\\)*\)\@<='
let s:notcomment = '\%(\%(\\\@<!\%(\\\\\)*\)\@<=%.*\)\@<!'
let s:envbeginpattern = s:notcomment . s:notbslash . '\\begin\s*{.\{-}}'
let s:envendpattern = s:notcomment . s:notbslash . '\\end\s*{.\{-}}'
let s:foldparts = '^\s*\\\%(' . join(g:LatexBox_fold_parts, '\|') . '\)'
let s:folded = '\(% Fake\|\\\(document\|begin\|end\|paragraph\|'
            \ . 'front\|main\|back\|app\|sub\|section\|chapter\|part\)\)'

function! LatexBox_FoldLevel(lnum)
    " Check for normal lines first (optimization)
    let line  = getline(a:lnum)
    if line !~ s:folded
        return "="
    endif

    " Fold preamble
    if g:LatexBox_fold_preamble == 1
        if line =~# s:notcomment . s:notbslash . '\s*\\documentclass'
            return ">1"
        elseif line =~# s:notcomment . s:notbslash . '\s*\\begin\s*{\s*document\s*}'
            return "0"
        endif
    endif

    " Fold parts (\frontmatter, \mainmatter, \backmatter, and \appendix)
    if line =~# s:foldparts
        return ">1"
    endif

    " Fold chapters and sections
    for [part, level] in b:LatexBox_FoldSections
        if line =~# part
            return ">" . level
        endif
    endfor

    " Never fold \end{document}
    if line =~# '^\s*\\end{document}'
        return 0
    endif

    " Fold environments
    if line =~# s:envbeginpattern && line =~# s:envendpattern
        " If the begin and end pattern are on the same line , do not fold
        return "="
    else
        if line =~# s:envbeginpattern
            if g:LatexBox_fold_envs == 1
                return "a1"
            else
                let env = matchstr(line,'\\begin\*\?{\zs\w*\*\?\ze}')
                if index(g:LatexBox_fold_envs_force, env) >= 0
                    return "a1"
                else
                    return "="
                endif
            endif
        elseif line =~# s:envendpattern
            if g:LatexBox_fold_envs == 1
                return "s1"
            else
                let env = matchstr(line,'\\end\*\?{\zs\w*\*\?\ze}')
                if index(g:LatexBox_fold_envs_force, env) >= 0
                    return "s1"
                else
                    return "="
                endif
            endif
        endif
    endif

    " Return foldlevel of previous line
    return "="
endfunction

" {{{1 LatexBox_FoldText help functions
function! s:LabelEnv()
    let i = v:foldend
    while i >= v:foldstart
        if getline(i) =~ '^\s*\\label'
            return matchstr(getline(i), '^\s*\\label{\zs.*\ze}')
        end
        let i -= 1
    endwhile
    return ""
endfunction

function! s:CaptionEnv()
    let i = v:foldend
    while i >= v:foldstart
        if getline(i) =~ '^\s*\\caption'
            return matchstr(getline(i), '^\s*\\caption\(\[.*\]\)\?{\zs.\+')
        end
        let i -= 1
    endwhile
    return ""
endfunction

function! s:CaptionTable()
    let i = v:foldstart
    while i <= v:foldend
        if getline(i) =~ '^\s*\\caption'
            return matchstr(getline(i), '^\s*\\caption\(\[.*\]\)\?{\zs.\+')
        end
        let i += 1
    endwhile
    return ""
endfunction

function! s:CaptionFrame(line)
    " Test simple variants first
    let caption1 = matchstr(a:line,'\\begin\*\?{.*}{\zs.\+\ze}')
    let caption2 = matchstr(a:line,'\\begin\*\?{.*}{\zs.\+')

    if len(caption1) > 0
        return caption1
    elseif len(caption2) > 0
        return caption2
    else
        let i = v:foldstart
        while i <= v:foldend
            if getline(i) =~ '^\s*\\frametitle'
                return matchstr(getline(i),
                            \ '^\s*\\frametitle\(\[.*\]\)\?{\zs.\+')
            end
            let i += 1
        endwhile

        return ""
    endif
endfunction

function! LatexBox_FoldText_title()
    let line = getline(v:foldstart)
    let title = 'Not defined'

    " Preamble
    if line =~ '\s*\\documentclass'
        return "Preamble"
    endif

    " Parts, sections and fakesections
    let sections = '\(\(sub\)*\(section\|paragraph\)\|part\|chapter\)'
    let secpat1 = '^\s*\\' . sections . '\*\?\s*{'
    let secpat2 = '^\s*\\' . sections . '\*\?\s*\['
    if line =~ '\\frontmatter'
        let title = "Frontmatter"
    elseif line =~ '\\mainmatter'
        let title = "Mainmatter"
    elseif line =~ '\\backmatter'
        let title = "Backmatter"
    elseif line =~ '\\appendix'
        let title = "Appendix"
    elseif line =~ secpat1 . '.*}'
        let title =  matchstr(line, secpat1 . '\zs.\{-}\ze}')
    elseif line =~ secpat1
        let title =  matchstr(line, secpat1 . '\zs.*')
    elseif line =~ secpat2 . '.*\]'
        let title =  matchstr(line, secpat2 . '\zs.\{-}\ze\]')
    elseif line =~ secpat2
        let title =  matchstr(line, secpat2 . '\zs.*')
    elseif line =~ 'Fake' . sections . ':'
        let title =  matchstr(line,'Fake' . sections . ':\s*\zs.*')
    elseif line =~ 'Fake' . sections
        let title =  matchstr(line, 'Fake' . sections)
    endif

    " Environments
    if line =~ '\\begin'
        " Capture environment name
        let env = matchstr(line,'\\begin\*\?{\zs\w*\*\?\ze}')

        " Set caption based on type of environment
        if env == 'frame'
            let label = ''
            let caption = s:CaptionFrame(line)
        elseif env == 'table'
            let label = s:LabelEnv()
            let caption = s:CaptionTable()
        else
            let label = s:LabelEnv()
            let caption = s:CaptionEnv()
        endif

        " If no caption found, check for a caption comment
        if caption == ''
            let caption = matchstr(line,'\\begin\*\?{.*}\s*%\s*\zs.*')
        endif

        " Create title based on caption and label
        if caption . label == ''
            let title = env
        elseif label == ''
            let title = printf('%-12s%s', env . ':',
                        \ substitute(caption, '}\s*$', '',''))
        elseif caption == ''
            let title = printf('%-12s%56s', env, '(' . label . ')')
        else
            let title = printf('%-12s%-30s %21s', env . ':',
                        \ strpart(substitute(caption, '}\s*$', '',''),0,34),
                        \ '(' . label . ')')
        endif
    endif

    return title
endfunction

" {{{1 LatexBox_FoldText
function! LatexBox_FoldText()
    let nlines = v:foldend - v:foldstart + 1
    let title = strpart(LatexBox_FoldText_title(), 0, 68)
    let level = ''

    " Fold level
    let level = strpart(repeat('-', v:foldlevel-1) . '*',0,3)
    if v:foldlevel > 3
        let level = strpart(level, 1) . v:foldlevel
    endif
    let level = printf('%-3s', level)

    return printf('%-3s %-68s #%5d', level, title, nlines)
endfunction

" {{{1 Footer
" vim:fdm=marker:ff=unix:ts=4:sw=4

endif
