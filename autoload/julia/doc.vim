if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'julia') == -1
  
let s:FALSE = 0
let s:TRUE = 1

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

" command to open a new juliadoc buffer
" for example, :split, :vert split, :edit, :tabedit etc.
" if it is empty, split the current window depending on its size -> s:opencmd()
let g:julia#doc#opencmd = get(g:, 'julia#doc#opencmd', '')

" height of a juliadoc window (in case of horizontal split window by g:julia#doc#opencmd)
" if it is a positive number, adjust the height to the number of lines
" if is is a negative number, adjust the height to the percentage of &lines
" otherwise do nothing, see s:adjustwinsize()
let g:julia#doc#winheight = get(g:, 'julia#doc#winheight', -30)

" width of a juliadoc window (in case of vertical split window by g:julia#doc#opencmd)
" if it is a positive number, adjust the width to the number of columns
" if is is a negative number, adjust the height to the percentage of &columns
" otherwise do nothing, see s:adjustwinsize()
let g:julia#doc#winwidth = get(g:, 'julia#doc#winwidth', 80)

" a boolean option to control the location of cursor after opening a juliadoc window
" if it is TRUE, the cursor is moved to the original window
" if it is FALSE, the cursor is left in the juliadoc window
let g:julia#doc#cursorback = get(g:, 'julia#doc#cursorback', s:TRUE)



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

  " workaround for * and ? since a buffername cannot include them
  let keyword = a:keyword
  let keyword = substitute(keyword, '\*', ':asterisk:', 'g')
  let keyword = substitute(keyword, '?', ':question:', 'g')

  let buffername = printf('juliadoc://%s', keyword)
  let originaltabpagenr = tabpagenr()
  let samewin = s:TRUE
  if s:bufferexists(buffername)
    let samewin = s:openjuliadocwin(buffername)
  else
    let doc = julia#doc#lookup(a:keyword, g:julia#doc#juliapath)
    if empty(doc) || match(doc[0], s:NODOCPATTERN) > -1
      call s:warn('No documentation found for "%s".', a:keyword)
      return
    endif

    let samewin = s:openjuliadocwin(buffername)
    setlocal modifiable
    call s:printdoc(doc)
    setlocal nobackup noswapfile nomodifiable nobuflisted buftype=nofile bufhidden=hide
    setfiletype juliadoc
  endif

  if tabpagenr() == originaltabpagenr && !samewin && g:julia#doc#cursorback
    wincmd p
  endif

  call filter(s:HELPHISTORY, 'v:val isnot# a:keyword')
  call add(s:HELPHISTORY, a:keyword)
endfunction

function! s:bufferexists(buffername) abort
  return !empty(filter(map(getbufinfo(), 'v:val.name'), 'v:val is# a:buffername'))
endfunction

" This function returns TRUE if the cursor is in the same window as before.
function! s:openjuliadocwin(buffername) abort
  let samewin = s:TRUE
  let existingwinnr = s:existingwindow()
  if existingwinnr != 0
    " move to the existing window
    if existingwinnr != winnr()
      let samewin = s:FALSE
      execute existingwinnr . 'wincmd w'
    endif
    if bufname('%') isnot# a:buffername
      execute printf('silent edit %s', a:buffername)
    endif
  else
    " open a new window
    let originalwinnr = winnr()
    let originalheight = winheight(originalwinnr)
    let originalwidth = winwidth(originalwinnr)
    let originalwinid = s:win_getid()
    let height = s:getwinheight(g:julia#doc#winheight)
    let width = s:getwinwidth(g:julia#doc#winwidth)
    if !empty(g:julia#doc#opencmd)
      let opencmd = g:julia#doc#opencmd
    else
      let opencmd = s:opencmd(width * 2)
    endif

    execute printf('silent %s %s', opencmd, a:buffername)
    if !s:issamewin(originalwinid)
      let samewin = s:FALSE
      call s:adjustwinsize(height, width, originalheight, originalwidth)
    endif
  endif
  return samewin
endfunction

function! s:existingwindow() abort
  for winnr in range(1, winnr('$'))
    if bufname(winbufnr(winnr)) =~# '\m^juliadoc://'
      return winnr
    endif
  endfor
  return 0
endfunction

function! s:getwinheight(height) abort
  if a:height < 0
    let winmaxheight = &lines
    return float2nr(round(winmaxheight * abs(a:height) / 100.0))
  endif
  return a:height
endfunction

function! s:getwinwidth(width) abort
  if a:width < 0
    let winmaxwidth = &columns
    return float2nr(round(winmaxwidth * abs(a:width) / 100.0))
  endif
  return a:width
endfunction

if exists('*win_getid')
  let s:win_getid = function('win_getid')

  function! s:issamewin(winid) abort
    return a:winid == win_getid()
  endfunction
else
  function! s:win_getid(...) abort
    return [tabpagenr(), winnr('$')]
  endfunction

  function! s:issamewin(winid) abort
    let [originaltabnr, originallastwinnr] = a:winid
    if tabpagenr() != originaltabnr
      return s:FALSE
    endif

    " The cursor should be in the juliadoc window after opening a new window,
    " thus if the number of window has been changed, we could think that the
    " cursor has been moved. If not changed, probably :edit is used.
    if winnr('$') != originallastwinnr
      return s:FALSE
    endif

    " This is not always true. For example after :split | :only,
    " it doesn't change tabpage and number of windows but the cursor is not in
    " same window. However it is too difficult to track that kind of change.
    return s:TRUE
  endfunction
endif

function! s:opencmd(thr_width) abort
  if a:thr_width != 0 && winwidth('%') >= a:thr_width
    return 'vert split'
  endif
  return 'split'
endfunction

function! s:adjustwinsize(height, width, originalheight, originalwidth) abort
  if winwidth(winnr()) == a:originalwidth && a:height > 0
    " horizontal split
    execute 'resize ' . a:height
  endif

  if winheight(winnr()) == a:originalheight && a:width > 0
    " vertical split
    execute 'vertical resize ' . a:width
  endif
endfunction

function! s:printdoc(doc) abort
  silent %delete _
  call append(0, a:doc)
  silent $delete _
  normal! gg
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
