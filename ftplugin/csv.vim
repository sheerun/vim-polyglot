" Filetype plugin for editing CSV files. "{{{1
" Author:  Christian Brabandt <cb@256bit.org>
" Version: 0.29
" Script:  http://www.vim.org/scripts/script.php?script_id=2830
" License: VIM License
" Last Change: Wed, 14 Aug 2013 22:05:39 +0200
" Documentation: see :help ft-csv.txt
" GetLatestVimScripts: 2830 28 :AutoInstall: csv.vim
"
" Some ideas are taken from the wiki http://vim.wikia.com/wiki/VimTip667
" though, implementation differs.

" Plugin folklore "{{{2
if v:version < 700 || exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

" Function definitions: "{{{2
"
" Script specific functions "{{{2
fu! <sid>Warn(mess) "{{{3
    echohl WarningMsg
    echomsg "CSV: " . a:mess
    echohl Normal
endfu

fu! <sid>Init(startline, endline) "{{{3
    " Hilight Group for Columns
    if exists("g:csv_hiGroup")
        let s:hiGroup = g:csv_hiGroup
    else
        let s:hiGroup="WildMenu"
    endif
    if !exists("g:csv_hiHeader")
        let s:hiHeader = "Title"
    else
        let s:hiHeader = g:csv_hiHeader
    endif
    exe "hi link CSVHeaderLine" s:hiHeader

    " Determine default Delimiter
    if !exists("g:csv_delim")
        let b:delimiter=<SID>GetDelimiter(a:startline, a:endline)
    else
        let b:delimiter=g:csv_delim
    endif

    " Define custom commentstring
    if !exists("g:csv_comment")
        let b:csv_cmt = split(&cms, '%s')
    else
        let b:csv_cmt = split(g:csv_comment, '%s')
    endif

    if empty(b:delimiter) && !exists("b:csv_fixed_width")
        call <SID>Warn("No delimiter found. See :h csv-delimiter to set it manually!")
        " Use a sane default as delimiter:
        let b:delimiter = ','
    endif

    let s:del='\%(' . b:delimiter . '\|$\)'
    let s:del_noend='\%(' . b:delimiter . '\)'
    " Pattern for matching a single column
    if !exists("g:csv_strict_columns") && !exists("g:csv_col")
        \ && !exists("b:csv_fixed_width")
        " - Allow double quotes as escaped quotes only insides double quotes
        " - Allow linebreaks only, if g:csv_nl isn't set (this is
        "   only allowed in double quoted strings see RFC4180), though this
        "   does not work with :WhatColumn and might mess up syntax
        "   highlighting.
        " - optionally allow whitespace in front of the fields (to make it
        "   work with :ArrangeCol (that is actually not RFC4180 valid))
        " - Should work with most ugly solutions that are available
        let b:col='\%(\%(\%(' . (b:delimiter !~ '\s' ? '\s*' : '') .
                \ '"\%(' . (exists("g:csv_nl") ? '\_' : '' ) .
                \ '[^"]\|""\)*"\)' . s:del . '\)\|\%(' .
                \  '[^' .  b:delimiter . ']*' . s:del . '\)\)'
        let b:col_end='\%(\%(\%(' . (b:delimiter !~ '\s' ? '\s*' : '') .
                \ '"\%(' . (exists("g:csv_nl") ? '\_' : '' ) .
                \ '[^"]\|""\)*"\)' . s:del_noend . '\)\|\%(' .
                \  '[^' .  b:delimiter . ']*' . s:del_noend . '\)\)'
    elseif !exists("g:csv_col") && exists("g:csv_strict_columns")
        " strict columns
        let b:col='\%([^' . b:delimiter . ']*' . s:del . '\)'
        let b:col_end='\%([^' . b:delimiter . ']*' . s:del_noend . '\)'
    elseif exists("b:csv_fixed_width")
        " Fixed width column
        let b:col=''
        " Check for sane default
        if b:csv_fixed_width =~? '[^0-9,]'
            call <sid>Warn("Please specify the list of character columns" .
                \ "like this: '1,3,5'. See also :h csv-fixedwidth")
            return
        endif
        let b:csv_fixed_width_cols=split(b:csv_fixed_width, ',')
        " Force evaluating as numbers
        call map(b:csv_fixed_width_cols, 'v:val+0')
    else
        " User given column definition
        let b:col = g:csv_col
        let b:col_noend = g:csv_col
    endif

    " set filetype specific options
    call <sid>LocalSettings('all')

    " define buffer-local commands
    call <SID>CommandDefinitions()

    " Check Header line
    " Defines which line is considered to be a header line
    call <sid>CheckHeaderLine()

    " CSV specific mappings
    call <SID>CSVMappings()

    " force reloading CSV Syntax Highlighting
    if exists("b:current_syntax")
        unlet b:current_syntax
        " Force reloading syntax file
    endif
    call <sid>DoAutoCommands()
    " enable CSV Menu
    call <sid>Menu(1)
    call <sid>DisableFolding()
    silent do Syntax
    unlet! b:csv_start b:csv_end

    " Remove configuration variables
    let b:undo_ftplugin .=  "| unlet! b:delimiter b:col"
        \ . "| unlet! b:csv_fixed_width_cols b:csv_filter"
        \ . "| unlet! b:csv_fixed_width b:csv_list b:col_width"
        \ . "| unlet! b:csv_SplitWindow b:csv_headerline"
        \ . "| unlet! b:csv_thousands_sep b:csv_decimal_sep"
        \. " | unlet! b:browsefilter b:csv_cmt"
        \. " | unlet! b:csv_arrange_leftalign"

 " Delete all functions
 " disabled currently, because otherwise when switching ft
 "          I think, all functions need to be read in again and this
 "          costs time.
 "
 " let b:undo_ftplugin .= "| delf <sid>Warn | delf <sid>Init |
 " \ delf <sid>GetPat | delf <sid>SearchColumn | delf <sid>DelColumn |
 " \ delf <sid>HiCol | delf <sid>GetDelimiter | delf <sid>WColumn |
 " \ delf <sid>MaxColumns | delf <sid>ColWidth | delf <sid>ArCol |
 " \ delf <sid>PrepUnArCol | delf <sid>UnArCol |
 " \ delf <sid>CalculateColumnWidth | delf <sid>Columnize |
 " \ delf <sid>GetColPat | delf <sid>SplitHeaderLine |
 " \ delf <sid>SplitHeaderToggle | delf <sid>MoveCol |
 " \ delf <sid>SortComplete | delf <sid>SortList | delf <sid>Sort |
 " \ delf CSV_WCol | delf <sid>CopyCol | delf <sid>MoveColumn |
 " \ delf <sid>SumColumn csv#EvalColumn | delf <sid>DoForEachColumn |
 " \ delf <sid>PrepareDoForEachColumn | delf <sid>CSVMappings |
 " \ delf <sid>Map | delf <sid>EscapeValue | delf <sid>FoldValue |
 " \ delf <sid>PrepareFolding | delf <sid>OutputFilters |
 " \ delf <sid>SortFilter | delf <sid>GetColumn |
 " \ delf <sid>RemoveLastItem | delf <sid>DisableFolding |
 " \ delf <sid>GetSID | delf <sid>CheckHeaderLine |
 " \ delf <sid>AnalyzeColumn | delf <sid>Vertfold |
 " \ delf <sid>InitCSVFixedWidth | delf <sid>LocalCmd |
 " \ delf <sid>CommandDefinitions | delf <sid>NumberFormat |
 " \ delf <sid>NewRecord | delf <sid>MoveOver | delf <sid>Menu |
 " \ delf <sid>NewDelimiter | delf <sid>DuplicateRows | delf <sid>IN |
 " \ delf <sid>SaveOptions | delf <sid>CheckDuplicates |
 " \ delf <sid>CompleteColumnNr | delf <sid>CSVPat | delf <sid>Transpose |
 " \ delf <sid>LocalSettings() | delf <sid>AddColumn | delf <sid>SubstituteInColumn
 " \ delf <sid>SetupQuitPre() | delf CSV_CloseBuffer
endfu

fu! <sid>LocalSettings(type) "{{{3
    if a:type == 'all'
        " CSV local settings
        setl nostartofline tw=0 nowrap

        " undo when setting a new filetype
        let b:undo_ftplugin = "setlocal sol& tw< wrap<"

        " Set browsefilter
        if (v:version > 703 || (v:version == 703 && has("patch593")))
                    \ && exists("browsefilter")
            let b:browsefilter="CSV Files (*.csv, *.dat)\t*.csv;*.dat\n".
                 \ "All Files\t*.*\n"
        endif

        if has("conceal")
            setl cole=2 cocu=nc
            let b:undo_ftplugin .= '| setl cole< cocu< '
        endif

    elseif a:type == 'fold'
        let s:fdt = &l:fdt
        let s:fcs = &l:fcs

        if a:type == 'fold'
            " Be sure to also fold away single screen lines
            setl fen fdm=expr
            setl fdl=0 fml=0 fdc=2
            if !get(g:, 'csv_disable_fdt',0)
                let &l:foldtext=strlen(v:folddashes) . ' lines hidden'
                let &fcs=substitute(&fcs, 'fold:.,', '', '')
                if !exists("b:csv_did_foldsettings")
                    let b:undo_ftplugin .= printf("|set fdt<|setl fcs=%s", escape(s:fcs, '\\| '))
                endif
            endif
            if !exists("b:csv_did_foldsettings")
                let b:undo_ftplugin .=
                \ "| setl fen< fdm< fdl< fdc< fml< fde<"
                let b:csv_did_foldsettings = 1
                let b:undo_ftplugin .= "| unlet! b:csv_did_foldsettings"
            endif
        endif
    endif
endfu

fu! <sid>DoAutoCommands() "{{{3
    " Highlight column, on which the cursor is?
    if exists("g:csv_highlight_column") && g:csv_highlight_column =~? 'y' &&
        \ !exists("#CSV_HI#CursorMoved")
        aug CSV_HI
            au!
            au CursorMoved <buffer> HiColumn
        aug end
        " Set highlighting for column, on which the cursor is currently
        HiColumn
    elseif exists("#CSV_HI#CursorMoved")
        aug CSV_HI
            au! CursorMoved <buffer>
        aug end
        aug! CSV_HI
        " Remove any existing highlighting
        HiColumn!
    endif
    " undo autocommand:
    let b:undo_ftplugin .= '| exe "sil! au! CSV_HI CursorMoved <buffer> "'
    let b:undo_ftplugin .= '| exe "sil! aug! CSV_HI" |exe "sil! HiColumn!"'

    " Visually arrange columns when opening a csv file
    if exists("g:csv_autocmd_arrange") &&
        \ !exists("#CSV_Edit#BufReadPost")
        aug CSV_Edit
            au!
            au BufReadPost,BufWritePost *.csv,*.dat :sil %ArrangeColumn
            au BufWritePre *.csv,*.dat :sil %UnArrangeColumn
        aug end
    elseif exists("#CSV_Edit#BufReadPost")
        aug CSV_Edit
            au!
        aug end
        aug! CSV_Edit
    endif
    " undo autocommand:
    let b:undo_ftplugin .= '| exe "sil! au! CSV_Edit "'
    let b:undo_ftplugin .= '| exe "sil! aug! CSV_Edit"'

"    if !exists("#CSV_ColorScheme#ColorScheme")
"        " Make sure, syntax highlighting is applied
"        " after changing the colorscheme
"        augroup CSV_ColorScheme
"            au!
"            au ColorScheme *.csv,*.dat,*.tsv,*.tab do Syntax
"        augroup end
"    endif
"    let b:undo_ftplugin .= '| exe "sil! au! CSV_ColorScheme "'
"    let b:undo_ftplugin .= '| exe "sil! aug! CSV_ColorScheme"'

    if has("gui_running") && !exists("#CSV_Menu#FileType")
        augroup CSV_Menu
            au!
            au FileType * call <sid>Menu(&ft=='csv')
            au BufEnter <buffer> call <sid>Menu(1) " enable
            au BufLeave <buffer> call <sid>Menu(0) " disable
            au BufNewFile,BufNew * call <sid>Menu(0)
        augroup END
        "let b:undo_ftplugin .= '| sil! amenu disable CSV'
        "
        " b:undo_ftplugin does not support calling <sid> Functions
        "let b:undo_ftplugin .= '| sil! call <sid>Menu(0)'
    endif
endfu

fu! <sid>GetPat(colnr, maxcolnr, pat) "{{{3
    if a:colnr > 1 && a:colnr < a:maxcolnr
        if !exists("b:csv_fixed_width_cols")
            return '^' . <SID>GetColPat(a:colnr-1,0) . '\%([^' .
                \ b:delimiter . ']\{-}\)\?\zs' . a:pat . '\ze' .
                \ '\%([^' . b:delimiter .']\{-}\)\?' .
                \ b:delimiter . <SID>GetColPat(a:maxcolnr - a:colnr, 0) .
                \ '$'
        else
            return '\%' . b:csv_fixed_width_cols[(a:colnr - 1)] . 'c\zs'
                \ . a:pat . '.\{-}\ze\%'
                \ . (b:csv_fixed_width_cols[a:colnr]) . 'c\ze'
        endif
    elseif a:colnr == a:maxcolnr
        if !exists("b:csv_fixed_width_cols")
            return '^' . <SID>GetColPat(a:colnr - 1,0) .
                \ '\%([^' . b:delimiter .
                \ ']\{-}\)\?\zs' . a:pat . '\ze'
        else
            return '\%' . b:csv_fixed_width_cols[-1] .
                \ 'c\zs' . a:pat . '\ze'
        endif
    else " colnr = 1
        if !exists("b:csv_fixed_width_cols")
            return '^' . '\%([^' . b:delimiter . ']\{-}\)\?\zs' . a:pat .
            \ '\ze\%([^' . b:delimiter . ']*\)\?' . b:delimiter .
            \ <SID>GetColPat(a:maxcolnr -1 , 0) . '$'
        else
            return a:pat . '\ze.\{-}\%' . b:csv_fixed_width_cols[1] . 'c'
        endif
    endif
    return ''
endfu

fu! <sid>SearchColumn(arg) "{{{3
    try
        let arglist=split(a:arg)
        if len(arglist) == 1
            let colnr=<SID>WColumn()
            let pat=substitute(arglist[0], '^\(.\)\(.*\)\1$', '\2', '')
            if pat == arglist[0]
                throw "E684"
            endif
        else
            " Determine whether the first word in the argument is a number
            " (of the column to search).
            let colnr = substitute( a:arg, '^\s*\(\d\+\)\s.*', '\1', '' )
            " If it is _not_ a number,
            if colnr == a:arg
                " treat the whole argument as the pattern.
                let pat = substitute(a:arg,
                    \ '^\s*\(\S\)\(.*\)\1\s*$', '\2', '' )
                if pat == a:arg
                    throw "E684"
                endif
                let colnr = <SID>WColumn()
            else
                " if the first word tells us the number of the column,
                " treat the rest of the argument as the pattern.
                let pat = substitute(a:arg,
                    \ '^\s*\d\+\s*\(\S\)\(.*\)\1\s*$', '\2', '' )
                if pat == a:arg
                    throw "E684"
                endif
            endif
"             let colnr=arglist[0]
"             let pat=substitute(arglist[1], '^\(.\)\(.*\)\1$', '\2', '')
"             if pat == arglist[1]
"                 throw "E684"
"             endif
        endif
    "catch /^Vim\%((\a\+)\)\=:E684/
    catch /E684/	" catch error index out of bounds
        call <SID>Warn("Error! Usage :SearchInColumn [<colnr>] /pattern/")
        return 1
    endtry
    let maxcolnr = <SID>MaxColumns()
    if colnr > maxcolnr
        call <SID>Warn("There exists no column " . colnr)
        return 1
    endif
    let @/ = <sid>GetPat(colnr, maxcolnr, pat)
    try
        norm! n
    catch /^Vim\%((\a\+)\)\=:E486/
        " Pattern not found
        echohl Error
        echomsg "E486: Pattern not found in column " . colnr . ": " . pat
        if &vbs > 0
            echomsg substitute(v:exception, '^[^:]*:', '','')
        endif
        echohl Normal
    endtry
endfu


fu! <sid>DeleteColumn(arg) "{{{3
    let _wsv = winsaveview()
    if a:arg =~ '^[/]'
        let i = 0
        let pat = a:arg[1:]
        call cursor(1,1)
        while search(pat, 'cW')
            " Delete matching column
            sil call <sid>DelColumn('')
            let i+=1
        endw
    else
        let i = 1
        sil call <sid>DelColumn(a:arg)
    endif
    if i > 1
        call <sid>Warn(printf("%d columns deleted", i))
    else
        call <sid>Warn("1 column deleted")
    endif
    call winrestview(_wsv)
endfu

fu! <sid>DelColumn(colnr) "{{{3
    let maxcolnr = <SID>MaxColumns()
    let _p = getpos('.')

    if empty(a:colnr)
       let colnr=<SID>WColumn()
    else
       let colnr=a:colnr
    endif

    if colnr > maxcolnr
        call <SID>Warn("There exists no column " . colnr)
        return
    endif

    if colnr != '1'
        if !exists("b:csv_fixed_width_cols")
            let pat= '^' . <SID>GetColPat(colnr-1,1) . b:col
        else
            let pat= <SID>GetColPat(colnr,0)
        endif
    else
        " distinction between csv and fixed width does not matter here
        let pat= '^' . <SID>GetColPat(colnr,0)
    endif
    if &ro
        let ro = 1
        setl noro
    else
        let ro = 0
    endif
    exe ':%s/' . escape(pat, '/') . '//'
    call setpos('.', _p)
    if ro
        setl ro
    endif
endfu

fu! <sid>HiCol(colnr, bang) "{{{3
    if a:colnr > <SID>MaxColumns() && !a:bang
        call <SID>Warn("There exists no column " . a:colnr)
        return
    endif
    if !a:bang
        if empty(a:colnr)
            let colnr=<SID>WColumn()
        else
            let colnr=a:colnr
        endif

        if colnr==1
            let pat='^'. <SID>GetColPat(colnr,0)
        elseif !exists("b:csv_fixed_width_cols")
            let pat='^'. <SID>GetColPat(colnr-1,1) . b:col
        else
            let pat=<SID>GetColPat(colnr,0)
        endif
    endif

    if exists("*matchadd")
        if exists("s:matchid")
            " ignore errors, that come from already deleted matches
            sil! call matchdelete(s:matchid)
        endif
        " Additionally, filter all matches, that could have been used earlier
        let matchlist=getmatches()
        call filter(matchlist, 'v:val["group"] !~ s:hiGroup')
        call setmatches(matchlist)
        if a:bang
            return
        endif
        let s:matchid=matchadd(s:hiGroup, pat, 0)
    elseif !a:bang
        exe ":2match " . s:hiGroup . ' /' . pat . '/'
    endif
endfu

fu! <sid>GetDelimiter(first, last) "{{{3
    if !exists("b:csv_fixed_width_cols")
        let _cur = getpos('.')
        let _s   = @/
        let Delim= {0: ';', 1:  ',', 2: '|', 3: '	'}
        let temp = {}
        " :silent :s does not work with lazyredraw
        let _lz  = &lz
        set nolz
        for i in  values(Delim)
            redir => temp[i]
            exe "silent! ". a:first. ",". a:last. "s/" . i . "/&/nge"
            redir END
        endfor
        let &lz = _lz
        let Delim = map(temp, 'matchstr(substitute(v:val, "\n", "", ""), "^\\d\\+")')
        let Delim = filter(temp, 'v:val=~''\d''')
        let max   = max(values(temp))

        let result=[]
        call setpos('.', _cur)
        let @/ = _s
        for [key, value] in items(Delim)
            if value == max
                return key
            endif
        endfor
        return ''
    else
        " There is no delimiter for fixedwidth files
        return ''
    endif
endfu

fu! <sid>WColumn(...) "{{{3
    " Return on which column the cursor is
    let _cur = getpos('.')
    if !exists("b:csv_fixed_width_cols")
        let line=getline('.')
        " move cursor to end of field
        "call search(b:col, 'ec', line('.'))
        call search(b:col, 'ec')
        let end=col('.')-1
        let fields=(split(line[0:end],b:col.'\zs'))
        let ret=len(fields)
        if exists("a:1") && a:1 > 0
            " bang attribute
            let head  = split(getline(1),b:col.'\zs')
            " remove preceeding whitespace
            let ret   = substitute(head[ret-1], '^\s\+', '', '')
            " remove delimiter
            let ret   = substitute(ret, b:delimiter. '$', '', '')
        endif
    else
        let temp=getpos('.')[2]
        let j=1
        let ret = 1
        for i in sort(b:csv_fixed_width_cols, "<sid>SortList")
            if temp >= i
                let ret = j
            endif
            let j += 1
        endfor
    endif
    call setpos('.',_cur)
    return ret
endfu

fu! <sid>MaxColumns(...) "{{{3
    if exists("a:0") && a:0 == 1
        let this_col = 1
    else
        let this_col = 0
    endif
    "return maximum number of columns in first 10 lines
    if !exists("b:csv_fixed_width_cols")
        if this_col
            let i = a:1
        else
            let i = 1
        endif
        while 1
            let l = getline(i, i+10)

            " Filter comments out
            let pat = '^\s*\V'. escape(b:csv_cmt[0], '\\')
            call filter(l, 'v:val !~ pat')
            if !empty(l) || this_col
                break
            else
                let i+=10
            endif
        endw

        if empty(l)
            throw 'csv:no_col'
        endif
        let fields=[]
        let result=0
        for item in l
            let temp=len(split(item, b:col.'\zs'))
            let result=(temp>result ? temp : result)
        endfor
        return result
    else
        return len(b:csv_fixed_width_cols)
    endif
endfu

fu! <sid>ColWidth(colnr) "{{{3
    " Return the width of a column
    " Internal function
    let width=20 "Fallback (wild guess)
    let tlist=[]

    if !exists("b:csv_fixed_width_cols")
        if !exists("b:csv_list")
            let b:csv_list=getline(1,'$')
            let pat = '^\s*\V'. escape(b:csv_cmt[0], '\\')
            call filter(b:csv_list, 'v:val !~ pat')
            call filter(b:csv_list, '!empty(v:val)')
            call map(b:csv_list, 'split(v:val, b:col.''\zs'')')
        endif
        try
            for item in b:csv_list
                call add(tlist, item[a:colnr-1])
            endfor
            " we have a list of the first 10 rows
            " Now transform it to a list of field a:colnr
            " and then return the maximum strlen
            " That could be done in 1 line, but that would look ugly
            "call map(list, 'split(v:val, b:col."\\zs")[a:colnr-1]')
            call map(tlist, 'substitute(v:val, ".", "x", "g")')
            call map(tlist, 'strlen(v:val)')
            return max(tlist)
        catch
            throw "ColWidth-error"
            return width
        endtry
    else
        let cols = len(b:csv_fixed_width_cols)
        if a:colnr == cols
            return strlen(substitute(getline('$'), '.', 'x', 'g')) -
                \ b:csv_fixed_width_cols[cols-1] + 1
        elseif a:colnr < cols && a:colnr > 0
            return b:csv_fixed_width_cols[a:colnr] -
                \ b:csv_fixed_width_cols[(a:colnr - 1)]
        else
            throw "ColWidth-error"
            return 0
        endif
    endif
endfu

fu! <sid>ArrangeCol(first, last, bang) range "{{{3
    "TODO: Why doesn't that work?
    " is this because of the range flag?
    " It's because of the way, Vim works with
    " a:firstline and a:lastline parameter, therefore
    " explicitly give the range as argument to the function
    if exists("b:csv_fixed_width_cols")
        " Nothing to do
        call <sid>Warn("ArrangeColumn does not work with fixed width column!")
        return
    endif
    let cur=winsaveview()
    if a:bang || !exists("b:col_width")
        if a:bang
            " Force recalculating the Column width
            unlet! b:csv_list
        endif
        " Force recalculation of Column width
        call <sid>CalculateColumnWidth()
    endif

    if &ro
       " Just in case, to prevent the Warning
       " Warning: W10: Changing read-only file
       let ro = 1
       setl noro
    else
       let ro = 0
    endif
    exe "sil". a:first . ',' . a:last .'s/' . (b:col) .
    \ '/\=<SID>Columnize(submatch(0))/' . (&gd ? '' : 'g')
    " Clean up variables, that were only needed for <sid>Columnize() function
    unlet! s:columnize_count s:max_cols s:prev_line
    if ro
        setl ro
        unlet ro
    endif
    call winrestview(cur)
endfu

fu! <sid>PrepUnArrangeCol(first, last) "{{{3
    " Because of the way, Vim works with
    " a:firstline and a:lastline parameter,
    " explicitly give the range as argument to the function
    if exists("b:csv_fixed_width_cols")
        " Nothing to do
        call <sid>Warn("UnArrangeColumn does not work with fixed width column!")
        return
    endif
    let cur=winsaveview()

    if &ro
       " Just in case, to prevent the Warning
       " Warning: W10: Changing read-only file
       setl noro
    endif
    exe a:first . ',' . a:last .'s/' . (b:col) .
    \ '/\=<SID>UnArrangeCol(submatch(0))/' . (&gd ? '' : 'g')
    " Clean up variables, that were only needed for <sid>Columnize() function
    call winrestview(cur)
endfu

fu! <sid>UnArrangeCol(match) "{{{3
    " Strip leading white space, also trims empty records:
    if get(b:, 'csv_arrange_leftalign',0)
        return substitute(a:match, '\s\+\ze'. b:delimiter. '\?$', '', '')
    else
        return substitute(a:match, '^\s\+', '', '')
    endif
    " only strip leading white space, if a non-white space follows:
    "return substitute(a:match, '^\s\+\ze\S', '', '')
endfu

fu! <sid>CalculateColumnWidth() "{{{3
    " Internal function, not called from external,
    " does not work with fixed width columns
    let b:col_width=[]
    try
        let s:max_cols=<SID>MaxColumns(line('.'))
        for i in range(1,s:max_cols)
            call add(b:col_width, <SID>ColWidth(i))
        endfor
    catch /csv:no_col/
        call <sid>Warn("Error: getting Column numbers, aborting!")
    catch /ColWidth/
        call <sid>Warn("Error: getting Column Width, using default!")
    endtry
    " delete buffer content in variable b:csv_list,
    " this was only necessary for calculating the max width
    unlet! b:csv_list
endfu

fu! <sid>Columnize(field) "{{{3
    " Internal function, not called from external,
    " does not work with fixed width columns
    if !exists("s:columnize_count")
        let s:columnize_count = 0
    endif

    if !exists("s:max_cols")
        let s:max_cols = len(b:col_width)
    endif

    if exists("s:prev_line") && s:prev_line != line('.')
        let s:columnize_count = 0
    endif

    let s:prev_line = line('.')
    " convert zero based indexed list to 1 based indexed list,
    " Default: 20 width, in case that column width isn't defined
    " Careful: Keep this fast! Using
    " let width=get(b:col_width,<SID>WColumn()-1,20)
    " is too slow, so we are using:
    let width=get(b:col_width, (s:columnize_count % s:max_cols), 20)

    let s:columnize_count += 1
    let has_delimiter = (a:field =~# b:delimiter.'$')
    if v:version > 703 || v:version == 703 && has("patch713")
        " printf knows about %S (e.g. can handle char length
        if get(b:, 'csv_arrange_leftalign',0)
            " left-align content
            return printf("%-*S%s", width+1 , 
                \ (has_delimiter ?
                \ matchstr(a:field, '.*\%('.b:delimiter.'\)\@=') : a:field),
                \ (has_delimiter ? b:delimiter : ''))
        else
            return printf("%*S", width+1 ,  a:field)
        endif
    else
        " printf only handles bytes
        if !exists("g:csv_no_multibyte") &&
            \ match(a:field, '[^ -~]') != -1
            " match characters outside the ascii range
            let a = split(a:field, '\zs')
            let add = eval(join(map(a, 'len(v:val)'), '+'))
            let add -= len(a)
        else
            let add = 0
        endif

        " Add one for the frame
        " plus additional width for multibyte chars,
        " since printf(%*s..) uses byte width!
        let width = width + add  + 1

        if width == strlen(a:field)
            " Column has correct length, don't use printf()
            return a:field
        else
            if get(b:, 'csv_arrange_leftalign',0)
                " left-align content
                return printf("%-*s%s", width,  
                \ (has_delimiter ?  matchstr(a:field, '.*\%('.b:delimiter.'\)\@=') : a:field),
                \ (has_delimiter ? b:delimiter : ''))
            else
                return printf("%*s", width ,  a:field)
            endif
        endif
    endif
endfun

fu! <sid>GetColPat(colnr, zs_flag) "{{{3
    " Return Pattern for given column
    if a:colnr > 1
        if !exists("b:csv_fixed_width_cols")
            let pat=b:col . '\{' . (a:colnr) . '\}'
        else
            if a:colnr >= len(b:csv_fixed_width_cols)
            " Get last column
                let pat='\%' . b:csv_fixed_width_cols[-1] . 'c.*'
            else
            let pat='\%' . b:csv_fixed_width_cols[(a:colnr - 1)] .
            \ 'c.\{-}\%' .   b:csv_fixed_width_cols[a:colnr] . 'c'
            endif
        endif
    elseif !exists("b:csv_fixed_width_cols")
        let pat=b:col
    else
        let pat='\%' . b:csv_fixed_width_cols[0] . 'c.\{-}' .
            \ (len(b:csv_fixed_width_cols) > 1 ?
            \ '\%' . b:csv_fixed_width_cols[1] . 'c' :
            \ '')
    endif
    return pat . (a:zs_flag ? '\zs' : '')
endfu

fu! <sid>SetupQuitPre(window) "{{{3
    " Setup QuitPre autocommand to quit cleanly
    if exists("##QuitPre")
        augroup CSV_QuitPre
            au!
            exe "au QuitPre * call CSV_CloseBuffer(".winbufnr(a:window).")"
        augroup end
    endif
endfu

fu! <sid>SplitHeaderLine(lines, bang, hor) "{{{3
    if exists("b:csv_fixed_width_cols")
        call <sid>Warn("Header does not work with fixed width column!")
        return
    endif
    " Check that there exists a header line
    call <sid>CheckHeaderLine()
    if !a:bang
        " A Split Header Window already exists,
        " first close the already existing Window
        if exists("b:csv_SplitWindow")
            call <sid>SplitHeaderLine(a:lines, 1, a:hor)
        endif
        " Split Window
        let _stl = &l:stl
        let _sbo = &sbo
        let a = []
        let b=b:col
        if a:hor
            setl scrollopt=hor scrollbind
            let _fdc = &l:fdc
            let lines = empty(a:lines) ? s:csv_fold_headerline : a:lines
            let a = getline(1,lines)
            " Does it make sense to use the preview window?
            " sil! pedit %
            above sp +enew
            call setline(1, a)
            " Needed for syntax highlighting
            "let b:col=b
            "setl syntax=csv
            sil! doautocmd FileType csv
            noa 1
            exe "resize" . lines
            setl scrollopt=hor winfixheight nowrap
            "let &l:stl=repeat(' ', winwidth(0))
            let &l:stl="%#Normal#".repeat(' ',winwidth(0))
            " set the foldcolumn to the same of the other window
            let &l:fdc = _fdc
        else
            setl scrollopt=ver scrollbind
            noa 0
            let a=<sid>CopyCol('',1,a:lines)
            " Does it make sense to use the preview window?
            "vert sil! pedit |wincmd w | enew!
            above vsp +enew
            call append(0, a)
            $d _
            let b:col = b
            sil! doautocmd FileType csv
            " remove leading delimiter
            exe "sil :%s/^". b:delimiter. "//e"
            " remove trailing delimiter
            exe "sil :%s/". b:delimiter. "\s*$//e"
            syn clear
            noa 0
            let b:csv_SplitWindow = winnr()
            sil :call <sid>ArrangeCol(1,line('$'), 1)
            exe "vert res" . len(split(getline(1), '\zs'))
            call matchadd("CSVHeaderLine", b:col)
            setl scrollopt=ver winfixwidth
        endif
        call <sid>SetupQuitPre(winnr())
        let win = winnr()
        setl scrollbind buftype=nowrite bufhidden=wipe noswapfile nobuflisted
        noa wincmd p
        let b:csv_SplitWindow = win
        aug CSV_Preview
            au!
            au BufWinLeave <buffer> call <sid>SplitHeaderLine(0, 1, 0)
        aug END
    else
        " Close split window
        if !exists("b:csv_SplitWindow")
            return
        endif
        exe b:csv_SplitWindow . "wincmd w"
        if exists("_stl")
            let &l:stl = _stl
        endif
        if exists("_sbo")
            let &sbo = _sbo
        endif
        setl noscrollbind
        try
            wincmd c
        catch /^Vim\%((\a\+)\)\=:E444/	" cannot close last window
        catch /^Vim\%((\a\+)\)\=:E517/	" buffer already wiped
            " no-op
        endtry
        "pclose!
        unlet! b:csv_SplitWindow
        aug CSV_Preview
            au!
        aug END
        aug! CSV_Preview
    endif
endfu

fu! <sid>SplitHeaderToggle(hor) "{{{3
    if !exists("b:csv_SplitWindow")
        :call <sid>SplitHeaderLine(1,0,a:hor)
    else
        :call <sid>SplitHeaderLine(1,1,a:hor)
    endif
endfu

" TODO: from here on add logic for fixed-width csv files!
fu! <sid>MoveCol(forward, line, ...) "{{{3
    " Move cursor position upwards/downwards left/right
    " a:1 is there to have some mappings move in the same
    " direction but still stop at a different position
    " see :h csv-mapping-H
    let colnr=<SID>WColumn()
    let maxcol=<SID>MaxColumns()
    let cpos=getpos('.')[2]
    if !exists("b:csv_fixed_width_cols")
        call search(b:col, 'bc', line('.'))
    endif
    let spos=getpos('.')[2]

    " Check for valid column
    " a:forward == 1 : search next col
    " a:forward == -1: search prev col
    " a:forward == 0 : stay in col
    if colnr - v:count1 >= 1 && a:forward == -1
        let colnr -= v:count1
    elseif colnr - v:count1 < 1 && a:forward == -1
        let colnr = 0
    elseif colnr + v:count1 <= maxcol && a:forward == 1
        let colnr += v:count1
    elseif colnr + v:count1 > maxcol && a:forward == 1
        let colnr = maxcol + 1
    endif

    let line=a:line
    if line < 1
        let line=1
    elseif line > line('$')
        let line=line('$')
    endif

    " Generate search pattern
    if colnr == 1
        let pat = '^' . <SID>GetColPat(colnr-1,0)
        "let pat = pat . '\%' . line . 'l'
    elseif (colnr == 0) || (colnr == maxcol + 1)
        if !exists("b:csv_fixed_width_cols")
            let pat=b:col
        else
            if a:forward > 0
                " Move forwards
                let pat=<sid>GetColPat(1, 0)
            else
                " Move backwards
                let pat=<sid>GetColPat(maxcol, 0)
            endif
        endif
    else
        if !exists("b:csv_fixed_width_cols")
            let pat='^'. <SID>GetColPat(colnr-1,1) . b:col
        else
            let pat=<SID>GetColPat(colnr,0)
        endif
        "let pat = pat . '\%' . line . 'l'
    endif

    " Search
    " move left/right
    if a:forward > 0
        call search(pat, 'W')
    elseif a:forward < 0
        if colnr > 0 || cpos == spos
            call search('.\ze'.pat, 'bWe')
            while getpos('.')[2] == cpos
                " cursor didn't move, move cursor one cell to the left
                norm! h
                if colnr > 0
                    call <sid>MoveCol(-1, line('.'))
                else
                    norm! 0
                endif
            endw
            if (exists("a:1") && a:1)
                " H also stops at the beginning of the content
                " of a field.
                let epos = getpos('.')
                if getline('.')[col('.')-1] == ' '
                    call search('\S', 'W', line('.'))
                    if getpos('.')[2] > spos
                        call setpos('.', epos)
                    endif
                endif
            endif
        else
            norm! 0
        endif
        " Moving upwards/downwards
    elseif line >= line('.')
        call search(pat . '\%' . line . 'l', '', line)
        " Move to the correct screen column
        " This is a best effort approach, we might still
        " leave the column (if the next column is shorter)
        if !exists("b:csv_fixed_width_cols")
            let a    = getpos('.')
            let a[2]+= cpos-spos
        else
            let a    = getpos('.')
            let a[2] = cpos
        endif
        call setpos('.', a)
    elseif line < line('.')
        call search(pat . '\%' . line . 'l', 'b', line)
        " Move to the correct screen column
        if !exists("b:csv_fixed_width_cols")
            let a    = getpos('.')
            let a[2]+= cpos-spos
        else
            let a    = getpos('.')
            let a[2] = cpos
        endif
        call setpos('.', a)
    endif
endfun

fu! <sid>SortComplete(A,L,P) "{{{3
    return join(range(1,<sid>MaxColumns()),"\n")
endfun

fu! <sid>SortList(a1, a2) "{{{3
    return a:a1+0 == a:a2+0 ? 0 : a:a1+0 > a:a2+0 ? 1 : -1
endfu

fu! <sid>Sort(bang, line1, line2, colnr) range "{{{3
    let wsv=winsaveview()
    if a:colnr =~? 'n'
        let numeric = 1
    else
        let numeric = 0
    endif
    let col = (empty(a:colnr) || a:colnr !~? '\d\+') ? <sid>WColumn() : a:colnr+0
    if col != 1
        if !exists("b:csv_fixed_width_cols")
            let pat= '^' . <SID>GetColPat(col-1,1) . b:col
        else
            let pat= '^' . <SID>GetColPat(col,0)
        endif
    else
        let pat= '^' . <SID>GetColPat(col,0)
    endif
    exe a:line1 ',' a:line2 . "sort" . (a:bang ? '!' : '') .
        \' r ' . (numeric ? 'n' : '') . ' /' . pat . '/'
    call winrestview(wsv)
endfun

fu! <sid>CopyCol(reg, col, cnt) "{{{3
    " Return Specified Column into register reg
    let col = a:col == "0" ? <sid>WColumn() : a:col+0
    let mcol = <sid>MaxColumns()
    if col == '$' || col > mcol
        let col = mcol
    endif
    " The number of columns to return
    " by default (value of zero, will only return that specific column)
    let cnt_cols = col - 1
    if !empty(a:cnt) && a:cnt > 0 && col + a:cnt <= mcol
        let cnt_cols = col + a:cnt - 1
    endif
    let a = []
    " Don't get lines, that are currently filtered away
    if !exists("b:csv_filter") || empty(b:csv_filter)
        let a=getline(1, '$')
    else
        for line in range(1, line('$'))
            if foldlevel(line)
                continue
            else
                call add(a, getline(line))
            endif
        endfor
    endif
    " Filter comments out
    let pat = '^\s*\V'. escape(b:csv_cmt[0], '\\')
    call filter(a, 'v:val !~ pat')

    if !exists("b:csv_fixed_width_cols")
        call map(a, 'split(v:val, ''^'' . b:col . ''\zs'')[col-1:cnt_cols]')
    else
        call map(a, 'matchstr(v:val, <sid>GetColPat(col, 0)).*<sid>GetColPat(col+cnt_cols, 0)')
    endif
    if type(a[0]) == type([])
        call map(a, 'join(v:val, "")')
    endif
    if a:reg =~ '[-"0-9a-zA-Z*+]'
        "exe  ':let @' . a:reg . ' = "' . join(a, "\n") . '"'
        " set the register to blockwise mode
        call setreg(a:reg, join(a, "\n"), 'b')
    else
        return a
    endif
endfu

fu! <sid>MoveColumn(start, stop, ...) range "{{{3
    " Move column behind dest
    " Explicitly give the range as argument,
    " cause otherwise, Vim would move the cursor
    let wsv = winsaveview()

    let col = <sid>WColumn()
    let max = <sid>MaxColumns()

    " If no argument is given, move current column after last column
    let source=(exists("a:1") && a:1 > 0 && a:1 <= max ? a:1 : col)
    let dest  =(exists("a:2") && a:2 > 0 && a:2 <= max ? a:2 : max)

    " translate 1 based columns into zero based list index
    let source -= 1
    let dest   -= 1

    if source >= dest
        call <sid>Warn("Destination column before source column, aborting!")
        return
    endif

    " Swap line by line, instead of reading the whole range into memory

    for i in range(a:start, a:stop)
        let content = getline(i)
        if content =~ '^\s*\V'. escape(b:csv_cmt[0], '\\')
            " skip comments
            continue
        endif
        if !exists("b:csv_fixed_width_cols")
            let fields=split(content, b:col . '\zs')
            " Add delimiter to destination column, in case there was none,
            " remove delimiter from source, in case destination did not have one
            if matchstr(fields[dest], '.$') !~? b:delimiter
                let fields[dest] = fields[dest] . b:delimiter
                if matchstr(fields[source], '.$') =~? b:delimiter
                let fields[source] = substitute(fields[source],
                    \ '^\(.*\).$', '\1', '')
                endif
            endif
        else
            let fields=[]
            " this is very inefficient!
            for j in range(1, max, 1)
                call add(fields, matchstr(content, <sid>GetColPat(j,0)))
            endfor
        endif

        let fields= (source == 0 ? [] : fields[0 : (source-1)])
                \ + fields[ (source+1) : dest ]
                \ + [ fields[source] ] + fields[(dest+1):]

        call setline(i, join(fields, ''))
    endfor

    call winrestview(wsv)

endfu

fu! <sid>AddColumn(start, stop, ...) range "{{{3
    " Add new empty column
    " Explicitly give the range as argument,
    " cause otherwise, Vim would move the cursor
    if exists("b:csv_fixed_width_cols")
        call <sid>Warn("Adding Columns only works for delimited files")
        return
    endif

    let wsv = winsaveview()

    let col = <sid>WColumn()
    let max = <sid>MaxColumns()

    " If no argument is given, add column after current column
    if exists("a:1")
        if a:1 == '$' || a:1 >= max
            let pos = max
        elseif a:1 <= 0
            let pos = col
        endif
    else
        let pos = col
    endif
    let cnt=(exists("a:2") && a:2 > 0 ? a:2 : 1)

    " translate 1 based columns into zero based list index
    let pos -= 1
    let col -= 1

    if pos == 0
        let pat = '^'
    elseif pos == max-1
        let pat = '$'
    else
        let pat = <sid>GetColPat(pos,1)
    endif

    if pat != '$' || (pat == '$' &&  getline(a:stop)[-1:] == b:delimiter)
        let subst = repeat(' '. b:delimiter, cnt)
    else
        let subst = repeat(b:delimiter. ' ', cnt)
    endif

    " if the data contains comments, substitute one line after another
    " skipping comment lines (we could do it with a single :s statement,
    " but that would fail for the first and last column.

    let commentpat = '\%(\%>'.(a:start-1).'l\V'.
                \ escape(b:csv_cmt[0], '\\').'\m\)'. '\&\%(\%<'.
                \ (a:stop+1). 'l\V'. escape(b:csv_cmt[0], '\\'). '\m\)'
    if search(commentpat)
        for i in range(a:start, a:stop)
            let content = getline(i)
            if content =~ '^\s*\V'. escape(b:csv_cmt[0], '\\')
                " skip comments
                continue
            endif
            exe printf("sil %ds/%s/%s/e", i, pat, subst)
        endfor
    else
        " comments should by default be skipped (pattern shouldn't match)
        exe printf("sil %d,%ds/%s/%s/e", a:start, a:stop, pat, subst)
    endif

    call winrestview(wsv)
endfu

fu! <sid>SumColumn(list) "{{{3
    " Sum a list of values, but only consider the digits within each value
    " parses the digits according to the given format (if none has been
    " specified, assume POSIX format (without thousand separator) If Vim has
    " does not support floats, simply sum up only the integer part
    if empty(a:list)
        return 0
    else
        let sum = has("float") ? 0.0 : 0
        for item in a:list
            if empty(item)
                continue
            endif
            let nr = matchstr(item, '-\?\d\(.*\d\)\?$')
            let format1 = '^-\?\d\+\zs\V' . s:nr_format[0] . '\m\ze\d'
            let format2 = '\d\+\zs\V' . s:nr_format[1] . '\m\ze\d'
            try
                let nr = substitute(nr, format1, '', '')
                if has("float") && s:nr_format[1] != '.'
                    let nr = substitute(nr, format2, '.', '')
                endif
            catch
                let nr = 0
            endtry
            let sum += (has("float") ? str2float(nr) : (nr + 0))
        endfor
        if has("float")
            if float2nr(sum) == sum
                return float2nr(sum)
            else
                return printf("%.2f", sum)
            endif
        endif
        return sum
    endif
endfu

fu! <sid>DoForEachColumn(start, stop, bang) range "{{{3
    " Do something for each column,
    " e.g. generate SQL-Statements, convert to HTML,
    " something like this
    " TODO: Define the function
    " needs a csv_pre_convert variable
    "         csv_post_convert variable
    "         csv_convert variable
    "         result contains converted buffer content
    let result = []

    if !exists("g:csv_convert")
        call <sid>Warn("You need to define how to convert your data using" .
                \ "the g:csv_convert variable, see :h csv-convert")
        return
    endif

    if exists("g:csv_pre_convert") && !empty(g:csv_pre_convert)
        call add(result, g:csv_pre_convert)
    endif

    for item in range(a:start, a:stop, 1)
        let t = g:csv_convert
        let line = getline(item)
        if line =~ '^\s*\V'. escape(b:csv_cmt[0], '\\')
            " Filter comments out
            call add(result, line)
            continue
        endif
        let context = split(g:csv_convert, '%s')
        let columns = len(context)
        if columns > <sid>MaxColumns()
            let columns = <sid>MaxColumns()
        elseif columns == 1
            call <sid>Warn("No Columns defined in your g:csv_convert variable, Aborting")
            return
        endif

        if !exists("b:csv_fixed_width_cols")
            let fields=split(line, b:col . '\zs')
            if a:bang
                call map(fields, 'substitute(v:val, b:delimiter .
                    \ ''\?$'' , "", "")')
            endif
        else
            let fields=[]
            for j in range(1, columns, 1)
                call add(fields, matchstr(line, <sid>GetColPat(j,0)))
            endfor
        endif
        for j in range(1, columns, 1)
            let t=substitute(t, '%s', fields[j-1], '')
        endfor
        call add(result, t)
    endfor

    if exists("g:csv_post_convert") && !empty(g:csv_post_convert)
        call add(result, g:csv_post_convert)
    endif

    new
    call append('$', result)
    1d _

endfun

fu! <sid>PrepareDoForEachColumn(start, stop, bang) range"{{{3
    let pre = exists("g:csv_pre_convert") ? g:csv_pre_convert : ''
    let g:csv_pre_convert=input('Pre convert text: ', pre)
    let post = exists("g:csv_post_convert") ? g:csv_post_convert : ''
    let g:csv_post_convert=input('Post convert text: ', post)
    let convert = exists("g:csv_convert") ? g:csv_convert : ''
    let g:csv_convert=input("Converted text, use %s for column input:\n", convert)
    call <sid>DoForEachColumn(a:start, a:stop, a:bang)
endfun
fu! <sid>EscapeValue(val) "{{{3
    return '\V' . escape(a:val, '\')
endfu

fu! <sid>FoldValue(lnum, filter) "{{{3
    call <sid>CheckHeaderLine()

    if (a:lnum == s:csv_fold_headerline)
        " Don't fold away the header line
        return 0
    endif
    let result = 0

    for item in values(a:filter)
        " always fold comments away
        let content = getline(a:lnum)
        if content =~ '^\s*\V'. escape(b:csv_cmt[0], '\\')
            return 1
        elseif eval('content' .  (item.match ? '!~' : '=~') . 'item.pat')
            let result += 1
        endif
    endfor
    return (result > 0)
endfu

fu! <sid>PrepareFolding(add, match)  "{{{3
    if !has("folding")
        return
    endif

    " Move folded-parts away?
    if exists("g:csv_move_folds")
        let s:csv_move_folds = g:csv_move_folds
    else
        let s:csv_move_folds = 0
    endif

    if !exists("b:csv_filter")
        let b:csv_filter = {}
    endif
    if !exists("s:filter_count") || s:filter_count < 1
        let s:filter_count = 0
    endif
    let cpos = winsaveview()

    if !a:add
        " remove last added item from filter
        if !empty(b:csv_filter)
            call <sid>RemoveLastItem(s:filter_count)
            let s:filter_count -= 1
            if empty(b:csv_filter)
                call <sid>DisableFolding()
                return
            endif
        else
            " Disable folding, if no pattern available
            call <sid>DisableFolding()
            return
        endif
    else

        let col = <sid>WColumn()
        let max = <sid>MaxColumns()
        let a   = <sid>GetColumn(line('.'), col)

        if !exists("b:csv_fixed_width")
            try
                " strip leading whitespace
                if (a =~ '\s\+'. b:delimiter . '$')
                    let b = split(a, '^\s\+\ze[^' . b:delimiter. ']\+')[0]
                else
                    let b = a
                endif
            catch /^Vim\%((\a\+)\)\=:E684/
                " empty pattern - should match only empty columns
                let b = a
            endtry

            " strip trailing delimiter
            try
                let a = split(b, b:delimiter . '$')[0]
            catch /^Vim\%((\a\+)\)\=:E684/
                let a = b
            endtry

            if a == b:delimiter
                try
                    let a=repeat(' ', <sid>ColWidth(col))
                catch
                    " no-op
                endtry
            endif
        endif

        " Make a column pattern
        let b= '\%(' .
            \ (exists("b:csv_fixed_width") ? '.*' : '') .
            \ <sid>GetPat(col, max, <sid>EscapeValue(a) . '\m') .
            \ '\)'

        let s:filter_count += 1
        let b:csv_filter[s:filter_count] = { 'pat': b, 'id': s:filter_count,
            \ 'col': col, 'orig': a, 'match': a:match}

    endif
    " Put the pattern into the search register, so they will also
    " be highlighted
"    let @/ = ''
"    for val in sort(values(b:csv_filter), '<sid>SortFilter')
"        let @/ .= val.pat . (val.id == s:filter_count ? '' : '\&')
"    endfor
    let sid = <sid>GetSID()

    " Fold settings:
    call <sid>LocalSettings('fold')
    " Don't put spaces between the arguments!
    exe 'setl foldexpr=<snr>' . sid . '_FoldValue(v:lnum,b:csv_filter)'

    " Move folded area to the bottom, so there is only on consecutive
    " non-folded area
    if exists("s:csv_move_folds") && s:csv_move_folds
        \ && !&l:ro && &l:ma
        folddoclosed m$
        let cpos.lnum = s:csv_fold_headerline + 1
    endif
    call winrestview(cpos)
endfu

fu! <sid>OutputFilters(bang) "{{{3
    if !a:bang
        call <sid>CheckHeaderLine()
        if s:csv_fold_headerline
            let  title="Nr\tMatch\tCol\t      Name\tValue"
        else
            let  title="Nr\tMatch\tCol\tValue"
        endif
        echohl "Title"
        echo   printf("%s", title)
        echo   printf("%s", repeat("=",strdisplaywidth(title)))
        echohl "Normal"
        if !exists("b:csv_filter") || empty(b:csv_filter)
            echo printf("%s", "No active filter")
        else
            let items = values(b:csv_filter)
            call sort(items, "<sid>SortFilter")
            for item in items
                if s:csv_fold_headerline
                    echo printf("%02d\t% 2s\t%02d\t%10.10s\t%s",
                        \ item.id, (item.match ? '+' : '-'), item.col,
                        \ substitute(<sid>GetColumn(1, item.col),
                        \ b:col.'$', '', ''), item.orig)
                else
                    echo printf("%02d\t% 2s\t%02d\t%s",
                        \ item.id, (item.match ? '+' : '-'),
                        \ item.col, item.orig)
                endif
            endfor
        endif
    else
        " Reapply filter again
        if !exists("b:csv_filter") || empty(b:csv_filter)
            call <sid>Warn("No filters defined currently!")
            return
        else
            let sid = <sid>GetSID()
            exe 'setl foldexpr=<snr>' . sid . '_FoldValue(v:lnum,b:csv_filter)'
        endif
    endif
endfu

fu! <sid>SortFilter(a, b) "{{{3
    return a:a.id == a:b.id ? 0 :
        \ a:a.id > a:b.id ? 1 : -1
endfu

fu! <sid>GetColumn(line, col) "{{{3
    " Return Column content at a:line, a:col
    let a=getline(a:line)
    " Filter comments out
    if a =~ '^\s*\V'. escape(b:csv_cmt[0], '\\')
        return ''
    endif

    if !exists("b:csv_fixed_width_cols")
        try
            let a = split(a, '^' . b:col . '\zs')[a:col - 1]
        catch
            " index out of range
            let a = ''
        endtry
    else
        let a = matchstr(a, <sid>GetColPat(a:col, 0))
    endif
    return substitute(a, '^\s\+\|\s\+$', '', 'g')
endfu

fu! <sid>RemoveLastItem(count) "{{{3
    for [key,value] in items(b:csv_filter)
        if value.id == a:count
            call remove(b:csv_filter, key)
        endif
    endfor
endfu

fu! <sid>DisableFolding() "{{{3
    setl nofen fdm=manual fdc=0 fdl=0
    if !get(g:, 'csv_disable_fdt',0) && exists("s:fdt") && exists("s:fcs")
        exe printf("setl fdt=%s fcs=%s", s:fdt, escape(s:fcs, '\\|'))
    endif
endfu

fu! <sid>GetSID() "{{{3
    if v:version > 703 || v:version == 703 && has("patch032")
        return maparg('W', "", "", 1).sid
    else
        "return substitute(maparg('W'), '\(<SNR>\d\+\)_', '\1', '')
        return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_GetSID$')
    endif
endfu

fu! <sid>NumberFormat() "{{{3
    let s:nr_format = [',', '.']
    if exists("b:csv_thousands_sep")
        let s:nr_format[0] = b:csv_thousands_sep
    endif
    if exists("b:csv_decimal_sep")
        let s:nr_format[1] = b:csv_decimal_sep
    endif
endfu

fu! <sid>CheckHeaderLine() "{{{3
    if !exists("b:csv_headerline")
        let s:csv_fold_headerline = 1
    else
        let s:csv_fold_headerline = b:csv_headerline
    endif
endfu

fu! <sid>AnalyzeColumn(...) "{{{3
    let maxcolnr = <SID>MaxColumns()
    if len(a:000) == 1
        let colnr = a:1
    else
        let colnr = <sid>WColumn()
    endif

    if colnr > maxcolnr
        call <SID>Warn("There exists no column " . colnr)
        return 1
    endif

    " Initialize s:fold_headerline
    call <sid>CheckHeaderLine()
    let data = <sid>CopyCol('', colnr, '')[s:csv_fold_headerline : -1]
    let qty = len(data)
    let res = {}
    for item in data
        if empty(item)
            let item = 'NULL'
        endif
        if !get(res, item)
            let res[item] = 0
        endif
        let res[item]+=1
    endfor

    let max_items = reverse(sort(values(res)))
    let count_items = keys(res)
    if len(max_items) > 5
        call remove(max_items, 5, -1)
        call filter(res, 'v:val =~ ''^''.join(max_items, ''\|'').''$''')
    endif

    if has("float")
        let  title="Nr\tCount\t % \tValue"
    else
        let  title="Nr\tCount\tValue"
    endif
    echohl Title
    echo printf("%s", title)
    echohl Normal
    echo printf("%s", repeat('=', strdisplaywidth(title)))

    let i=1
    for val in max_items
        for key in keys(res)
            if res[key] == val && i <= len(max_items)
                if !empty(b:delimiter)
                    let k = substitute(key, b:delimiter . '\?$', '', '')
                else
                    let k = key
                endif
                if has("float")
                    echo printf("%02d\t%02d\t%2.0f%%\t%.50s", i, res[key],
                        \ ((res[key] + 0.0)/qty)*100, k)
                else
                    echo printf("%02d\t%02d\t%.50s", i, res[key], k)
                endif
                call remove(res,key)
                let i+=1
            else
                continue
            endif
        endfor
    endfor
    echo printf("%s", repeat('=', strdisplaywidth(title)))
    echo printf("different values: %d", len(count_items))
    unlet max_items
endfunc

fu! <sid>Vertfold(bang, col) "{{{3
    if a:bang
        do Syntax
        return
    endif
    if !has("conceal")
        call <sid>Warn("Concealing not supported in your Vim")
        return
    endif
    if empty(b:delimiter) && !exists("b:csv_fixed_width_cols")
        call <sid>Warn("There are no columns defined, can't hide away anything!")
        return
    endif
    if empty(a:col)
        let colnr=<SID>WColumn()
    else
        let colnr=a:col
    endif
    let pat=<sid>GetPat(colnr, <sid>MaxColumns(), '.*')
    if exists("b:csv_fixed_width_cols") &&
        \ pat !~ '^\^\.\*'
        " Make the pattern implicitly start at line start,
        " so it will be applied by syntax highlighting (:h :syn-priority)
        let pat='^.*' . pat
    endif
    let pat=substitute(pat, '\\zs\(\.\*\)\@=', '', '')
    if !empty(pat)
        exe "syn match CSVFold /" . pat . "/ conceal cchar=+"
    endif
endfu

fu! <sid>InitCSVFixedWidth() "{{{3
    if !exists("+cc")
        " TODO: make this work with a custom matchadd() command for older
        " Vims, that don't have 'colorcolumn'
        call <sid>Warn("'colorcolumn' option not available")
        return
    endif
    " Turn off syntax highlighting
    syn clear
    let max_len = len(split(getline(1), '\zs'))
    let _cc  = &l:cc
    let &l:cc = 1
    redraw!
    let Dict = {'1': 1} " first column is always the start of a new column
    let tcc  = &l:cc
    let &l:cc = 1
    echo "<Cursor>, <Space>, <ESC>, <BS>, <CR>..."
    let char=getchar()
    while 1
        if char == "\<Left>" || char == "\<Right>"
            let tcc = eval('tcc'.(char=="\<Left>" ? '-' : '+').'1')
            if tcc < 0
                let tcc=0
            elseif tcc > max_len
                let tcc = max_len
            endif
        elseif char == "\<Space>" || char == 32 " Space
            let Dict[tcc] = 1
        elseif char == "\<BS>" || char == 127
            try
                call remove(Dict, reverse(sort(keys(Dict)))[0])
            catch /^Vim\%((\a\+)\)\=:E\(\%(716\)\|\%(684\)\)/	" Dict or List empty
                break
            endtry
        elseif char == "\<ESC>" || char == 27
            let &l:cc=_cc
            redraw!
            return
        elseif char == "\<CR>" || char == "\n" || char == "\r"  " Enter
            let Dict[tcc] = 1
            break
        else
            break
        endif
        let &l:cc=tcc . (!empty(keys(Dict))? ',' . join(keys(Dict), ','):'')
        redraw!
        echo "<Cursor>, <Space>, <ESC>, <BS>, <CR>..."
        let char=getchar()
    endw
    let b:csv_fixed_width_cols=[]
    let tcc=0
    let b:csv_fixed_width_cols = sort(keys(Dict), "<sid>SortList")
    let b:csv_fixed_width = join(sort(keys(Dict), "<sid>SortList"), ',')
    call <sid>Init(1, line('$'))

    let &l:cc=_cc
    redraw!
endfu

fu! <sid>NewRecord(line1, line2, count) "{{{3
    if a:count =~ "\D"
        call <sid>WarningMsg("Invalid count specified")
        return
    endif

    let cnt = (empty(a:count) ? 1 : a:count)
    let record = ""
    for item in range(1,<sid>MaxColumns())
        if !exists("b:col_width")
            " Best guess width
            if exists("b:csv_fixed_width_cols")
                let record .= printf("%*s", <sid>ColWidth(item),
                            \ b:delimiter)
            else
                let record .= printf("%20s", b:delimiter)
            endif
        else
            let record .= printf("%*s", get(b:col_width, item-1, 0)+1, b:delimiter)
        endif
    endfor

    if getline(1)[-1:] !=  b:delimiter
        let record = record[0:-2] . " "
    endif

    let line = []
    for item in range(cnt)
        call add(line, record)
    endfor
    for nr in range(a:line1, a:line2)
        call append(nr, line)
    endfor
endfu

fu! <sid>MoveOver(outer) "{{{3
    " Move over a field
    " a:outer means include the delimiter
    let last = 0
    let outer_field = a:outer
    let cur_field = <sid>WColumn()
    let _wsv = winsaveview()

    if cur_field == <sid>MaxColumns()
        let last = 1
        if !outer_field && getline('.')[-1:] != b:delimiter
            " No trailing delimiter, so inner == outer
            let outer_field = 1
        endif
    endif
    " Move 1 column backwards, unless the cursor is in the first column
    " or in front of a delimiter
    if matchstr(getline('.'), '.\%'.virtcol('.').'v') != b:delimiter && virtcol('.') > 1
        call <sid>MoveCol(-1, line('.'))
    endif
"    if cur_field != <sid>WColumn()
        " cursor was at the beginning of the field, and moved back to the
        " previous field, move back to original position
"        call cursor(_wsv.lnum, _wsv.col)
"    endif
    let _s = @/
    if last
        exe "sil! norm! v$h" . (outer_field ? "" : "h") . (&sel ==# 'exclusive' ? "l" : '')
    else
        exe "sil! norm! v/." . b:col . "\<cr>h" . (outer_field ? "" : "h") . (&sel ==# 'exclusive' ? "l" : '')
    endif
    let _wsv.col = col('.')-1
    call winrestview(_wsv)
    let @/ = _s
endfu

fu! <sid>CSVMappings() "{{{3
    call <sid>Map('noremap', 'W', ':<C-U>call <SID>MoveCol(1, line("."))<CR>')
    call <sid>Map('noremap', '<C-Right>', ':<C-U>call <SID>MoveCol(1, line("."))<CR>')
    call <sid>Map('noremap', 'L', ':<C-U>call <SID>MoveCol(1, line("."))<CR>')
    call <sid>Map('noremap', 'E', ':<C-U>call <SID>MoveCol(-1, line("."))<CR>')
    call <sid>Map('noremap', '<C-Left>', ':<C-U>call <SID>MoveCol(-1, line("."))<CR>')
    call <sid>Map('noremap', 'H', ':<C-U>call <SID>MoveCol(-1, line("."), 1)<CR>')
    call <sid>Map('noremap', 'K', ':<C-U>call <SID>MoveCol(0,
        \ line(".")-v:count1)<CR>')
    call <sid>Map('noremap', '<Up>', ':<C-U>call <SID>MoveCol(0,
        \ line(".")-v:count1)<CR>')
    call <sid>Map('noremap', 'J', ':<C-U>call <SID>MoveCol(0,
        \ line(".")+v:count1)<CR>')
    call <sid>Map('noremap', '<Down>', ':<C-U>call <SID>MoveCol(0,
        \ line(".")+v:count1)<CR>')
    call <sid>Map('nnoremap', '<CR>', ':<C-U>call <SID>PrepareFolding(1,
        \ 1)<CR>')
    call <sid>Map('nnoremap', '<Space>', ':<C-U>call <SID>PrepareFolding(1,
        \ 0)<CR>')
    call <sid>Map('nnoremap', '<BS>', ':<C-U>call <SID>PrepareFolding(0,
        \ 1)<CR>')
    call <sid>Map('imap', '<CR>', '<sid>ColumnMode()', 'expr')
    " Text object: Field
    call <sid>Map('vnoremap', 'if', ':<C-U>call <sid>MoveOver(0)<CR>')
    call <sid>Map('vnoremap', 'af', ':<C-U>call <sid>MoveOver(1)<CR>')
    call <sid>Map('omap', 'af', ':norm vaf<cr>')
    call <sid>Map('omap', 'if', ':norm vif<cr>')
    " Remap <CR> original values to a sane backup
    call <sid>Map('noremap', '<LocalLeader>J', 'J')
    call <sid>Map('noremap', '<LocalLeader>K', 'K')
    call <sid>Map('vnoremap', '<LocalLeader>W', 'W')
    call <sid>Map('vnoremap', '<LocalLeader>E', 'E')
    call <sid>Map('noremap', '<LocalLeader>H', 'H')
    call <sid>Map('noremap', '<LocalLeader>L', 'L')
    call <sid>Map('nnoremap', '<LocalLeader><CR>', '<CR>')
    call <sid>Map('nnoremap', '<LocalLeader><Space>', '<Space>')
    call <sid>Map('nnoremap', '<LocalLeader><BS>', '<BS>')
endfu

fu! <sid>CommandDefinitions() "{{{3
    call <sid>LocalCmd("WhatColumn", ':echo <sid>WColumn(<bang>0)',
        \ '-bang')
    call <sid>LocalCmd("NrColumns", ':call <sid>NrColumns(<q-bang>)', '-bang')
    call <sid>LocalCmd("HiColumn", ':call <sid>HiCol(<q-args>,<bang>0)',
        \ '-bang -nargs=?')
    call <sid>LocalCmd("SearchInColumn",
        \ ':call <sid>SearchColumn(<q-args>)', '-nargs=*')
    call <sid>LocalCmd("DeleteColumn", ':call <sid>DeleteColumn(<q-args>)',
        \ '-nargs=? -complete=custom,<sid>SortComplete')
    call <sid>LocalCmd("ArrangeColumn",
        \ ':call <sid>ArrangeCol(<line1>, <line2>, <bang>0)',
        \ '-range -bang')
    call <sid>LocalCmd("UnArrangeColumn",
        \':call <sid>PrepUnArrangeCol(<line1>, <line2>)',
        \ '-range')
    call <sid>LocalCmd("InitCSV", ':call <sid>Init(<line1>,<line2>)', '-range=%')
    call <sid>LocalCmd('Header',
        \ ':call <sid>SplitHeaderLine(<q-args>,<bang>0,1)',
        \ '-nargs=? -bang')
    call <sid>LocalCmd('VHeader',
        \ ':call <sid>SplitHeaderLine(<q-args>,<bang>0,0)',
        \ '-nargs=? -bang')
    call <sid>LocalCmd("HeaderToggle",
        \ ':call <sid>SplitHeaderToggle(1)', '')
    call <sid>LocalCmd("VHeaderToggle",
        \ ':call <sid>SplitHeaderToggle(0)', '')
    call <sid>LocalCmd("Sort",
        \ ':call <sid>Sort(<bang>0, <line1>,<line2>,<q-args>)',
        \ '-nargs=* -bang -range=% -complete=custom,<sid>SortComplete')
    call <sid>LocalCmd("Column",
        \ ':call <sid>CopyCol(empty(<q-reg>)?''"'':<q-reg>,<q-count>,<q-args>)',
        \ '-count -register -nargs=?')
    call <sid>LocalCmd("MoveColumn",
        \ ':call <sid>MoveColumn(<line1>,<line2>,<f-args>)',
        \ '-range=% -nargs=* -complete=custom,<sid>SortComplete')
    call <sid>LocalCmd("SumCol",
        \ ':echo csv#EvalColumn(<q-args>, "<sid>SumColumn", <line1>,<line2>)',
        \ '-nargs=? -range=% -complete=custom,<sid>SortComplete')
    call <sid>LocalCmd("ConvertData",
        \ ':call <sid>PrepareDoForEachColumn(<line1>,<line2>,<bang>0)',
        \ '-bang -nargs=? -range=%')
    call <sid>LocalCmd("Filters", ':call <sid>OutputFilters(<bang>0)',
        \ '-nargs=0 -bang')
    call <sid>LocalCmd("Analyze", ':call <sid>AnalyzeColumn(<args>)',
        \ '-nargs=?')
    call <sid>LocalCmd("VertFold", ':call <sid>Vertfold(<bang>0,<q-args>)',
        \ '-bang -nargs=? -range=% -complete=custom,<sid>SortComplete')
    call <sid>LocalCmd("CSVFixed", ':call <sid>InitCSVFixedWidth()', '')
    call <sid>LocalCmd("NewRecord", ':call <sid>NewRecord(<line1>,
        \ <line2>, <q-args>)', '-nargs=? -range')
    call <sid>LocalCmd("NewDelimiter", ':call <sid>NewDelimiter(<q-args>)',
        \ '-nargs=1')
    call <sid>LocalCmd("Duplicates", ':call <sid>CheckDuplicates(<q-args>)',
        \ '-nargs=1 -complete=custom,<sid>CompleteColumnNr')
    call <sid>LocalCmd('Transpose', ':call <sid>Transpose(<line1>, <line2>)',
        \ '-range=%')
    call <sid>LocalCmd('Tabularize', ':call <sid>Tabularize(<bang>0,<line1>,<line2>)',
        \ '-bang -range=%')
    " Alias for :Tabularize, might be taken by Tabular plugin
    call <sid>LocalCmd('CSVTabularize', ':call <sid>Tabularize(<bang>0,<line1>,<line2>)',
        \ '-bang -range=%')
    call <sid>LocalCmd("AddColumn",
        \ ':call <sid>AddColumn(<line1>,<line2>,<f-args>)',
        \ '-range=% -nargs=* -complete=custom,<sid>SortComplete')
    call <sid>LocalCmd('Substitute', ':call <sid>SubstituteInColumn(<q-args>,<line1>,<line2>)',
        \ '-nargs=1 -range=%')
endfu

fu! <sid>Map(map, name, definition, ...) "{{{3
    let keyname = substitute(a:name, '[<>]', '', 'g')
    let expr = (exists("a:1") && a:1 == 'expr'  ? '<expr>' : '')
    if !get(g:, "csv_nomap_". tolower(keyname), 0)
        " All mappings are buffer local
        exe a:map "<buffer> <silent>". expr a:name a:definition
        " should already exists
        if a:map == 'nnoremap'
            let unmap = 'nunmap'
        elseif a:map == 'noremap' || a:map == 'map'
            let unmap = 'unmap'
        elseif a:map == 'vnoremap'
            let unmap = 'vunmap'
        elseif a:map == 'omap'
            let unmap = 'ounmap'
        elseif a:map == 'imap'
            let unmap = 'iunmap'
        endif
        let b:undo_ftplugin .= "| " . unmap . " <buffer> " . a:name
    endif
endfu

fu! <sid>LocalCmd(name, definition, args) "{{{3
    if !exists(':'.a:name)
        exe "com! -buffer " a:args a:name a:definition
        let b:undo_ftplugin .= "| sil! delc " . a:name
    endif
    " Setup :CSV<Command> Aliases
    if a:name !~ '^CSV'
        call <sid>LocalCmd('CSV'.a:name, a:definition, a:args)
    endif
endfu

fu! <sid>Menu(enable) "{{{3
    if a:enable
        " Make a menu for the graphical vim
        amenu CSV.&Init\ Plugin             :InitCSV<cr>
        amenu CSV.SetUp\ &fixedwidth\ Cols  :CSVFixed<cr>
        amenu CSV.-sep1-                    <nul>
        amenu &CSV.&Column.&Number          :WhatColumn<cr>
        amenu CSV.Column.N&ame              :WhatColumn!<cr>
        amenu CSV.Column.&Highlight\ column :HiColumn<cr>
        amenu CSV.Column.&Remove\ highlight :HiColumn!<cr>
        amenu CSV.Column.&Delete            :DeleteColumn<cr>
        amenu CSV.Column.&Sort              :%Sort<cr>
        amenu CSV.Column.&Copy              :Column<cr>
        amenu CSV.Column.&Move              :%MoveColumn<cr>
        amenu CSV.Column.S&um               :%SumCol<cr>
        amenu CSV.Column.Analy&ze           :Analyze<cr>
        amenu CSV.Column.&Arrange           :%ArrangeCol<cr>
        amenu CSV.Column.&UnArrange         :%UnArrangeCol<cr>
        amenu CSV.Column.&Add               :%AddColumn<cr>
        amenu CSV.-sep2-                    <nul>
        amenu CSV.&Toggle\ Header           :HeaderToggle<cr>
        amenu CSV.&ConvertData              :ConvertData<cr>
        amenu CSV.Filters                   :Filters<cr>
        amenu CSV.Hide\ C&olumn             :VertFold<cr>
        amenu CSV.&New\ Record              :NewRecord<cr>
    else
        " just in case the Menu wasn't defined properly
        sil! amenu disable CSV
    endif
endfu

fu! <sid>SaveOptions(list) "{{{3
    let save = {}
    for item in a:list
        exe "let save.". item. " = &l:". item
    endfor
    return save
endfu

fu! <sid>NewDelimiter(newdelimiter) "{{{3
    let save = <sid>SaveOptions(['ro', 'ma'])
    if exists("b:csv_fixed_width_cols")
        call <sid>Warn("NewDelimiter does not work with fixed width column!")
        return
    endif
    if !&l:ma
        setl ma
    endif
    if &l:ro
        setl noro
    endif
    let line=1
    while line <= line('$')
        " Don't change delimiter for comments
        if getline(line) =~ '^\s*\V'. escape(b:csv_cmt[0], '\\')
            let line+=1
            continue
        endif
        let fields=split(getline(line), b:col . '\zs')
        " Remove field delimiter
        call map(fields, 'substitute(v:val, b:delimiter .
            \ ''\?$'' , "", "")')
        call setline(line, join(fields, a:newdelimiter))
        let line+=1
    endwhile
    " reset local buffer options
    for [key, value] in items(save)
        call setbufvar('', '&'. key, value)
    endfor
    "reinitialize the plugin
    call <sid>Init(1,line('$'))
endfu

fu! <sid>IN(list, value) "{{{3
    for item in a:list
        if item == a:value
            return 1
        endif
    endfor
    return 0
endfu

fu! <sid>DuplicateRows(columnlist) "{{{3
    let duplicates = {}
    let cnt   = 0
    let line  = 1
    while line <= line('$')
        let key = ""
        let i = 1
        let content = getline(line)
        " Skip comments
        if content =~ '^\s*\V'. escape(b:csv_cmt[0], '\\')
            continue
        endif
        let cols = split(content, b:col. '\zs')
        for column in cols
            if <sid>IN(a:columnlist, i)
                let key .= column
            endif
            let i += 1
        endfor
        if has_key(duplicates, key) && cnt < 10
            call <sid>Warn("Duplicate Row ". line)
            let cnt += 1
        elseif has_key(duplicates, key)
            call <sid>Warn("More duplicate Rows after: ". line)
            call <sid>Warn("Aborting...")
            return
        else
            let duplicates[key] = 1
        endif
        let line += 1
    endwhile
    if cnt == 0
        call <sid>Warn("No Duplicate Row found!")
    endif
endfu
fu! <sid>CompleteColumnNr(A,L,P) "{{{3
    return join(range(1,<sid>MaxColumns()), "\n")
endfu

fu! <sid>CheckDuplicates(list) "{{{3
    let string = a:list
    if string =~ '\d\s\?-\s\?\d'
        let string = substitute(string, '\(\d\+\)\s\?-\s\?\(\d\+\)',
            \ '\=join(range(submatch(1),submatch(2)), ",")', '')
    endif
    let list=split(string, ',')
    call <sid>DuplicateRows(list)
endfu

fu! <sid>Transpose(line1, line2) "{{{3
    " Note: - Comments will be deleted.
    "       - Does not work with fixed-width columns
    if exists("b:csv_fixed_width")
        call <sid>Warn("Transposing does not work with fixed-width columns!")
        return
    endif
    let _wsv    = winsaveview()
    let TrailingDelim = 0

    if line('$') > 1
        let TrailingDelim = getline(1) =~ b:delimiter.'$'
    endif

    let pat = '^\s*\V'. escape(b:csv_cmt[0], '\\')

    try
        let columns = <sid>MaxColumns(a:line1)
    catch
        " No column, probably because of comment or empty line
        " so use the number of columns from the beginning of the file
        let columns = <sid>MaxColumns()
    endtry
    let matrix  = []
    for line in range(a:line1, a:line2)
        " Filter comments out
        if getline(line) =~ pat
            continue
        endif
        let r   = []
        for row in range(1,columns)
            let field = <sid>GetColumn(line, row)
            call add(r, field)
        endfor
        call add(matrix, r)
    endfor
    unlet row

    " create new transposed matrix
    let transposed = []
    for row in matrix
        let i = 0
        for val in row
            if get(transposed, i, []) == []
                call add(transposed, [])
            endif
            if val[-1:] != b:delimiter
                let val .= b:delimiter
            endif
            call add(transposed[i], val)
            let i+=1
        endfor
    endfor
    " Save memory
    unlet! matrix
    call map(transposed, 'join(v:val, '''')')
    if !TrailingDelim
        call map(transposed, 'substitute(v:val, b:delimiter.''\?$'', "", "")')
    endif
    " filter out empty records
    call filter(transposed, 'v:val != b:delimiter')

    " Insert transposed data
    let delete_last_line = 0
    if a:line1 == 1 && a:line2 == line('$')
        let delete_last_line = 1
    endif
    exe a:line1. ",". a:line2. "d _"
    let first = (a:line1 > 0 ? (a:line1 - 1) : 0)
    call append(first, transposed)
    if delete_last_line
        sil $d _
    endif
    " save memory
    unlet! transposed
    call winrestview(_wsv)
endfu


fu! <sid>NrColumns(bang) "{{{3
    if !empty(a:bang)
        try
            let cols = <sid>MaxColumns(line('.'))
        catch
            " No column or comment line
            call <sid>Warn("No valid CSV Column!")
        endtry
    else
        let cols = <sid>MaxColumns()
    endif
    echo cols
endfu

fu! <sid>Tabularize(bang, first, last) "{{{3
    let _c = winsaveview()
    " Table delimiter definition "{{{4
    if !exists("s:td")
        let s:td = {
            \ 'hbar': (&enc =~# 'utf-8' ? '─' : '-'),
            \ 'vbar': (&enc =~# 'utf-8' ? '│' : '|'),
            \ 'scol': (&enc =~# 'utf-8' ? '├' : '|'),
            \ 'ecol': (&enc =~# 'utf-8' ? '┤' : '|'),
            \ 'ltop': (&enc =~# 'utf-8' ? '┌' : '+'),
            \ 'rtop': (&enc =~# 'utf-8' ? '┐' : '+'),
            \ 'lbot': (&enc =~# 'utf-8' ? '└' : '+'),
            \ 'rbot': (&enc =~# 'utf-8' ? '┘' : '+'),
            \ 'cros': (&enc =~# 'utf-8' ? '┼' : '+'),
            \ 'dhor': (&enc =~# 'utf-8' ? '┬' : '-'),
            \ 'uhor': (&enc =~# 'utf-8' ? '┴' : '-')
            \ }
    endif "}}}4
    if match(getline(a:first), '^'.s:td.ltop) > -1
        " Already tabularized, done
        call <sid>Warn("Looks already Tabularized, aborting!")
        return
    endif
    let _ma = &l:ma
    setl ma
    let colwidth = 0
    let adjust_last = 0
    call cursor(a:first,0)
    call <sid>CheckHeaderLine()
    if exists("b:csv_fixed_width_cols")
        let cols=copy(b:csv_fixed_width_cols)
        let pat = join(map(cols, ' ''\(\%''. v:val. ''c\)'' '), '\|')
        let colwidth = strlen(substitute(getline('$'), '.', 'x', 'g'))
        let t=-1
        let b:col_width = []
        for item in b:csv_fixed_width_cols + [colwidth]
            if t > -1
                call add(b:col_width, item-t)
            endif
            let t = item
        endfor
    else
        " don't clear column width variable, might have been set in the
        " plugin!
        sil call <sid>ArrangeCol(a:first, a:last, 0)
    endif

    if empty(b:col_width)
        call <sid>Warn('An error occured, aborting!')
        return
    endif
    let b:col_width[-1] += 1
    let marginline = s:td.scol. join(map(copy(b:col_width), 'repeat(s:td.hbar, v:val)'), s:td.cros). s:td.ecol

    exe printf('sil %d,%ds/%s/%s/ge', a:first, (a:last+adjust_last),
        \ (exists("b:csv_fixed_width_cols") ? pat : b:delimiter ), s:td.vbar)
    " Add vertical bar in first column, if there isn't already one
    exe printf('sil %d,%ds/%s/%s/e', a:first, a:last+adjust_last,
        \ '^[^'. s:td.vbar. s:td.scol. ']', s:td.vbar.'&')
    " And add a final vertical bar, if there isn't already
    exe printf('sil %d,%ds/%s/%s/e', a:first, a:last+adjust_last,
        \ '[^'. s:td.vbar. s:td.ecol. ']$', '&'. s:td.vbar)
    " Make nice intersection graphs
    let line = split(getline(a:first), s:td.vbar)
    call map(line, 'substitute(v:val, ''[^''.s:td.vbar. '']'', s:td.hbar, ''g'')')
    " Set top and bottom margins
    call append(a:first-1, s:td.ltop. join(line, s:td.dhor). s:td.rtop)
    call append(a:last+adjust_last+1, s:td.lbot. join(line, s:td.uhor). s:td.rbot)

    if s:csv_fold_headerline > 0 && !a:bang
        "call <sid>NewRecord(s:csv_fold_headerline, s:csv_fold_headerline, 1)
        call append(a:first + s:csv_fold_headerline, marginline)
        let adjust_last += 1
    endif

    if a:bang
        exe printf('sil %d,%ds/^%s\zs\n/&%s&/e', a:first + s:csv_fold_headerline, a:last + adjust_last,
                    \ '[^'.s:td.scol. '][^'.s:td.hbar.'].*', marginline)
    endif

    syn clear
    let &l:ma = _ma
    call winrestview(_c)
endfu

fu! <sid>SubstituteInColumn(command, line1, line2) range "{{{3
    " Command can be something like 1,2/foobar/foobaz/ to replace in 1 and second column
    " Command can be something like /foobar/foobaz/ to replace in the current column
    " Command can be something like 1,$/foobar/foobaz/ to replace in all columns
    " Command can be something like 3/foobar/foobaz/flags to replace only in the 3rd column

    " Save position and search register
    let _wsv = winsaveview()
    let _search = [ '/', getreg('/'), getregtype('/')]
    let columns = []
    let maxcolnr = <sid>MaxColumns()
    let simple_s_command = 0 " when set to 1, we can simply use an :s command

    " try to split on '/' if it is not escaped or in a collection
    let cmd = split(a:command, '\%([\\]\|\[[^]]*\)\@<!/')
    if a:command !~? '^\%([$]\|\%(\d\+\)\%(,\%([0-9]\+\|[$]\)\)\?\)/' ||
                \ len(cmd) == 2 ||
                \ ((len(cmd) == 3 && cmd[2] =~# '^[&cgeiInp#l]\+$'))
        " No Column address given
        call add(columns, <sid>WColumn())
        let cmd = [columns[0]] + cmd "First item of cmd list contains address!
    elseif ((len(cmd) == 3 && cmd[2] !~# '^[&cgeiInp#l]\+$')
    \ || len(cmd) == 4)
        " command could be '1/foobbar/foobaz'
        " but also 'foobar/foobar/g'
        let columns = split(cmd[0], ',')
        if empty(columns)
            " No columns given? replace in current column only
            let columns[0] = <sid>WColumn()
        elseif columns[-1] == '$'
            let columns[-1] = maxcolnr
        endif
    else " not reached ?
        call add(columns, <sid>WColumn())
    endif

    try
        if len(cmd) == 1 || columns[0] =~ '\D' || (len(columns) == 2 && columns[1] =~ '\D')
            call <SID>Warn("Error! Usage :S [columns/]pattern/replace[/flags]")
            return
        endif

        if len(columns) == 2 && columns[0] == 1 && columns[1] == maxcolnr
            let simple_s_command = 1
        elseif len(columns) == 2
            let columns = range(columns[0], columns[1])
        endif

        let has_flags = len(cmd) == 4

        if simple_s_command
            while search(cmd[1])
                exe printf("%d,%ds/%s/%s%s", a:line1, a:line2, cmd[1], cmd[2], (has_flags ? '/'. cmd[3] : ''))
                if !has_flags || (has_flags && cmd[3] !~# 'g')
                    break
                endif
            endw
        else
            for colnr in columns
                let @/ = <sid>GetPat(colnr, maxcolnr, cmd[1])
                while search(@/)
                    exe printf("%d,%ds//%s%s", a:line1, a:line2, cmd[2], (has_flags ? '/'. cmd[3] : ''))
                    if !has_flags || (has_flags && cmd[3] !~# 'g')
                        break
                    endif
                endw
            endfor
        endif
    catch /^Vim\%((\a\+)\)\=:E486/
        " Pattern not found
        echohl Error
        echomsg "E486: Pattern not found in column " . colnr . ": " . pat
        if &vbs > 0
            echomsg substitute(v:exception, '^[^:]*:', '','')
        endif
        echohl Normal
    catch
        echohl Error
        "if &vbs > 0
            echomsg substitute(v:exception, '^[^:]*:', '','')
        "endif
        echohl Normal
    finally
        " Restore position and search register
        call winrestview(_wsv)
        call call('setreg', _search)
    endtry
endfu

fu! <sid>ColumnMode() "{{{3
    let mode = mode()
    if mode =~# 'R'
        " (virtual) Replace mode
        let new_line = (line('.') == line('$') ||
        \ (synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name") =~? "comment"))
        return "\<ESC>g`[". (new_line ? "o" : "J".mode)
    else
        return "\<CR>"
    endif
endfu

" Global functions "{{{2
fu! csv#EvalColumn(nr, func, first, last) range "{{{3
    " Make sure, the function is called for the correct filetype.
    if match(split(&ft, '\.'), 'csv') == -1
        call <sid>Warn("File is no CSV file!")
        return
    endif
    let save = winsaveview()
    call <sid>CheckHeaderLine()
    let nr = matchstr(a:nr, '^\-\?\d\+')
    let col = (empty(nr) ? <sid>WColumn() : nr)
    " don't take the header line into consideration
    let start = a:first - 1 + s:csv_fold_headerline
    let stop  = a:last  - 1 + s:csv_fold_headerline

    let column = <sid>CopyCol('', col, '')[start : stop]
    " Delete delimiter
    call map(column, 'substitute(v:val, b:delimiter . "$", "", "g")')
    " Revmoe trailing whitespace
    call map(column, 'substitute(v:val, ''^\s\+$'', "", "g")')
    " Remove leading whitespace
    call map(column, 'substitute(v:val, ''^\s\+'', "", "g")')
    " Delete empty values
    " Leave this up to the function that does something
    " with each value
    "call filter(column, '!empty(v:val)')

    " parse the optional number format
    let format = matchstr(a:nr, '/[^/]*/')
    call <sid>NumberFormat()
    if !empty(format)
        try
            let s = []
            " parse the optional number format
            let str = matchstr(format, '/\zs[^/]*\ze/', 0, start)
            let s = matchlist(str, '\(.\)\?:\(.\)\?')[1:2]
            if empty(s)
                " Number format wrong
                call <sid>Warn("Numberformat wrong, needs to be /x:y/!")
                return ''
            endif
            if !empty(s[0])
                let s:nr_format[0] = s[0]
            endif
            if !empty(s[1])
                let s:nr_format[1] = s[1]
            endif
        endtry
    endif
    try
        let result=call(function(a:func), [column])
        return result
    catch
        " Evaluation of expression failed
        echohl Title
        echomsg "Evaluating" matchstr(a:func, '[a-zA-Z]\+$')
        \ "failed for column" col . "!"
        echohl Normal
        return ''
    finally
        call winrestview(save)
    endtry
endfu

" return field index (x,y) with leading/trailing whitespace and trailing
" delimiter stripped (only when a:0 is not given)
fu! CSVField(x, y, ...) "{{{3
    if &ft != 'csv'
        return
    endif
    let y = a:y - 1
    let x = (a:x < 0 ? 0 : a:x)
    let orig = !empty(a:0)
    let y = (y < 0 ? 0 : y)
    let x = (x > (<sid>MaxColumns()) ? (<sid>MaxColumns()) : x)
    let col = <sid>CopyCol('',x,'')
    if !orig
    " remove leading and trainling whitespace and the delimiter
        return matchstr(col[y], '^\s*\zs.\{-}\ze\s*'.b:delimiter.'\?$')
    else
        return col[y]
    endif
endfu
" return current column number (if a:0 is given, returns the name
fu! CSVCol(...) "{{{3
    return <sid>WColumn(a:0)
endfu
fu! CSVPat(colnr, ...) "{{{3
    " Make sure, we are working in a csv file
    if &ft != 'csv'
        return ''
    endif
    " encapsulates GetPat(), that returns the search pattern for a
    " given column and tries to set the cursor at the specific position
    let pat = <sid>GetPat(a:colnr, <SID>MaxColumns(), a:0 ? a:1 : '.*')
    "let pos = match(pat, '.*\\ze') + 1
    " Try to set the cursor at the beginning of the pattern
    " does not work
    "call setcmdpos(pos)
    return pat
endfu

fu! CSV_WCol(...) "{{{3
    try
        if exists("a:1") && (a:1 == 'Name' || a:1 == 1)
            return printf("%s", <sid>WColumn(1))
        else
            return printf(" %d/%d", <SID>WColumn(), <SID>MaxColumns())
        endif
    catch
        return ''
    endtry
endfun

fu! CSV_CloseBuffer(buffer) "{{{3
    " Setup by SetupQuitPre autocommand
    try
        if bufnr((a:buffer)+0) > -1
            exe a:buffer. "bw"
        endif
    catch /^Vim\%((\a\+)\)\=:E517/	" buffer already wiped
    " no-op
    finally
        augroup CSV_QuitPre
            au!
        augroup END
        augroup! CSV_QuitPre
    endtry
endfu
        

" Initialize Plugin "{{{2
let b:csv_start = exists("b:csv_start") ? b:csv_start : 1
let b:csv_end   = exists("b:csv_end") ? b:csv_end : line('$')

call <SID>Init(b:csv_start, b:csv_end)
let &cpo = s:cpo_save
unlet s:cpo_save

" Vim Modeline " {{{2
" vim: set foldmethod=marker et:
