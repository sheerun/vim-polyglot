if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'gdscript') == -1

setlocal commentstring=#\ %s

if exists("g:gdscript3_loaded")
    finish
endif
let g:gdscript3_loaded=1

if !has("python3") && !has("python")
    finish
endif

if has("python3")
    let s:pyfile_cmd = "py3file"
    let s:py_cmd = "py3"
else
    let s:pyfile_cmd = "pyfile"
    let s:py_cmd = "py"
endif

execute s:pyfile_cmd . " " . expand('<sfile>:p:h') . "/../python/init.py"

fun! GDScriptComplete(findstart, base)
    if a:findstart == 1
        let line = getline('.')
        let start = col('.') - 1
        " Treat '-' as part of the word when completing in a string.
        if synIDattr(synID(line('.'), col('.')-1, 1), 'name') ==# "gdString"
            let pattern = '[-a-zA-Z0-9_]'
        else
            let pattern = '[a-zA-Z0-9_]'
        endif
        while start > 0 && line[start - 1] =~ pattern
            let start -= 1
        endwhile
        return start
    else
        execute s:py_cmd . " gdscript_complete()"
        if exists("gdscript_completions")
            return gdscript_completions
        else
            return []
        endif
    endif
endfun
set omnifunc=GDScriptComplete

" Configure for common completion frameworks.

" Deoplete
if &rtp =~ 'deoplete.nvim'
    call deoplete#custom#option('sources', {
        \ 'gdscript3': ['omni'],
    \ })
    call deoplete#custom#var('omni', 'input_patterns', {
        \ 'gdscript3': [
            \ '\.|\w+',
            \ '\bextends\s+',
            \ '\bexport\(',
            \ '\bfunc\s+',
            \ '"res://[^"]*'
        \ ]
    \ })
endif

" SuperTab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" YouCompleteMe
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.gdscript3 = [
    \'re!\w+',
    \'.',
    \'re!\bextends\s+',
    \'re!\bexport\(',
    \'re!\bfunc\s+',
    \'re!"res://[^"]*'
    \]



" Configure echodoc
if &rtp =~ 'echodoc'
    let s:echodoc_dict = { "name": "gdscript3", "rank": 9 }
    fun! s:echodoc_dict.search(text)
        execute s:py_cmd . " echodoc_search()"
        if exists("echodoc_search_result")
            return echodoc_search_result
        else
            return []
        endif
    endfun
    call echodoc#register('gdscript3', s:echodoc_dict)

    " Reset echodoc cache when exiting insert mode.
    " This fixes an issue where the function signature wouldn't re-appear
    " after exiting and re-entering insert mode.
    au InsertLeave * let b:prev_echodoc = []
endif

" Configure Syntastic checker
let g:syntastic_gdscript3_checkers = ['godot_server']

endif
