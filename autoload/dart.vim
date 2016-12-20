if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dart') == -1
  

function! s:error(text) abort
  echohl Error
  echomsg printf('[dart-vim-plugin] %s', a:text)
  echohl None
endfunction

function! s:cexpr(errorformat, joined_lines) abort
  let temp_errorfomat = &errorformat
  try
    let &errorformat = a:errorformat
    cexpr a:joined_lines
    copen
  finally
    let &errorformat = temp_errorfomat
  endtry
endfunction

function! dart#fmt(q_args) abort
  if executable('dartfmt')
    let buffer_content = join(getline(1, '$'), "\n")
    let joined_lines = system(printf('dartfmt %s', a:q_args), buffer_content)
    if 0 == v:shell_error
      let win_view = winsaveview()
      silent % delete _
      silent put=joined_lines
      silent 1 delete _
      call winrestview(win_view)
    else
      let errors = split(joined_lines, "\n")[2:]
      let file_path = expand('%')
      call map(errors, 'file_path.":".v:val')
      let error_format = '%A%f:line %l\, column %c of stdin: %m,%C%.%#'
      call s:cexpr(error_format, join(errors, "\n"))
    endif
  else
    call s:error('cannot execute binary file: dartfmt')
  endif
endfunction

function! dart#analyzer(q_args) abort
  if executable('dartanalyzer')
    let path = expand('%:p:gs:\:/:')
    if filereadable(path)
      let joined_lines = system(printf('dartanalyzer %s %s', a:q_args, shellescape(path)))
      call s:cexpr('%m (%f\, line %l\, col %c)', joined_lines)
    else
      call s:error(printf('cannot read a file: "%s"', path))
    endif
  else
    call s:error('cannot execute binary file: dartanalyzer')
  endif
endfunction

function! dart#tojs(q_args) abort
  if executable('dart2js')
    let path = expand('%:p:gs:\:/:')
    if filereadable(path)
      let joined_lines = system(printf('dart2js %s %s', a:q_args, shellescape(path)))
      call s:cexpr('%m (%f\, line %l\, col %c)', joined_lines)
    else
      call s:error(printf('cannot read a file: "%s"', path))
    endif
  else
    call s:error('cannot execute binary file: dartanalyzer')
  endif
endfunction


endif
