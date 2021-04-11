if polyglot#init#is_disabled(expand('<sfile>:p'), 'zig', 'autoload/zig/fmt.vim')
  finish
endif

" Adapted from fatih/vim-go: autoload/go/fmt.vim
"
" Copyright 2011 The Go Authors. All rights reserved.
" Use of this source code is governed by a BSD-style
" license that can be found in the LICENSE file.

function! zig#fmt#Format() abort
  " Save cursor position and many other things.
  let view = winsaveview()

  let current_buf = bufnr('')

  let bin_path = get(g:, 'zig_bin_path', 'zig')
  let stderr_file = tempname()
  let cmdline = printf('%s fmt --stdin 2> %s', bin_path, stderr_file)

  " The formatted code is output on stdout, the errors go on stderr.
  if exists('*systemlist')
    silent let out = systemlist(cmdline, current_buf)
  else
    silent let out = split(system(cmdline, current_buf))
  endif
  let err = v:shell_error

  if err == 0
    " remove undo point caused via BufWritePre.
    try | silent undojoin | catch | endtry

    " Replace the file content with the formatted version.
    call deletebufline(current_buf, len(out), line('$'))
    call setline(1, out)

    " No errors detected, close the loclist.
    call setloclist(0, [], 'r')
    lclose
  elseif get(g:, 'zig_fmt_parse_errors', 1)
    let errors = s:parse_errors(expand('%'), readfile(stderr_file))

    call setloclist(0, [], 'r', {
        \ 'title': 'Errors',
        \ 'items': errors,
        \ })

    let max_win_height = get(g:, 'zig_fmt_max_window_height', 5)
    " Prevent the loclist from becoming too long.
    let win_height = min([max_win_height, len(errors)])
    " Open the loclist, but only if there's at least one error to show.
    execute 'lwindow ' . win_height
  endif

  call delete(stderr_file)

  call winrestview(view)

  if err != 0
    echohl Error | echomsg "zig fmt returned error" | echohl None
    return
  endif

  " Run the syntax highlighter on the updated content and recompute the folds if
  " needed.
  syntax sync fromstart
endfunction

" parse_errors parses the given errors and returns a list of parsed errors
function! s:parse_errors(filename, lines) abort
  " list of errors to be put into location list
  let errors = []
  for line in a:lines
    let tokens = matchlist(line, '^\(.\{-}\):\(\d\+\):\(\d\+\)\s*\(.*\)')
    if !empty(tokens)
      call add(errors,{
            \"filename": a:filename,
            \"lnum":     tokens[2],
            \"col":      tokens[3],
            \"text":     tokens[4],
            \ })
    endif
  endfor

  return errors
endfunction
" vim: sw=2 ts=2 et
