if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'rust') == -1
  
" Author: Stephen Sugden <stephen@stephensugden.com>
"
" Adapted from https://github.com/fatih/vim-go

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

let s:got_fmt_error = 0

function! rustfmt#Format()
  let l:curw = winsaveview()
  let l:tmpname = expand("%:p:h") . "/." . expand("%:p:t") . ".rustfmt"
  call writefile(getline(1, '$'), l:tmpname)

  let command = g:rustfmt_command . " --write-mode=overwrite "

  let out = systemlist(command . g:rustfmt_options . " " . shellescape(l:tmpname))

  if v:shell_error == 0
    " remove undo point caused via BufWritePre
    try | silent undojoin | catch | endtry

    " Replace current file with temp file, then reload buffer
    call rename(l:tmpname, expand('%'))
    silent edit!
    let &syntax = &syntax

    " only clear location list if it was previously filled to prevent
    " clobbering other additions
    if s:got_fmt_error
      let s:got_fmt_error = 0
      call setloclist(0, [])
      lwindow
    endif
  elseif g:rustfmt_fail_silently == 0
    " otherwise get the errors and put them in the location list
    let errors = []

    for line in out
      " src/lib.rs:13:5: 13:10 error: expected `,`, or `}`, found `value`
      let tokens = matchlist(line, '^\(.\{-}\):\(\d\+\):\(\d\+\):\s*\(\d\+:\d\+\s*\)\?\s*error: \(.*\)')
      if !empty(tokens)
        call add(errors, {"filename": @%,
                         \"lnum":     tokens[2],
                         \"col":      tokens[3],
                         \"text":     tokens[5]})
      endif
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
    " We didn't use the temp file, so clean up
    call delete(l:tmpname)
  endif

  call winrestview(l:curw)
endfunction

endif
