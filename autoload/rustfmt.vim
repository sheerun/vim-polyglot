if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'rust') == -1
  
" Author: Stephen Sugden <stephen@stephensugden.com>
"
" Adapted from https://github.com/fatih/vim-go
" For bugs, patches and license go to https://github.com/rust-lang/rust.vim

if !exists("g:rustfmt_autosave")
    let g:rustfmt_autosave = 0
endif

if !exists("g:rustfmt_command")
    let g:rustfmt_command = "rustfmt"
endif

if !exists("g:rustfmt_options")
    let g:rustfmt_options = ""
endif

if !exists("g:rustfmt_fail_silently")
    let g:rustfmt_fail_silently = 0
endif

function! rustfmt#DetectVersion()
    " Save rustfmt '--help' for feature inspection
    silent let s:rustfmt_help = system(g:rustfmt_command . " --help")
    let s:rustfmt_unstable_features = 1 - (s:rustfmt_help !~# "--unstable-features")

    " Build a comparable rustfmt version varible out of its `--version` output:
    silent let s:rustfmt_version = system(g:rustfmt_command . " --version")
    let s:rustfmt_version = matchlist(s:rustfmt_version, '\vrustfmt ([0-9]+[.][0-9]+[.][0-9]+)')

    if len(s:rustfmt_version) < 3 
        let s:rustfmt_version = "0"
    else
        let s:rustfmt_version = s:rustfmt_version[1]
    endif

    return s:rustfmt_version
endfunction

call rustfmt#DetectVersion()

if !exists("g:rustfmt_emit_files")
    let g:rustfmt_emit_files = s:rustfmt_version >= "0.8.2"
endif

if !exists("g:rustfmt_file_lines")
    let g:rustfmt_file_lines = 1 - (s:rustfmt_help !~# "--file-lines JSON")
endif

let s:got_fmt_error = 0

function! rustfmt#Load()
    " Utility call to get this script loaded, for debugging
endfunction

function! s:RustfmtWriteMode()
    if g:rustfmt_emit_files
        return "--emit=files"
    else
        return "--write-mode=overwrite"
    endif
endfunction

function! s:RustfmtCommandRange(filename, line1, line2)
    if g:rustfmt_file_lines == 0
        echo "--file-lines is not supported in the installed `rustfmt` executable"
        return
    endif

    let l:arg = {"file": shellescape(a:filename), "range": [a:line1, a:line2]}
    let l:write_mode = s:RustfmtWriteMode()

    " FIXME: When --file-lines gets to be stable, enhance this version range checking
    " accordingly.
    let l:unstable_features = 
                \ (s:rustfmt_unstable_features && (s:rustfmt_version < '1.'))
                \ ? '--unstable-features' : ''

    let l:cmd = printf("%s %s %s %s --file-lines '[%s]' %s", g:rustfmt_command, 
                \ l:write_mode, g:rustfmt_options, 
                \ l:unstable_features, json_encode(l:arg), shellescape(a:filename))
    return l:cmd
endfunction

function! s:RustfmtCommand(filename)
    let l:write_mode = s:RustfmtWriteMode()
    return g:rustfmt_command . " ". l:write_mode . " " . g:rustfmt_options . " " . shellescape(a:filename)
endfunction

function! s:RunRustfmt(command, tmpname, fail_silently)
    mkview!

    if exists("*systemlist")
        let out = systemlist(a:command)
    else
        let out = split(system(a:command), '\r\?\n')
    endif

    if v:shell_error == 0 || v:shell_error == 3
        " remove undo point caused via BufWritePre
        try | silent undojoin | catch | endtry

        " take the tmpfile's content, this is better than rename
        " because it preserves file modes.
        let l:content = readfile(a:tmpname)
        1,$d _
        call setline(1, l:content)

        " only clear location list if it was previously filled to prevent
        " clobbering other additions
        if s:got_fmt_error
            let s:got_fmt_error = 0
            call setloclist(0, [])
            lwindow
        endif
    elseif g:rustfmt_fail_silently == 0 && a:fail_silently == 0
        " otherwise get the errors and put them in the location list
        let errors = []

        let prev_line = ""
        for line in out
            " error: expected one of `;` or `as`, found `extern`
            "  --> src/main.rs:2:1
            let tokens = matchlist(line, '^\s-->\s\(.\{-}\):\(\d\+\):\(\d\+\)$')
            if !empty(tokens)
                call add(errors, {"filename": @%,
                            \"lnum":	tokens[2],
                            \"col":	tokens[3],
                            \"text":	prev_line})
            endif
            let prev_line = line
        endfor

        if empty(errors)
            % | " Couldn't detect rustfmt error format, output errors
        endif

        if !empty(errors)
            call setloclist(0, errors, 'r')
            echohl Error | echomsg "rustfmt returned error" | echohl None
        endif

        let s:got_fmt_error = 1
        lwindow
    endif

    call delete(a:tmpname)

    silent! loadview
endfunction

function! s:rustfmtSaveToTmp()
    let l:tmpname = tempname()
    call writefile(getline(1, '$'), l:tmpname)
    return l:tmpname
endfunction

function! rustfmt#FormatRange(line1, line2)
    let l:tmpname = s:rustfmtSaveToTmp()
    let command = s:RustfmtCommandRange(l:tmpname, a:line1, a:line2)
    call s:RunRustfmt(command, l:tmpname, 0)
endfunction

function! rustfmt#Format()
    let l:tmpname = s:rustfmtSaveToTmp()
    let command = s:RustfmtCommand(l:tmpname)
    call s:RunRustfmt(command, l:tmpname, 0)
endfunction

function! rustfmt#PreWrite()
    if rust#GetConfigVar('rustfmt_autosave_if_config_present', 0)
        if findfile('rustfmt.toml', '.;') !=# '' 
            let b:rustfmt_autosave = 1
            let b:rustfmt_autosave_because_of_config = 1
        endif
    endif

    if !rust#GetConfigVar("rustfmt_autosave", 0)
        return
    endif

    let l:tmpname = s:rustfmtSaveToTmp()
    let command = s:RustfmtCommand(l:tmpname)
    call s:RunRustfmt(command, l:tmpname, 1)
endfunction


" vim: set et sw=4 sts=4 ts=8:

endif
