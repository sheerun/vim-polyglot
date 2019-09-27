if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dart') == -1


function! s:error(text) abort
  echohl Error
  echomsg printf('[dart-vim-plugin] %s', a:text)
  echohl None
endfunction

function! s:cexpr(errorformat, lines, reason) abort
  call setqflist([], ' ', {
      \ 'lines': a:lines,
      \ 'efm': a:errorformat,
      \ 'context': {'reason': a:reason},
      \})
  copen
endfunction

" If the quickfix list has a context matching [reason], clear and close it.
function! s:clearQfList(reason) abort
  let context = get(getqflist({'context': 1}), 'context', {})
  if type(context) == v:t_dict &&
      \ has_key(context, 'reason') &&
      \ context.reason == a:reason
    call setqflist([], 'r')
    cclose
  endif
endfunction

function! dart#fmt(q_args) abort
  let cmd = s:FindDartFmt()
  if type(cmd) != type('') | return | endif
  let buffer_content = getline(1, '$')
  let args = '--stdin-name '.expand('%').' '.a:q_args
  let lines = systemlist(printf('%s %s', cmd, args), join(buffer_content, "\n"))
  " TODO(https://github.com/dart-lang/sdk/issues/38507) - Remove once the
  " tool no longer emits this line on SDK upgrades.
  if lines[-1] ==# 'Isolate creation failed'
    let lines = lines[:-2]
  endif
  if buffer_content == lines
    call s:clearQfList('dartfmt')
    return
  endif
  if 0 == v:shell_error
    let win_view = winsaveview()
    silent keepjumps call setline(1, lines)
    if line('$') > len(lines)
      silent keepjumps execute string(len(lines)+1).',$ delete'
    endif
    call winrestview(win_view)
    call s:clearQfList('dartfmt')
  else
    let errors = lines[2:]
    let error_format = '%Aline %l\, column %c of %f: %m,%C%.%#'
    call s:cexpr(error_format, errors, 'dartfmt')
  endif
endfunction

function! s:FindDartFmt() abort
  if executable('dartfmt') | return 'dartfmt' | endif
  if executable('flutter')
    let l:flutter_cmd = resolve(exepath('flutter'))
    let l:bin = fnamemodify(l:flutter_cmd, ':h')
    let l:dartfmt = l:bin.'/cache/dart-sdk/bin/dartfmt'
    if executable(l:dartfmt) | return l:dartfmt | endif
  endif
  call s:error('Cannot find a `dartfmt` command')
endfunction

function! dart#analyzer(q_args) abort
  call s:error('DartAnalyzer support has been removed. '.
      \'If this broke your workflow please comment on '.
      \'https://github.com/dart-lang/dart-vim-plugin/issues/89')
endfunction

function! dart#tojs(q_args) abort
  call s:error('Dart2JS support has been removed. '.
      \'If this broke your workflow please comment on '.
      \'https://github.com/dart-lang/dart-vim-plugin/issues/89')
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
