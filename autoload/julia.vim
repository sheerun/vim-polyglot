if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'julia') == -1

function! julia#set_syntax_version(jvers)
  if &filetype != "julia"
    echo "Not a Julia file"
    return
  endif
  syntax clear
  let b:julia_syntax_version = a:jvers
  set filetype=julia
endfunction

function! julia#toggle_deprecated_syntax()
  if &filetype != "julia"
    echo "Not a Julia file"
    return
  endif
  syntax clear
  let hd = get(b:, "julia_syntax_highlight_deprecated",
      \    get(g:, "julia_syntax_highlight_deprecated", 0))
  let b:julia_syntax_highlight_deprecated = hd ? 0 : 1
  set filetype=julia
  if b:julia_syntax_highlight_deprecated
    echo "Highlighting of deprecated syntax enabled"
  else
    echo "Highlighting of deprecated syntax disabled"
  endif
endfunction

if exists("loaded_matchit")

function! julia#toggle_function_blockassign()
    let sav_pos = getcurpos()
    let l = getline('.')
    let c = match(l, '\C\m\<function\s\+.\+(')
    if c != -1
        return julia#function_block2assign()
    endif
    let c = match(l, '\C\m)\%(::\S\+\)\?\%(\s\+where\s\+.*\)\?\s*=\s*')
    if c == -1
        echohl WarningMsg | echo "Not on a function definition or assignment line" | echohl None
        return
    endif
    return julia#function_assign2block()
endfunction

