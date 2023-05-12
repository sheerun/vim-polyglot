if polyglot#init#is_disabled(expand('<sfile>:p'), 'jsonnet', 'autoload/jsonnet.vim')
  finish
endif



" Options.

if !exists("g:jsonnet_command")
  let g:jsonnet_command = "jsonnet"
endif

if !exists("g:jsonnet_fmt_command")
  let g:jsonnet_fmt_command = "jsonnetfmt"
endif

if !exists('g:jsonnet_fmt_options')
  let g:jsonnet_fmt_options = ''
endif

if !exists('g:jsonnet_fmt_fail_silently')
  let g:jsonnet_fmt_fail_silently = 1
endif


" System runs a shell command. It will reset the shell to /bin/sh for Unix-like
" systems if it is executable.
function! jsonnet#System(str, ...)
  let l:shell = &shell
  if executable('/bin/sh')
    let &shell = '/bin/sh'
  endif

  try
    let l:output = call("system", [a:str] + a:000)
    return l:output
  finally
    let &shell = l:shell
  endtry
endfunction


" CheckBinPath checks whether the given binary exists or not and returns the
" path of the binary. It returns an empty string if it doesn't exists.
function! jsonnet#CheckBinPath(binName)

    if executable(a:binName)
        if exists('*exepath')
            let binPath = exepath(a:binName)
	    return binPath
        else
	   return a:binName
        endif
    else
        echo "vim-jsonnet: could not find '" . a:binName . "'."
        return ""
    endif

endfunction

" Format calls `jsonnetfmt ... ` on the file and replaces the file with the
" auto formatted version. Does some primitive error checking of the
" jsonnetfmt command too.
function! jsonnet#Format()

    " Save cursor position and many other things.
    let l:curw = winsaveview()

    " Write current unsaved buffer to a temp file
    let l:tmpname = tempname()
    call writefile(getline(1, '$'), l:tmpname)

    " get the command first so we can test it
    let l:binName = g:jsonnet_fmt_command

   " check if the user has installed command binary.
    let l:binPath = jsonnet#CheckBinPath(l:binName)
    if empty(l:binPath)
      return
    endif


    " Populate the final command.
    let l:command = l:binPath
    " The inplace modification is default. Makes file management easier
    let l:command = l:command . ' -i '
    let l:command = l:command . g:jsonnet_fmt_options

    " Execute the compiled jsonnetfmt command and save the return value
    let l:out = jsonnet#System(l:command . " " . l:tmpname)
    let l:errorCode = v:shell_error

    if l:errorCode == 0
        " The format command succeeded Move the formatted temp file over the
        " current file and restore other settings

        " stop undo recording
        try | silent undojoin | catch | endtry

        let l:originalFileFormat = &fileformat
        if exists("*getfperm")
          " save old file permissions
          let l:originalFPerm = getfperm(expand('%'))
        endif
        " Overwrite current file with the formatted temp file
        call rename(l:tmpname, expand('%'))

        if exists("*setfperm") && l:originalFPerm != ''
          call setfperm(expand('%'), l:originalFPerm)
        endif
        " the file has been changed outside of vim, enable reedit
        mkview
        silent edit!
        let &fileformat = l:originalFileFormat
        let &syntax = &syntax
        silent loadview
    elseif g:jsonnet_fmt_fail_silently == 0
        " FixMe: We could leverage the errors coming from the `jsonnetfmt` and
        " give immediate feedback to the user at every save time.
        " Our inspiration, vim-go, opens a new list below the current edit
        " window and shows the errors (the output of the fmt command).
        " We are not sure whether this is desired in the vim-jsonnet community
        " or not. Nevertheless, this else block is a suitable place to benefit
        " from the `jsonnetfmt` errors.
    endif

    " Restore our cursor/windows positions.
    call winrestview(l:curw)
endfunction

function! jsonnet#GetVisualSelection()
    " Source: https://stackoverflow.com/a/6271254
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfun

" Format calls `jsonnetfmt ... ` on a Visual selection
function! jsonnet#FormatVisual()
    " Get current visual selection
    let l:selection = jsonnet#GetVisualSelection()

    " Get the command first so we can test it
    let l:binName = g:jsonnet_fmt_command

    " Check if the user has installed command binary.
    let l:binPath = jsonnet#CheckBinPath(l:binName)
    if empty(l:binPath)
      return
    endif

    " Populate the final command.
    let l:command = l:binPath
    let l:command = l:command . ' -e '
    let l:command = l:command . g:jsonnet_fmt_options

    " Execute the compiled jsonnetfmt command and save the return value
    let l:out = jsonnet#System(l:command . " \"" . l:selection . "\"")
    let l:errorCode = v:shell_error

    " Save register contents
    let reg = '"'
    let save_cb = &cb
    let regInfo = getreginfo(reg)
    try
        " Set register to formatted output
        call setreg(reg,l:out)
        " Paste formatted output
        silent exe 'norm! gv'.(reg == '"' ? '' : '"' . reg).'p`['
    finally
        " Restore register contents
        let &cb = save_cb
        call setreg(reg, regInfo)
    endtry
endfunction

" Evaluate jsonnet into vsplit
function! jsonnet#Eval()
  let output = system(g:jsonnet_command . ' ' . shellescape(expand('%')))
  vnew
  setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile ft=jsonnet
  put! = output
endfunction
