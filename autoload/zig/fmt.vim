if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'zig') == -1

" Adapted from fatih/vim-go: autoload/go/fmt.vim
"
" Copyright 2011 The Go Authors. All rights reserved.
" Use of this source code is governed by a BSD-style
" license that can be found in the LICENSE file.
"
function! zig#fmt#Format() abort
  if zig#config#FmtExperimental()
    " Using winsaveview to save/restore cursor state has the problem of
    " closing folds on save:
    "   https://github.com/fatih/vim-go/issues/502
    " One fix is to use mkview instead. Unfortunately, this sometimes causes
    " other bad side effects:
    "   https://github.com/fatih/vim-go/issues/728
    " and still closes all folds if foldlevel>0:
    "   https://github.com/fatih/vim-go/issues/732
    let l:curw = {}
    try
      mkview!
    catch
      let l:curw = winsaveview()
    endtry

    " save our undo file to be restored after we are done. This is needed to
    " prevent an additional undo jump due to BufWritePre auto command and also
    " restore 'redo' history because it's getting being destroyed every
    " BufWritePre
    let tmpundofile = tempname()
    exe 'wundo! ' . tmpundofile
  else
    " Save cursor position and many other things.
    let l:curw = winsaveview()
  endif

  " Save cursor position and many other things.
  let l:curw = winsaveview()

  let bin_name = zig#config#FmtCommand()

  " Get current position in file
  let current_col = col('.')
  let orig_line_count = line('$')

  " Save current buffer first, else fmt will run on the original file and we
  " will lose our changes.
  silent! execute 'write' expand('%')

  let [l:out, l:err] = zig#fmt#run(bin_name, expand('%'))

  if l:err == 0
    call zig#fmt#update_file(expand('%'))
  elseif !zig#config#FmtFailSilently()
    let errors = s:parse_errors(expand('%'), out)
    call s:show_errors(errors)
  endif

  let diff_offset = line('$') - orig_line_count

  if zig#config#FmtExperimental()
    " restore our undo history
    silent! exe 'rundo ' . tmpundofile
    call delete(tmpundofile)

    " Restore our cursor/windows positions, folds, etc.
    if empty(l:curw)
      silent! loadview
    else
      call winrestview(l:curw)
    endif
  else
    " Restore our cursor/windows positions.
    call winrestview(l:curw)
  endif

  " be smart and jump to the line the new statement was added/removed
  call cursor(line('.') + diff_offset, current_col)

  " Syntax highlighting breaks less often.
  syntax sync fromstart
endfunction

" update_file updates the target file with the given formatted source
function! zig#fmt#update_file(target)
  " remove undo point caused via BufWritePre
  try | silent undojoin | catch | endtry

  " reload buffer to reflect latest changes
  silent edit!

  let l:listtype = zig#list#Type("ZigFmt")

  " the title information was introduced with 7.4-2200
  " https://github.com/vim/vim/commit/d823fa910cca43fec3c31c030ee908a14c272640
  if has('patch-7.4.2200')
    " clean up previous list
    if l:listtype == "quickfix"
      let l:list_title = getqflist({'title': 1})
    else
      let l:list_title = getloclist(0, {'title': 1})
    endif
  else
    " can't check the title, so assume that the list was for go fmt.
    let l:list_title = {'title': 'Format'}
  endif

  if has_key(l:list_title, "title") && l:list_title['title'] == "Format"
    call zig#list#Clean(l:listtype)
  endif
endfunction

" run runs the gofmt/goimport command for the given source file and returns
" the output of the executed command. Target is the real file to be formatted.
function! zig#fmt#run(bin_name, target)
  let l:cmd = []
  call extend(cmd, a:bin_name)
  call extend(cmd, [a:target])
  return zig#util#Exec(l:cmd)
endfunction

" parse_errors parses the given errors and returns a list of parsed errors
function! s:parse_errors(filename, content) abort
  let splitted = split(a:content, '\n')

  " list of errors to be put into location list
  let errors = []
  for line in splitted
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

" show_errors opens a location list and shows the given errors. If the given
" errors is empty, it closes the the location list
function! s:show_errors(errors) abort
  let l:listtype = zig#list#Type("ZigFmt")
  if !empty(a:errors)
    call zig#list#Populate(l:listtype, a:errors, 'Format')
    echohl Error | echomsg "zig fmt returned error" | echohl None
  endif

  " this closes the window if there are no errors or it opens
  " it if there is any
  call zig#list#Window(l:listtype, len(a:errors))
endfunction

function! zig#fmt#ToggleFmtAutoSave() abort
  if zig#config#FmtAutosave()
    call zig#config#SetFmtAutosave(0)
    call zig#util#EchoProgress("auto fmt disabled")
    return
  end

  call zig#config#SetFmtAutosave(1)
  call zig#util#EchoProgress("auto fmt enabled")
endfunction

" vim: sw=2 ts=2 et

endif
