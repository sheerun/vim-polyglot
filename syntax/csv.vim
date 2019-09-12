if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'csv') == -1

" A simple syntax highlighting, simply alternate colors between two
" adjacent columns
" Init {{{2
let s:cpo_save = &cpo
set cpo&vim

scriptencoding utf8
if version < 600
    syn clear
elseif exists("b:current_syntax")
    finish
endif

" Helper functions "{{{2
fu! <sid>Warning(msg) "{{{3
    " Don't redraw, so we are not overwriting messages from the ftplugin
    " script
    echohl WarningMsg
    echomsg "CSV Syntax:" . a:msg
    echohl Normal
endfu

fu! <sid>Esc(val, char) "{{{3 
    if empty(a:val)
        return a:val
    endif
    return '\V'.escape(a:val, '\\'.a:char).'\m'
endfu

fu! <sid>CheckSaneSearchPattern() "{{{3
    let s:del_def = ','
    let s:col_def = '\%([^' . s:del_def . ']*' . s:del_def . '\|$\)'
    let s:col_def_end = '\%([^' . s:del_def . ']*' . s:del_def . '\)'

    " First: 
    " Check for filetype plugin. This syntax script relies on the filetype
    " plugin, else, it won't work properly.
    redir => s:a |sil filetype | redir end
    let s:a=split(s:a, "\n")[0]
    if match(s:a, '\cplugin:off') > 0
        call <sid>Warning("No filetype support, only simple highlighting using"
        \ . s:del_def . " as delimiter! See :h csv-installation")
    endif

    " Check Comment setting
    if !exists("g:csv_comment")
        let b:csv_cmt = split(&cms, '%s')
    elseif match(g:csv_comment, '%s') >= 0
        let b:csv_cmt = split(g:csv_comment, '%s')
    else
        let b:csv_cmt = [g:csv_comment]
    endif


    " Second: Check for sane defaults for the column pattern
    " Not necessary to check for fixed width columns
    if exists("b:csv_fixed_width_cols")
        return
    endif


    " Try a simple highlighting, if the defaults from the ftplugin
    " don't exist
    let s:col  = get(b:, 'col', s:col_def)
    let s:col_end  = get(b:, 'col_end', s:col_def_end)
    let s:del  = get(b:, 'delimiter', s:del_def)
    let s:cmts = b:csv_cmt[0]
    let s:cmte = len(b:csv_cmt) == 2 ? b:csv_cmt[1] : ''
    " Make the file start at the first actual CSV record (issue #71)
    if !exists("b:csv_headerline")
        let cmts    = <sid>Esc(s:cmts, '')
        let pattern = '\%^\(\%('.cmts.'.*\n\)\|\%(\s*\n\)\)\+'
        let start = search(pattern, 'nWe', 10)
        " don't do it, on an empty file
        if start > 0 && !empty(getline(start))
            let b:csv_headerline = start+1
        endif
    endif
    " escape '/' for syn match command
    let s:cmts=<sid>Esc(s:cmts, '/')
    let s:cmte=<sid>Esc(s:cmte, '/')

    if line('$') > 1 && (!exists("b:col") || empty(b:col))
        " check for invalid pattern, ftplugin hasn't been loaded yet
        call <sid>Warning("Invalid column pattern, using default pattern " . s:col_def)
    endif
endfu

" Syntax rules {{{2
fu! <sid>DoHighlight() "{{{3
    if has("conceal") && !exists("g:csv_no_conceal") &&
        \ !exists("b:csv_fixed_width_cols")
        exe "syn match CSVDelimiter /" . s:col_end . 
            \ '/ms=e,me=e contained conceal cchar=' .
            \ (&enc == "utf-8" ? "│" : '|')
        hi def link CSVDelimiter Conceal
    elseif !exists("b:csv_fixed_width_cols")
    " The \%(.\)\@<= makes sure, the last char won't be concealed,
    " if it isn't a delimiter
        exe "syn match CSVDelimiter /" . s:col_end . '/ms=e,me=e contained'
        if has("conceal")
            hi def link CSVDelimiter Conceal
        else
            hi def link CSVDelimiter Ignore
        endif
    endif " There is no delimiter for csv fixed width columns

    if !exists("b:csv_fixed_width_cols")
        exe 'syn match CSVColumnEven nextgroup=CSVColumnOdd /'
            \ . s:col . '/ contains=CSVDelimiter'
        exe 'syn match CSVColumnOdd nextgroup=CSVColumnEven /'
            \ . s:col . '/ contains=CSVDelimiter'
        exe 'syn match CSVColumnHeaderEven nextgroup=CSVColumnHeaderOdd /\%<'. (get(b:, 'csv_headerline', 1)+1).'l'
            \. s:col . '/ contains=CSVDelimiter'
        exe 'syn match CSVColumnHeaderOdd nextgroup=CSVColumnHeaderEven /\%<'. (get(b:, 'csv_headerline', 1)+1).'l'
            \. s:col . '/ contains=CSVDelimiter'
    else
        for i in range(len(b:csv_fixed_width_cols))
            let pat = '/\%' . b:csv_fixed_width_cols[i] . 'v.*' .
                \ ((i == len(b:csv_fixed_width_cols)-1) ? '/' : 
                \ '\%' . b:csv_fixed_width_cols[i+1] . 'v/')

            let group  = "CSVColumn" . (i%2 ? "Odd"  : "Even" )
            let ngroup = "CSVColumn" . (i%2 ? "Even" : "Odd"  )
            exe "syn match " group pat " nextgroup=" . ngroup
        endfor
    endif
    " Comment regions
    exe 'syn match CSVComment /'. s:cmts. '.*'.
        \ (!empty(s:cmte) ? '\%('. s:cmte. '\)\?'
        \: '').  '/'
    hi def link CSVComment Comment
endfun

fu! <sid>HiLink(name, target) "{{{3
    if !hlexists(a:name)
        exe "hi def link" a:name a:target
    endif
endfu

fu! <sid>DoSyntaxDefinitions() "{{{3
    syn spell toplevel
    " Not really needed
    syn case ignore
    call <sid>HiLink("CSVColumnHeaderOdd", "WarningMsg")
    call <sid>HiLink("CSVColumnHeaderEven", "WarningMsg")
    if get(g:, 'csv_no_column_highlight', 0)
        call <sid>HiLink("CSVColumnOdd", "Normal")
        call <sid>HiLink("CSVColumnEven", "Normal")
    else
        call <sid>HiLink("CSVColumnOdd", "String")
        call <sid>HiLink("CSVColumnEven","Statement")
    endif
endfun

" Main: {{{2 
" Make sure, we are using a sane, valid pattern for syntax
" highlighting
call <sid>CheckSaneSearchPattern()
" Define all necessary syntax groups
call <sid>DoSyntaxDefinitions()
" Highlight the file
call <sid>DoHighlight()
" Set the syntax variable {{{2
let b:current_syntax="csv"

let &cpo = s:cpo_save
unlet s:cpo_save
" vim: set foldmethod=marker et sw=0 sts=-1 ts=4:

endif
