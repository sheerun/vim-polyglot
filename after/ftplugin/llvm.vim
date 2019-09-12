if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'llvm') == -1

" Copyright (c) 2018 rhysd
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.

if get(g:, 'llvm_extends_official', 1) == 0
    finish
endif

let g:llvm_ext_no_mapping = get(g:, 'llvm_ext_no_mapping', 0)
let g:llvm_ext_lli_executable = get(g:, 'llvm_ext_lli_executable', 'lli')

let s:KIND_BLOCK_PREC = 0
let s:KIND_BLOCK_FOLLOW = 1
let s:KIND_FUNC_BEGIN = 2
let s:KIND_FUNC_END = 3

function! s:section_delim_at(lnum) abort
    let line = getline(a:lnum)
    let m = matchlist(line, '^\([^:]\+\):\%( \+; preds = \(%.\+\)\)\=$')
    if !empty(m)
        if m[2] ==# ''
            return [s:KIND_BLOCK_PREC, m[1]]
        else
            return [s:KIND_BLOCK_FOLLOW, m[1], split(m[2], ',\s*')]
        endif
    endif
    if line =~# '^}$'
        return [s:KIND_FUNC_END]
    endif
    if line =~# '^define\>'
        return [s:KIND_FUNC_BEGIN]
    endif
    return []
endfunction

function! s:is_section_delim(line, func_delim) abort
    let sec = s:section_delim_at(a:line)
    if empty(sec)
        return 0
    endif
    let kind = sec[0]
    return kind == s:KIND_BLOCK_PREC || kind == s:KIND_BLOCK_FOLLOW || kind == func_delim
endfunction

function! s:next_section(stop_func_begin) abort
    let func_delim = a:stop_func_begin ? s:KIND_FUNC_BEGIN : s:KIND_FUNC_END
    let last = line('$') - 1
    let line = line('.')
    while line < last
        let line += 1
        if s:is_section_delim(line, func_delim)
            call cursor(line, col('.'))
            return
        endif
    endwhile
endfunction

function! s:prev_section(stop_func_begin) abort
    let func_delim = a:stop_func_begin ? s:KIND_FUNC_BEGIN : s:KIND_FUNC_END
    let line = line('.')
    while line > 1
        let line -= 1
        if s:is_section_delim(line, func_delim)
            call cursor(line, col('.'))
            return
        endif
    endwhile
endfunction

