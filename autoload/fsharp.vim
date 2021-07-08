if polyglot#init#is_disabled(expand('<sfile>:p'), 'fsharp', 'autoload/fsharp.vim')
  finish
endif

" Vim autoload functions

if exists('g:loaded_autoload_fsharp')
    finish
endif
let g:loaded_autoload_fsharp = 1

let s:cpo_save = &cpo
set cpo&vim

function! s:prompt(msg)
    let height = &cmdheight
    if height < 2
        set cmdheight=2
    endif
    echom a:msg
    let &cmdheight = height
endfunction

function! s:PlainNotification(content)
    return { 'Content': a:content }
endfunction

function! s:TextDocumentIdentifier(path)
    let usr_ss_opt = &shellslash
    set shellslash
    let uri = fnamemodify(a:path, ":p")
    if uri[0] == "/"
        let uri = "file://" . uri
    else
        let uri = "file:///" . uri
    endif
    let &shellslash = usr_ss_opt
    return { 'Uri': uri }
endfunction

function! s:Position(line, character)
    return { 'Line': a:line, 'Character': a:character }
endfunction

function! s:TextDocumentPositionParams(documentUri, line, character)
    return {
        \ 'TextDocument': s:TextDocumentIdentifier(a:documentUri),
        \ 'Position':     s:Position(a:line, a:character)
        \ }
endfunction

function! s:DocumentationForSymbolRequest(xmlSig, assembly)
    return {
        \ 'XmlSig': a:xmlSig,
        \ 'Assembly': a:assembly
        \ }
endfunction

function! s:ProjectParms(projectUri)
    return { 'Project': s:TextDocumentIdentifier(a:projectUri) }
endfunction

function! s:WorkspacePeekRequest(directory, deep, excludedDirs)
    return {
        \ 'Directory': fnamemodify(a:directory, ":p"),
        \ 'Deep': a:deep,
        \ 'ExcludedDirs': a:excludedDirs
        \ }
endfunction

function! s:WorkspaceLoadParms(files)
    let prm = []
    for file in a:files
        call add(prm, s:TextDocumentIdentifier(file))
    endfor
    return { 'TextDocuments': prm }
endfunction

function! s:FsdnRequest(query)
    return { 'Query': a:query }
endfunction

function! s:call(method, params, cont)
    call LanguageClient#Call(a:method, a:params, a:cont)
endfunction

function! s:signature(filePath, line, character, cont)
    return s:call('fsharp/signature', s:TextDocumentPositionParams(a:filePath, a:line, a:character), a:cont)
endfunction
function! s:signatureData(filePath, line, character, cont)
    return s:call('fsharp/signatureData', s:TextDocumentPositionParams(a:filePath, a:line, a:character), a:cont)
endfunction
function! s:lineLens(projectPath, cont)
    return s:call('fsharp/lineLens', s:ProjectParms(a:projectPath), a:cont)
endfunction
function! s:compilerLocation(cont)
    return s:call('fsharp/compilerLocation', {}, a:cont)
endfunction
function! s:compile(projectPath, cont)
    return s:call('fsharp/compile', s:ProjectParms(a:projectPath), a:cont)
endfunction
function! s:workspacePeek(directory, depth, excludedDirs, cont)
    return s:call('fsharp/workspacePeek', s:WorkspacePeekRequest(a:directory, a:depth, a:excludedDirs), a:cont)
endfunction
function! s:workspaceLoad(files, cont)
    return s:call('fsharp/workspaceLoad', s:WorkspaceLoadParms(a:files), a:cont)
endfunction
function! s:project(projectPath, cont)
    return s:call('fsharp/project', s:ProjectParms(a:projectPath), a:cont)
endfunction
function! s:fsdn(signature, cont)
    return s:call('fsharp/fsdn', s:FsdnRequest(a:signature), a:cont)
endfunction
function! s:f1Help(filePath, line, character, cont)
    return s:call('fsharp/f1Help', s:TextDocumentPositionParams(a:filePath, a:line, a:character), a:cont)
endfunction
function! fsharp#documentation(filePath, line, character, cont)
    return s:call('fsharp/documentation', s:TextDocumentPositionParams(a:filePath, a:line, a:character), a:cont)
endfunction
function! s:documentationSymbol(xmlSig, assembly, cont)
    return s:call('fsharp/documentationSymbol', s:DocumentationForSymbolRequest(a:xmlSig, a:assembly), a:cont)
endfunction

