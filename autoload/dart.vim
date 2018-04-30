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
    if buffer_content ==# joined_lines[:-2] | return | endif
    if 0 == v:shell_error
      let win_view = winsaveview()
      let lines = split(joined_lines, "\n")
      silent keepjumps call setline(1, lines)
      if line('$') > len(lines)
        silent keepjumps execute string(len(lines)+1).',$ delete'
      endif
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

" Finds the path to `uri`.
"
" If the file is a package: uri, looks for a .packages file to resolve the path.
" If the path cannot be resolved, or is not a package: uri, returns the
" original.
function! dart#resolveUri(uri) abort
  if a:uri !~ 'package:'
    return a:uri
  endif
  let package_name = substitute(a:uri, 'package:\(\w\+\)\/.*', '\1', '')
  let [found, package_map] = s:PackageMap()
  if !found
    call s:error('cannot find .packages file')
    return a:uri
  endif
  if !has_key(package_map, package_name)
    call s:error('no package mapping for '.package_name)
    return a:uri
  endif
  let package_lib = package_map[package_name]
  return substitute(a:uri,
      \ 'package:'.package_name,
      \ escape(package_map[package_name], '\'),
      \ '')
endfunction

" A map from package name to lib directory parse from a '.packages' file.
"
" Returns [found, package_map]
function! s:PackageMap() abort
  let [found, dot_packages] = s:DotPackagesFile()
  if !found
    return [v:false, {}]
  endif
  let dot_packages_dir = fnamemodify(dot_packages, ':p:h')
  let lines = readfile(dot_packages)
  let map = {}
  for line in lines
    if line =~ '\s*#'
      continue
    endif
    let package = substitute(line, ':.*$', '', '')
    let lib_dir = substitute(line, '^[^:]*:', '', '')
    if lib_dir =~ 'file:/'
      let lib_dir = substitute(lib_dir, 'file://', '', '')
      if lib_dir =~ '/[A-Z]:/'
        let lib_dir = lib_dir[1:]
      endif
    else
      let lib_dir = resolve(dot_packages_dir.'/'.lib_dir)
    endif
    if lib_dir =~ '/$'
      let lib_dir = lib_dir[:len(lib_dir) - 2]
    endif
    let map[package] = lib_dir
  endfor
  return [v:true, map]
endfunction

" Toggle whether dartfmt is run on save or not.
function! dart#ToggleFormatOnSave() abort
  if get(g:, "dart_format_on_save", 0)
    let g:dart_format_on_save = 0
    return
  endif
  let g:dart_format_on_save = 1
endfunction

" Finds a file name '.packages' in the cwd, or in any directory above the open
" file.
"
" Returns [found, file].
function! s:DotPackagesFile() abort
  if filereadable('.packages')
    return [v:true, '.packages']
  endif
  let dir_path = expand('%:p:h')
  while v:true
    let file_path = dir_path.'/.packages'
    if filereadable(file_path)
      return [v:true, file_path]
    endif
    let parent = fnamemodify(dir_path, ':h')
    if dir_path == parent
      break
    endif
    let dir_path = parent
  endwhile
  return [v:false, '']
endfunction

" Prevent writes to files in the pub cache.
function! dart#setModifiable() abort
  let full_path = expand('%:p')
  if full_path =~# '.pub-cache' ||
      \ full_path =~# 'Pub\Cache'
    setlocal nomodifiable
  endif
endfunction

endif
