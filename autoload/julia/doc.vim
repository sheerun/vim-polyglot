if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'julia') == -1

" path to the julia binary to communicate with
if has('win32') || has('win64')
  if exists('g:julia#doc#juliapath')
    " use assigned g:julia#doc#juliapath
  elseif executable('julia')
    " use julia command in PATH
    let g:julia#doc#juliapath = 'julia'
  else
    " search julia binary in the default installation paths
    let pathlist = sort(glob($LOCALAPPDATA . '\Julia-*\bin\julia.exe', 1, 1))
    let g:julia#doc#juliapath = get(pathlist, -1, 'julia')
  endif
else
  let g:julia#doc#juliapath = get(g:, 'julia#doc#juliapath', 'julia')
endif

function! s:version() abort
  let VERSION = {'major': 0, 'minor': 0}
  if !executable(g:julia#doc#juliapath)
    return VERSION
  endif

  let cmd = printf('%s -v', g:julia#doc#juliapath)
  let output = system(cmd)
  let versionstr = matchstr(output, '\C^julia version \zs\d\+\.\d\+\ze')
  let [major, minor] = map(split(versionstr, '\.'), 'str2nr(v:val)')
  let VERSION.major = major
  let VERSION.minor = minor
  return VERSION
endfunction

let s:VERSION = s:version()
let s:NODOCPATTERN = '\C\VNo documentation found.'

function! julia#doc#lookup(keyword, ...) abort
  let juliapath = get(a:000, 0, g:julia#doc#juliapath)
  let keyword = escape(a:keyword, '"\')
  let cmd = printf('%s -E "@doc %s"', juliapath, keyword)
  return systemlist(cmd)
endfunction

function! julia#doc#open(keyword) abort
  if empty(a:keyword)
    call s:warn('Not an appropriate keyword.')
    return
  endif

  if !executable(g:julia#doc#juliapath)
    call s:warn('%s command is not executable', g:julia#doc#juliapath)
    return
  endif

  let doc = julia#doc#lookup(a:keyword, g:julia#doc#juliapath)
  if empty(doc) || match(doc[0], s:NODOCPATTERN) > -1
    call s:warn('No documentation found for "%s".', a:keyword)
    return
  endif

  " workaround for * and ? since a buffername cannot include them
  let keyword = a:keyword
  let keyword = substitute(keyword, '\*', ':asterisk:', 'g')
  let keyword = substitute(keyword, '?', ':question:', 'g')
  let buffername = printf('juliadoc: %s', keyword)

  call s:write_to_preview_window(doc, "juliadoc", buffername)

  call filter(s:HELPHISTORY, 'v:val isnot# a:keyword')
  call add(s:HELPHISTORY, a:keyword)
endfunction

function! s:write_to_preview_window(content, ftype, buffername)
  " Are we in the preview window from the outset? If not, best to close any
  " preview windows that might exist.
  let pvw = &previewwindow
  if !pvw
    silent! pclose!
  endif
  execute "silent! pedit +setlocal\\ nobuflisted\\ noswapfile\\"
        \ "buftype=nofile\\ bufhidden=wipe" a:buffername
  silent! wincmd P
  if &previewwindow
    setlocal modifiable noreadonly
    silent! %delete _
    call append(0, a:content)
    silent! $delete _
    normal! ggj
    setlocal nomodified readonly nomodifiable
    execute "setfiletype" a:ftype
    " Only return to a normal window if we didn't start in a preview window.
    if !pvw
      silent! wincmd p
    endif
  else
    " We couldn't make it to the preview window, so as a fallback we dump the
    " contents in the status area.
    execute printf("echo '%s'", join(a:content, "\n"))
  endif
endfunction

function! s:warn(...) abort
  if a:0 == 0
    return
  endif

  echohl WarningMsg
  try
    if a:0 == 1
      echo a:1
    else
      echo call('printf', a:000)
    endif
  finally
    echohl None
  endtry
endfunction



let s:KEYWORDPATTERN = '\m@\?\h\k*!\?'

" This function is called in normal mode or visual mode.
function! julia#doc#keywordprg(word) abort
  if a:word is# ''
    return
  endif

  let word = s:unfnameescape(a:word)
  if word is# expand('<cword>')
    " 'K' in normal mode
    " NOTE: Because ! and @ is not in 'iskeyword' option, this func ignore
    "       the argument to recognize keywords like "@time" and "push!"
    let view = winsaveview()
    let lnum = line('.')
    let tail = searchpos(s:KEYWORDPATTERN, 'ce', lnum)
    let head = searchpos(s:KEYWORDPATTERN, 'bc', lnum)
    call winrestview(view)
    if head == [0, 0] || tail == [0, 0]
      return
    else
      let start = head[1] - 1
      let end = tail[1] - 1
      let word = getline(lnum)[start : end]
    endif
  endif
  call julia#doc#open(word)
endfunction

if exists('+shellslash')
  let s:ESCAPEDCHARS = " \t\n\"#%'*<?`|"
else
  let s:ESCAPEDCHARS = " \t\n*?[{`$\\%#'\"|!<"
endif
let s:FNAMEESCAPEPATTERN = '\\\ze[' . escape(s:ESCAPEDCHARS, ']^-\') . ']'

" this function reproduces an original string escaped by fnameescape()
function! s:unfnameescape(str) abort
  if a:str is# ''
    return ''
  endif

  " NOTE: We cannot determine the original string if a:str starts from '\-',
  "       '\+' or '\>' because fnameescape('-') ==# fnameescape('\-').
  if a:str is# '\-'
    " Remove escape anyway.
    return '-'
  endif

  if a:str =~# '^\\[+>]'
    let str = a:str[1:]
  else
    let str = a:str
  endif
  return substitute(str, s:FNAMEESCAPEPATTERN, '', 'g')
endfunction



let s:HELPPROMPT = 'help?> '
let s:HELPHISTORY = []

function! julia#doc#prompt() abort
  let inputhist = s:savehistory('input')
  echohl MoreMsg
  try
    call s:restorehistory('input', s:HELPHISTORY)
    let keyword = input(s:HELPPROMPT, '', 'customlist,julia#doc#complete')

    " Clear the last prompt
    normal! :
  finally
    echohl None
    call s:restorehistory('input', inputhist)
  endtry

  if empty(keyword)
    return
  endif

  call julia#doc#open(keyword)
endfunction

function! s:savehistory(name) abort
  if histnr(a:name) == -1
    return []
  endif

  let history = []
  for i in range(1, histnr(a:name))
    let item = histget(a:name, i)
    if !empty(item)
      call add(history, item)
    endif
  endfor
  return history
endfunction

function! s:restorehistory(name, history) abort
  call histdel(a:name)
  for item in a:history
    call histadd(a:name, item)
  endfor
endfunction



if s:VERSION.major == 0 && s:VERSION.minor <= 6
  let s:REPL_SEARCH = 'Base.Docs.repl_search'
else
  let s:REPL_SEARCH = 'import REPL.repl_search; repl_search'
endif

function! julia#doc#complete(ArgLead, CmdLine, CursorPos) abort
  return s:likely(a:ArgLead)
endfunction

function! s:likely(str) abort
  " escape twice
  let str = escape(escape(a:str, '"\'), '"\')
  let cmd = printf('%s -E "%s(\"%s\")"', g:julia#doc#juliapath, s:REPL_SEARCH, str)
  let output = systemlist(cmd)
  return split(matchstr(output[0], '\C^search: \zs.*'))
endfunction

endif