" FSharpConfigDto from https://github.com/fsharp/FsAutoComplete/blob/master/src/FsAutoComplete/LspHelpers.fs
"
" * The following options seems not working with workspace/didChangeConfiguration
"   since the initialization has already completed?
"     'AutomaticWorkspaceInit',
"     'WorkspaceModePeekDeepLevel',
"
" * Changes made to linter/unused analyzer settings seems not reflected after sending them to FSAC?
"
let s:config_keys_camel =
    \ [
    \     {'key': 'AutomaticWorkspaceInit', 'default': 1},
    \     {'key': 'WorkspaceModePeekDeepLevel', 'default': 2},
    \     {'key': 'ExcludeProjectDirectories', 'default': []},
    \     {'key': 'keywordsAutocomplete', 'default': 1},
    \     {'key': 'ExternalAutocomplete', 'default': 0},
    \     {'key': 'Linter', 'default': 1},
    \     {'key': 'UnionCaseStubGeneration', 'default': 1},
    \     {'key': 'UnionCaseStubGenerationBody'},
    \     {'key': 'RecordStubGeneration', 'default': 1},
    \     {'key': 'RecordStubGenerationBody'},
    \     {'key': 'InterfaceStubGeneration', 'default': 1},
    \     {'key': 'InterfaceStubGenerationObjectIdentifier', 'default': 'this'},
    \     {'key': 'InterfaceStubGenerationMethodBody'},
    \     {'key': 'UnusedOpensAnalyzer', 'default': 1},
    \     {'key': 'UnusedDeclarationsAnalyzer', 'default': 1},
    \     {'key': 'SimplifyNameAnalyzer', 'default': 0},
    \     {'key': 'ResolveNamespaces', 'default': 1},
    \     {'key': 'EnableReferenceCodeLens', 'default': 1},
    \     {'key': 'EnableAnalyzers', 'default': 0},
    \     {'key': 'AnalyzersPath'},
    \     {'key': 'DisableInMemoryProjectReferences', 'default': 0},
    \     {'key': 'LineLens', 'default': {'enabled': 'never', 'prefix': ''}},
    \     {'key': 'UseSdkScripts', 'default': 1},
    \     {'key': 'dotNetRoot'},
    \     {'key': 'fsiExtraParameters', 'default': []},
    \ ]
let s:config_keys = []

function! fsharp#toSnakeCase(str)
    let sn = substitute(a:str, '\(\<\u\l\+\|\l\+\)\(\u\)', '\l\1_\l\2', 'g')
    if sn == a:str | return tolower(a:str) | endif
    return sn
endfunction

function! s:buildConfigKeys()
    if len(s:config_keys) == 0
        for key_camel in s:config_keys_camel
            let key = {}
            let key.snake = fsharp#toSnakeCase(key_camel.key)
            let key.camel = key_camel.key
            if has_key(key_camel, 'default')
                let key.default = key_camel.default
            endif
            call add(s:config_keys, key)
        endfor
    endif
endfunction

function! g:fsharp#getServerConfig()
    let fsharp = {}
    call s:buildConfigKeys()
    for key in s:config_keys
        if exists('g:fsharp#' . key.snake)
            let fsharp[key.camel] = g:fsharp#{key.snake}
        elseif exists('g:fsharp#' . key.camel)
            let fsharp[key.camel] = g:fsharp#{key.camel}
        elseif has_key(key, 'default') && g:fsharp#use_recommended_server_config
            let g:fsharp#{key.snake} = key.default
            let fsharp[key.camel] = key.default
        endif
    endfor
    return fsharp
endfunction

function! g:fsharp#updateServerConfig()
    let fsharp = fsharp#getServerConfig()
    let settings = {'settings': {'FSharp': fsharp}}
    call LanguageClient#Notify('workspace/didChangeConfiguration', settings)
endfunction