function! julia#function_block2assign()
    let sav_pos = getcurpos()
    let l = getline('.')
    let c = match(l, '\C\m\<function\s\+.\+(')
    if c == -1
        echohl WarningMsg | echo "Not on a function definition line" | echohl None
        return
    endif
    let fpos = copy(sav_pos)
    let fpos[2] = c+1
    call setpos('.', fpos)
    normal %
    if line('.') != fpos[1]+2 || match(getline('.'), '\C\m^\s*end\s*$') == -1
        echohl WarningMsg | echo "Only works with 3-lines functions" | echohl None
        call setpos('.', sav_pos)
        return
    endif
    call setpos('.', fpos)
    normal! f(
    normal %
    while line('.') == fpos[1] && match(l[col('.')-1:], '\C\m)(') == 0
        normal! l
        normal %
    endwhile
    if line('.') != fpos[1] || match(l[(col('.')-1):], '\C\m)\%(::\S\+\)\?\%(\s\+where\s\+.*\)\?\s*$') != 0
        echohl WarningMsg | echo "Unrecognized function definition format" | echohl None
        call setpos('.', sav_pos)
        return
    endif

    call setpos('.', fpos)
    normal! dwA = J
    if match(getline('.')[(col('.')-1):], '\C\mreturn\>') == 0
        normal! dw
    endif
    if match(getline('.')[(col('.')-1):], '\C\m\s*$') == 0
        normal! F=C= nothing
    endif
    normal! jddk^
    return
endfunction

function! julia#function_assign2block()
    let sav_pos = getcurpos()
    let l = getline('.')
    let c = match(l, '\C\m)\%(::\S\+\)\?\%(\s\+where\s\+.*\)\?\s*=\s*')
    if c == -1
        echohl WarningMsg | echo "Not on a function assignment-definition line" | echohl None
        return
    endif
    normal ^
    while match(l[(col('.')-1):], '\%(\S\+\.\)*@') == 0
        normal! W
    endwhile
    normal! ifunction 
    let l = getline('.')
    let c = match(l, '\C\m)\%(::\S\+\)\?\%(\s\+where\s\+.*\)\?\s*\zs=\s*')
    let eqpos = copy(sav_pos)
    let eqpos[2] = c+1
    call setpos('.', eqpos)
    normal! cwoend
    normal %
    s/\s*$// | noh
    return
endfunction


let s:nonid_chars = "\U01-\U07" . "\U0E-\U1F" .
      \             "\"#$'(,.:;=?@`\\U5B{" .
      \             "\U80-\UA1" . "\UA7\UA8\UAB\UAD\UAF\UB4" . "\UB6-\UB8" . "\UBB\UBF"

let s:nonidS_chars = "[:space:])\\U5D}" . s:nonid_chars

" the following excludes '!' since it can be used as an identifier,
" and '$' since it can be used in interpolations
" note that \U2D is '-'
let s:uniop_chars = "+\\U2D~¬√∛∜"

let s:binop_chars = "=+\\U2D*/\\%÷^&|⊻<>≤≥≡≠≢∈∉⋅×∪∩⊆⊈⊂⊄⊊←→∋∌⊕⊖⊞⊟∘∧⊗⊘↑↓∨⊠±"

" the following is a list of all remainig valid operator chars,
" but it's more efficient when expressed with ranges (see below)
" let s:binop_chars_extra = "↔↚↛↠↣↦↮⇎⇏⇒⇔⇴⇶⇷⇸⇹⇺⇻⇼⇽⇾⇿⟵⟶⟷⟷⟹⟺⟻⟼⟽⟾⟿⤀⤁⤂⤃⤄⤅⤆⤇⤌⤍⤎⤏⤐⤑⤔⤕⤖⤗⤘⤝⤞⤟⤠⥄⥅⥆⥇⥈⥊⥋⥎⥐⥒⥓⥖⥗⥚⥛⥞⥟⥢⥤⥦⥧⥨⥩⥪⥫⥬⥭⥰⧴⬱⬰⬲⬳⬴⬵⬶⬷⬸⬹⬺⬻⬼⬽⬾⬿⭀⭁⭂⭃⭄⭇⭈⭉⭊⭋⭌￩￫" .
"       \                   "∝∊∍∥∦∷∺∻∽∾≁≃≄≅≆≇≈≉≊≋≌≍≎≐≑≒≓≔≕≖≗≘≙≚≛≜≝≞≟≣≦≧≨≩≪≫≬≭≮≯≰≱≲≳≴≵≶≷≸≹≺≻≼≽≾≿⊀⊁⊃⊅⊇⊉⊋⊏⊐⊑⊒⊜⊩⊬⊮⊰⊱⊲⊳⊴⊵⊶⊷⋍⋐⋑⋕⋖⋗⋘⋙⋚⋛⋜⋝⋞⋟⋠⋡⋢⋣⋤⋥⋦⋧⋨⋩⋪⋫⋬⋭⋲⋳⋴⋵⋶⋷⋸⋹⋺⋻⋼⋽⋾⋿⟈⟉⟒⦷⧀⧁⧡⧣⧤⧥⩦⩧⩪⩫⩬⩭⩮⩯⩰⩱⩲⩳⩴⩵⩶⩷⩸⩹⩺⩻⩼⩽⩾⩿⪀⪁⪂⪃⪄⪅⪆⪇⪈⪉⪊⪋⪌⪍⪎⪏⪐⪑⪒⪓⪔⪕⪖⪗⪘⪙⪚⪛⪜⪝⪞⪟⪠⪡⪢⪣⪤⪥⪦⪧⪨⪩⪪⪫⪬⪭⪮⪯⪰⪱⪲⪳⪴⪵⪶⪷⪸⪹⪺⪻⪼⪽⪾⪿⫀⫁⫂⫃⫄⫅⫆⫇⫈⫉⫊⫋⫌⫍⫎⫏⫐⫑⫒⫓⫔⫕⫖⫗⫘⫙⫷⫸⫹⫺⊢⊣" .
"       \                   "⊔∓∔∸≂≏⊎⊽⋎⋓⧺⧻⨈⨢⨣⨤⨥⨦⨧⨨⨩⨪⨫⨬⨭⨮⨹⨺⩁⩂⩅⩊⩌⩏⩐⩒⩔⩖⩗⩛⩝⩡⩢⩣" .
"       \                   "⊙⊚⊛⊡⊓∗∙∤⅋≀⊼⋄⋆⋇⋉⋊⋋⋌⋏⋒⟑⦸⦼⦾⦿⧶⧷⨇⨰⨱⨲⨳⨴⨵⨶⨷⨸⨻⨼⨽⩀⩃⩄⩋⩍⩎⩑⩓⩕⩘⩚⩜⩞⩟⩠⫛⊍▷⨝⟕⟖⟗" .
"       \                   "⇵⟰⟱⤈⤉⤊⤋⤒⤓⥉⥌⥍⥏⥑⥔⥕⥘⥙⥜⥝⥠⥡⥣⥥⥮⥯￪￬"

" same as above, but with character ranges, for performance
let s:binop_chars_extra = "\\U214B\\U2190-\\U2194\\U219A\\U219B\\U21A0\\U21A3\\U21A6\\U21AE\\U21CE\\U21CF\\U21D2\\U21D4\\U21F4-\\U21FF\\U2208-\\U220D\\U2213\\U2214\\U2217-\\U2219\\U221D\\U2224-\\U222A\\U2237\\U2238\\U223A\\U223B\\U223D\\U223E\\U2240-\\U228B\\U228D-\\U229C\\U229E-\\U22A3\\U22A9\\U22AC\\U22AE\\U22B0-\\U22B7\\U22BB-\\U22BD\\U22C4-\\U22C7\\U22C9-\\U22D3\\U22D5-\\U22ED\\U22F2-\\U22FF\\U25B7\\U27C8\\U27C9\\U27D1\\U27D2\\U27D5-\\U27D7\\U27F0\\U27F1\\U27F5-\\U27F7\\U27F7\\U27F9-\\U27FF\\U2900-\\U2918\\U291D-\\U2920\\U2944-\\U2970\\U29B7\\U29B8\\U29BC\\U29BE-\\U29C1\\U29E1\\U29E3-\\U29E5\\U29F4\\U29F6\\U29F7\\U29FA\\U29FB\\U2A07\\U2A08\\U2A1D\\U2A22-\\U2A2E\\U2A30-\\U2A3D\\U2A40-\\U2A45\\U2A4A-\\U2A58\\U2A5A-\\U2A63\\U2A66\\U2A67\\U2A6A-\\U2AD9\\U2ADB\\U2AF7-\\U2AFA\\U2B30-\\U2B44\\U2B47-\\U2B4C\\UFFE9-\\UFFEC"

" a Julia identifier, sort of
let s:idregex = '[^' . s:nonidS_chars . '0-9!' . s:uniop_chars . s:binop_chars . '][^' . s:nonidS_chars . s:uniop_chars . s:binop_chars . s:binop_chars_extra . ']*'

let s:operators = '\%(' . '\.\%([-+*/^÷%|&!]\|//\|\\\|<<\|>>>\?\)\?=' .
      \           '\|'  . '[:$<>]=\|||\|&&\||>\|<|\|<:\|:>\|::\|<<\|>>>\?\|//\|[-=]>\|\.\{3\}' .
      \           '\|'  . '[' . s:uniop_chars . '!$]' .
      \           '\|'  . '\.\?[' . s:binop_chars . s:binop_chars_extra . ']' .
      \           '\)'

function! julia#idundercursor()
    " TODO...
    let w = expand('<cword>')
    " let [l,c] = [line('.'),col('.')]
    " let ll = getline(l)
    return w
endfunction

function! julia#gotodefinition()
    let w = julia#idundercursor()
    if empty(w)
        return ''
    endif
    let [l,c] = [line('.'),col('.')]
    let st = map(synstack(l,c), 'synIDattr(v:val, "name")')
    let n = len(st)
    if n > 0 && st[-1] =~# '^julia\%(\%(Range\|Ternary\|CTrans\)\?Operator\|\%(Possible\)\?SymbolS\?\|\%(Bl\|Rep\)\?Keyword\|Conditional\|ParDelim\|Char\|Colon\|Typedef\|Number\|Float\|Const\%(Generic\|Bool\)\|ComplexUnit\|\%(Special\|\%(Octal\|Hex\)Escape\)Char\|UniChar\%(Small\|Large\)\|Comment[LM]\|Todo\|Semicolon\)$'
        return ''
    endif

    let comprehension = 0
    let indollar = 0
    for i in range(n-1, 0, -1)
        if st[i] =~# '^juliaDollar\%(Var\|Par\|SqBra\)$'
            let indollar = 1
        endif
        if !indollar && st[i] =~# '^julia\%(\a*String\|QuotedParBlockS\?\)$'
            return ''
        endif
        if st[i] =~# '^julia\%(ParBlock\%(InRange\)\?\|SqBraBlock\|\%(Dollar\|StringVars\)\%(Par\|SqBra\)\)$'
            let comprehension = 1
        endif
    endfor

    let s1 = search('\C\<' . w . '\s*=[^=]', 'bcWzs')

    return
endfunction

endif

endif
