if has_key(g:polyglot_is_disabled, 'nim')
  finish
endif

let g:nim_log = []
let s:plugin_path = escape(expand('<sfile>:p:h'), '\')

if !exists('g:nim_caas_enabled')
  let g:nim_caas_enabled = 0
endif

if !executable('nim')
  echoerr "the Nim compiler must be in your system's PATH"
endif

if has('pythonx')
  exe 'pyxfile ' . fnameescape(s:plugin_path) . '/nim_vim.py'
endif

fun! nim#init() abort
  let cmd = printf('nim --dump.format:json --verbosity:0 dump %s', s:CurrentNimFile())
  let raw_dumpdata = system(cmd)
  if !v:shell_error && expand('%:e') ==# 'nim'
    let false = 0 " Needed for eval of json
    let true = 1 " Needed for eval of json
    let dumpdata = eval(substitute(raw_dumpdata, "\n", '', 'g'))
    
    let b:nim_project_root = dumpdata['project_path']
    let b:nim_defined_symbols = dumpdata['defined_symbols']
    let b:nim_caas_enabled = g:nim_caas_enabled || index(dumpdata['defined_symbols'], 'forcecaas') != -1

    for path in dumpdata['lib_paths']
      if finddir(path) ==# path
        let &l:path = path . ',' . &l:path
      endif
    endfor
  else
    let b:nim_caas_enabled = 0
  endif
endf

fun! s:UpdateNimLog() abort
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile

  for entry in g:nim_log
    call append(line('$'), split(entry, "\n"))
  endfor

  let g:nim_log = []

  match Search /^nim\ .*/
endf

augroup NimVim
  au!
  au BufEnter log://nim call s:UpdateNimLog()
  if has('pythonx')
    " au QuitPre * :pyx nimTerminateAll()
    au VimLeavePre * :pyx nimTerminateAll()
  endif
augroup END

command! NimLog :e log://nim

command! NimTerminateService
  \ :exe printf("pyx nimTerminateService('%s')", b:nim_project_root)

command! NimRestartService
  \ :exe printf("pyx nimRestartService('%s')", b:nim_project_root)

fun! s:CurrentNimFile() abort
  let save_cur = getpos('.')
  call cursor(0, 0, 0)
  
  let PATTERN = '\v^\#\s*included from \zs.*\ze'
  let l = search(PATTERN, 'n')

  if l != 0
    let f = matchstr(getline(l), PATTERN)
    let l:to_check = expand('%:h') . '/' . f
  else
    let l:to_check = expand('%')
  endif

  call setpos('.', save_cur)
  return l:to_check
endf

let g:nim_symbol_types = {
  \ 'skParam': 'v',
  \ 'skVar': 'v',
  \ 'skLet': 'v',
  \ 'skTemp': 'v',
  \ 'skForVar': 'v',
  \ 'skConst': 'v',
  \ 'skResult': 'v',
  \ 'skGenericParam': 't',
  \ 'skType': 't',
  \ 'skField': 'm',
  \ 'skProc': 'f',
  \ 'skMethod': 'f',
  \ 'skIterator': 'f',
  \ 'skConverter': 'f',
  \ 'skMacro': 'f',
  \ 'skTemplate': 'f',
  \ 'skEnumField': 'v',
  \ }

fun! NimExec(op) abort
  let isDirty = getbufvar(bufnr('%'), '&modified')
  if isDirty
    let tmp = tempname() . bufname('%') . '_dirty.nim'
    silent! exe ':w ' . tmp

    let cmd = printf('idetools %s --trackDirty:"%s,%s,%d,%d" "%s"',
      \ a:op, tmp, expand('%:p'), line('.'), col('.')-1, s:CurrentNimFile())
  else
    let cmd = printf('idetools %s --track:"%s,%d,%d" "%s"',
      \ a:op, expand('%:p'), line('.'), col('.')-1, s:CurrentNimFile())
  endif

  if b:nim_caas_enabled
    exe printf("pyx nimExecCmd('%s', '%s', False)", b:nim_project_root, cmd)
    let output = get(l:, 'py_res', '')
  else
    let output = system('nim ' . cmd)
  endif

  call add(g:nim_log, 'nim ' . cmd . "\n" . output)
  return output
endf

fun! NimExecAsync(op, Handler) abort
  let result = NimExec(a:op)
  call a:Handler(result)
endf

fun! NimComplete(findstart, base) abort
  if b:nim_caas_enabled ==# 0
    return -1
  endif

  if a:findstart
    if synIDattr(synIDtrans(synID(line('.'),col('.'),1)), 'name') ==# 'Comment'
      return -1
    endif
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~? '\w'
      let start -= 1
    endwhile
    return start
  else
    let result = []
    let sugOut = NimExec('--suggest')
    for line in split(sugOut, '\n')
      let lineData = split(line, '\t')
      if len(lineData) > 0 && lineData[0] ==# 'sug'
        let word = split(lineData[2], '\.')[-1]
        if a:base ==? '' || word =~# '^' . a:base
          let kind = get(g:nim_symbol_types, lineData[1], '')
          let c = { 'word': word, 'kind': kind, 'menu': lineData[3], 'dup': 1 }
          call add(result, c)
        endif
      endif
    endfor
    return result
  endif
endf

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns['nim'] = '[^. *\t]\.\w*'

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns['nim'] = '[^. *\t]\.\w*'

let g:nim_completion_callbacks = {}

fun! NimAsyncCmdComplete(cmd, output) abort
  call add(g:nim_log, a:output)
  echom g:nim_completion_callbacks
  if has_key(g:nim_completion_callbacks, a:cmd)
    let Callback = get(g:nim_completion_callbacks, a:cmd)
    call Callback(a:output)
    " remove(g:nim_completion_callbacks, a:cmd)
  else
    echom 'ERROR, Unknown Command: ' . a:cmd
  endif
  return 1
endf

fun! GotoDefinition_nim_ready(def_output) abort
  if v:shell_error
    echo 'nim was unable to locate the definition. exit code: ' . v:shell_error
    " echoerr a:def_output
    return 0
  endif
  
  let rawDef = matchstr(a:def_output, 'def\t\([^\n]*\)')
  if rawDef == ''
    echo 'the current cursor position does not match any definitions'
    return 0
  endif
  
  let defBits = split(rawDef, '\t')
  let file = defBits[4]
  let line = defBits[5]
  exe printf('e +%d %s', line, file)
  return 1
endf

fun! GotoDefinition_nim() abort
  call NimExecAsync('--def', function('GotoDefinition_nim_ready'))
endf

fun! FindReferences_nim() abort
  "setloclist()
endf

" Syntastic syntax checking
fun! SyntaxCheckers_nim_nim_GetLocList() abort
  let makeprg = 'nim check --hints:off --listfullpaths ' . s:CurrentNimFile()
  let errorformat = &errorformat
  
  return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })
endf

function! SyntaxCheckers_nim_nim_IsAvailable() abort
  return executable('nim')
endfunction

if exists('g:SyntasticRegistry')
  call g:SyntasticRegistry.CreateAndRegisterChecker({
      \ 'filetype': 'nim',
      \ 'name': 'nim'})
endif