function! s:findWorkspace(dir, cont)
    let s:cont_findWorkspace = a:cont
    function! s:callback_findWorkspace(result)
        let result = a:result
        let content = json_decode(result.result.content)
        if len(content.Data.Found) < 1
            return []
        endif
        let workspace = { 'Type': 'none' }
        for found in content.Data.Found
            if workspace.Type == 'none'
                let workspace = found
            elseif found.Type == 'solution'
                if workspace.Type == 'project'
                    let workspace = found
                else
                    let curLen = len(workspace.Data.Items)
                    let newLen = len(found.Data.Items)
                    if newLen > curLen
                        let workspace = found
                    endif
                endif
            endif
        endfor
        if workspace.Type == 'solution'
            call s:cont_findWorkspace([workspace.Data.Path])
        else
            call s:cont_findWorkspace(workspace.Data.Fsprojs)
        endif
    endfunction
    call s:workspacePeek(a:dir, g:fsharp#workspace_mode_peek_deep_level, g:fsharp#exclude_project_directories, function("s:callback_findWorkspace"))
endfunction

let s:workspace = []

function! s:load(arg)
    let s:loading_workspace = a:arg
    function! s:callback_load(_)
        echo "[FSAC] Workspace loaded: " . join(s:loading_workspace, ', ')
        let s:workspace = s:workspace + s:loading_workspace
    endfunction
    call s:workspaceLoad(a:arg, function("s:callback_load"))
endfunction

function! fsharp#loadProject(...)
    let prjs = []
    for proj in a:000
        call add(prjs, fnamemodify(proj, ':p'))
    endfor
    call s:load(prjs)
endfunction

function! fsharp#loadWorkspaceAuto()
    if &ft == 'fsharp'
        call fsharp#updateServerConfig()
        if g:fsharp#automatic_workspace_init
            echom "[FSAC] Loading workspace..."
            let bufferDirectory = fnamemodify(resolve(expand('%:p')), ':h')
            call s:findWorkspace(bufferDirectory, function("s:load"))
        endif
    endif
endfunction

function! fsharp#reloadProjects()
    if len(s:workspace) > 0
        function! s:callback_reloadProjects(_)
            call s:prompt("[FSAC] Workspace reloaded.")
        endfunction
        call s:workspaceLoad(s:workspace, function("s:callback_reloadProjects"))
    else
        echom "[FSAC] Workspace is empty"
    endif
endfunction

function! fsharp#OnFSProjSave()
    if &ft == "fsharp_project" && exists('g:fsharp#automatic_reload_workspace') && g:fsharp#automatic_reload_workspace
        call fsharp#reloadProjects()
    endif
endfunction

function! fsharp#showSignature()
    function! s:callback_showSignature(result)
        let result = a:result
        if exists('result.result.content')
            let content = json_decode(result.result.content)
            if exists('content.Data')
                echom substitute(content.Data, '\n\+$', ' ', 'g')
            endif
        endif
    endfunction
    call s:signature(expand('%:p'), line('.') - 1, col('.') - 1, function("s:callback_showSignature"))
endfunction

function! fsharp#OnCursorMove()
    if g:fsharp#show_signature_on_cursor_move
        call fsharp#showSignature()
    endif
endfunction

function! fsharp#showF1Help()
    let result = s:f1Help(expand('%:p'), line('.') - 1, col('.') - 1)
    echo result
endfunction

function! fsharp#showTooltip()
    function! s:callback_showTooltip(result)
        let result = a:result
        if exists('result.result.content')
            let content = json_decode(result.result.content)
            if exists('content.Data')
                call LanguageClient#textDocument_hover()
            endif
        endif
    endfunction
    " show hover only if signature exists for the current position
    call s:signature(expand('%:p'), line('.') - 1, col('.') - 1, function("s:callback_showTooltip"))
endfunction

let s:script_root_dir = expand('<sfile>:p:h') . "/../"
let s:fsac = fnamemodify(s:script_root_dir . "fsac/fsautocomplete.dll", ":p")
let g:fsharp#languageserver_command =
    \ ['dotnet', s:fsac,
        \ '--background-service-enabled'
    \ ]

function! s:update_win()
    echom "[FSAC] Downloading FSAC. This may take a while..."
    let script = s:script_root_dir . "install.ps1"
    call system('powershell -ExecutionPolicy Unrestricted ' . script . " update")
endfunction

function! s:update_unix()
    echom "[FSAC] Downloading FSAC. This may take a while..."
    let zip = s:script_root_dir . "fsac.zip"
    call system(
        \ 'curl -fLo ' . zip .  ' --create-dirs ' .
        \ '"https://github.com/fsharp/FsAutoComplete/releases/latest/download/fsautocomplete.netcore.zip"'
        \ )
    if v:shell_error == 0
        call system('unzip -o -d ' . s:script_root_dir . "/fsac " . zip)
        call system('find ' . s:script_root_dir . '/fsac' . ' -type f -exec chmod 777 \{\} \;')
        echom "[FSAC] Updated FsAutoComplete"
    else
        echom "[FSAC] Failed to update FsAutoComplete"
    endif
endfunction

function! fsharp#updateFSAC(...)
    if has('win32') && !has('win32unix')
        call s:update_win()
    else
        call s:update_unix()
    endif
endfunction

let s:fsi_buffer = -1
let s:fsi_job    = -1
let s:fsi_width  = 0
let s:fsi_height = 0

function! s:win_gotoid_safe(winid)
    function! s:vimReturnFocus(window)
        call win_gotoid(a:window)
        redraw!
    endfunction
    if has('nvim')
        call win_gotoid(a:winid)
    else
        call timer_start(1, { -> s:vimReturnFocus(a:winid) })
    endif
endfunction

function! s:get_fsi_command()
    let cmd = g:fsharp#fsi_command
    for prm in g:fsharp#fsi_extra_parameters
        let cmd = cmd . " " . prm
    endfor
    return cmd
endfunction

function! fsharp#openFsi(returnFocus)
    if bufwinid(s:fsi_buffer) <= 0
        let fsi_command = s:get_fsi_command()
        " Neovim
        if exists('*termopen') || exists('*term_start')
            let current_win = win_getid()
            execute g:fsharp#fsi_window_command
            if s:fsi_width  > 0 | execute 'vertical resize' s:fsi_width | endif
            if s:fsi_height > 0 | execute 'resize' s:fsi_height | endif
            " if window is closed but FSI is still alive then reuse it
            if s:fsi_buffer >= 0 && bufexists(str2nr(s:fsi_buffer))
                exec 'b' s:fsi_buffer
                normal G
                if !has('nvim') && mode() == 'n' | execute "normal A" | endif
                if a:returnFocus | call s:win_gotoid_safe(current_win) | endif
            " open FSI: Neovim
            elseif has('nvim')
                let s:fsi_job = termopen(fsi_command)
                if s:fsi_job > 0
                    let s:fsi_buffer = bufnr("%")
                else
                    close
                    echom "[FSAC] Failed to open FSI."
                    return -1
                endif
            " open FSI: Vim
            else
                let options = {
                \ "term_name": "F# Interactive",
                \ "curwin": 1,
                \ "term_finish": "close"
                \ }
                let s:fsi_buffer = term_start(fsi_command, options)
                if s:fsi_buffer != 0
                    if exists('*term_setkill') | call term_setkill(s:fsi_buffer, "term") | endif
                    let s:fsi_job = term_getjob(s:fsi_buffer)
                else
                    close
                    echom "[FSAC] Failed to open FSI."
                    return -1
                endif
            endif
            setlocal bufhidden=hide
            normal G
            if a:returnFocus | call s:win_gotoid_safe(current_win) | endif
            return s:fsi_buffer
        else
            echom "[FSAC] Your Vim does not support terminal".
            return 0
        endif
    endif
    return s:fsi_buffer
endfunction

function! fsharp#toggleFsi()
    let fsiWindowId = bufwinid(s:fsi_buffer)
    if fsiWindowId > 0
        let current_win = win_getid()
        call win_gotoid(fsiWindowId)
        let s:fsi_width = winwidth('%')
        let s:fsi_height = winheight('%')
        close
        call win_gotoid(current_win)
    else
        call fsharp#openFsi(0)
    endif
endfunction

function! fsharp#quitFsi()
    if s:fsi_buffer >= 0 && bufexists(str2nr(s:fsi_buffer))
        if has('nvim')
            let winid = bufwinid(s:fsi_buffer)
            if winid > 0 | execute "close " . winid | endif
            call jobstop(s:fsi_job)
        else
            call job_stop(s:fsi_job, "term")
        endif
        let s:fsi_buffer = -1
        let s:fsi_job = -1
    endif
endfunction

function! fsharp#resetFsi()
    call fsharp#quitFsi()
    return fsharp#openFsi(1)
endfunction

function! fsharp#sendFsi(text)
    if fsharp#openFsi(!g:fsharp#fsi_focus_on_send) > 0
        " Neovim
        if has('nvim')
            call chansend(s:fsi_job, a:text . "\n" . ";;". "\n")
        " Vim 8
        else
            call term_sendkeys(s:fsi_buffer, a:text . "\<cr>" . ";;" . "\<cr>")
            call term_wait(s:fsi_buffer)
        endif
    endif
endfunction

" https://stackoverflow.com/a/6271254
function! s:get_visual_selection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return lines
endfunction

function! s:get_complete_buffer()
    return join(getline(1, '$'), "\n")
endfunction

function! fsharp#sendSelectionToFsi() range
    let lines = s:get_visual_selection()
    exec 'normal' len(lines) . 'j'
    let text = join(lines, "\n")
    return fsharp#sendFsi(text)
endfunction

function! fsharp#sendLineToFsi()
    let text = getline('.')
    exec 'normal j'
    return fsharp#sendFsi(text)
endfunction

function! fsharp#sendAllToFsi()
    let text = s:get_complete_buffer()
    return fsharp#sendFsi(text)
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: sw=4 et sts=4
