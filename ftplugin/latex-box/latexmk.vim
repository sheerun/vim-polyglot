" LaTeX Box latexmk functions

" Options and variables {{{

if !exists('g:LatexBox_latexmk_options')
	let g:LatexBox_latexmk_options = ''
endif
if !exists('g:LatexBox_latexmk_env')
	let g:LatexBox_latexmk_env = ''
endif
if !exists('g:LatexBox_latexmk_async')
	let g:LatexBox_latexmk_async = 0
endif
if !exists('g:LatexBox_latexmk_preview_continuously')
	let g:LatexBox_latexmk_preview_continuously = 0
endif
if !exists('g:LatexBox_output_type')
	let g:LatexBox_output_type = 'pdf'
endif
if !exists('g:LatexBox_autojump')
	let g:LatexBox_autojump = 0
endif
if ! exists('g:LatexBox_quickfix')
	let g:LatexBox_quickfix = 1
endif
if ! exists('g:LatexBox_personal_latexmkrc')
	let g:LatexBox_personal_latexmkrc = 0
endif

" }}}

" Process ID management (used for asynchronous and continuous mode) {{{

" A dictionary of latexmk PID's (basename: pid)
if !exists('g:latexmk_running_pids')
	let g:latexmk_running_pids = {}
endif

" Set PID {{{
function! s:LatexmkSetPID(basename, pid)
	let g:latexmk_running_pids[a:basename] = a:pid
endfunction
" }}}

" kill_latexmk_process {{{
function! s:kill_latexmk_process(pid)
	if has('win32')
		silent execute '!taskkill /PID ' . a:pid . ' /T /F'
	else
		if g:LatexBox_latexmk_async
			" vim-server mode
			let pids = []
			let tmpfile = tempname()
			silent execute '!ps x -o pgid,pid > ' . tmpfile
			for line in readfile(tmpfile)
				let new_pid = matchstr(line, '^\s*' . a:pid . '\s\+\zs\d\+\ze')
				if !empty(new_pid)
					call add(pids, new_pid)
				endif
			endfor
			call delete(tmpfile)
			if !empty(pids)
				silent execute '!kill ' . join(pids)
			endif
		else
			" single background process
			silent execute '!kill ' . a:pid
		endif
	endif
	if !has('gui_running')
		redraw!
	endif
endfunction
" }}}

" kill_all_latexmk_processes {{{
function! s:kill_all_latexmk_processes()
	for pid in values(g:latexmk_running_pids)
		call s:kill_latexmk_process(pid)
	endfor
endfunction
" }}}

" }}}

" Setup for vim-server {{{
function! s:SIDWrap(func)
	if !exists('s:SID')
		let s:SID = matchstr(expand('<sfile>'), '\zs<SNR>\d\+_\ze.*$')
	endif
	return s:SID . a:func
endfunction

function! s:LatexmkCallback(basename, status)
	" Only remove the pid if not in continuous mode
	if !g:LatexBox_latexmk_preview_continuously
		call remove(g:latexmk_running_pids, a:basename)
	endif
	call LatexBox_LatexErrors(a:status, a:basename)
endfunction

function! s:setup_vim_server()
	if !exists('g:vim_program')

		" attempt autodetection of vim executable
		let g:vim_program = ''
		if has('win32')
			" Just drop through to the default for windows
		else
			if match(&shell, '\(bash\|zsh\)$') >= 0
				let ppid = '$PPID'
			else
				let ppid = '$$'
			endif

			let tmpfile = tempname()
			silent execute '!ps -o command= -p ' . ppid . ' > ' . tmpfile
			for line in readfile(tmpfile)
				let line = matchstr(line, '^\S\+\>')
				if !empty(line) && executable(line)
					let g:vim_program = line . ' -g'
					break
				endif
			endfor
			call delete(tmpfile)
		endif

		if empty(g:vim_program)
			if has('gui_macvim')
				let g:vim_program
						\ = '/Applications/MacVim.app/Contents/MacOS/Vim -g'
			else
				let g:vim_program = v:progname
			endif
		endif
	endif
endfunction
" }}}

" Latexmk {{{

