if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'csv') == -1

" Filetype plugin for editing CSV files. "{{{1
" Author:  Christian Brabandt <cb@256bit.org>
" Version: 0.31
" Script:  http://www.vim.org/scripts/script.php?script_id=2830
" License: VIM License
" Last Change: Thu, 15 Jan 2015 21:05:10 +0100
" Documentation: see :help ft-csv.txt
" GetLatestVimScriptcsv# 2830 30 :AutoInstall: csv.vim
"
" Some ideas are taken from the wiki http://vim.wikia.com/wiki/VimTip667
" though, implementation differs.

let s:csv_numeric_sort = v:version > 704 || v:version == 704 && has("patch341")
if !s:csv_numeric_sort "{{{2
  fu! csv#CSVSortValues(i1, i2) "{{{3
    return (a:i1+0) == (a:i2+0) ? 0 : (a:i1+0) > (a:i2+0) ? 1 : -1
  endfu
endif
" Function definitioncsv# "{{{1
fu! csv#CSVArrangeCol(first, last, bang, limit) range "{{{2
    " call csv#ArrangeCol(a:first, a:last, a:bang, a:limit)
    " if &ft !~? 'csv'
    if !exists("b:csv_cmt")
        let b:csv_start = get(g:, 'csv_start', 1)
        let b:csv_end   = get(g:, 'csv_end', line('$'))
        let b:csv_result = ''
        call csv#Init(b:csv_start, b:csv_end)
    endif
    call csv#ArrangeCol(a:first, a:last, a:bang, a:limit)
endfu

" Script specific functions "{{{2
fu! csv#Warn(mess) "{{{3
    echohl WarningMsg
    echomsg "CSV: " . a:mess
    echohl Normal
endfu

fu! csv#Init(start, end, ...) "{{{3
    " if a:1 is set, keep the b:delimiter
    let keep = exists("a:1") && a:1
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
    if !keep
        if !exists("g:csv_delim")
            let b:delimiter=csv#GetDelimiter(a:start, a:end, get(g:, 'csv_delim_test', ''))
        else
            let b:delimiter=g:csv_delim
        endif
    endif

    " Define custom commentstring
    if !exists("g:csv_comment")
        let b:csv_cmt = split(&cms, '%s')
    else
        let b:csv_cmt = split(g:csv_comment, '%s')
    endif

    if empty(b:delimiter) && !exists("b:csv_fixed_width")
        call csv#Warn("No delimiter found. See :h csv-delimiter to set it manually!")
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
                \ '[^"]\|""\)*"\s*\)' . s:del . '\)\|\%(' .
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
            call csv#Warn("Please specify the list of character columns" .
                \ "like thicsv# '1,3,5'. See also :h csv-fixedwidth")
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

    " Enable vartabs for tab delimited files
    if b:delimiter=="\t" && has("vartabs")&& !exists("b:csv_fixed_width_cols")
        if get(b:, 'col_width', []) ==# []
            call csv#CalculateColumnWidth('')
        endif
        let &l:vts=join(b:col_width, ',')
        let g:csv_no_conceal=1
    endif

    " set filetype specific options
    call csv#LocalSettings('all')

    " define buffer-local commands
    call csv#CommandDefinitions()

    " Check Header line
    " Defines which line is considered to be a header line
    call csv#CheckHeaderLine()

    " CSV specific mappings
    call csv#CSVMappings()

    " force reloading CSV Syntax Highlighting
    if exists("b:current_syntax")
        unlet b:current_syntax
        " Force reloading syntax file
    endif
    call csv#DoAutoCommands()
    " enable CSV Menu
    call csv#Menu(1)
    call csv#DisableFolding()
    if !exists("b:current_syntax")
      silent do Syntax
    endif
    unlet! b:csv_start b:csv_end

    " Remove configuration variables
    let b:undo_ftplugin .=  "| unlet! b:delimiter b:col"
        \ . "| unlet! b:csv_fixed_width_cols b:csv_filter"
        \ . "| unlet! b:csv_fixed_width b:csv_list b:col_width"
        \ . "| unlet! b:csv_SplitWindow b:csv_headerline b:csv_cmt"
        \ . "| unlet! b:csv_thousands_sep b:csv_decimal_sep"
        \. " | unlet! b:browsefilter b:csv_cmt"
        \. " | unlet! b:csv_arrange_leftalign"

 " Delete all functions
 " disabled currently, because otherwise when switching ft
 "          I think, all functions need to be read in again and this
 "          costs time.
endfu

fu! csv#LocalSettings(type) "{{{3
    if a:type == 'all'
        " CSV local settings
        setl nostartofline tw=0 nowrap

        " undo when setting a new filetype
        let b:undo_ftplugin = "setlocal sol& tw< wrap<"

        " Set browsefilter
        let b:browsefilter="CSV Files (*.csv, *.dat)\t*.csv;*.dat\n".
                 \ "All Files\t*.*\n"

        if !get(g:, 'csv_no_conceal', 0) && has("conceal")
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

fu! csv#DoAutoCommands() "{{{3
    " Highlight column, on which the cursor is
    if exists("g:csv_highlight_column") && g:csv_highlight_column =~? 'y'
        exe "aug CSV_HI".bufnr('')
            au!
            exe "au CursorMoved <buffer=".bufnr('')."> HiColumn"
            exe "au BufWinLeave <buffer=".bufnr('')."> sil! HiColumn!"
        aug end
        " Set highlighting for column, on which the cursor is currently
        HiColumn
    else
        exe "aug CSV_HI".bufnr('')
            exe "au! CursorMoved <buffer=".bufnr('').">"
        aug end
        exe "aug! CSV_HI".bufnr('')
        " Remove any existing highlighting
        HiColumn!
    endif
    " undo autocommand:
    let b:undo_ftplugin .= '| exe "sil! au! CSV_HI'.bufnr('').' CursorMoved <buffer> "'
    let b:undo_ftplugin .= '| exe "sil! aug! CSV_HI'.bufnr('').'"'
    let b:undo_ftplugin = 'exe "sil! HiColumn!" |' . b:undo_ftplugin

    if has("gui_running") && !exists("#CSV_Menu#FileType")
        augroup CSV_Menu
            au!
            au FileType * call csv#Menu(&ft=='csv')
            au BufEnter <buffer> call csv#Menu(1) " enable
            au BufLeave <buffer> call csv#Menu(0) " disable
            au BufNewFile,BufNew * call csv#Menu(0)
        augroup END
    endif
endfu
fu! csv#GetPat(colnr, maxcolnr, pat, allowmore) "{{{3
    " if a:allowmmore, allows more to match after the pattern
    if a:colnr > 1 && a:colnr < a:maxcolnr
        if !exists("b:csv_fixed_width_cols")
            return '^' . csv#GetColPat(a:colnr-1,0) . '\%([^' .
                \ b:delimiter . ']\{-}\)\?\zs' . a:pat . '\ze' .
                \ (a:allowmore ? ('\%([^' . b:delimiter .']\{-}\)\?' .
                \ b:delimiter . csv#GetColPat(a:maxcolnr - a:colnr, 0). '$') : '')
        else
            return '\%' . b:csv_fixed_width_cols[(a:colnr - 1)] . 'c\zs'
                \ . a:pat . '.\{-}\ze\%'
                \ . (b:csv_fixed_width_cols[a:colnr]) . 'c\ze'
        endif
    elseif a:colnr == a:maxcolnr
        if !exists("b:csv_fixed_width_cols")
            " Allow space in front of the pattern, so that it works correctly
            " even if :Arrange Col has been used #100
            return '^' . csv#GetColPat(a:colnr - 1,0) .
                \ '\s*\zs' . a:pat . '\ze' . (a:allowmore ? '' : '$')
        else
            return '\%' . b:csv_fixed_width_cols[-1] .
                \ 'c\zs' . a:pat . '\ze' . (a:allowmore ? '' : '$')
        endif
    else " colnr = 1
        if !exists("b:csv_fixed_width_cols")
            return '^' . '\%([^' . b:delimiter . ']\{-}\)\?\zs' . a:pat .
            \ (a:allowmore ? ('\ze\%([^' . b:delimiter . ']*\)\?' . b:delimiter .
            \ csv#GetColPat(a:maxcolnr -1 , 0) . '$') : '')
        else
            return a:pat . '\ze.\{-}\%' . b:csv_fixed_width_cols[1] . 'c'
        endif
    endif
    return ''
endfu
fu! csv#SearchColumn(arg) "{{{3
    try
        let arglist=split(a:arg)
        if len(arglist) == 1
            let colnr=csv#WColumn()
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
                let colnr = csv#WColumn()
            else
                " if the first word tells us the number of the column,
                " treat the rest of the argument as the pattern.
                let pat = substitute(a:arg,
                    \ '^\s*\d\+\s*\(\S\)\(.*\)\1\s*$', '\2', '' )
                if pat == a:arg
                    throw "E684"
                endif
            endif
        endif
    "catch /^Vim\%((\a\+)\)\=:E684/
    catch /E684/	" catch error index out of bounds
        call csv#Warn("Error! Usage :SearchInColumn [<colnr>] /pattern/")
        return 1
    endtry
    let maxcolnr = csv#MaxColumns()
    if colnr > maxcolnr
        call csv#Warn("There exists no column " . colnr)
        return 1
    endif
    let @/ = csv#GetPat(colnr, maxcolnr, '\%(.\{-\}'.pat. '\)', 1)
    try
        " force redraw, so that the search pattern isn't shown
        exe "norm! n\<c-l>"
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
fu! csv#DeleteColumn(arg) "{{{3
    let _wsv = winsaveview()
    let i = 0
    if a:arg =~ '^[/]'
        let pat = a:arg[1:]
        call cursor(1,1)
        while search(pat, 'cW')
            " Delete matching column
            sil call csv#DelColumn('')
            let i+=1
        endw
    elseif a:arg =~ '-'
        let list=split(a:arg, '-')
        call cursor(1,1)
        for col in range(list[1], list[0], -1)
            " delete backwards, so that the column numbers do not change
            sil call csv#DelColumn(col)
            let i+=1
        endfor
    else
        let i = 1
        sil call csv#DelColumn(a:arg)
    endif
    if i > 1
        call csv#Warn(printf("%d columns deleted", i))
    elseif i == 1
        call csv#Warn("1 column deleted")
    else
        call csv#Warn("no column deleted")
    endif
    call winrestview(_wsv)
endfu
fu! csv#DelColumn(colnr) "{{{3
    let maxcolnr = csv#MaxColumns()
    let _p = getpos('.')

    if empty(a:colnr)
       let colnr=csv#WColumn()
    else
       let colnr=a:colnr
    endif

    if colnr > maxcolnr
        call csv#Warn("There exists no column " . colnr)
        return
    endif

    if colnr != '1'
        if !exists("b:csv_fixed_width_cols")
            let pat= '^' . csv#GetColPat(colnr-1,1) . b:col
        else
            let pat= csv#GetColPat(colnr,0)
        endif
    else
        " distinction between csv and fixed width does not matter here
        let pat= '^' . csv#GetColPat(colnr,0)
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
fu! csv#HiCol(colnr, bang) "{{{3
    if !a:bang
        if a:colnr > csv#MaxColumns()
            call csv#Warn("There exists no column " . a:colnr)
            return
        endif
        if empty(a:colnr)
            let colnr=csv#WColumn()
        else
            let colnr=a:colnr
        endif

        if colnr==1
            let pat='^'. csv#GetColPat(colnr,0)
        elseif !exists("b:csv_fixed_width_cols")
            let pat='^'. csv#GetColPat(colnr-1,1) . b:col
        else
            let pat=csv#GetColPat(colnr,0)
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
fu! csv#GetDelimiter(first, last, ...) "{{{3
    " This depends on the locale. Hopefully it works
	let lang=v:lang
	if lang isnot# 'C'
		sil lang mess C
	endif
    if !exists("b:csv_fixed_width_cols")
        let _cur = getpos('.')
        let _s   = @/
        " delimiters to try matching in the file
        if len(a:000) && !empty(a:1)
            let j=0
            let Delim={}
            for i in split(a:1, '\zs')
                let Delim[j] = i
                let j+=1
            endfor
        else
            let Delim= {0: ',', 1:  ';', 2: '|', 3: '	', 4: '^', 5: ':'}
        endif
        let temp = {}
        let last = a:last > line('$') ? line('$') : a:last
        let first = a:first > line('$') ? line('$') : a:first
        " :silent :s does not work with lazyredraw
        let _lz  = &lz
        set nolz
        for i in values(Delim)
            redir => temp[i]
            " use very non-magic
            exe ":silent! :". first. ",". last. 's/\V' . i . "/&/nge"
            redir END
        endfor
        let &lz = _lz
        let Delim = map(temp, 'matchstr(substitute(v:val, "\n", "", ""), "^\\s*\\d\\+")')
        let Delim = filter(temp, 'v:val=~''\d''')
        let max   = max(values(temp))
        if lang != 'C'
            exe "sil lang mess" lang
        endif

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
fu! csv#WColumn(...) "{{{3
    " Return on which column the cursor is
    let _cur = getpos('.')
    if !exists("b:csv_fixed_width_cols")
        if line('.') > 1 && mode('') != 'n'
            " in insert mode, get line from above, just in case the current
            " line is empty
            let line = getline(line('.')-1)
        else
            let line = getline('.')
        endif
        " move cursor to end of field
        "call search(b:col, 'ec', line('.'))
        call search(b:col, 'ec')
        let end=col('.')-1
        let fields=(split(line[0:end],b:col.'\zs'))
        let ret=len(fields)
        if exists("a:1") && a:1 > 0
            " bang attribute: Try to get the column name
            let head  = split(getline(get(b:, 'csv_headerline', 1)),b:col.'\zs')
            " remove preceeding whitespace
            if len(head) < ret
                call csv#Warn("Header has no field ". ret)
            else
                let ret   = substitute(head[ret-1], '^\s\+', '', '')
                " remove delimiter
                let ret   = substitute(ret, b:delimiter. '$', '', '')
            endif
        endif
    else
        let temp=getpos('.')[2]
        let j=1
        let ret = 1
        for i in sort(b:csv_fixed_width_cols, s:csv_numeric_sort ? 'n' : 'csv#CSVSortValues')
            if temp >= i
                let ret = j
            endif
            let j += 1
        endfor
    endif
    call setpos('.',_cur)
    return ret
endfu
fu! csv#MaxColumns(...) "{{{3
    let this_col = exists("a:1")
    "return maximum number of columns in first 10 lines
    if !exists("b:csv_fixed_width_cols")
      let i = this_col ? a:1 : get(b:, 'csv_headerline', 1)
        while 1
            let l = getline(i, (this_col ? i : i+10))
            if empty(l) && i >= line('$')
                break
            endif

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
fu! csv#ColWidth(colnr, ...) "{{{3
    " if a:1 is given, specifies the row, for which to calculate the width
    "
    " Return the width of a column
    " Internal function
    let width=20 "Fallback (wild guess)
    let tlist=[]
    let skipfirst=get(g:, 'csv_skipfirst', 0)

    if !exists("b:csv_fixed_width_cols")
        if !exists("b:csv_list")
            " only check first 10000 lines, to be faster
            let last = line('$')
            if exists("a:1") && !empty(a:1)
                let last = a:1
            endif
            if !get(b:, 'csv_arrange_use_all_rows', 0)
                if last > 10000
                    let last = 10000
                    call csv#Warn('File too large, only checking the first 10000 rows for the width')
                endif
            endif
            let b:csv_list=getline(skipfirst+1,last)
            let pat = '^\s*\V'. escape(b:csv_cmt[0], '\\')
            call filter(b:csv_list, 'v:val !~ pat')
            call filter(b:csv_list, '!empty(v:val)')
            call map(b:csv_list, 'split(v:val, b:col.''\zs'')')
        endif
        try
            for item in b:csv_list
                call add(tlist, get(item, a:colnr-1, ''))
            endfor
            call map(tlist, 'strdisplaywidth(v:val)')
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
fu! csv#ArrangeCol(first, last, bang, limit, ...) range "{{{3
    " a:1, optional width parameter of line from which to take the width
    "
    " explicitly give the range as argument to the function
    if exists("b:csv_fixed_width_cols")
        " Nothing to do
        call csv#Warn("ArrangeColumn does not work with fixed width column!")
        return
    endif
    let cur=winsaveview()
    " Force recalculation of Column width
    let row = exists("a:1") ? a:1 : ''
    if a:bang || !empty(row)
        if a:bang && exists("b:col_width")
          " Unarrange, so that if csv_arrange_align has changed
          " it will be adjusted automatically
          call csv#PrepUnArrangeCol(a:first, a:last)
        endif
        " Force recalculating the Column width
        unlet! b:csv_list b:col_width
    elseif a:limit > -1 && a:limit < getfsize(fnamemodify(bufname(''), ':p'))
        return
    endif

    let first = a:first
    let last  = a:last
    if exists("b:csv_headerline")
      if a:first < b:csv_headerline
        let first = b:csv_headerline
      endif
      if a:last < b:csv_headerline
        let last = b:csv_headerline
      endif
    endif
    if first > line('$')
        let first=line('$')
    endif
    if last > line('$')
        let last=line('$')
    endif
    if &vbs
      echomsg printf("ArrangeCol Start: %d, End: %d", first, last)
    endif

    if !exists("b:col_width")
        call csv#CalculateColumnWidth(row)
    endif

    " abort on empty file
    if !len(b:col_width)
        call csv#Warn("No column data detected, aborting ArrangeCol command!")
        return
    endif
    let ro=&ro
    if &ro
       " Just in case, to prevent the Warning
       " Warning: W10: Changing read-only file
       setl noro
    endif
    let s:count = 0
    let _stl  = &stl
    let s:max   = (last - first + 1) * len(b:col_width)
    let s:temp  = 0
    try
        if first==1 && last == line('$') && b:delimiter=="\t" && has("vartabs") && !empty(get(b:, 'col_width', []))
            " Make use of vartab feature
            let &l:vts=join(b:col_width, ',')
            let g:csv_no_conceal=1
        else
            exe "sil". first . ',' . last .'s/' . (b:col) .
            \ '/\=csv#Columnize(submatch(0))/' . (&gd ? '' : 'g')
        endif
    finally
        " Clean up variables, that were only needed for csv#Columnize() function
        unlet! s:columnize_count s:max_cols s:prev_line s:max s:count s:temp s:val
        if ro
            setl ro
            unlet ro
        endif
        let &stl = _stl
        call winrestview(cur)
    endtry
endfu
fu! csv#ProgressBar(cnt, max) "{{{3
    if get(g:, 'csv_no_progress', 0) || a:max == 0
        return
    endif
    let width = 40 " max width of progressbar
    if width > &columns
        let width = &columns
    endif
    let s:val = a:cnt * width / a:max
    if (s:val > s:temp || a:cnt==1)
        let &stl='%#DiffAdd#['.repeat('=', s:val).'>'. repeat(' ', width-s:val).']'.
                \ (width < &columns  ? ' '.100*s:val/width. '%%' : '')
        redrawstatus
        let s:temp = s:val
    endif
endfu
fu! csv#PrepUnArrangeCol(first, last) "{{{3
    " Because of the way, Vim works with
    " a:firstline and a:lastline parameter,
    " explicitly give the range as argument to the function
    if exists("b:csv_fixed_width_cols")
        " Nothing to do
        call csv#Warn("UnArrangeColumn does not work with fixed width column!")
        return
    endif
    let cur=winsaveview()

    if &ro
       " Just in case, to prevent the Warning
       " Warning: W10: Changing read-only file
       setl noro
    endif
    exe a:first . ',' . a:last .'s/' . (b:col) .
    \ '/\=csv#UnArrangeCol(submatch(0))/' . (&gd ? '' : 'g')
    " Clean up variables, that were only needed for csv#Columnize() function
    call winrestview(cur)
endfu
fu! csv#UnArrangeCol(match) "{{{3
    " Strip leading white space, also trims empty recordcsv#
    return substitute(a:match, '\%(^ \+\)\|\%( \+\ze'.b:delimiter. '\?$\)', '', 'g')
endfu
fu! csv#CalculateColumnWidth(row) "{{{3
    " Internal function, not called from external,
    " does not work with fixed width columns
    " row for the row for which to calculate the width
    let b:col_width=[]
    try
        if exists("b:csv_headerline")
          if line('.') < b:csv_headerline
            call cursor(b:csv_headerline,1)
          endif
        endif
        let s:max_cols=csv#MaxColumns(line('.'))
        for i in range(1,s:max_cols)
            call add(b:col_width, csv#ColWidth(i, a:row))
        endfor
    catch /csv:no_col/
        call csv#Warn("Error: getting Column numbers, aborting!")
    catch /ColWidth/
        call csv#Warn("Error: getting Column Width, using default!")
    endtry
    " delete buffer content in variable b:csv_list,
    " this was only necessary for calculating the max width
    unlet! b:csv_list s:columnize_count s:decimal_column
endfu
fu! csv#Columnize(field) "{{{3
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
    let s:count+=1

    let s:prev_line = line('.')
    " convert zero based indexed list to 1 based indexed list,
    " Default: 20 width, in case that column width isn't defined
    " Careful: Keep this fast! Using
    " let width=get(b:col_width,csv#WColumn()-1,20)
    " is too slow, so we are using:
    let colnr = s:columnize_count % s:max_cols
    let width = get(b:col_width, colnr, 20)
    let align = 'r'
    if exists('b:csv_arrange_align')
        let align=b:csv_arrange_align
        let indx=match(align, '\*')
        if indx > 0
            let align = align[0:(indx-1)]. repeat(align[indx-1], len(b:col_width)-indx)
        endif
        let align_list=split(align, '\zs')
        try
            let align = align_list[colnr]
        catch
            let align = 'r'
        endtry
    endif
    if ((align isnot? 'r' && align isnot? 'l' &&
       \ align isnot? 'c' && align isnot? '.') || get(b:, 'csv_arrange_leftalign', 0))
       let align = 'r'
    endif
    call csv#ProgressBar(s:count,s:max)

    let s:columnize_count += 1
    let has_delimiter = (a:field[-1:] is? b:delimiter)
    if align is? 'l'
        " left-align content
        return printf("%-*S%s", width-1,
            \ (has_delimiter ? a:field[:-2] : a:field),
            \ (has_delimiter ? b:delimiter : ' '))
    elseif align is? 'c'
        " center the column
        let t = width - len(split(a:field, '\zs'))
        let leftwidth = t/2
        " uneven width, add one
        let rightwidth = (t%2 ? leftwidth+1 : leftwidth)
        let field = (has_delimiter ?  a:field[:-2] : a:field).  repeat(' ', rightwidth)
        return printf("%*S%s", width , field, (has_delimiter ? b:delimiter : ' '))
    elseif align is? '.'
        if !exists("s:decimal_column")
            let s:decimal_column = {}
        endif
        if get(s:decimal_column, colnr, 0) == 0
            call csv#CheckHeaderLine()
            call csv#NumberFormat()
            let data = csv#CopyCol('', colnr+1, '')[s:csv_fold_headerline : -1]
            let pat1 = escape(s:nr_format[1], '.').'\zs[^'.s:nr_format[1].']*\ze'.
                        \ (has_delimiter ? b:delimiter : '').'$'
            let pat2 = '\d\+\ze\%(\%('.escape(s:nr_format[1], '.'). '\d\+\)\|'.
                        \ (has_delimiter ? b:delimiter : '').'$\)'
            let data1 = map(copy(data), 'matchstr(v:val, pat1)')
            let data2 = map(data, 'matchstr(v:val, pat2)')
            " strlen should be okay for decimals...
            let data1 = map(data1, 'strlen(v:val)')
            let data2 = map(data2, 'strlen(v:val)')
            let dec = max(data1)
            let scal = max(data2)
            if dec + scal + 1 + (has_delimiter ? 1 : 0) > width
                let width = dec + scal + 1 + (has_delimiter ? 1 :0)
                let b:col_width[colnr] = width
            endif

            let s:decimal_column[colnr] = dec
        else
            let dec = get(s:decimal_column, colnr)
        endif
        let field = (has_delimiter ?  a:field[:-2] : a:field)
        let fmt = printf("%%%d.%df", width+1, dec)
        try
            if s:nr_format[1] isnot '.'
                let field = substitute(field, s:nr_format[1], '.', 'g')
                let field = substitute(field, s:nr_format[0], '', 'g')
            endif
            if field =~? '\h' " text in the column, can't be converted to float
                throw "no decimal"
            endif
            let result = printf(fmt, str2float(field)). (has_delimiter ? b:delimiter : ' ')
        catch
            let result = printf("%*S", width+2, a:field)
        endtry
        return result
    else
        " right align
        return printf("%*S", width+1 ,  a:field)
    endif
endfun
fu! csv#GetColPat(colnr, zs_flag) "{{{3
    " Return Pattern for given column
    if a:colnr > 1
        if !exists("b:csv_fixed_width_cols")
            let pat=b:col . '\{' . (a:colnr) . '\}'
        else
            if a:colnr >= len(b:csv_fixed_width_cols)
            " Get last column
                let pat='\%' . b:csv_fixed_width_cols[-1] . 'v.*'
            else
            let pat='\%' . b:csv_fixed_width_cols[(a:colnr - 1)] .
            \ 'c.\{-}\%' .   b:csv_fixed_width_cols[a:colnr] . 'v'
            endif
        endif
    elseif !exists("b:csv_fixed_width_cols")
        let pat=b:col
    else
        let pat='\%' . b:csv_fixed_width_cols[0] . 'v.\{-}' .
            \ (len(b:csv_fixed_width_cols) > 1 ?
            \ '\%' . b:csv_fixed_width_cols[1] . 'v' :
            \ '')
    endif
    return pat . (a:zs_flag ? '\zs' : '')
endfu
fu! csv#SetupAutoCmd(window,bufnr) "{{{3
    " Setup QuitPre autocommand to quit cleanly
    aug CSV_QuitPre
        au!
        exe "au QuitPre * call CSV_CloseBuffer(".winbufnr(a:window).")"
        if !exists("##OptionSet")
          exe "au CursorHold <buffer=".a:bufnr."> call CSV_SetSplitOptions(".a:window.")"
        else
          exe "au OptionSet foldcolumn,number,relativenumber call csv#CSV_SetOption(".a:bufnr.
            \ ", ".bufnr('%').", expand('<amatch>'), v:option_new)"
        endif
        exe "au VimResized,FocusLost,FocusGained <buffer=".a:bufnr."> call CSV_SetSplitOptions(".a:window.")"
    aug END
endfu
fu! csv#CSV_SetOption(csvfile, header, option, value) "{{{3
  " only trigger if the option is called in the correct buffer
  if getbufvar(a:csvfile, 'csv_SplitWindow') && bufnr('') == a:csvfile
    call setbufvar(a:header, '&'.a:option, a:value)
  endif
endfu
fu! csv#SplitHeaderLine(lines, bang, hor) "{{{3
    if exists("b:csv_fixed_width_cols")
        call csv#Warn("Header does not work with fixed width column!")
        return
    endif
    " Check that there exists a header line
    call csv#CheckHeaderLine()
    if !a:bang
        " A Split Header Window already exists,
        " first close the already existing Window
        if exists("b:csv_SplitWindow")
            call csv#SplitHeaderLine(a:lines, 1, a:hor)
        endif
        " Split Window
        let _stl = &l:stl
        let _sbo = &sbo
        let a = []
        let b=b:col
        let bufnr = bufnr('.')
        if a:hor
            setl scrollopt=hor scrollbind cursorbind
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
            sil! sign unplace *
            exe "resize" . lines
            setl scrollopt=hor winfixheight nowrap cursorbind
            let &l:stl="%#Normal#".repeat(' ',winwidth(0))
            let s:local_stl = &l:stl
            " set the foldcolumn to the same of the other window
            let &l:fdc = _fdc
        else
            setl scrollopt=ver scrollbind cursorbind
            noa 0
            if a:lines[-1:] is? '!'
                let a=csv#CopyCol('',a:lines,'')
            else
                let a=csv#CopyCol('',1, a:lines-1)
            endif
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
            sil :call csv#ArrangeCol(1,line('$'), 1, -1)
            sil! sign unplace *
            exe "vert res" . len(split(getline(1), '\zs'))
            call matchadd("CSVHeaderLine", b:col)
            setl scrollopt=ver winfixwidth cursorbind nonu nornu fdc=0
        endif
        call csv#SetupAutoCmd(winnr(),bufnr)
        " disable airline
        let w:airline_disabled = 1
        let win = winnr()
        setl scrollbind buftype=nowrite bufhidden=wipe noswapfile nobuflisted
        noa wincmd p
        let b:csv_SplitWindow = win
        aug CSV_Preview
            au!
            au BufWinLeave <buffer> call csv#SplitHeaderLine(0, 1, 0)
        aug END
    else
        " Close split window
        if !exists("b:csv_SplitWindow")
            return
        endif
        try
          let winnr = winnr()
          if winnr == b:csv_SplitWindow || winbufnr(b:csv_SplitWindow) == bufnr('')
            " window already closed
            return
          endif
          exe b:csv_SplitWindow . "wincmd w"
          if exists("_stl")
              let &l:stl = _stl
          endif
          if exists("_sbo")
              let &sbo = _sbo
          endif
          setl noscrollbind nocursorbind
          call CSV_CloseBuffer(bufnr('%'))
        catch /^Vim\%((\a\+)\)\=:E444/	" cannot close last window
        catch /^Vim\%((\a\+)\)\=:E517/	" buffer already wiped
            " no-op
        finally
          unlet! b:csv_SplitWindow
          aug CSV_Preview
              au!
          aug END
          aug! CSV_Preview
        endtry
    endif
endfu
fu! csv#SplitHeaderToggle(hor) "{{{3
    if !exists("b:csv_SplitWindow")
        :call csv#SplitHeaderLine(1,0,a:hor)
    else
        :call csv#SplitHeaderLine(1,1,a:hor)
    endif
endfu
" TODO: from here on add logic for fixed-width csv files!
fu! csv#MoveCol(forward, line, ...) "{{{3
    " Move cursor position upwards/downwards left/right
    " a:1 is there to have some mappings move in the same
    " direction but still stop at a different position
    " see :h csv-mapping-H
    let colnr=csv#WColumn()
    let maxcol=csv#MaxColumns(line('.'))
    let cpos=getpos('.')[2]
    if !exists("b:csv_fixed_width_cols")
        let curwidth=CSVWidth()
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
    if foldclosed(line) != -1
        let line = line > line('.') ? foldclosedend(line) + 1 : foldclosed(line)
    endif

    " Generate search pattern
    if colnr == 1
        let pat = '^' . csv#GetColPat(colnr-1,0)
        "let pat = pat . '\%' . line . 'l'
    elseif (colnr == 0) || (colnr == maxcol + 1)
        if !exists("b:csv_fixed_width_cols")
            let pat=b:col
        else
            if a:forward > 0
                " Move forwards
                let pat=csv#GetColPat(1, 0)
            else
                " Move backwards
                let pat=csv#GetColPat(maxcol, 0)
            endif
        endif
    else
        if !exists("b:csv_fixed_width_cols")
            let pat='^'. csv#GetColPat(colnr-1,1) . b:col
        else
            let pat=csv#GetColPat(colnr,0)
        endif
        "let pat = pat . '\%' . line . 'l'
    endif

    " Search
    " move left/right
    if a:forward > 0
        call search(pat, 'W')
    elseif a:forward < 0
        if colnr > 0 || cpos == spos
            call search(pat, 'bWe')
            let stime=localtime()
            while getpos('.')[2] == cpos && csv#Timeout(stime) " make sure loop terminates
                " cursor didn't move, move cursor one cell to the left
                sil! norm! h
                if colnr > 0
                    call csv#MoveCol(-1, line('.'))
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
            if CSVWidth() == curwidth
                let a[2]+= cpos-spos
            endif
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
            if CSVWidth() == curwidth
                let a[2]+= cpos-spos
            endif
        else
            let a    = getpos('.')
            let a[2] = cpos
        endif
        call setpos('.', a)
    endif
endfun
fu! csv#SortComplete(A,L,P) "{{{3
    return join(range(1,csv#MaxColumns()),"\n")
endfun
fu! csv#Sort(bang, line1, line2, colnr) range "{{{3
    " :Sort command
    let wsv  = winsaveview()
    let flag = matchstr(a:colnr, '[nixo]')
    call csv#CheckHeaderLine()
    let line1 = a:line1
    let line2 = a:line2
    if line1 <= s:csv_fold_headerline
      let line1 += s:csv_fold_headerline
    endif
    if line2 <= s:csv_fold_headerline
      let line2 += s:csv_fold_headerline
    endif
    let col = (empty(a:colnr) || a:colnr !~? '\d\+[nixo]\?') ? csv#WColumn() : a:colnr+0
    if col != 1
        if !exists("b:csv_fixed_width_cols")
            let pat= '^' . csv#GetColPat(col-1,1) . b:col
        else
            let pat= csv#GetColPat(col,0)
        endif
    else
        let pat= '^' . csv#GetColPat(col,0)
    endif
    exe line1. ','. line2. "sort". (a:bang ? '!' : '') .
        \' r'. flag. ' /' . pat . '/'
    call winrestview(wsv)
endfun
fu! csv#CopyCol(reg, col, cnt) "{{{3
    " Return Specified Column into register reg
    let col = a:col == "0" ? csv#WColumn() : a:col+0
    let mcol = csv#MaxColumns()
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
        call map(a, 'matchstr(v:val, csv#GetColPat(col, 0)).*csv#GetColPat(col+cnt_cols, 0)')
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
fu! csv#MoveColumn(start, stop, ...) range "{{{3
    " Move column behind dest
    " Explicitly give the range as argument,
    " cause otherwise, Vim would move the cursor
    let wsv = winsaveview()

    let col = csv#WColumn()
    let max = csv#MaxColumns()

    " If no argument is given, move current column after last column
    let source=(exists("a:1") && a:1 > 0 && a:1 <= max ? a:1 : col)
    let dest  =(exists("a:2") && a:2 > 0 && a:2 <= max ? a:2 : max)

    " translate 1 based columns into zero based list index
    let source -= 1
    let dest   -= 1

    if source >= dest
        call csv#Warn("Destination column before source column, aborting!")
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
                call add(fields, matchstr(content, csv#GetColPat(j,0)))
            endfor
        endif

        let fields= (source == 0 ? [] : fields[0 : (source-1)])
                \ + fields[ (source+1) : dest ]
                \ + [ fields[source] ] + fields[(dest+1):]

        call setline(i, join(fields, ''))
    endfor
    call winrestview(wsv)
endfu
fu! csv#DupColumn(start, stop, ...) range "{{{3
    " Add new empty column
    " Explicitly give the range as argument,
    " cause otherwise, Vim would move the cursor
    if exists("b:csv_fixed_width_cols")
        call csv#Warn("Duplicating Columns only works for delimited files")
        return
    endif

    let wsv = winsaveview()

    " translate 1 based columns into zero based list index
    let col = csv#WColumn() - 1
    let max = csv#MaxColumns()
    let add_delim = 0

    " If no argument is given, add column after current column
    if exists("a:1")
        if a:1 == '$' || a:1 >= max
            let pos = max - 1
        elseif a:1 < 0
            let pos = col
        else
            let pos = a:1 - 1
        endif
    else
        let pos = col
    endif
    if pos == max - 1
        let add_delim = 1
    endif
    let cnt=(exists("a:2") && a:2 > 0 ? a:2 : 1)

    " if the data contains comments, substitute one line after another
    " skipping comment lines (we could do it with a single :s statement,
    " but that would fail for the first and last column.

    let commentpat = '\%(\%>'.(a:start-1).'l\V'.
                \ escape(b:csv_cmt[0], '\\').'\m\)'. '\&\%(\%<'.
                \ (a:stop+1). 'l\V'. escape(b:csv_cmt[0], '\\'). '\m\)'

    for i in range(a:start, a:stop)
        let content = getline(i)
        if content =~ '^\s*\V'. escape(b:csv_cmt[0], '\\')
            " skip comments
            continue
        endif
        let fields = split(getline(i), b:col.'\zs')
        if add_delim && fields[-1][:-1] isnot b:delimiter
            " Need to add a delimiter
            let fields[pos] .= b:delimiter
        endif
        let fields = fields[0:pos] + repeat([fields[pos]], cnt) + fields[pos+1:-1]
        call setline(i, join(fields, ''))
    endfor
    call winrestview(wsv)
endfu

fu! csv#AddColumn(start, stop, ...) range "{{{3
    " Add new empty column
    " Explicitly give the range as argument,
    " cause otherwise, Vim would move the cursor
    if exists("b:csv_fixed_width_cols")
        call csv#Warn("Adding Columns only works for delimited files")
        return
    endif

    let wsv = winsaveview()

    let col = csv#WColumn()
    let max = csv#MaxColumns()

    " If no argument is given, add column after current column
    if exists("a:1")
        if a:1 == '$' || a:1 >= max
            let pos = max
        elseif a:1 < 0
            let pos = col
        else
            let pos = a:1
        endif
    else
        let pos = col
    endif
    let cnt=(exists("a:2") && a:2 > 0 ? a:2 : 1)

    " translate 1 based columns into zero based list index
    let col -= 1

    if pos == 0
        let pat = '^'
    elseif pos == max
        let pat = '$'
    else
        let pat = csv#GetColPat(pos,1)
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
fu! csv#SumColumn(list) "{{{3
    " Sum a list of values, but only consider the digits within each value
    " parses the digits according to the given format (if none has been
    " specified, assume POSIX format (without thousand separator) If Vim has
    " does not support floats, simply sum up only the integer part
    if empty(a:list)
        let b:csv_result = '0'
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
            let b:csv_result = string(float2nr(sum))
            if float2nr(sum) == sum
                return float2nr(sum)
            else
                return printf("%.2f", sum)
            endif
        endif
        let b:csv_result = string(sum)
        return sum
    endif
endfu
fu! csv#AvgColumn(list) "{{{3
    if empty(a:list)
        let b:csv_result = '0'
        return 0
    else
        let cnt = 0
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
            let cnt += 1
        endfor
        if has("float")
            let b:csv_result = printf("%.2f", sum/cnt)
            return b:csv_result
        else
            let b:csv_result = printf("%s", sum/cnt)
            return sum/cnt
        endif
    endif
endfu
fu! csv#VarianceColumn(list, is_population) "{{{3
    if empty(a:list)
        return 0
    else
        let cnt = 0
        let sum = has("float") ? 0.0 : 0
        let avg = csv#AvgColumn(a:list)
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
            let sum += pow((has("float") ? (str2float(nr)-avg) : ((nr + 0)-avg)), 2)
            let cnt += 1
        endfor
        if(a:is_population == 0)
            let cnt = cnt-1
        endif
        if has("float")
            let b:csv_result = printf("%.2f", sum/cnt)
            return b:csv_result
        else
            let b:csv_result = printf("%s", sum/cnt)
            return sum/(cnt)
        endif
    endif
endfu

fu! csv#SmplVarianceColumn(list) "{{{2
    if empty(a:list)
        let b:csv_result = '0'
        return 0
    else
        return csv#VarianceColumn(a:list, 0)
    endif
endfu

fu! csv#PopVarianceColumn(list) "{{{2
    if empty(a:list)
        let b:csv_result = '0'
        return 0
    else
        return csv#VarianceColumn(a:list, 1)
    endif
endfu

fu! csv#SmplStdDevColumn(list) "{{{2
    if empty(a:list)
        let b:csv_result = '0'
        return 0
    else
        let result = sqrt(str2float(csv#VarianceColumn(a:list, 0)))
        let b:csv_result = string(result)
        return result
    endif
endfu

fu! csv#PopStdDevColumn(list) "{{{2
    if empty(a:list)
        let b:csv_result = '0'
        return 0
    else
        let result = sqrt(str2float(csv#VarianceColumn(a:list, 1)))
        let b:csv_result = string(result)
        return result
    endif
endfu

fu! csv#MaxColumn(list) "{{{3
    " Sum a list of values, but only consider the digits within each value
    " parses the digits according to the given format (if none has been
    " specified, assume POSIX format (without thousand separator) If Vim
    " does not support floats, simply sum up only the integer part
    if empty(a:list)
        return 0
    else
        let result = []
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
            call add(result, has("float") ? str2float(nr) : nr+0)
        endfor
        let result = sort(result, s:csv_numeric_sort ? 'n' : 'csv#CSVSortValues')
        let ind = len(result) > 9 ? 9 : len(result)
        if has_key(get(s:, 'additional', {}), 'distinct') && s:additional['distinct']
          if exists("*uniq")
            let result=uniq(result)
          else
            let l = {}
            for item in result
              let l[item] = get(l, 'item', 0)
            endfor
            let result = keys(l)
          endif
        endif
        return s:additional.ismax ? reverse(result)[:ind] : result[:ind]
    endif
endfu
fu! csv#CountColumn(list) "{{{3
    if empty(a:list)
        return 0
    elseif has_key(get(s:, 'additional', {}), 'distinct') && s:additional['distinct']
      if exists("*uniq")
        return len(uniq(sort(a:list)))
      else
        let l = {}
        for item in a:list
          let l[item] =  get(l, 'item', 0) + 1
        endfor
        return len(keys(l))
      endif
    else
        return len(a:list)
    endif
endfu
fu! csv#DoForEachColumn(start, stop, bang) range "{{{3
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
        call csv#Warn("You need to define how to convert your data using" .
                \ "the g:csv_convert variable, see :h csv-convert")
        return
    endif

    if exists("g:csv_pre_convert") && !empty(g:csv_pre_convert)
        call add(result, g:csv_pre_convert)
    endif

    for item in range(a:start, a:stop, 1)
        if foldlevel(line)
          " Filter out folded lines (from dynamic filter)
          continue
        endif
        let t = g:csv_convert
        let line = getline(item)
        if line =~ '^\s*\V'. escape(b:csv_cmt[0], '\\')
            " Filter comments out
            call add(result, line)
            continue
        endif
        let context = split(g:csv_convert, '%s')
        let columns = len(context)
        if columns > csv#MaxColumns()
            let columns = csv#MaxColumns()
        elseif columns == 1
            call csv#Warn("No Columns defined in your g:csv_convert variable, Aborting")
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
                call add(fields, matchstr(line, csv#GetColPat(j,0)))
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
fu! csv#PrepareDoForEachColumn(start, stop, bang) range"{{{3
    let pre = exists("g:csv_pre_convert") ? g:csv_pre_convert : ''
    let g:csv_pre_convert=input('Pre convert text: ', pre)
    let post = exists("g:csv_post_convert") ? g:csv_post_convert : ''
    let g:csv_post_convert=input('Post convert text: ', post)
    let convert = exists("g:csv_convert") ? g:csv_convert : ''
    let g:csv_convert=input("Converted text, use %s for column input:\n", convert)
    call csv#DoForEachColumn(a:start, a:stop, a:bang)
endfun
fu! csv#EscapeValue(val) "{{{3
    return '\V' . escape(a:val, '\')
endfu
fu! csv#FoldValue(lnum, filter) "{{{3
    call csv#CheckHeaderLine()

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
fu! csv#PrepareFolding(add, match)  "{{{3
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
            call csv#RemoveLastItem(s:filter_count)
            let s:filter_count -= 1
            if empty(b:csv_filter)
                call csv#DisableFolding()
                return
            endif
        else
            " Disable folding, if no pattern available
            call csv#DisableFolding()
            return
        endif
    else

        let col = csv#WColumn()
        let max = csv#MaxColumns()
        let a   = csv#GetColumn(line('.'), col, 0)
        let a   = csv#ProcessFieldValue(a)
        let pat = '\%(^\|'.b:delimiter. '\)\@<='.csv#EscapeValue(a).
                 \ '\m\ze\%('.b:delimiter.'\|$\)'

        " Make a column pattern
        let b= '\%(' .
            \ (exists("b:csv_fixed_width") ? '.*' : '') .
            \ csv#GetPat(col, max, pat, 0) . '\)'

        let s:filter_count += 1
        let b:csv_filter[s:filter_count] = { 'pat': b, 'id': s:filter_count,
            \ 'col': col, 'orig': a, 'match': a:match}

    endif
    " Put the pattern into the search register, so they will also
    " be highlighted
"    let @/ = ''
"    for val in sort(values(b:csv_filter), 'csv#SortFilter')
"        let @/ .= val.pat . (val.id == s:filter_count ? '' : '\&')
"    endfor

    " Fold settingcsv#
    call csv#LocalSettings('fold')
    " Don't put spaces between the arguments!
    exe 'setl foldexpr=csv#FoldValue(v:lnum,b:csv_filter)'

    " Move folded area to the bottom, so there is only on consecutive
    " non-folded area
    if exists("s:csv_move_folds") && s:csv_move_folds
        \ && !&l:ro && &l:ma
        folddoclosed m$
        let cpos.lnum = s:csv_fold_headerline + 1
    endif
    call winrestview(cpos)
endfu
fu! csv#ProcessFieldValue(field) "{{{3
    let a = a:field
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
                let a=repeat(' ', csv#ColWidth(col))
            catch
                " no-op
            endtry
        endif
    endif
    return a
endfu
fu! csv#OutputFilters(bang) "{{{3
    if !a:bang
        call csv#CheckHeaderLine()
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
            call sort(items, "csv#SortFilter")
            for item in items
                if s:csv_fold_headerline
                    echo printf("%02d\t% 2s\t%02d\t%10.10s\t%s",
                        \ item.id, (item.match ? '+' : '-'), item.col,
                        \ substitute(csv#GetColumn(1, item.col, 0),
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
            call csv#Warn("No filters defined currently!")
            return
        else
            exe 'setl foldexpr=csv#FoldValue(v:lnum,b:csv_filter)'
        endif
    endif
endfu
fu! csv#SortFilter(a, b) "{{{3
    return a:a.id == a:b.id ? 0 :
        \ a:a.id > a:b.id ? 1 : -1
endfu
fu! csv#GetColumn(line, col, strip) "{{{3
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
        let a = matchstr(a, csv#GetColPat(a:col, 0))
    endif
    if a:strip
        return substitute(a, '^\s\+\|\s\+$', '', 'g')
    else
        return a
    endif
endfu
fu! csv#RemoveLastItem(count) "{{{3
    for [key,value] in items(b:csv_filter)
        if value.id == a:count
            call remove(b:csv_filter, key)
        endif
    endfor
endfu
fu! csv#DisableFolding() "{{{3
    setl nofen fdm=manual fdc=0 fdl=0
    if !get(g:, 'csv_disable_fdt',0) && exists("s:fdt") && exists("s:fcs")
        exe printf("setl fdt=%s fcs=%s", s:fdt, escape(s:fcs, '\\|'))
    endif
endfu
fu! csv#NumberFormat() "{{{3
    let s:nr_format = [',', '.']
    if exists("b:csv_thousands_sep")
        let s:nr_format[0] = b:csv_thousands_sep
    endif
    if exists("b:csv_decimal_sep")
        let s:nr_format[1] = b:csv_decimal_sep
    endif
endfu
fu! csv#CheckHeaderLine() "{{{3
    if !exists("b:csv_headerline")
        let s:csv_fold_headerline = 1
    else
        let s:csv_fold_headerline = b:csv_headerline
    endif
endfu
fu! csv#AnalyzeColumn(...) "{{{3
    let maxcolnr = csv#MaxColumns()
    if len(a:000) == 1
        let colnr = a:1
    else
        let colnr = csv#WColumn()
    endif

    if colnr > maxcolnr
        call csv#Warn("There exists no column " . colnr)
        return 1
    endif

    " Initialize csv#fold_headerline
    call csv#CheckHeaderLine()
    let data = csv#CopyCol('', colnr, '')[s:csv_fold_headerline : -1]
    let qty = len(data)
    let res = {}
    for item in data
        if empty(item) || item ==# b:delimiter
            let item = 'NULL'
        endif
        if !get(res, item)
            let res[item] = 0
        endif
        let res[item]+=1
    endfor

    let max_items = reverse(sort(values(res), s:csv_numeric_sort ? 'n' : 'csv#CSVSortValues'))
    " What about the minimum 5 items?
    let count_items = keys(res)
    if len(max_items) > 5
        call remove(max_items, 5, -1)
        call map(max_items, 'printf(''\V%s\m'', escape(v:val, ''\\''))')
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
            if res[key] =~ val && i <= len(max_items)
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
    if &columns > 40
        echo printf("different values in column %d: %d", colnr, len(count_items))
    else
        echo printf("different valuecsv# %d", len(count_items))
    endif
    unlet max_items
endfunc
fu! csv#Vertfold(bang, col) "{{{3
    if a:bang
        do Syntax
        return
    endif
    if !has("conceal")
        call csv#Warn("Concealing not supported in your Vim")
        return
    endif
    if empty(b:delimiter) && !exists("b:csv_fixed_width_cols")
        call csv#Warn("There are no columns defined, can't hide away anything!")
        return
    endif
    if empty(a:col)
        let colnr=csv#WColumn()
    else
        let colnr=a:col
    endif
    let pat=csv#GetPat(colnr, csv#MaxColumns(), '.*', 1)
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
fu! csv#InitCSVFixedWidth() "{{{3
    if !exists("+cc")
        call csv#Warn("Command disabled: 'colorcolumn' option not available")
        return
    endif
    " Turn off syntax highlighting
    syn clear
    let max_line = line('$') > 10 ? 10 : line('$')
    let t = getline(1, max_line)
    let max_len = max(map(t, 'len(split(v:val, ''\zs''))'))
    let _cc  = &l:cc
    let &l:cc = 1
    redraw!
    let Dict = {'1': 1} " first column is always the start of a new column
    let tcc  = &l:cc
    let &l:cc = 1
    echo "<Cursor>, <Space>, <ESC>, <BS>, <CR>, ?"
    let char=getchar()
    while 1
        let skip_mess = 0
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
        elseif char == "\<CR>" || char == "\n" || char == "\r" || char == 13  " Enter
            let Dict[tcc] = 1
            break
        elseif char == char2nr('?')
            redraw!
            echohl Title
            echo    "Key\tFunction"
            echo    "=================="
            echohl Normal
            echo    "<cr>\tDefine new column"
            echo    "<left>\tMove left"
            echo    "<right>\tMove right"
            echo    "<esc>\tAbort"
            echo    "<bs>\tDelete last column definition"
            echo    "?\tShow this help\n"
            let skip_mess = 1
        else
            let Dict={}
            break
        endif
        let &l:cc=tcc . (!empty(keys(Dict))? ',' . join(keys(Dict), ','):'')
        if !skip_mess
          redraw!
          echo "<Cursor>, <Space>, <ESC>, <BS>, <CR>..."
        endif
        let char=getchar()
    endw
    let b:csv_fixed_width_cols=[]
    let tcc=0
    let b:csv_fixed_width_cols = sort(keys(Dict), s:csv_numeric_sort ? 'n' : 'csv#CSVSortValues')
    let b:csv_fixed_width = join(sort(keys(Dict), s:csv_numeric_sort ? 'n' : 'csv#CSVSortValues'), ',')
    call csv#Init(1, line('$'))

    let &l:cc=_cc
    redraw!
endfu
fu! csv#NewRecord(line1, line2, count) "{{{3
    if a:count =~ "\D"
        call csv#Warn("Invalid count specified")
        return
    endif

    let cnt = (empty(a:count) ? 1 : a:count)
    let record = ""
    for item in range(1,csv#MaxColumns())
        if !exists("b:col_width")
            " Best guess width
            if exists("b:csv_fixed_width_cols")
                let record .= printf("%*s", csv#ColWidth(item),
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
fu! csv#MoveOver(outer) "{{{3
    " Move over a field
    " a:outer means include the delimiter
    let last = 0
    let outer_field = a:outer
    let cur_field = csv#WColumn()
    let _wsv = winsaveview()

    if cur_field == csv#MaxColumns()
        let last = 1
        if !outer_field && getline('.')[-1:] != b:delimiter
            " No trailing delimiter, so inner == outer
            let outer_field = 1
        endif
    endif
    " Move 1 column backwards, unless the cursor is in the first column
    " or in front of a delimiter
    if matchstr(getline('.'), '.\%'.virtcol('.').'v') != b:delimiter && virtcol('.') > 1
        call csv#MoveCol(-1, line('.'))
    endif
"    if cur_field != csv#WColumn()
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
fu! csv#CSVMappings() "{{{3
    if !exists("g:no_plugin_maps") && !exists("g:no_csv_maps")
        call csv#Map('nnoremap', 'W', ':<C-U>call csv#MoveCol(1, line("."))<CR>')
        call csv#Map('nnoremap', '<C-Right>', ':<C-U>call csv#MoveCol(1, line("."))<CR>')
        call csv#Map('nnoremap', 'L', ':<C-U>call csv#MoveCol(1, line("."))<CR>')
        call csv#Map('nnoremap', 'E', ':<C-U>call csv#MoveCol(-1, line("."))<CR>')
        call csv#Map('nnoremap', '<C-Left>', ':<C-U>call csv#MoveCol(-1, line("."))<CR>')
        call csv#Map('nnoremap', 'H', ':<C-U>call csv#MoveCol(-1, line("."), 1)<CR>')
        call csv#Map('nnoremap', 'K', ':<C-U>call csv#MoveCol(0, line(".")-v:count1)<CR>')
        call csv#Map('nnoremap', '<Up>', ':<C-U>call csv#MoveCol(0, line(".")-v:count1)<CR>')
        call csv#Map('nnoremap', 'J', ':<C-U>call csv#MoveCol(0, line(".")+v:count1)<CR>')
        call csv#Map('nnoremap', '<Down>', ':<C-U>call csv#MoveCol(0, line(".")+v:count1)<CR>')
        call csv#Map('nnoremap', '<CR>', ':<C-U>call csv#PrepareFolding(1, 1)<CR>')
        call csv#Map('nnoremap', '<Space>', ':<C-U>call csv#PrepareFolding(1, 0)<CR>')
        call csv#Map('nnoremap', '<BS>', ':<C-U>call csv#PrepareFolding(0, 1)<CR>')
        call csv#Map('imap', '<CR>', 'csv#ColumnMode()', 'expr')
        " Text object: Field
        call csv#Map('xnoremap', 'if', ':<C-U>call csv#MoveOver(0)<CR>')
        call csv#Map('xnoremap', 'af', ':<C-U>call csv#MoveOver(1)<CR>')
        call csv#Map('omap', 'af', ':norm vaf<cr>')
        call csv#Map('omap', 'if', ':norm vif<cr>')
        call csv#Map('xnoremap', 'iL', ':<C-U>call csv#SameFieldRegion()<CR>')
        call csv#Map('omap', 'iL', ':<C-U>call csv#SameFieldRegion()<CR>')
        " Remap <CR> original values to a sane backup
        call csv#Map('noremap', '<LocalLeader>J', 'J')
        call csv#Map('noremap', '<LocalLeader>K', 'K')
        call csv#Map('xnoremap', '<LocalLeader>W', 'W')
        call csv#Map('xnoremap', '<LocalLeader>E', 'E')
        call csv#Map('noremap', '<LocalLeader>H', 'H')
        call csv#Map('noremap', '<LocalLeader>L', 'L')
        call csv#Map('nnoremap', '<LocalLeader><CR>', '<CR>')
        call csv#Map('nnoremap', '<LocalLeader><Space>', '<Space>')
        call csv#Map('nnoremap', '<LocalLeader><BS>', '<BS>')
    endif
endfu
fu! csv#CommandDefinitions() "{{{3
    call csv#LocalCmd("WhatColumn", ':echo csv#WColumn(<bang>0)',
        \ '-bang')
    call csv#LocalCmd("NrColumns", ':call csv#NrColumns(<q-bang>)', '-bang')
    call csv#LocalCmd("HiColumn", ':call csv#HiCol(<q-args>,<bang>0)',
        \ '-bang -nargs=?')
    call csv#LocalCmd("SearchInColumn",
        \ ':call csv#SearchColumn(<q-args>)', '-nargs=*')
    call csv#LocalCmd("DeleteColumn", ':call csv#DeleteColumn(<q-args>)',
        \ '-nargs=? -complete=custom,csv#SortComplete')
    call csv#LocalCmd("ArrangeColumn",
        \ ':call csv#ArrangeCol(<line1>, <line2>, <bang>0, -1, <q-args>)',
        \ '-range -bang -bar -nargs=?')
    call csv#LocalCmd("SmplVarCol",
        \ ':echo csv#EvalColumn(<q-args>, "csv#SmplVarianceColumn", <line1>,<line2>)',
        \ '-nargs=? -range=% -complete=custom,csv#SortComplete')
    call csv#LocalCmd("PopVarCol",
        \ ':echo csv#EvalColumn(<q-args>, "csv#PopVarianceColumn", <line1>,<line2>)',
        \ '-nargs=? -range=% -complete=custom,csv#SortComplete')
    call csv#LocalCmd("SmplStdCol",
        \ ':echo csv#EvalColumn(<q-args>, "csv#SmplStdDevColumn", <line1>,<line2>)',
        \ '-nargs=? -range=% -complete=custom,csv#SortComplete')
    call csv#LocalCmd("PopStdCol",
        \ ':echo csv#EvalColumn(<q-args>, "csv#SmplStdDevColumn", <line1>,<line2>)',
        \ '-nargs=? -range=% -complete=custom,csv#SortComplete')
    call csv#LocalCmd("UnArrangeColumn",
        \':call csv#PrepUnArrangeCol(<line1>, <line2>)',
        \ '-bar -range')
    call csv#LocalCmd("CSVInit", ':call csv#Init(<line1>,<line2>,<bang>0)',
        \ '-bang -range=%')
    call csv#LocalCmd('Header',
        \ ':call csv#SplitHeaderLine(<q-args>,<bang>0,1)',
        \ '-nargs=? -bang')
    call csv#LocalCmd('VHeader',
        \ ':call csv#SplitHeaderLine(<q-args>,<bang>0,0)',
        \ '-nargs=? -bang')
    call csv#LocalCmd("HeaderToggle",
        \ ':call csv#SplitHeaderToggle(1)', '')
    call csv#LocalCmd("VHeaderToggle",
        \ ':call csv#SplitHeaderToggle(0)', '')
    call csv#LocalCmd("Sort",
        \ ':call csv#Sort(<bang>0, <line1>,<line2>,<q-args>)',
        \ '-nargs=* -bang -range=% -complete=custom,csv#SortComplete')
    call csv#LocalCmd("Column",
        \ ':call csv#CopyCol(empty(<q-reg>)?''"'':<q-reg>,<q-count>,<q-args>)',
        \ '-count -register -nargs=?')
    call csv#LocalCmd("MoveColumn",
        \ ':call csv#MoveColumn(<line1>,<line2>,<f-args>)',
        \ '-range=% -nargs=* -complete=custom,csv#SortComplete')
    call csv#LocalCmd("SumCol",
        \ ':echo csv#EvalColumn(<q-args>, "csv#SumColumn", <line1>,<line2>)',
        \ '-nargs=? -range=% -complete=custom,csv#SortComplete')
    call csv#LocalCmd("MaxCol",
        \ ':echo csv#EvalColumn(<q-args>, "csv#MaxColumn", <line1>,<line2>, 1)',
        \ '-nargs=? -range=% -complete=custom,csv#SortComplete')
    call csv#LocalCmd("MinCol",
        \ ':echo csv#EvalColumn(<q-args>, "csv#MaxColumn", <line1>,<line2>, 0)',
        \ '-nargs=? -range=% -complete=custom,csv#SortComplete')
    call csv#LocalCmd("CountCol",
        \ ':echo csv#EvalColumn(<q-args>, "csv#CountColumn", <line1>,<line2>)',
        \ '-nargs=? -range=% -complete=custom,csv#SortComplete')
    call csv#LocalCmd("AvgCol",
        \ ':echo csv#EvalColumn(<q-args>, "csv#AvgColumn", <line1>,<line2>)',
        \ '-nargs=? -range=% -complete=custom,csv#SortComplete')
    call csv#LocalCmd('SumRow', ':call csv#SumCSVRow(<q-count>, <q-args>)',
        \ '-nargs=? -range')
    call csv#LocalCmd("ConvertData",
        \ ':call csv#PrepareDoForEachColumn(<line1>,<line2>,<bang>0)',
        \ '-bang -nargs=? -range=%')
    call csv#LocalCmd("Filters", ':call csv#OutputFilters(<bang>0)',
        \ '-nargs=0 -bang')
    call csv#LocalCmd("Analyze", ':call csv#AnalyzeColumn(<args>)',
        \ '-nargs=?')
    call csv#LocalCmd("VertFold", ':call csv#Vertfold(<bang>0,<q-args>)',
        \ '-bang -nargs=? -range=% -complete=custom,csv#SortComplete')
    call csv#LocalCmd("CSVFixed", ':call csv#InitCSVFixedWidth()', '')
    call csv#LocalCmd("NewRecord", ':call csv#NewRecord(<line1>,
        \ <line2>, <q-args>)', '-nargs=? -range')
    call csv#LocalCmd("NewDelimiter", ':call csv#NewDelimiter(<q-args>, 1, line(''$''))',
        \ '-nargs=1')
    call csv#LocalCmd("Duplicates", ':call csv#CheckDuplicates(<q-args>)',
        \ '-nargs=1 -complete=custom,csv#CompleteColumnNr')
    call csv#LocalCmd('Transpose', ':call csv#Transpose(<line1>, <line2>)',
        \ '-range=%')
    call csv#LocalCmd('CSVTabularize', ':call csv#Tabularize(<bang>0,<line1>,<line2>)',
        \ '-bang -range=%')
    call csv#LocalCmd("AddColumn",
        \ ':call csv#AddColumn(<line1>,<line2>,<f-args>)',
        \ '-range=% -nargs=* -complete=custom,csv#SortComplete')
    call csv#LocalCmd("DupColumn",
        \ ':call csv#DupColumn(<line1>,<line2>,<f-args>)',
        \ '-range=% -nargs=* -complete=custom,csv#SortComplete')
    call csv#LocalCmd('Substitute', ':call csv#SubstituteInColumn(<q-args>,<line1>,<line2>)',
        \ '-nargs=1 -range=%')
    call csv#LocalCmd('ColumnWidth', ':call csv#ColumnWidth()', '')
endfu
fu! csv#ColumnWidth()
    let w=CSVWidth()
    let i=1
    for col in w
        echomsg printf("Column %02i: %d", i, col)
        let i+=1
    endfor
endfu

fu! csv#Map(map, name, definition, ...) "{{{3
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
        elseif a:map == 'xnoremap'
            let unmap = 'xunmap'
        endif
        let b:undo_ftplugin .= "| " . unmap . " <buffer> " . a:name
    endif
endfu
fu! csv#LocalCmd(name, definition, args) "{{{3
    if !exists(':'.a:name)
        exe "com! -buffer " a:args a:name a:definition
        let b:undo_ftplugin .= "| sil! delc " . a:name
    endif
    " Setup :CSV<Command> Aliases
    if a:name !~ '^CSV'
        call csv#LocalCmd('CSV'.a:name, a:definition, a:args)
    endif
endfu
fu! csv#Menu(enable) "{{{3
    if a:enable
        " Make a menu for the graphical vim
        amenu CSV.&Init\ Plugin             :CSVInit<cr>
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
fu! csv#SaveOptions(list) "{{{3
    let save = {}
    for item in a:list
        exe "let save.". item. " = &l:". item
    endfor
    return save
endfu
fu! csv#NewDelimiter(newdelimiter, firstl, lastl) "{{{3
    let save = csv#SaveOptions(['ro', 'ma'])
    if exists("b:csv_fixed_width_cols")
        call csv#Warn("NewDelimiter does not work with fixed width column!")
        return
    endif
    if !&l:ma
        setl ma
    endif
    if &l:ro
        setl noro
    endif
    let delimiter = a:newdelimiter
    if a:newdelimiter is '\t'
        let delimiter="\t"
    endif
    let line=a:firstl
    while line <= a:lastl
        " Don't change delimiter for comments
        if getline(line) =~ '^\s*\V'. escape(b:csv_cmt[0], '\\')
            let line+=1
            continue
        endif
        let fields=split(getline(line), b:col . '\zs')
        " Remove field delimiter
        call map(fields, 'substitute(v:val, b:delimiter .
            \ ''\?$'' , "", "")')
        call setline(line, join(fields, delimiter))
        let line+=1
    endwhile
    " reset local buffer options
    for [key, value] in items(save)
        call setbufvar('', '&'. key, value)
    endfor
    "reinitialize the plugin
    if exists("g:csv_delim")
        let _delim = g:csv_delim
    endif
    let g:csv_delim = delimiter
    call csv#Init(1,line('$'))
    if exists("_delim")
        let g:csv_delim = _delim
    else
        unlet g:csv_delim
    endif
    unlet! _delim
endfu
fu! csv#IN(list, value) "{{{3
    for item in a:list
        if item == a:value
            return 1
        endif
    endfor
    return 0
endfu
fu! csv#DuplicateRows(columnlist) "{{{3
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
            if csv#IN(a:columnlist, i)
                let key .= column
            endif
            let i += 1
        endfor
        if has_key(duplicates, key) && cnt < 10
            call csv#Warn("Duplicate Row ". line)
            let cnt += 1
        elseif has_key(duplicates, key)
            call csv#Warn("More duplicate Rows after: ". line)
            call csv#Warn("Aborting...")
            return
        else
            let duplicates[key] = 1
        endif
        let line += 1
    endwhile
    if cnt == 0
        call csv#Warn("No Duplicate Row found!")
    endif
endfu
fu! csv#CompleteColumnNr(A,L,P) "{{{3
    return join(range(1,csv#MaxColumns()), "\n")
endfu
fu! csv#CheckDuplicates(list) "{{{3
    let string = a:list
    if string =~ '\d\s\?-\s\?\d'
        let string = substitute(string, '\(\d\+\)\s\?-\s\?\(\d\+\)',
            \ '\=join(range(submatch(1),submatch(2)), ",")', '')
    endif
    let list=split(string, ',')
    call csv#DuplicateRows(list)
endfu
fu! csv#Transpose(line1, line2) "{{{3
    " Note: - Comments will be deleted.
    "       - Does not work with fixed-width columns
    if exists("b:csv_fixed_width")
        call csv#Warn("Transposing does not work with fixed-width columns!")
        return
    endif
    let _wsv    = winsaveview()
    let TrailingDelim = 0

    if line('$') > 1
        let TrailingDelim = getline(1) =~ b:delimiter.'$'
    endif

    let pat = '^\s*\V'. escape(b:csv_cmt[0], '\\')

    try
        let columns = csv#MaxColumns(a:line1)
    catch
        " No column, probably because of comment or empty line
        " so use the number of columns from the beginning of the file
        let columns = csv#MaxColumns()
    endtry
    let matrix  = []
    for line in range(a:line1, a:line2)
        " Filter comments out
        if getline(line) =~ pat
            continue
        endif
        let r   = []
        for row in range(1,columns)
            let field = csv#GetColumn(line, row, 0)
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
fu! csv#NrColumns(bang) "{{{3
      try
          let cols = empty(a:bang) ? csv#MaxColumns() : csv#MaxColumns(line('.'))
      catch
          " No column or comment line
          call csv#Warn("No valid CSV Column!")
      endtry
    echo cols
endfu
fu! csv#Tabularize(bang, first, last) "{{{3
    if match(split(&ft, '\.'),'csv') == -1
        call csv#Warn("No CSV filetype, aborting!")
        return
    endif
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
        call csv#Warn("Looks already Tabularized, aborting!")
        return
    endif
    let _ma = &l:ma
    setl ma
    let colwidth = 0
    let adjust_last = 0
    call cursor(a:first,0)
    call csv#CheckHeaderLine()
    let line=a:first
    if exists("g:csv_table_leftalign")
        let b:csv_arrange_leftalign = 1
    endif
    let newlines=[]
    let content=[]
    while line <= a:last
        if foldclosed(line) != -1
            let line = foldclosedend(line) + 1
            continue
        endif
        let curline = getline(line)
        call add(content, curline)
        if empty(split(curline, b:delimiter))
            " only empty delimiters, add one empty delimiter
            " (:NewDelimiter strips trailing delimiter
            let curline = repeat(b:delimiter, csv#MaxColumns())
            call add(newlines, line)
            call setline(line, curline)
        endif
        let line+=1
    endw
    unlet! line
    let delim=b:delimiter
    new
    call setline(1,content)
    let b:delimiter=delim
    let csv_highlight_column = get(g:, 'csv_highlight_column', '')
    unlet! g:csv_highlight_column
    call csv#Init(1,line('$'), 1)
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
        sil call csv#ArrangeCol(1, line('$'), 0, -1)
        if !get(b:, 'csv_arrange_leftalign',0)
            for line in newlines
                let cline = getline(line)
                let cline = substitute(cline, '\s$', ' ', '')
                call setline(line, cline)
            endfor
            unlet! line
        endif
    endif

    if empty(b:col_width)
        call csv#Warn('An error occured, aborting!')
        return
    endif
    if getline(a:first)[-1:] isnot? b:delimiter
        let b:col_width[-1] += 1
    endif
    let marginline = s:td.scol. join(map(copy(b:col_width), 'repeat(s:td.hbar, v:val)'), s:td.cros). s:td.ecol

    call csv#NewDelimiter(s:td.vbar, 1, line('$'))
    "exe printf('sil %d,%ds/%s/%s/ge', a:first, (a:last+adjust_last),
    "    \ (exists("b:csv_fixed_width_cols") ? pat : b:delimiter ), s:td.vbar)
    " Add vertical bar in first column, if there isn't already one
    exe printf('sil %d,%ds/%s/%s/e', 1, line('$'),
        \ '^[^'. s:td.vbar. s:td.scol. ']', s:td.vbar.'&')
    " And add a final vertical bar, if there isn't one already
    exe printf('sil %d,%ds/%s/%s/e', 1, line('$'),
        \ '[^'. s:td.vbar. s:td.ecol. ']$', '&'. s:td.vbar)
    " Make nice intersection graphs
    let line = split(getline(1), s:td.vbar)
    call map(line, 'substitute(v:val, ''[^''.s:td.vbar. '']'', s:td.hbar, ''g'')')
    " Set top and bottom margins
    call append(0, s:td.ltop. join(line, s:td.dhor). s:td.rtop)
    call append(line('$'), s:td.lbot. join(line, s:td.uhor). s:td.rbot)

    if s:csv_fold_headerline > 0
        call append(1 + s:csv_fold_headerline, marginline)
        let adjust_last += 1
    endif
    " Syntax will be turned off, so disable this part
    "
    " Adjust headerline to header of new table
    "let b:csv_headerline = (exists('b:csv_headerline')?b:csv_headerline+2:3)
    "call csv#CheckHeaderLine()
    " Adjust syntax highlighting
    "unlet! b:current_syntax
    "ru syntax/csv.vim

    if a:bang
        exe printf('sil %d,%ds/^%s\zs\n/&%s&/e', 1 + s:csv_fold_headerline, line('$') + adjust_last,
                    \ '[^'.s:td.scol. '][^'.s:td.hbar.'].*', marginline)
    endif

    syn clear
    let &l:ma = _ma
    if !empty(csv_highlight_column)
      let g:csv_highlight_column = csv_highlight_column
    endif
    call winrestview(_c)
endfu
fu! csv#SubstituteInColumn(command, line1, line2) range "{{{3
    " Command can be something like 1,2/foobar/foobaz/ to replace in 1 and second column
    " Command can be something like /foobar/foobaz/ to replace in the current column
    " Command can be something like 1,$/foobar/foobaz/ to replace in all columns
    " Command can be something like 3/foobar/foobaz/flags to replace only in the 3rd column

    " Save position and search register
    let _wsv = winsaveview()
    let _search = [ '/', getreg('/'), getregtype('/')]
    let columns = []
    let maxcolnr = csv#MaxColumns()
    let simple_s_command = 0 " when set to 1, we can simply use an :s command

    " try to split on '/' if it is not escaped or in a collection
    let cmd = split(a:command, '\%([\\]\|\[[^]]*\)\@<!/')
    if a:command !~? '^\%([$]\|\%(\d\+\)\%(,\%([0-9]\+\|[$]\)\)\?\)/' ||
                \ len(cmd) == 2 ||
                \ ((len(cmd) == 3 && cmd[2] =~# '^[&cgeiInp#l]\+$'))
        " No Column address given
        call add(columns, csv#WColumn())
        let cmd = [columns[0]] + cmd "First item of cmd list contains address!
    elseif ((len(cmd) == 3 && cmd[2] !~# '^[&cgeiInp#l]\+$')
    \ || len(cmd) == 4)
        " command could be '1/foobbar/foobaz'
        " but also 'foobar/foobar/g'
        let columns = split(cmd[0], ',')
        if empty(columns)
            " No columns given? replace in current column only
            let columns[0] = csv#WColumn()
        elseif columns[-1] == '$'
            let columns[-1] = maxcolnr
        endif
    else " not reached ?
        call add(columns, csv#WColumn())
    endif

    try
        if len(cmd) == 1 || columns[0] =~ '\D' || (len(columns) == 2 && columns[1] =~ '\D')
            call csv#Warn("Error! Usage :S [columns/]pattern/replace[/flags]")
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
                let @/ = csv#GetPat(colnr, maxcolnr, cmd[1], 1)
                while search(@/)
                    let curpos = getpos('.')
                    " safety check
                    if (csv#WColumn() != colnr)
                      break
                    endif
                    if  len(split(getline('.'), '\zs')) > curpos[2] && csv#GetCursorChar() is# b:delimiter
                      " Cursor is on delimiter and next char belongs to the
                      " next field, skip this match
                      norm! l
                      if (csv#WColumn() != colnr)
                        break
                      endif
                      call setpos('.', curpos)
                    endif
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
fu! csv#ColumnMode() "{{{3
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
fu! csv#Timeout(start) "{{{3
    return localtime()-a:start < 2
endfu
fu! csv#GetCursorChar() "{{{3
    let register = ['a', getreg('a'), getregtype('a')]
    try
      norm! v"ay
      let s=getreg('a')
      return s
    finally
      call call('setreg', register)
    endtry
endfu

fu! csv#SameFieldRegion() "{{{3
    " visually select the region, that has the same value in the cursor field
    let col = csv#WColumn()
    let max = csv#MaxColumns()
    let field = csv#GetColumn(line('.'), col, 0)
    let line = line('.')

    let limit = [line, line]
    " Search upwards and downwards from the current position and find the
    " limit of the current selection
    while line > 1
        let line -= 1
        if csv#GetColumn(line, col, 0) ==# field
            let limit[0] = line
        else
            break
        endif
    endw
    let line = line('.')
    while line > 1 && line < line('$')
        let line += 1
        if csv#GetColumn(line, col, 0) ==# field
            let limit[1] = line
        else
            break
        endif
    endw
    exe printf(':norm! %dGV%dG',limit[0],limit[1])
endfu

fu! csv#GetCells(list) "{{{3
    " returns the content of the cells
    let column=a:list
    " Delete delimiter
    call map(column, 'substitute(v:val, b:delimiter . "$", "", "g")')
    " Revmoe trailing whitespace
    call map(column, 'substitute(v:val, ''^\s\+$'', "", "g")')
    " Remove leading whitespace
    call map(column, 'substitute(v:val, ''^\s\+'', "", "g")')
    return column
endfu
fu! CSV_CloseBuffer(buffer) "{{{3
    " Setup by SetupAutoCmd autocommand
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
fu! CSV_SetSplitOptions(window) "{{{3
    if exists("s:local_stl")
        " local horizontal statusline
        for opt in items({'&nu': &l:nu, '&rnu': &l:rnu, '&fdc': &fdc})
            if opt[1] != getwinvar(a:window, opt[0])
                call setwinvar(a:window, opt[0], opt[1])
            endif
        endfor
        " Check statusline (airline might change it)
        if getwinvar(a:window, '&l:stl') != s:local_stl
            call setwinvar(a:window, '&stl', s:local_stl)
        endif
    endif
endfun
" Global functions "{{{2
fu! csv#EvalColumn(nr, func, first, last, ...) range "{{{3
    " Make sure, the function is called for the correct filetype.
    if match(split(&ft, '\.'), 'csv') == -1
        call csv#Warn("File is no CSV file!")
        return
    endif
    let save = winsaveview()
    call csv#CheckHeaderLine()
    let nr = matchstr(a:nr, '^\-\?\d\+')
    let col = (empty(nr) ? csv#WColumn() : nr)
    if col == 0
        let col = 1
    endif

    let start = a:first - 1
    let stop  = a:last  - 1

    if a:first <= s:csv_fold_headerline
        " don't take the header line into consideration
        let start += s:csv_fold_headerline
        let stop  += s:csv_fold_headerline
    endif

    let column = csv#CopyCol('', col, '')[start : stop]
    let column = csv#GetCells(column)
    " Delete empty values
    " Leave this up to the function that does something
    " with each value
    "call filter(column, '!empty(v:val)')

    " parse the optional number format
    let format = matchstr(a:nr, '/[^/]*/')
    let s:additional={}
    call csv#NumberFormat()
    if !empty(format)
        try
            let s = []
            " parse the optional number format
            let str = matchstr(format, '/\zs[^/]*\ze/', 0, start)
            let s = matchlist(str, '\(.\)\?:\(.\)\?')[1:2]
            if empty(s)
                " Number format wrong
                call csv#Warn("Numberformat wrong, needs to be /x:y/!")
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
    let distinct = matchstr(a:nr, '\<distinct\>')
    if !empty(distinct)
      let s:additional.distinct=1
    endif
    if function(a:func) is# function("csv#MaxColumn")
      let s:additional.ismax = a:1
    endif
    try
        let result=call(function(a:func), [column])
        let b:csv_result = string(result)
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
fu! csv#SumCSVRow(line, nr) "{{{3
    let ln = a:line
    if a:line == -1
        let ln = line('.')
    elseif a:line > line('$')
        call csv#Warn("Invalid count specified")
        return
    endif
    let line=getline(ln)
    " Filter comments out
    let pat = '^\s*\V'. escape(b:csv_cmt[0], '\\')
    if line =~ pat
        call csv#Warn("Invalid count specified")
        return
    endif
    let func='csv#SumColumn'
    let cells=split(line, b:col.'\zs')
    let cells=csv#GetCells(cells)
    " parse the optional number format
    let format = matchstr(a:nr, '/[^/]*/')
    call csv#NumberFormat()
    let save = winsaveview()
    if !empty(format)
        try
            let s = []
            " parse the optional number format
            let str = matchstr(format, '/\zs[^/]*\ze/', 0, start)
            let s = matchlist(str, '\(.\)\?:\(.\)\?')[1:2]
            if empty(s)
                " Number format wrong
                call csv#Warn("Numberformat wrong, needs to be /x:y/!")
                return
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
        let result=call(function(func), [cells])
        echo printf("Sum of line %d: %s", ln, result)
    catch
        " Evaluation of expression failed
        echohl Title
        echomsg "Evaluating the Sum failed for line ". ln
        echohl Normal
    finally
        call winrestview(save)
    endtry
endfu

fu! CSVField(x, y, ...) "{{{3
    if &ft != 'csv'
        return
    endif
    let y = a:y - 1
    let x = (a:x < 0 ? 0 : a:x)
    let orig = !empty(a:0)
    let y = (y < 0 ? 0 : y)
    let x = (x > (csv#MaxColumns()) ? (csv#MaxColumns()) : x)
    let col = csv#CopyCol('',x,'')
    if !orig
    " remove leading and trainling whitespace and the delimiter
        return matchstr(col[y], '^\s*\zs.\{-}\ze\s*'.b:delimiter.'\?$')
    else
        return col[y]
    endif
endfu
" return current column number (if a:0 is given, returns the name
fu! CSVCol(...) "{{{3
    return csv#WColumn(a:0)
endfu
fu! CSVPat(colnr, ...) "{{{3
    " Make sure, we are working in a csv file
    if &ft != 'csv'
        return ''
    endif
    " encapsulates GetPat(), that returns the search pattern for a
    " given column and tries to set the cursor at the specific position
    let pat = csv#GetPat(a:colnr, csv#MaxColumns(), a:0 ? a:1 : '.*', 1)
    "let pos = match(pat, '.*\\ze') + 1
    " Try to set the cursor at the beginning of the pattern
    " does not work
    "call setcmdpos(pos)
    return pat
endfu
fu! CSVSum(col, fmt, first, last) "{{{3
    let first = a:first
    let last  = a:last
    if empty(first)
        let first = 1
    endif
    if empty(last)
        let last = line('$')
    endif
    return csv#EvalColumn(a:col, 'csv#SumColumn', first, last)
endfu
fu! CSVMax(col, fmt, first, last) "{{{3
    let first = a:first
    let last  = a:last
    if empty(first)
        let first = 1
    endif
    if empty(last)
        let last = line('$')
    endif
    return csv#EvalColumn(a:col, 'csv#MaxColumn', first, last, 1)
endfu
fu! CSVMin(col, fmt, first, last) "{{{3
    let first = a:first
    let last  = a:last
    if empty(first)
        let first = 1
    endif
    if empty(last)
        let last = line('$')
    endif
    return csv#EvalColumn(a:col, 'csv#MaxColumn', first, last, 0)
endfu
fu! CSVCount(col, fmt, first, last, ...) "{{{3
    let first = a:first
    let last  = a:last
    let distinct = 0
    if empty(first)
        let first = 1
    endif
    if empty(last)
        let last = line('$')
    endif
    if !exists('s:additional')
      let s:additional = {}
    endif
    if exists("a:1") &&  !empty(a:1)
      let s:additional['distinct'] = 1
    endif
    let result=csv#EvalColumn(a:col, 'csv#CountColumn', first, last, distinct)
    unlet! s:additional['distinct']
    return (empty(result) ? 0 : result)
endfu
fu! CSVWidth() "{{{3
    " does not work with fixed width columns
    if exists("b:csv_fixed_width_cols")
        let c = getline(1,'$')
        let c = map(c, 'substitute(v:val, ".", "x", "g")')
        let c = map(c, 'strlen(v:val)+0')
        let max = max(c)
        let temp = copy(b:csv_fixed_width_cols)
        let width = []
        let y=1
        " omit the first item, since the starting position is not very useful
        for i in temp[1:]
            let length=i-y
            let y=i
            call add(width, length)
        endfor
        " Add width for last column
        call add(width, max-y+1)
    else
        call csv#CalculateColumnWidth('')
        let width=map(copy(b:col_width), 'v:val-1')
    endif
    return width
endfu
fu! CSV_WCol(...) "{{{3
    " Needed for airline
    try
        if line('$') == 1 && empty(getline(1))
            " Empty file
            return ''
        elseif exists("a:1") && (a:1 == 'Name' || a:1 == 1)
            return printf("%s", csv#WColumn(1))
        else
            return printf(" %d/%d", csv#WColumn(), csv#MaxColumns())
        endif
    catch
        return ''
    endtry
endfun

" Vim Modeline " {{{2
" vim: set foldmethod=marker et sw=0 sts=-1 ts=4:

endif
