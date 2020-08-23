"=============================================================================
" File:         eregex.vim and eregex_e.vim
" Author:       AKUTSU toshiyuki <locrian@mbd.ocn.ne.jp>
" Maintainer:   Kao, Wei-Ko <othree@gmail.com>
" Requirements: Vim version 6.1 and later.
" Description:  eregex.vim is a converter from extended regex to vim regex
"               eregex_e.vim is an evaluater for command of eregex.vim
"               The meaning of extended regex is pseudo ruby/perl-style regex.
"               Previous $Id: eregex.vim,v 2.56 2010-10-18 11:59:41+08 ta Exp $
"               $Id: eregex.vim,v 2.60 2013-02-22 14:38:41+08 ta Exp $
" Note:         English isn't my mother tongue.
"=============================================================================
" Principle:
" eregex.vim adopts the way of extended regex about "alternation",
" "repetition" and "grouping".
" As for those things, the way of Vim regex is adopted.
" You can use '\_^', '\zs', '\<', '\%<23c', '\_u', etc in extended regex.
"=============================================================================
" Functions:
"
" E2v({extended_regex} [, {iISCDMm}])
"     The result is a String, which is vim style regex.
"
"     :let vimregex = E2v('(?<=abc),\d+,(?=xzy)','i')
"     :echo vimregex
"     \c\%(abc\)\@<=,\d\+,\%(xzy\)\@=
"
" E2v('','V')
"     The result is a Number, which is eregex.vim version.
"
"     :echo E2v('','V')
"     238
"
" E2v({replacement} ,{R1,R2,R3})
"     The result is a String, which is used for the "to" part of :S/from/to/
"
"     E2v('\r,\n,\&,&,\~,~', 'R1') => \n,\r,\&,&,\~,~
"     E2v('\r,\n,\&,&,\~,~', 'R2') => \r,\n,&,\&,~,\~
"     E2v('\r,\n,\&,&,\~,~', 'R3') => \n,\r,&,\&,~,\~
"
"=============================================================================
" Commands:
"
" :[range]E2v [iISCDMm]
"     Extended regex To Vim regex.
"     Replace each extended-regex in [range] with vim-style-regex.
"
" :M/eregex/[offset][iISCDMm]
"     Match.
"     :M/<span class="foo">.*?<\/span>/Im
"     => /\C<span class="foo">\_.\{-}<\/span>
"
" :[range]S/eregex/replacement/[&cegpriISCDMm]
"     Substitute.
"     :'<,'>S/(\d{1,3})(?=(\d\d\d)+($|\D))/\1,/g
"     => :'<,'>s/\(\d\{1,3}\)\%(\(\d\d\d\)\+\($\|\D\)\)\@=/\1,/g
"
" :[range]G/eregex/command
"     Global.
"     :G/<<-(["'])?EOD\1/,/^\s*EOD\>/:left 8
"     => :g/<<-\(["']\)\=EOD\1/,/^\s*EOD\>/:left 8
"
" :[range]V/eregex/command
"     Vglobal
"
"=============================================================================
" Tips And Configuration:
"
" Put the following commands in your ~/.vimrc to replace normal / with :M/
"
" nnoremap / :M/
" nnoremap ,/ /
"
" v238, v243
" If you put 'let eregex_replacement=3' in your ~/.vimrc,
"
" :S/pattern/\r,\n,\&,&,\~,~/ will be converted to :s/pattern/\n,\r,&,\&,~,\~/
"
"    +--------------------+-----------------------------+
"    | eregex_replacement | :S/pattern/\n,\r,&,\&,~,\~/ |
"    +--------------------+-----------------------------+
"    | 0                  | :s/pattern/\n,\r,&,\&,~,\~/ |
"    | 1                  | :s/pattern/\r,\n,&,\&,~,\~/ |
"    | 2                  | :s/pattern/\n,\r,\&,&,\~,~/ |
"    | 3                  | :s/pattern/\r,\n,\&,&,\~,~/ |
"    +--------------------+-----------------------------+
" See :h sub-replace-special
"
"=============================================================================
" Options:
"   Note: "^L" is "\x0c".
"
"   "i"   ignorecase
"   "I"   noignorecase
"   "S"   convert "\s" to "[ \t\r\n^L]" and also convert "\S" to "[^ \t\r^L]"
"         Mnemonic:  extended spaces
"   "C"   convert "[^az]" to "\_[^az]" and also convert "\W" to "\_W".
"         Mnemonic: extended complement
"         Vim's "[^az]" matches anything but "a", "z", and a newline.
"   "D"   convert "." to "\_."
"         Mnemonic: extended dot
"         Normally, "." matches any character except a newline.
"   "M"   partial multiline;  do both "S" and "C".
"         In other words, It is not "multiline" in ruby way.
"   "m"   full multiline;  do all the above conversions "S", "C" and "D".
"         In other words, It is just "multiline" in ruby way.
"
"+-----+----------------------------------------------+--------------------+
"| Num | eregex.vim      => vim regex                 | ruby regex         |
"+-----+----------------------------------------------+--------------------+
"| (1) | :M/a\s[^az].z/  => /a\s[^az].z/              | /a[ \t][^az\n].z/  |
"+-----+----------------------------------------------+--------------------+
"|     | :M/a\s[^az].z/S => /a[ \t\r\n^L][^az].z/     | /a\s[^az\n].z/     |
"|     | :M/a\s[^az].z/C => /a\s\_[^az].z/            | /a[ \t][^az].z/    |
"|     | :M/a\s[^az].z/D => /a\s[^az]\_.z/            | /a[ \t][^az\n].z/m |
"+-----+----------------------------------------------+--------------------+
"| (2) | :M/a\s[^az].z/M => /a[ \t\r\n^L]\_[^az].z/   | /a\s[^az].z/       |
"| (3) | :M/a\s[^az].z/m => /a[ \t\r\n^L]\_[^az]\_.z/ | /a\s[^az].z/m      |
"+-----+----------------------------------------------+--------------------+
"
"    Note:
"        As for "\s", "[^az]" and ".",   "M" and "m" options make
"        eregex.vim-regexen compatible with ruby/perl-style-regexen.
"    Note:
"        Vim's "[^az]" doesn't match a newline.
"        Contrary to the intention, "[^az\n]" matches a newline.
"        The countermeasure is to convert "[^\s]" to "[^ \t\r^L]" with
"        multiline.
"
"=============================================================================
" pseudo ruby/perl-style regexen.
"
"   available extended regexen:
"       alternation:
"           "a|b"
"       repetition:
"           "a+", "a*", "a?", "a+?", "a*?", "a??,"
"           "a{3,5}", "a{3,}", "a{,5}", "a{3,5}?", "a{3,}?", "a{,5}?"
"       grouping:
"           "(foo)", "(?:foo)", "(?=foo)", "(?!foo)", "(?<=foo)",
"           "(?<!foo)", "(?>foo)"
"       modifiers:
"           "(?I)", "(?i)", "(?M)", "(?m)", "(?#comment)"
"
"       Note:
"       The use of "\M" or "\m" is preferable to the use of "(?M)" or "(?m)".
"       "(?M)" and "(?m)" can't expand "\s" in brackets to " \t\r\n^L".
"
"    not available extended regexen:
"       "\A", "\b", "\B", "\G", "\Z", "\z",
"       "(?i:a)", "(?-i)", "(?m:.)",
"       There are no equivalents in vim-style regexen.
"
"    special atoms:
"       "\C"   noignorecase
"       "\c"   ignorecase
"       "\M"   partial multiline
"       "\m"   full multiline
"
"       For example:
"       :M/a\s[^az].z/M  => /a[ \t\r\n^L]\_[^az].z/
"       :M/a\s[^az].z\M/ => /a[ \t\r\n^L]\_[^az].z/
"       :M/a\s[^az].z/m  => /a[ \t\r\n^L]\_[^az]\_.z/
"       :M/a\s[^az].z\m/ => /a[ \t\r\n^L]\_[^az]\_.z/
"       The order of priority:
"       [A] /IiMm,  [B] \C, \c, \M, \m, [C] (?I), (?i), (?M), (?m)
"
"    many other vim-style regexen available:
"       "\d", "\D", "\w", "\W", "\s", "\S", "\a", "\A",
"       "\u", "\U", "\b"
"       "\<", "\>"
"       "\zs", "\ze"
"       "\_[a-z]", "\%[abc]", "[[:alpha:]]"
"       "\_.", "\_^", "\_$"
"       "\%23l", "\%23c", "\%23v", "\%#"
"       and so on. See :h /ordinary-atom
"
"    misc:
"       Convert "\xnn" to char except "\x00", "\x0a" and "\x08".
"       "\x41\x42\x43"  => "ABC"
"       "\x2a\x5b\x5c"  => "\*\[\\"
"       Expand atoms in brackets.
"       "[#$\w]" => "[#$0-9A-Za-z_]"
"
"       "\f" in brackets is converted to "\x0c".
"       but "\f" out of brackets is a class of filename characters.
"
"    eregex.vim expansion of atoms and its meaning.
"    +-------+----------------------+----------------------+
"    | atom  | out of brackets      | in brackets          |
"    +-------+----------------------+----------------------+
"    | \a    | alphabetic char      | alphabetic char      |
"    | \b    | \x08                 | \x08                 |
"    | \e    | \x1b                 | \x1b                 |
"    | \f    | filename char        | \x0c                 |
"    | \n    | \x0a                 | \x0a                 |
"    | \r    | \x0d                 | \x0d                 |
"    | \s    | [ \t] or [ \t\r\n\f] | " \t" or " \t\r\n\f" |
"    | \t    | \x09                 | \x09                 |
"    | \v    | \x0b                 | \x0b                 |
"    | \xnn  | hex nn               | hex nn               |
"    +-------+----------------------+----------------------+
"
"=============================================================================
if version < 601 | finish | endif
if exists("loaded_eregex")
    finish
endif
let loaded_eregex=1
"=============================================================================
"Commands And Mappings:
command! -nargs=? -range E2v :<line1>,<line2>call <SID>ExtendedRegex2VimRegexLineWise(<q-args>)
command! -nargs=? -count=1 M :let s:eregex_tmp_hlsearch = &hlsearch | let v:searchforward = <SID>Ematch(<count>, <q-args>) | if s:eregex_tmp_hlsearch == 1 | set hlsearch | endif
"command! -nargs=? -range S :<line1>,<line2>call <SID>Esubstitute(<q-args>)
command! -nargs=? -range S :<line1>,<line2>call <SID>Esubstitute(<q-args>) <Bar> :noh

command! -nargs=? -range=% -bang G :<line1>,<line2>call <SID>Eglobal(<q-bang>, <q-args>)
command! -nargs=? -range=% V :<line1>,<line2>call <SID>Evglobal(<q-args>)

"=============================================================================
"Script Variables:
let s:eglobal_working=0

"--------------------
let s:ch_with_backslash=0
let s:ch_posix_charclass=1
let s:ch_brackets=2
let s:ch_braces=3
let s:ch_parentheses_option=4
let s:ch_parentheses=5

let s:re_factor{0}='\\\%([^x_]\|x\x\{0,2}\|_[.$^]\=\)'

let s:re_factor{1}= '\[:\%(alnum\|alpha\|blank\|cntrl\|digit\|graph\|lower\|print\|punct\|' .
          \  'space\|upper\|xdigit\|return\|tab\|escape\|backspace\):\]'

let s:re_factor{2}='\[\%([^^][^]]*\|\^.[^]]*\)\]'

let s:re_factor{3}='{[0-9,]\+}?\='

"v141
"let s:re_factor{4}='(?[iISCDMm]\{1,7})'
let s:re_factor{4}='(?[iImM]\{1,2})'
let s:re_factor{5}='(\(?:\|?=\|?!\|?<=\|?<!\|?>\|?[-#ixm]\)\=[^()]*)'

let s:re_factor_size=6
"--------------------
let s:mark_left="\<Esc>" . strftime("%X") . ":" . strftime("%d") . "\<C-f>"
let s:mark_right="\<C-l>" . strftime("%X") . ":" . strftime("%d") . "\<Esc>"

let s:stack_size=0

let s:invert=0
let s:multiline=0
let s:ignorecase=0

"v220
let s:re_unescaped='\%(\\\)\@<!\%(\\\\\)*\zs'
let s:re_escaped='\%(\\\)\@<!\%(\\\\\)*\zs\\'
let s:bakregex=''

let s:mark_complements=s:mark_left . 'cOmPLemEnTs' . s:mark_right

"v141, 210
let s:extended_spaces=0
let s:extended_complements=0
let s:extended_dots=0
let s:str_modifiers='iISCDMm'
let s:meta_chars='$*.[\]^~'

"v217
"Why does "[^abc\n]" match  a newline ???
let s:countermeasure=1
":M/(?:v21[5-9]|why)/i

"v238
let s:eregex_replacement=0
if exists('eregex_replacement')
    let s:eregex_replacement=eregex_replacement
endif

"v240
let s:tmp=matchstr("$Revision: 2.60 $", '[0-9.]\+')
let s:maj=matchstr(s:tmp, '\d\+') * 100
let s:min=matchstr(s:tmp, '\.\zs\d\+') + 0
let s:version = s:maj + s:min
unlet s:tmp s:maj s:min

"v260
if !exists('g:eregex_forward_delim')
  let g:eregex_forward_delim = '/'
endif

if !exists('g:eregex_backward_delim')
  let g:eregex_backward_delim = '?'
endif

"v262
if !exists('g:eregex_force_case')
  let g:eregex_force_case = 0
endif


let s:enable = 0

function! eregex#toggle(...)
  let silent = 0
  if exists('a:1') && a:1
    let silent = 1
  endif
  if s:enable == 0
    exec 'nnoremap <expr> '.g:eregex_forward_delim.' ":<C-U>".v:count1."M/"'
    exec 'nnoremap <expr> '.g:eregex_backward_delim.' ":<C-U>".v:count1."M?"'
    if silent != 1
      echo "eregx.vim key mapping enabled"
    endif
  else
    exec 'nunmap '.g:eregex_forward_delim
    exec 'nunmap '.g:eregex_backward_delim
    if silent != 1
      echo "eregx.vim key mapping disabled"
    endif
  endif
  let s:enable = 1 - s:enable
endfun

if !(exists('g:eregex_default_enable') && g:eregex_default_enable == 0)
  call eregex#toggle(1)
endif

"=============================================================================
"Functions:
function! s:Push(fct, kind)
    let fct = a:fct

    if (a:kind==s:ch_with_backslash) && (fct =~# '^\\x\x\{1,2}$')
    " \x41
        exec 'let code=0 + 0x' . matchstr(fct, '\x\{1,2}$')
        if code!=0x0a && code!=0 && code!=0x08
            let fct = nr2char(code)
            "v141
            if stridx(s:meta_chars, fct)!=-1
                let fct = "\\" . fct
            endif

        endif

    elseif a:kind == s:ch_with_backslash
    " \.  \_x
        let chr = fct[1]
        if chr =~# '[+?{}|()=]'
            let fct = chr
        elseif chr =~# '[Vv]'
            if chr ==# 'v'
                let fct=nr2char(0x0b)
            else
                let fct='V'
            endif
        "[IiMm]
        endif

    elseif a:kind == s:ch_posix_charclass
    " [:alpha:] pass through

    elseif a:kind == s:ch_brackets
    "[ ]
        let fct = s:ExpandAtomsInBrackets(fct)
    elseif a:kind == s:ch_braces
    "{ }
        let fct = '\' . fct
        " minimal match, not greedy
        if fct =~# '?$'
            if fct =~# '\d\+,\d\+'
                let fct = substitute(fct, '{\(\d\+\),\(\d\+\)}?', '{-\1,\2}', '')
            elseif fct =~# ',}'
                let fct = substitute(fct, '{\(\d\+\),}?', '{-\1,}', '')
            elseif fct =~# '{,'
                let fct = substitute(fct, '{,\(\d\+\)}?', '{-,\1}', '')
            else
                let fct = strpart(fct, 1)
            endif
        endif
    elseif a:kind==s:ch_parentheses_option
    "( )
        "v223
        call s:SetModifiers(fct)
        let fct = ''

    elseif (a:kind==s:ch_parentheses) && (fct =~# '(?[-#ixm]')
    "( )
        if fct =~# '(?-\=[ixm]\{1,3})' || fct =~# '(?#'
            let fct = ''
        else
            let fct = substitute(fct, '(?-\=[ixm]\{1,3}:\([^()]*\))', '\1', "")
            let fct = s:ReplaceRemainFactorWithVimRegexFactor(fct)
        endif

    elseif a:kind==s:ch_parentheses
    "( )
        let kakko = matchstr(fct, '(\(?:\|?=\|?!\|?<=\|?<!\|?>\)\=')
        let fct = substitute(fct, '(\(?:\|?=\|?!\|?<=\|?<!\|?>\)\=', "", "")
        let fct = strpart(fct, 0, strlen(fct)-1)
        let fct = s:ReplaceRemainFactorWithVimRegexFactor(fct)
        if kakko ==# '('
            let fct = '\(' . fct . '\)'
        elseif kakko ==# '(?:'
            let fct = '\%(' . fct . '\)'
        elseif kakko ==# '(?='
            let fct = '\%(' . fct . '\)\@='
        elseif kakko ==# '(?!'
            let fct = '\%(' . fct . '\)\@!'
        elseif kakko ==# '(?<='
            let fct = '\%(' . fct . '\)\@<='
        elseif kakko ==# '(?<!'
            let fct = '\%(' . fct . '\)\@<!'
        elseif kakko ==# '(?>'
            let fct = '\%(' . fct . '\)\@>'
        else
            let fct = ":BUG:"
        endif

    endif
    let s:stack{s:stack_size} = fct
    let s:stack_size = s:stack_size + 1
endfunction
"end s:Push()
"-----------------------------------------------------------------------------
function! s:ExpandAtomsInBrackets(bracket)
    let bracket = a:bracket
    let re_mark = s:mark_left . '\d\+' . s:mark_right
    let re_snum = s:mark_left . '\(\d\+\)' . s:mark_right
    "v120
    let has_newline=0
    "v216,v249
    let complement=(bracket =~# '^\[^')

    let searchstart = 0
    let mtop = match(bracket, re_mark, searchstart)
    while mtop >= 0
        let mstr = matchstr(bracket, re_mark, searchstart)
        let snum = substitute(mstr, re_snum, '\1', "") + 0
        "v222
        let fct = s:stack{snum}
        "exclude, \e=0x1b, \b=0x08, \r=0x0d, \t=0x09
        if fct =~# '^\\[adfhlosuwx]$'
            let chr = fct[1]
            if chr ==# 'a'
                let fct='A-Za-z'
            elseif chr ==# 'd'
                let fct='0-9'
            elseif chr ==# 'f'
                "let fct=nr2char(0x0c)
                let fct="\x0c"
            elseif chr ==# 'h'
                let fct='A-Za-z_'
            elseif chr ==# 'l'
                let fct='a-z'
            elseif chr ==# 'o'
                let fct='0-7'
            elseif chr ==# 's'
                "v141
                if s:extended_spaces==1
                    "v217
                    if (s:countermeasure==1) && (complement==1)
                        let fct=" \\t\\r\x0c"
                    else
                        let fct=" \\t\\r\\n\x0c"
                    endif
                    let has_newline=1
                else
                    let fct=' \t'
                endif
            elseif chr ==# 'u'
                let fct='A-Z'
            elseif chr ==# 'w'
                let fct='0-9A-Za-z_'
            elseif chr ==# 'x'
                let fct='0-9A-Fa-f'
            endif

            let s:stack{snum}=fct
        else
            "v120
            if fct ==# '\n'
            "If there is only "\n" of inside of the brackets.
            "It becomes the same as "\_.".
                let has_newline=1
            "v219
            elseif fct ==# '-'
            " '-' converted from \xnn
            "If there is '-' in the beginning of the brackets and the end.
            "Unnecessary '\' is stuck.
                let s:stack{snum}='\-'
            "v237
            elseif fct ==# '\['
            " '\[' converted from \xnn
                let s:stack{snum}='['
            endif
        endif

        let searchstart = mtop + strlen(mstr)
        let mtop = match(bracket, re_mark, searchstart)
    endwhile

    "v120
    if (complement==1) && (has_newline==0)
        let bracket = s:mark_complements . bracket
    endif

    return bracket
endfunction
"end ExpandAtomsInBrackets()
"-----------------------------------------------------------------------------
function! s:Pop()
    if s:stack_size <= 0 | return "" | endif
    let s:stack_size = s:stack_size - 1
    return s:stack{s:stack_size}
endfunction
"-----------------------------------------------------------------------------
" Debug:
function! s:UnletStack()
    let i = 0
    while exists("s:stack" . i)
        exec "unlet s:stack" . i
        let i = i + 1
    endwhile
    let s:stack_size = 0
endfunction
" Debug:
"function! EachStack()
"    let lineno = line(".")
"    let i = 0
"    while exists("s:stack" . i)
"        call append(lineno + i,  i . " -> " . s:stack{i})
"        let i = i + 1
"    endwhile
"endfunction
"-----------------------------------------------------------------------------
function! s:ReplaceExtendedRegexFactorWithNumberFactor(extendedregex)
    let halfway = a:extendedregex
    let s:stack_size = 0
    let i=0
    let id_num=0
    while i < s:re_factor_size
        "CASESENSE:
        let regex = '\C' . s:re_factor{i}
        let mtop = match(halfway, regex)
        while mtop >= 0
            let factor = matchstr(halfway, regex)
            let pre_match = strpart(halfway, 0, mtop)
            let post_match= strpart(halfway, mtop + strlen(factor))
            let halfway = pre_match . s:mark_left . id_num . s:mark_right . post_match
            "END:
            call s:Push( factor, i )
            let id_num = id_num + 1
            let mtop = match(halfway, regex)
        endwhile
        let i = i + 1
    endwhile
    return halfway
endfunction
"end s:ReplaceExtendedRegexFactorWithNumberFactor()
"-----------------------------------------------------------------------------
function! s:ReplaceRemainFactorWithVimRegexFactor(halfway)
    let halfway = a:halfway

    " minimal match, not greedy
    let halfway = substitute(halfway, '+?', '\\{-1,}', 'g')
    let halfway = substitute(halfway, '\*?', '\\{-}', 'g')
    let halfway = substitute(halfway, '??', '\\{-,1}', 'g')
    "--------------------
    let halfway = substitute(halfway, '+', '\\+', 'g')
    let halfway = substitute(halfway, '?', '\\=', 'g')
    "--------------------
    let halfway = substitute(halfway, '|', '\\|', 'g')

    "--------------------
    let halfway = substitute(halfway, '\~', '\\&', 'g')
    "--------------------
    "v141
    if s:extended_dots==1
        let halfway = substitute(halfway, '\.', '\\_.', 'g')
    endif

    return halfway
endfunction
"end s:ReplaceRemainFactorWithVimRegexFactor()
"-----------------------------------------------------------------------------
function! s:ReplaceNumberFactorWithVimRegexFactor(halfway)
    let vimregex = a:halfway

    let i = s:stack_size
    while i > 0
        let i = i - 1

        let factor = s:Pop()
        let str_mark = s:mark_left . i . s:mark_right
        let vimregex = s:ReplaceAsStr(vimregex, str_mark, factor)
    endwhile
    "Debug:
    call s:UnletStack()

    "v221
    "v120
    if stridx(vimregex, s:mark_complements)!=-1
        "v141
        if s:extended_complements==1
            "there isn't \_ before [^...].
            " [^...] doesn't contain \n.
            let re='\C\%(\%(\\\)\@<!\(\\\\\)*\\_\)\@<!\zs' . s:mark_complements
            let vimregex = substitute(vimregex, re, '\\_', "g")
        endif
        let vimregex = substitute(vimregex, '\C' . s:mark_complements, '', "g")
    endif
    "v220
    if s:extended_complements==1
        let re='\C' . s:re_escaped . '\([ADHLOUWX]\)'
        let vimregex = substitute(vimregex, re, '\\_\1', "g")
    endif
    "v141
    if s:extended_spaces==1
        "    | atom | normal   | extended spaces
        "    | \s   | [ \t]    | [ \t\r\n\f]
        "    | \S   | [^ \t]   | [^ \t\r\n\f]
        "    | \_s  | \_[ \t]  | [ \t\r\n\f]
        "    | \_S  | \_[^ \t] | [^ \t\r\n\f]       *
        let ff=nr2char(0x0c)
        let re='\C' . s:re_escaped . '_\=s'
        let vimregex=substitute(vimregex, re, '[ \\t\\r\\n' . ff . ']', "g")
        let re='\C' . s:re_escaped . '_\=S'
        if s:countermeasure==1
            "v216
            let vimregex=substitute(vimregex, re, '[^ \\t\\r' . ff . ']', "g")
        else
            let vimregex=substitute(vimregex, re, '[^ \\t\\r\\n' . ff . ']', "g")
        endif
    endif

    if s:ignorecase > 0
        let tmp = (s:ignorecase==1) ? '\c' : '\C'
        let vimregex = tmp . vimregex
    endif
    "if &magic==0
    "    let vimregex = '\m' . vimregex
    "endif

    return vimregex
endfunction
"end s:ReplaceNumberFactorWithVimRegexFactor()
"=============================================================================
"Main:
function! s:ExtendedRegex2VimRegex(extendedregex, ...)
    "v141
    let s:ignorecase=0
    let s:multiline=0
    let s:extended_spaces=0
    let s:extended_complements=0
    let s:extended_dots=0
    if a:0==1
        "v238,v243
        if a:1 =~# 'R[0-3]'
            return s:ExchangeReplaceSpecials(a:extendedregex, matchstr(a:1, 'R\zs[0-3]'))
        "v240
        elseif a:1 ==# 'V'
            return s:version
        endif
        call s:SetModifiers(a:1)
    endif
    "v240 moved here
    if strlen(a:extendedregex)==0
        return ""
    endif

    "v141
    let eregex=a:extendedregex
    "v221
    let mods = matchstr(eregex, '\C' . s:re_escaped . '[Mm]')
    let mods = mods . matchstr(eregex, '\C' . s:re_escaped . '[Cc]')
    if mods !=# ''
        let mods = substitute(mods, '\CC', 'I',"g")
        let mods = substitute(mods, '\Cc', 'i',"g")
        call s:SetModifiers(mods)
        let re='\C' . s:re_escaped . '[MmCc]'
        let eregex=substitute(eregex, re, '', "g")
    endif

    "--------------------
    let halfway = s:ReplaceExtendedRegexFactorWithNumberFactor(eregex)
    let halfway = s:ReplaceRemainFactorWithVimRegexFactor(halfway)
    let vimregex = s:ReplaceNumberFactorWithVimRegexFactor(halfway)
    "v221
    return vimregex
endfunction
"end s:ExtendedRegex2VimRegex()
"-----------------------------------------------------------------------------
function! s:ExtendedRegex2VimRegexLineWise(...) range
    if a:1 ==# '--version'
        echo "$Id: eregex.vim,v 2.56 2003-09-19 17:39:41+09 ta Exp $"
        return
    endif
    let modifiers= a:1

    let i = a:firstline
    while i <= a:lastline
        call setline(i, s:ExtendedRegex2VimRegex(getline(i), modifiers))
        let i = i + 1
    endwhile
endfunction
"end s:ExtendedRegex2VimRegexLineWise()
"-----------------------------------------------------------------------------
"Public:
function! E2v(extendedregex, ...)
    if a:0==0
        return s:ExtendedRegex2VimRegex(a:extendedregex)
    endif
    return s:ExtendedRegex2VimRegex(a:extendedregex, a:1)
endfunction
"end E2v()
"-----------------------------------------------------------------------------
function! s:Ematch(...)
    let ccount = a:1
    if strlen(a:2) <= 1
        let string = a:2 . @/
    else
        let string = a:2
    endif

    let delim=string[0]

    if delim !=# '/' && delim !=# '?' 
        let v:errmsg= "The delimiter `" . delim . "' isn't available,  use `/' ."
        echohl WarningMsg | echo v:errmsg
        return
    endif

    let rxp ='^delim\([^delim\\]*\%(\\.[^delim\\]*\)*\)' .
        \      '\(delim.*\)\=$'
    let rxp=substitute(rxp, 'delim', delim, "g")

    let regex = substitute(string, rxp, '\1',"")
    let offset= substitute(string, rxp, '\2', "")

    "--------------------
    let modifiers=''
    "v141
    if offset =~# '[' . s:str_modifiers . ']'
        let modifiers = substitute(offset, '\C[^' . s:str_modifiers . ']\+', "", "g")
        let offset = substitute(offset, '\C[' . s:str_modifiers . ']\+', "", "g")
    endif

    if g:eregex_force_case == 1
      if match(modifiers, 'i') == -1 && match(modifiers, 'I') == -1
        let modifiers .= 'I'
      endif
    endif

    let regex = s:ExtendedRegex2VimRegex(regex, modifiers)
    "v130
    "set s:bakregex
    let regex = s:EscapeAndUnescape(regex, delim)

    "--------------------
    if offset==# ''
        let offset = delim
    endif

    let cmd = 'normal! ' . ccount . delim . regex . offset . "\<CR>"
    let v:errmsg=''
    set nohlsearch
    silent! exec cmd
    if (v:errmsg !~# '^E\d\+:') || (v:errmsg =~# '^E486:')
        "v130
        if s:bakregex !=# ''
            let @/ = s:bakregex
        endif
    endif
    if v:errmsg ==# ''
        redraw!
        if &foldenable && &foldopen =~# 'search'
            exec 'normal!zv'
        endif
    else
        echohl WarningMsg | echo v:errmsg
    endif

    if delim == '?'
      return 0
    else
      return 1
    endif
endfunction
"end s:Ematch()
"-----------------------------------------------------------------------------
function! s:Esubstitute(...) range
    if strlen(a:1) <= 1 | return | endif

    let string = a:1
    let delim = s:GetDelim(string[0])
    if delim==# '' | return | endif

    let rxp ='^delim\([^delim\\]*\%(\\.[^delim\\]*\)*\)delim\([^delim\\]*\%(\\.[^delim\\]*\)*\)' .
        \      '\(delim.*\)\=$'
    let rxp=substitute(rxp, 'delim', delim, "g")
    if string !~# rxp
        if s:eglobal_working==0
            echohl WarningMsg | echo 'Invalid arguments S' . a:1
        endif
        return
    endif
    let regex = substitute(string, rxp, '\1',"")
    let replacement = substitute(string, rxp, '\2', "")
    let options = substitute(string, rxp, '\3',"")
    "--------------------
    "v141
    let modifiers=''
    if options =~# '[' . s:str_modifiers . ']'
        let modifiers = substitute(options, '\C[^' . s:str_modifiers . ']\+', "", "g")
        let options = substitute(options, '\C[SCDmM]', "", "g")
    endif

    if g:eregex_force_case == 1
      if match(modifiers, 'i') == -1 && match(modifiers, 'I') == -1
        let modifiers .= 'I'
      endif
    endif

    let regex = s:ExtendedRegex2VimRegex(regex, modifiers)
    "v130
    "set s:bakregex
    let regex = s:EscapeAndUnescape(regex, delim)

    "v238, v243
    if (s:eregex_replacement > 0) && (strlen(replacement) > 1)
        let replacement = s:ExchangeReplaceSpecials(replacement, s:eregex_replacement)
    endif

    "--------------------
    if options ==# ''
        let options = delim
    endif

    let cmd = a:firstline . ',' . a:lastline . 's' . delim . regex . delim . replacement . options

    "Evaluater:
    let g:eregex_evaluater_how_exe = s:eglobal_working
    if g:eregex_evaluater_how_exe==0
        let v:statusmsg=''
        let v:errmsg=''
    endif
    let confirmoption = (options =~# 'c')
    if confirmoption==1
        "with confirm option.
        let g:eregex_evaluater_how_exe=1
    endif
    let g:eregex_evaluater_cmd = cmd
    runtime plugin/eregex_e.vim
    if g:eregex_evaluater_how_exe==0 || confirmoption==1
        unlet! g:eregex_evaluater_cmd
        "v130
        if s:bakregex !=# ''
            let @/ = s:bakregex
        endif

        if confirmoption==0
            if v:errmsg==# ''
                if v:statusmsg !=# ''
                    echohl WarningMsg | echo v:statusmsg
                endif
            else
                echohl WarningMsg | echo v:errmsg
            endif
        endif
    endif

endfunction
"end s:Esubstitute()
"-----------------------------------------------------------------------------
function! s:Eglobal(bang, ...) range
    if strlen(a:1)<=1 | return | endif
    let string=a:1
    let delim = s:GetDelim(string[0])
    if delim==#'' | return | endif

    "--------------------
    let re_pattern = substitute('[^delim\\]*\%(\\.[^delim\\]*\)*', 'delim', delim,"g")
    let re_offset = '\%([-+0-9]\d*\|\.[-+]\=\d*\)'
    let re_sep = '[,;]'
    let re_command = '[^,;].*'
    let re_command_less = '\_$'
    let re_end = '\%(' . re_sep . '\|' . re_command . '\|' . re_command_less . '\)'

    "--------------------
    let toprxp0 = '^' . delim . '\(' . re_pattern . '\)\(' . delim . re_offset . re_sep . '\)'
    let toprxp1 = '^' . delim . '\(' . re_pattern . '\)\(' . delim . re_sep . '\)'
    let toprxp2 = '^'

    let endrxp0 = delim . '\(' . re_pattern . '\)\(' . delim . re_offset . re_end . '\)'
    let endrxp1 = delim . '\(' . re_pattern . '\)\(' . delim . re_end . '\)'
    let endrxp2 = delim . '\(' . re_pattern . '\)' . re_command_less

    "--------------------
    let mtop = -1
    let j = 0
    while j < 3
        let i = 0
        while i < 3
            let regexp = toprxp{j} . endrxp{i}
            let mtop = match(string, regexp)
            if mtop>=0 | break | endif
            let i = i + 1
        endwhile
        if mtop>=0 | break | endif
        let j = j + 1
    endwhile
    if mtop<0 | return | endif

    "--------------------
    if a:bang==# '!'
        let s:invert=1
    endif
    let cmd = (s:invert==0) ? 'g' : 'v'
    let s:invert=0
    let cmd = a:firstline . ',' . a:lastline . cmd
    let globalcmd = ''
    if j == 2
        let pattern1 = substitute(string, regexp, '\1', "")
        let strright = delim
        if i < 2
            let strright = substitute(string, regexp, '\2', "")
        endif

        let pattern1 = s:ExtendedRegex2VimRegex(pattern1)
        "v130
        let pattern1 = s:EscapeAndUnescape(pattern1, delim)
        let globalcmd = cmd . delim . pattern1 . strright
    else
        let pattern1 = substitute(string, regexp, '\1', "")
        let strmid = substitute(string, regexp, '\2',"")
        let pattern2 = substitute(string, regexp, '\3', "")
        let strright = delim
        if i < 2
            let strright = substitute(string, regexp, '\4', "")
        endif

        let pattern1 = s:ExtendedRegex2VimRegex(pattern1)
        let pattern2 = s:ExtendedRegex2VimRegex(pattern2)
        "v130
        let pattern1 = s:EscapeAndUnescape(pattern1, delim)
        let pattern2 = s:EscapeAndUnescape(pattern2, delim)

        let globalcmd = cmd . delim . pattern1 . strmid . delim . pattern2 . strright
    endif
    "--------------------

    "Evaluater:
    let s:eglobal_working=1
    let g:eregex_evaluater_how_exe=2
    let g:eregex_evaluater_cmd = globalcmd

    runtime plugin/eregex_e.vim
    let s:eglobal_working=0
    "let g:eregex_evaluater_how_exe=0
    unlet! g:eregex_evaluater_cmd

endfunction
"end s:Eglobal()
"-----------------------------------------------------------------------------
function! s:Evglobal(...) range
    let s:invert=1
    let cmd = a:firstline . ',' . a:lastline . 'G' . a:1
    exec cmd

endfunction
"end s:Evglobal()
"-----------------------------------------------------------------------------
function! s:GetDelim(str)
    let valid = '[/@#]'
    let delim = a:str[0]
    if delim =~# valid
        return delim
    endif
    let v:errmsg = "The delimiter `" . delim . "' isn't available,  use " . valid
    echohl WarningMsg | echo v:errmsg
    return ''
endfunction
"end s:GetDelim()
"=============================================================================
"v130
"called from Ematch(), Esubstitute(), Eglobal()
"use s:re_unescaped, s:re_escaped, s:bakregex
function! s:EscapeAndUnescape(vimregex, delim)
    let vimregex = a:vimregex
    let s:bakregex= a:vimregex
    if a:delim ==# '@'
        return vimregex
    endif

    if s:bakregex =~# s:re_escaped . a:delim
    " \/ or \# exists
        let s:bakregex = substitute(vimregex, s:re_escaped . a:delim, a:delim, "g")
    endif
    if vimregex =~# s:re_unescaped . a:delim
    " / or # exists
        let vimregex = substitute(vimregex, s:re_unescaped . a:delim, '\\' . a:delim, "g")
    endif

    return vimregex
endfunction
"end s:EscapeAndUnescape()
"=============================================================================
"v141
"called from only s:ExtendedRegex2VimRegex()
function! s:SetModifiers(mods)
    "v221
    if s:ignorecase==0
        if a:mods =~# 'i'
            let s:ignorecase=1
        elseif a:mods =~# 'I'
            let s:ignorecase=2
        endif
    endif
    "v221
    if s:multiline==0
        if a:mods =~? 'm'
            let s:extended_spaces=1
            let s:extended_complements=1
            if a:mods =~# 'M'
                "partial multiline
                let s:multiline=1
            else
                "full multiline
                let s:extended_dots=1
                let s:multiline=2
            endif
        endif
    endif

    if a:mods =~# 'S'
        let s:extended_spaces=1
    endif
    if a:mods =~# 'C'
        let s:extended_complements=1
    endif
    if a:mods =~# 'D'
        let s:extended_dots=1
    endif
endfunction
"End: s:SetModifiers(mods)
"=============================================================================
"v238,
function! s:ExchangeReplaceSpecials(replacement, sort)
    let rs=a:replacement
    "v243,v246
    if (rs !~# '[&~]\|\\[rnx]') || (rs =~# '^\\=')
        return rs
    endif
    if (a:sort % 2)==1
        let rs=substitute(rs, '\C' . s:re_escaped . 'r', '\\R', "g")
        let rs=substitute(rs, '\C' . s:re_escaped . 'n', '\\r', "g")
        let rs=substitute(rs, '\C' . s:re_escaped . 'R', '\\n', "g")
    endif
    if a:sort >= 2
        let rs=substitute(rs, '\C' . s:re_escaped . '&', '\\R', "g")
        let rs=substitute(rs, '\C' . s:re_escaped . '\~', '\\N', "g")
        let rs=substitute(rs, '\C' . s:re_unescaped . '[&~]', '\\&', "g")
        let rs=substitute(rs, '\C' . s:re_escaped . 'R', '\&', "g")
        let rs=substitute(rs, '\C' . s:re_escaped . 'N', '\~', "g")
    endif
    return rs
endfunction
"End: s:ExchangeReplaceSpecials()
"=============================================================================
"=============================================================================
"Import: macros/locrian.vim
function! s:ReplaceAsStr(str, search, replacement, ...)
    let gsub = a:0
    if a:0 > 0
        let gsub = (a:1=~? 'g') ? 1 : 0
    endif
    let oldstr = a:str
    let newstr = ""
    let len = strlen(a:search)
    let i = stridx(oldstr, a:search)
    while i >= 0
        let newstr = newstr . strpart(oldstr, 0, i) . a:replacement
        let oldstr = strpart(oldstr, i + len)
        if gsub==0
            break
        endif
        let i = stridx(oldstr, a:search)
    endwhile
    if strlen(oldstr)!=0
        let newstr = newstr . oldstr
    endif
    return newstr
endfunction
"end s:ReplaceAsStr()
"=============================================================================

function! ExtendedRegex2VimRegex(data)
  return s:ExtendedRegex2VimRegex(a:data)
endfunction