function! LatexBox_Latexmk(force)
	" Define often used names
	let basepath = LatexBox_GetBuildBasename(1)
	let basename = fnamemodify(basepath, ':t')
	let texroot = shellescape(LatexBox_GetTexRoot())
	let mainfile = fnameescape(fnamemodify(LatexBox_GetMainTexFile(), ':t'))

	" Check if latexmk is installed
	if !executable('latexmk')
		echomsg "Error: LaTeX-Box relies on latexmk for compilation, but it" .
					\ " is not installed!"
		return
	endif

	" Check if already running
	if has_key(g:latexmk_running_pids, basepath)
		echomsg "latexmk is already running for `" . basename . "'"
		return
	endif

	" Set wrap width in log file
	let max_print_line = 2000
	if has('win32')
		let env = 'set max_print_line=' . max_print_line . ' & '
	elseif match(&shell, '/tcsh$') >= 0
		let env = 'setenv max_print_line ' . max_print_line . '; '
	else
		if fnamemodify(&shell, ':t') ==# 'fish'
			let env = 'set max_print_line ' . max_print_line . '; and '
		else
			let env = 'max_print_line=' . max_print_line
		endif
	endif

	" Set environment options
	let env .= ' ' . g:LatexBox_latexmk_env . ' '

	" Set latexmk command with options
	if has('win32')
		" Make sure to switch drive as well as directory
		let cmd = 'cd /D ' . texroot . ' && '
	else
		if fnamemodify(&shell, ':t') ==# 'fish'
			let cmd = 'cd ' . texroot . '; and '
		else
			let cmd = 'cd ' . texroot . ' && '
		endif
	endif
	let cmd .= env . ' latexmk'
	if ! g:LatexBox_personal_latexmkrc
		let cmd .= ' -' . g:LatexBox_output_type
	endif
	let cmd .= ' -quiet '
	let cmd .= g:LatexBox_latexmk_options
	if a:force
		let cmd .= ' -g'
	endif
	if g:LatexBox_latexmk_preview_continuously
		let cmd .= ' -pvc'
	endif
	let cmd .= ' -e ' . shellescape('$pdflatex =~ s/ / -file-line-error /')
	let cmd .= ' -e ' . shellescape('$latex =~ s/ / -file-line-error /')
	if g:LatexBox_latexmk_preview_continuously
		let cmd .= ' -e ' . shellescape('$success_cmd = $ENV{SUCCESSCMD}')
		let cmd .= ' -e ' . shellescape('$failure_cmd = $ENV{FAILURECMD}')
	endif
	let cmd .= ' ' . mainfile

	" Redirect output to null
	if has('win32')
		let cmd .= ' >nul'
	else
		if fnamemodify(&shell, ':t') ==# 'fish'
			let cmd .= ' >/dev/null ^/dev/null'
		else
			let cmd .= ' &>/dev/null'
		endif
	endif

	if g:LatexBox_latexmk_async
		" Check if VIM server exists
		if empty(v:servername)
			echoerr "cannot run latexmk in background without a VIM server"
			echoerr "set g:LatexBox_latexmk_async to 0 to change compiling mode"
			return
		endif

		" Start vim server if necessary
		call s:setup_vim_server()

		let setpidfunc = s:SIDWrap('LatexmkSetPID')
		let callbackfunc = s:SIDWrap('LatexmkCallback')
		if has('win32')
			let vim_program = substitute(g:vim_program,
						\ 'gvim\.exe$', 'vim.exe', '')

			" Define callback to set the pid
			let callsetpid = setpidfunc . '(''' . basepath . ''', %CMDPID%)'
			let vimsetpid = vim_program . ' --servername ' . v:servername
						\ . ' --remote-expr ' . shellescape(callsetpid)

			" Define callback after latexmk is finished
			let callback = callbackfunc . '(''' . basepath . ''', %LATEXERR%)'
			let vimcmd = vim_program . ' --servername ' . v:servername
						\ . ' --remote-expr ' . shellescape(callback)
			let scallback = callbackfunc . '(''' . basepath . ''', 0)'
			let svimcmd = vim_program . ' --servername ' . v:servername
						\ . ' --remote-expr ' . shellescape(scallback)
			let fcallback = callbackfunc . '(''' . basepath . ''', 1)'
			let fvimcmd = vim_program . ' --servername ' . v:servername
						\ . ' --remote-expr ' . shellescape(fcallback)

			let asyncbat = tempname() . '.bat'
			if g:LatexBox_latexmk_preview_continuously
				call writefile(['setlocal',
							\ 'set T=%TEMP%\sthUnique.tmp',
							\ 'wmic process where (Name="WMIC.exe" AND CommandLine LIKE "%%%TIME%%%") '
							\ . 'get ParentProcessId /value | find "ParentProcessId" >%T%',
							\ 'set /P A=<%T%',
							\ 'set CMDPID=%A:~16% & del %T%',
							\ vimsetpid,
							\ 'set SUCCESSCMD='.svimcmd,
							\ 'set FAILURECMD='.fvimcmd,
							\ cmd,
							\ 'endlocal'], asyncbat)
			else
				call writefile(['setlocal',
							\ 'set T=%TEMP%\sthUnique.tmp',
							\ 'wmic process where (Name="WMIC.exe" AND CommandLine LIKE "%%%TIME%%%") '
							\ . 'get ParentProcessId /value | find "ParentProcessId" >%T%',
							\ 'set /P A=<%T%',
							\ 'set CMDPID=%A:~16% & del %T%',
							\ vimsetpid,
							\ cmd,
							\ 'set LATEXERR=%ERRORLEVEL%',
							\ vimcmd,
							\ 'endlocal'], asyncbat)
			endif

			" Define command
			let cmd = '!start /b ' . asyncbat . ' & del ' . asyncbat
		else
			" Define callback to set the pid
			let callsetpid = shellescape(setpidfunc).'"(\"'.basepath.'\",$$)"'
			let vimsetpid = g:vim_program . ' --servername ' . v:servername
			                        \ . ' --remote-expr ' . callsetpid

			" Define callback after latexmk is finished
			let callback = shellescape(callbackfunc).'"(\"'.basepath.'\",$?)"'
			let vimcmd = g:vim_program . ' --servername ' . v:servername
									\ . ' --remote-expr ' . callback
			let scallback = shellescape(callbackfunc).'"(\"'.basepath.'\",0)"'
			let svimcmd = g:vim_program . ' --servername ' . v:servername
			                        \ . ' --remote-expr ' . scallback
			let fcallback = shellescape(callbackfunc).'"(\"'.basepath.'\",1)"'
			let fvimcmd = g:vim_program . ' --servername ' . v:servername
			                        \ . ' --remote-expr ' . fcallback

			" Define command
			" Note: Here we escape '%' because it may be given as a user option
			" through g:LatexBox_latexmk_options, for instance with
			" g:Latex..._options = "-pdflatex='pdflatex -synctex=1 \%O \%S'"
			if g:LatexBox_latexmk_preview_continuously
				let cmd = vimsetpid . ' ; '
						\ . 'export SUCCESSCMD=' . shellescape(svimcmd) . ' '
						\ . '       FAILURECMD=' . shellescape(fvimcmd) . ' ; '
						\ . escape(cmd, '%')
			else
				let cmd = vimsetpid . ' ; ' . escape(cmd, '%') . ' ; ' . vimcmd
			endif
			let cmd = '! (' . cmd . ') >/dev/null &'
		endif

		if g:LatexBox_latexmk_preview_continuously
			echo 'Compiling to ' . g:LatexBox_output_type
						\ . ' with continuous preview.'
		else
			echo 'Compiling to ' . g:LatexBox_output_type . ' ...'
		endif
		silent execute cmd
	else
		if g:LatexBox_latexmk_preview_continuously
			if has('win32')
				let cmd = '!start /b cmd /s /c "' . cmd . '"'
			else
				let cmd = '!' . cmd . ' &'
			endif
			echo 'Compiling to ' . g:LatexBox_output_type . ' ...'
			silent execute cmd

			" Save PID in order to be able to kill the process when wanted.
			if has('win32')
				let tmpfile = tempname()
				let pidcmd = 'cmd /c "wmic process where '
							\ . '(CommandLine LIKE "latexmk\%'.mainfile.'\%") '
							\ . 'get ProcessId /value | find "ProcessId" '
							\ . '>'.tmpfile.' "'
				silent execute '! ' . pidcmd
				let pids = readfile(tmpfile)
				let pid = strpart(pids[0], 10)
				let g:latexmk_running_pids[basepath] = pid
			else
				let pid = substitute(system('pgrep -f "perl.*'
							\ . mainfile . '" | head -n 1'),'\D','','')
				let g:latexmk_running_pids[basepath] = pid
			endif
		else
			" Execute command and check for errors
			echo 'Compiling to ' . g:LatexBox_output_type . ' ... (async off!)'
			call system(cmd)
			call LatexBox_LatexErrors(v:shell_error)
		endif
	endif

	" Redraw screen if necessary
	if !has("gui_running")
		redraw!
	endif
endfunction
" }}}

" LatexmkClean {{{
function! LatexBox_LatexmkClean(cleanall)
	" Check if latexmk is installed
	if !executable('latexmk')
		echomsg "Error: LaTeX-Box relies on latexmk for compilation, but it" .
					\ " is not installed!"
		return
	endif

	let basename = LatexBox_GetBuildBasename(1)

	if has_key(g:latexmk_running_pids, basename)
		echomsg "don't clean when latexmk is running"
		return
	endif

	if has('win32')
		let cmd = 'cd /D ' . shellescape(LatexBox_GetTexRoot()) . ' & '
	else
		let cmd = 'cd ' . shellescape(LatexBox_GetTexRoot()) . ';'
	endif
	if a:cleanall
		let cmd .= 'latexmk -C '
	else
		let cmd .= 'latexmk -c '
	endif
	let cmd .= shellescape(LatexBox_GetMainTexFile())
	if has('win32')
		let cmd .= ' >nul'
	else
		let cmd .= ' >&/dev/null'
	endif

	call system(cmd)
	if !has('gui_running')
		redraw!
	endif

	echomsg "latexmk clean finished"
endfunction
" }}}

" LatexErrors {{{
function! LatexBox_LatexErrors(status, ...)
	if a:0 >= 1
		let log = a:1 . '.log'
	else
		let log = LatexBox_GetLogFile()
	endif

	cclose

	" set cwd to expand error file correctly
	let l:cwd = fnamemodify(getcwd(), ':p')
	execute 'lcd ' . fnameescape(LatexBox_GetTexRoot())
	try
		if g:LatexBox_autojump
			execute 'cfile ' . fnameescape(log)
		else
			execute 'cgetfile ' . fnameescape(log)
		endif
	finally
		" restore cwd
		execute 'lcd ' . fnameescape(l:cwd)
	endtry

	" Always open window if started by LatexErrors command
	if a:status < 0
		botright copen
	else
		" Only open window when an error/warning is detected
		if g:LatexBox_quickfix >= 3
					\ ? s:log_contains_error(log)
					\ : g:LatexBox_quickfix > 0
			belowright cw
			if g:LatexBox_quickfix == 2 || g:LatexBox_quickfix == 4
				wincmd p
			endif
		endif
		redraw

		" Write status message to screen
		if a:status > 0 || len(getqflist())>1
			if s:log_contains_error(log)
				let l:status_msg = ' ... failed!'
			else
				let l:status_msg = ' ... there were warnings!'
			endif
		else
			let l:status_msg = ' ... success!'
		endif
		echomsg 'Compiling to ' . g:LatexBox_output_type . l:status_msg
	endif
endfunction

" Redefine uniq() for compatibility with older Vim versions (< 7.4.218)
function! s:uniq(list)
        if exists('*uniq')
                return uniq(a:list)
        elseif len(a:list) <= 1
                return a:list
        endif

        let last_element = get(a:list,0)
        let uniq_list = [last_element]

        for i in range(1, len(a:list)-1)
                let next_element = get(a:list, i)
                if last_element == next_element
                        continue
                endif
                let last_element = next_element
                call add(uniq_list, next_element)
        endfor
        return uniq_list
endfunction

function! s:log_contains_error(file)
	let lines = readfile(a:file)
	let lines = filter(lines, 'v:val =~ ''^.*:\d\+: ''')
	let lines = s:uniq(map(lines, 'matchstr(v:val, ''^.*\ze:\d\+:'')'))
	let lines = filter(lines, 'filereadable(fnameescape(v:val))')
	return len(lines) > 0
endfunction
" }}}

" LatexmkStatus {{{
function! LatexBox_LatexmkStatus(detailed)
	if a:detailed
		if empty(g:latexmk_running_pids)
			echo "latexmk is not running"
		else
			let plist = ""
			for [basename, pid] in items(g:latexmk_running_pids)
				if !empty(plist)
					let plist .= '; '
				endif
				let plist .= fnamemodify(basename, ':t') . ':' . pid
			endfor
			echo "latexmk is running (" . plist . ")"
		endif
	else
		let basename = LatexBox_GetBuildBasename(1)
		if has_key(g:latexmk_running_pids, basename)
			echo "latexmk is running"
		else
			echo "latexmk is not running"
		endif
	endif
endfunction
" }}}

" LatexmkStop {{{
function! LatexBox_LatexmkStop(silent)
	if empty(g:latexmk_running_pids)
		if !a:silent
			let basepath = LatexBox_GetBuildBasename(1)
			let basename = fnamemodify(basepath, ':t')
			echoerr "latexmk is not running for `" . basename . "'"
		endif
	else
		let basepath = LatexBox_GetBuildBasename(1)
		let basename = fnamemodify(basepath, ':t')
		if has_key(g:latexmk_running_pids, basepath)
			call s:kill_latexmk_process(g:latexmk_running_pids[basepath])
			call remove(g:latexmk_running_pids, basepath)
			if !a:silent
				echomsg "latexmk stopped for `" . basename . "'"
			endif
		elseif !a:silent
			echoerr "latexmk is not running for `" . basename . "'"
		endif
	endif
endfunction
" }}}

" Commands {{{

command! -bang	Latexmk			call LatexBox_Latexmk(<q-bang> == "!")
command! -bang	LatexmkClean	call LatexBox_LatexmkClean(<q-bang> == "!")
command! -bang	LatexmkStatus	call LatexBox_LatexmkStatus(<q-bang> == "!")
command! LatexmkStop			call LatexBox_LatexmkStop(0)
command! LatexErrors			call LatexBox_LatexErrors(-1)

if g:LatexBox_latexmk_async || g:LatexBox_latexmk_preview_continuously
	autocmd BufUnload <buffer> 	call LatexBox_LatexmkStop(1)
	autocmd VimLeave * 			call <SID>kill_all_latexmk_processes()
endif

" }}}

" vim:fdm=marker:ff=unix:noet:ts=4:sw=4