if !g:llvm_ext_no_mapping
    nnoremap <buffer><silent>]] :<C-u>call <SID>next_section(1)<CR>
    nnoremap <buffer><silent>[[ :<C-u>call <SID>prev_section(1)<CR>
    nnoremap <buffer><silent>][ :<C-u>call <SID>next_section(0)<CR>
    nnoremap <buffer><silent>[] :<C-u>call <SID>prev_section(0)<CR>
endif

function! s:function_range_at(linum) abort
    let line = a:linum
    while line >= 1
        let s = getline(line)
        if s =~# '^define\>'
            let start = line
            break
        elseif s =~# '^}$'
            return []
        endif
        let line -= 1
    endwhile
    if line < 1
        return []
    endif

    let line = a:linum
    let last = line('$')
    while line <= last
        let s = getline(line)
        if s =~# '^}$'
            let end = line
            break
        elseif s =~# '^define\>'
            return []
        endif
        let line += 1
    endwhile
    if line > last
        return []
    endif

    return [start, end]
endfunction

function! s:blocks_graph_at(linum) abort
    let func_range = s:function_range_at(a:linum)
    if empty(func_range)
        return {}
    endif
    let line = func_range[0] + 1
    let last = func_range[1] - 1
    let graph = {}
    while line <= last
        let block = s:section_delim_at(line)
        if empty(block)
            let line += 1
            continue
        endif
        let block_name = '%' . block[1]
        if block[0] == s:KIND_BLOCK_PREC
            let graph[block_name] = {'line': line, 'follows': [], 'preds': []}
        elseif block[0] == s:KIND_BLOCK_FOLLOW
            let graph[block_name] = {'line': line, 'follows': [], 'preds': block[2]}
            for follow in block[2]
                call add(graph[follow].follows, block_name)
            endfor
        else
            echoerr 'unreachable'
        endif
        let line += 1
    endwhile
    return graph
endfunction

function! s:find_pred_block(linum) abort
    let sec = s:section_delim_at(a:linum)
    if empty(sec) || sec[0] != s:KIND_BLOCK_PREC && sec[0] != s:KIND_BLOCK_FOLLOW
        throw 'No block is starting at line ' . a:linum
    endif
    if sec[0] != s:KIND_BLOCK_FOLLOW
        throw printf("Block '%s' has no pred block", sec[1])
    endif
    let block_name = '%' . sec[1]
    let pred_block = sec[2][0]

    let graph = s:blocks_graph_at(a:linum)
    if empty(graph)
        throw 'No block is found in function at line ' . a:linum
    endif

    if !has_key(graph, pred_block)
        throw printf("Block '%s' (pred block of '%s') not found in function", pred_block, block_name)
    endif
    return graph[pred_block]
endfunction

function! s:move_to_pred_block() abort
    try
        let b = s:find_pred_block(line('.'))
        call cursor(b.line, col('.'))
    catch
        echohl ErrorMsg | echom v:exception | echohl None
    endtry
endfunction

function! s:find_following_block(linum) abort
    let sec = s:section_delim_at(a:linum)
    if empty(sec) || sec[0] != s:KIND_BLOCK_PREC && sec[0] != s:KIND_BLOCK_FOLLOW
        throw 'No block is starting at line ' . a:linum
    endif
    let block_name = '%' . sec[1]

    let graph = s:blocks_graph_at(a:linum)
    if empty(graph)
        throw 'No block is found in function at line ' . a:linum
    endif

    let follows = graph[block_name].follows
    if empty(follows)
        throw printf("Block '%s' has no following block", block_name)
    endif

    echom printf("Block '%s' has %d following blocks: %s", block_name, len(follows), join(follows, ', '))

    if !has_key(graph, follows[0])
        throw printf("Block '%s' is not defined in function at line %d", follows[0], a:linum)
    endif
    return graph[follows[0]]
endfunction

function! s:move_to_following_block() abort
    try
        let b = s:find_following_block(line('.'))
        call cursor(b.line, col('.'))
    catch
        echohl ErrorMsg | echom v:exception | echohl None
    endtry
endfunction

if !g:llvm_ext_no_mapping
    nnoremap <buffer><silent>[b :<C-u>call <SID>move_to_pred_block()<CR>
    nnoremap <buffer><silent>]b :<C-u>call <SID>move_to_following_block()<CR>
endif

function! s:get_func_identifiers(line) abort
    let idx = stridx(a:line, '@')
    if idx == -1
        " Invalid signature
        return []
    endif

    " e.g. define internal i32 @foo(...) { -> @foo(...) {
    let sig = a:line[idx:]

    let idx = stridx(sig, '(')
    if idx == -1
        " Invalid signature
        return []
    endif

    " @foo(...) { -> @foo
    let idents = [sig[:idx-1]]

    " @foo(...) { -> ...) {
    let params = sig[idx+1:]

    let idx = strridx(sig, ')')
    if idx == -1
        return idents
    endif

    " ...) { -> ...
    let params = params[:idx-1]

    " Gather parameters in function signature
    while params !=# ''
        let m = matchlist(params, '^[^%]*\(%\%("[^"]\+"\|[[:alnum:]_.]\+\)\)\s*\(.*\)$')
        if empty(m)
            break
        endif
        let idents += [m[1]]
        let params = m[2]
    endwhile

    return idents
endfunction

function! s:get_identifiers(line) abort
    " Registers and type defs
    let m = matchlist(a:line, '^\s*\(%\S\+\)\s\+=')
    if !empty(m)
        return [m[1]]
    endif

    " Constants
    let m = matchlist(a:line, '^\(@\S\+\)\s\+=.\+\<constant\>')
    if !empty(m)
        return [m[1]]
    endif

    " Labels for basic blocks
    let m = matchlist(a:line, '^\([^:]\+\):\%(\s\+; preds = .\+\)\=$')
    if !empty(m)
        return ['%' . m[1]]
    endif

    " Meta variables
    let m = matchlist(a:line, '^\(!\S\+\)\s\+=')
    if !empty(m)
        return [m[1]]
    endif

    " Attributes
    let m = matchlist(a:line, '^attributes\s\+\(#\d\+\)\s\+=')
    if !empty(m)
        return [m[1]]
    endif

    if a:line =~# '^\%(declare\|define\)\>'
        return s:get_func_identifiers(a:line)
    endif

    return []
endfunction

function! s:extract_identifier(word) abort
    if strlen(a:word) <= 1
        return ''
    endif

    let prefix = a:word[0]
    if prefix ==# '@' || prefix ==# '%' || prefix ==# '!'
        if prefix ==# '!' && a:word[1] ==# '{'
            return ''
        endif

        if a:word[1] == '"'
            let idx = stridx(a:word, '"', 2)
            if idx == -1
                return ''
            endif
            " @"foo" or %"foo"
            return a:word[:idx]
        else
            " @foo or %foo
            return matchstr(a:word, '^[@%!][[:alnum:]_.]\+')
        endif
    endif

    if prefix ==# '#'
        return matchstr(a:word, '^#\d\+')
    endif

    return ''
endfunction

function! s:jump_to_identifier_at(linum, ident) abort
    let line = getline(a:linum)
    let column = stridx(line, a:ident) + 1
    if column == 0
        let column = col('.')
    endif
    call cursor(a:linum, column)
endfunction

function! s:browser_open_command() abort
    if exists('g:llvm_ext_browser_open_command')
        return g:llvm_ext_browser_open_command
    endif
    if exists('s:browser_opener')
        return s:browser_opener
    endif
    let s:browser_opener = ''
    if has('mac')
        let s:browser_opener = 'open'
    elseif has('win32') || has('win64')
        let s:browser_opener =  'cmd /q /c start ""'
    else
        for cmd in ['xdg-open', 'chromium', 'google-chrome', 'firefox']
            if executable(cmd)
                let s:browser_opener = cmd
                break
            endif
        endfor
    endif
    return s:browser_opener
endfunction

function! s:open_browser(url) abort
    let cmd = s:browser_open_command()
    if cmd ==# ''
        throw "Failed to open a browser. I don't know how to open a browser: Please set g:llvm_ext_browser_open_command"
    endif
    let cmdline = cmd . ' ' . shellescape(a:url)
    let out = system(cmdline)
    if v:shell_error
        throw printf("Failed to open a browser with command '%s': %s", cmdline, out)
    endif
endfunction

function! s:goto_definition() abort
    " Open language reference manual under the cursor in browser
    let syn_name = synIDattr(synID(line('.'),col('.'),1),'name')
    if syn_name ==# 'llvmStatement'
        let word = expand('<cword>')
        if word !=# ''
            try
                " Open browser assuming a word under the cursor is an instruction
                call s:open_browser('https://llvm.org/docs/LangRef.html#' . word . '-instruction')
            catch /^Failed to open a browser/
                echohl ErrorMsg | echom v:exception | echohl None
            endtry
        endif
        return
    endif

    " XXX: This does not support identifiers which contains spaces
    let word = expand('<cWORD>')
    if word ==# ''
        echom 'No identifier found under the cursor'
        return
    endif
    let ident = s:extract_identifier(word)
    if ident ==# ''
        echom 'No identifier found under the cursor'
        return
    endif

    " Definition tends to be near its usages. Look back at first.
    let line = line('.')
    while line > 0
        for found in s:get_identifiers(getline(line))
            if ident ==# found
                call s:jump_to_identifier_at(line, ident)
                return
            endif
        endfor
        let line -= 1
    endwhile

    let line = line('.') + 1
    let last = line('$')
    while line <= last
        for found in s:get_identifiers(getline(line))
            if ident ==# found
                call s:jump_to_identifier_at(line, ident)
                return
            endif
        endfor
        let line += 1
    endwhile

    echom "No definition for '" . ident . "' found"
endfunction

if !g:llvm_ext_no_mapping
    nnoremap <buffer><silent>K :<C-u>call <SID>goto_definition()<CR>
endif

function! s:run_lli(...) abort
    if !has('job') || !has('channel') || !has('terminal')
        echohl ErrorMsg
        echomsg ':LLI requires terminal feature. Please update your Vim to 8.0+'
        echohl None
        return
    endif

    if !executable(g:llvm_ext_lli_executable)
        echohl ErrorMsg
        echomsg g:llvm_ext_lli_executable . ' is not executable. Please set g:llvm_ext_lli_executable'
        echohl None
        return
    endif

    if a:0 > 0
        let bufnr = term_start([g:llvm_ext_lli_executable, a:1])
        echo 'Run lli in termnal buffer(' . bufnr . ')'
        return
    endif

    let tmpfile = tempname()
    call writefile(getline(1, '$'), tmpfile)
    let Cleanup = {ch -> filereadable(tmpfile) ? delete(tmpfile) : 0}
    let bufnr = term_start([g:llvm_ext_lli_executable, tmpfile], {'close_cb': Cleanup, 'exit_cb': Cleanup})
    echo 'Run lli in termnal buffer(' . bufnr . ')'
endfunction

if !exists(':LLI')
    command! -buffer -nargs=? -bar -complete=file LLI call <SID>run_lli(<f-args>)
endif

endif
