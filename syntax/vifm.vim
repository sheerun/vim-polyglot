if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vifm') == -1

" vifm syntax file
" Maintainer:  xaizek <xaizek@posteo.net>
" Last Change: July 12, 2019
" Inspired By: Vim syntax file by Dr. Charles E. Campbell, Jr.

if exists('b:current_syntax')
	finish
endif

let b:current_syntax = 'vifm'

let s:cpo_save = &cpo
set cpo-=C

" General commands
syntax keyword vifmCommand contained
		\ alink apropos bmark bmarks bmgo cds change chmod chown clone compare
		\ cope[n] co[py] cq[uit] d[elete] delbmarks delm[arks] di[splay] dirs e[dit]
		\ el[se] empty en[dif] exi[t] file fin[d] fini[sh] go[to] gr[ep] h[elp]
		\ hideui histnext his[tory] histprev jobs locate ls lstrash marks media
		\ mes[sages] mkdir m[ove] noh[lsearch] on[ly] popd pushd pu[t] pw[d] qa[ll]
		\ q[uit] redr[aw] reg[isters] regular rename restart restore rlink screen
		\ sh[ell] siblnext siblprev sor[t] sp[lit] s[ubstitute] tabc[lose] tabm[ove]
		\ tabname tabnew tabn[ext] tabp[revious] touch tr trashes tree sync
		\ undol[ist] ve[rsion] vie[w] vifm vs[plit] winc[md] w[rite] wq wqa[ll]
		\ xa[ll] x[it] y[ank]
		\ nextgroup=vifmArgs
syntax keyword vifmCommandCN contained
		\ alink apropos bmark bmarks bmgo cds change chmod chown clone compare
		\ cope[n] co[py] cq[uit] d[elete] delbmarks delm[arks] di[splay] dirs e[dit]
		\ el[se] empty en[dif] exi[t] file fin[d] fini[sh] go[to] gr[ep] h[elp]
		\ hideui histnext his[tory] histprev jobs locate ls lstrash marks media
		\ mes[sages] mkdir m[ove] noh[lsearch] on[ly] popd pushd pu[t] pw[d] qa[ll]
		\ q[uit] redr[aw] reg[isters] regular rename restart restore rlink screen
		\ sh[ell] siblnext siblprev sor[t] sp[lit] s[ubstitute] tabc[lose] tabm[ove]
		\ tabname tabnew tabn[ext] tabp[revious] touch tr trashes tree sync
		\ undol[ist] ve[rsion] vie[w] vifm vs[plit] winc[md] w[rite] wq wqa[ll]
		\ xa[ll] x[it] y[ank]
		\ nextgroup=vifmArgsCN

" commands that might be prepended to a command without changing everything else
syntax keyword vifmPrefixCommands contained windo winrun

" Map commands
syntax keyword vifmMap contained dm[ap] dn[oremap] du[nmap] map mm[ap]
		\ mn[oremap] mu[nmap] nm[ap] nn[oremap] no[remap] nun[map] qm[ap] qn[oremap]
		\ qun[map] unm[ap] vm[ap] vn[oremap] vu[nmap]
		\ skipwhite nextgroup=vifmMapArgs
syntax keyword vifmCMapAbbr contained ca[bbrev] cm[ap] cnorea[bbrev] cno[remap]
		\ cuna[bbrev] cu[nmap]
		\ skipwhite nextgroup=vifmCMapArgs

" Other commands
syntax keyword vifmAutocmdCommand contained au[tocmd] nextgroup=vifmAutoEvent
syntax keyword vifmCdCommand contained cd
syntax keyword vifmCmdCommand contained com[mand] nextgroup=vifmCmdCommandName
syntax keyword vifmColoCommand contained colo[rscheme]
syntax keyword vifmHiCommand contained hi[ghlight]
syntax keyword vifmInvertCommand contained invert
syntax keyword vifmLetCommand contained let
syntax keyword vifmUnletCommand contained unl[et]
syntax keyword vifmSetCommand contained se[t] setl[ocal] setg[lobal]
syntax keyword vifmSoCommand contained so[urce]
syntax keyword vifmMarkCommand contained ma[rk]
syntax keyword vifmFtCommand contained filet[ype] filex[type] filev[iewer]
syntax keyword vifmExprCommand contained if ec[ho] elsei[f] exe[cute]
syntax keyword vifmNormalCommand contained norm[al]
		\ nextgroup=vifmColonSubcommand
syntax match vifmPatternCommands contained /\<\(filter\(!\|\>\)\|select\(!\|\>\)\|unselect\>\)/ skipwhite
		\ nextgroup=vifmPattern

" List of event names for autocommands (case insensitive)
syntax case ignore
syntax keyword vifmAutoEvent contained DirEnter nextgroup=vifmStatementC
syntax case match

" Builtin functions
syntax match vifmBuiltinFunction
		\ '\(chooseopt\|expand\|executable\|extcached\|filetype\|fnameescape\|getpanetype\|has\|layoutis\|paneisat\|system\|tabpagenr\|term\)\ze('

" Operators
syntax match vifmOperator "\(==\|!=\|>=\?\|<=\?\|\.\|-\|+\|&&\|||\)" skipwhite

" Highlight groups
syntax keyword vifmHiArgs contained cterm ctermfg ctermbg
syntax case ignore
syntax keyword vifmHiGroups contained WildMenu Border Win CmdLine CurrLine
		\ OtherLine Directory Link Socket Device Executable Selected BrokenLink
		\ TopLine TopLineSel StatusLine JobLine SuggestBox Fifo ErrorMsg CmpMismatch
		\ AuxWin OtherWin TabLine TabLineSel
		\ User1 User2 User3 User4 User5 User6 User7 User8 User9
syntax keyword vifmHiStyles contained
		\ bold underline reverse inverse standout italic none
syntax keyword vifmHiColors contained black red green yellow blue magenta cyan
		\ white default lightblack lightred lightgreen lightyellow lightblue
		\ lightmagenta lightcyan lightwhite Grey0 NavyBlue DarkBlue Blue3 Blue3_2
		\ Blue1 DarkGreen DeepSkyBlue4 DeepSkyBlue4_2 DeepSkyBlue4_3 DodgerBlue3
		\ DodgerBlue2 Green4 SpringGreen4 Turquoise4 DeepSkyBlue3 DeepSkyBlue3_2
		\ DodgerBlue1 Green3 SpringGreen3 DarkCyan LightSeaGreen DeepSkyBlue2
		\ DeepSkyBlue1 Green3_2 SpringGreen3_2 SpringGreen2 Cyan3 DarkTurquoise
		\ Turquoise2 Green1 SpringGreen2_2 SpringGreen1 MediumSpringGreen Cyan2
		\ Cyan1 DarkRed DeepPink4 Purple4 Purple4_2 Purple3 BlueViolet Orange4
		\ Grey37 MediumPurple4 SlateBlue3 SlateBlue3_2 RoyalBlue1 Chartreuse4
		\ DarkSeaGreen4 PaleTurquoise4 SteelBlue SteelBlue3 CornflowerBlue
		\ Chartreuse3 DarkSeaGreen4_2 CadetBlue CadetBlue_2 SkyBlue3 SteelBlue1
		\ Chartreuse3_2 PaleGreen3 SeaGreen3 Aquamarine3 MediumTurquoise
		\ SteelBlue1_2 Chartreuse2 SeaGreen2 SeaGreen1 SeaGreen1_2 Aquamarine1
		\ DarkSlateGray2 DarkRed_2 DeepPink4_2 DarkMagenta DarkMagenta_2 DarkViolet
		\ Purple Orange4_2 LightPink4 Plum4 MediumPurple3 MediumPurple3_2 SlateBlue1
		\ Yellow4 Wheat4 Grey53 LightSlateGrey MediumPurple LightSlateBlue Yellow4_2
		\ DarkOliveGreen3 DarkSeaGreen LightSkyBlue3 LightSkyBlue3_2 SkyBlue2
		\ Chartreuse2_2 DarkOliveGreen3_2 PaleGreen3_2 DarkSeaGreen3 DarkSlateGray3
		\ SkyBlue1 Chartreuse1 LightGreen_2 LightGreen_3 PaleGreen1 Aquamarine1_2
		\ DarkSlateGray1 Red3 DeepPink4_3 MediumVioletRed Magenta3 DarkViolet_2
		\ Purple_2 DarkOrange3 IndianRed HotPink3 MediumOrchid3 MediumOrchid
		\ MediumPurple2 DarkGoldenrod LightSalmon3 RosyBrown Grey63 MediumPurple2_2
		\ MediumPurple1 Gold3 DarkKhaki NavajoWhite3 Grey69 LightSteelBlue3
		\ LightSteelBlue Yellow3 DarkOliveGreen3_3 DarkSeaGreen3_2 DarkSeaGreen2
		\ LightCyan3 LightSkyBlue1 GreenYellow DarkOliveGreen2 PaleGreen1_2
		\ DarkSeaGreen2_2 DarkSeaGreen1 PaleTurquoise1 Red3_2 DeepPink3 DeepPink3_2
		\ Magenta3_2 Magenta3_3 Magenta2 DarkOrange3_2 IndianRed_2 HotPink3_2
		\ HotPink2 Orchid MediumOrchid1 Orange3 LightSalmon3_2 LightPink3 Pink3
		\ Plum3 Violet Gold3_2 LightGoldenrod3 Tan MistyRose3 Thistle3 Plum2
		\ Yellow3_2 Khaki3 LightGoldenrod2 LightYellow3 Grey84 LightSteelBlue1
		\ Yellow2 DarkOliveGreen1 DarkOliveGreen1_2 DarkSeaGreen1_2 Honeydew2
		\ LightCyan1 Red1 DeepPink2 DeepPink1 DeepPink1_2 Magenta2_2 Magenta1
		\ OrangeRed1 IndianRed1 IndianRed1_2 HotPink HotPink_2 MediumOrchid1_2
		\ DarkOrange Salmon1 LightCoral PaleVioletRed1 Orchid2 Orchid1 Orange1
		\ SandyBrown LightSalmon1 LightPink1 Pink1 Plum1 Gold1 LightGoldenrod2_2
		\ LightGoldenrod2_3 NavajoWhite1 MistyRose1 Thistle1 Yellow1 LightGoldenrod1
		\ Khaki1 Wheat1 Cornsilk1 Grey100 Grey3 Grey7 Grey11 Grey15 Grey19 Grey23
		\ Grey27 Grey30 Grey35 Grey39 Grey42 Grey46 Grey50 Grey54 Grey58 Grey62
		\ Grey66 Grey70 Grey74 Grey78 Grey82 Grey85 Grey89 Grey93

syntax case match

" Options
syntax keyword vifmOption contained aproposprg autochpos caseoptions cdpath cd
		\ chaselinks classify columns co confirm cf cpoptions cpo cvoptions
		\ deleteprg dotdirs dotfiles dirsize fastrun fillchars fcs findprg
		\ followlinks fusehome gdefault grepprg histcursor history hi hlsearch hls
		\ iec ignorecase ic iooptions incsearch is laststatus lines locateprg ls
		\ lsoptions lsview mediaprg milleroptions millerview mintimeoutlen number nu
		\ numberwidth nuw previewprg quickview relativenumber rnu rulerformat ruf
		\ runexec scrollbind scb scrolloff so sort sortgroups sortorder sortnumbers
		\ shell sh shellflagcmd shcf shortmess shm showtabline stal sizefmt slowfs
		\ smartcase scs statusline stl suggestoptions syncregs syscalls tabscope
		\ tabstop timefmt timeoutlen title tm trash trashdir ts tuioptions to
		\ undolevels ul vicmd viewcolumns vifminfo vimhelp vixcmd wildmenu wmnu
		\ wildstyle wordchars wrap wrapscan ws

" Disabled boolean options
syntax keyword vifmOption contained noautochpos nocf nochaselinks nodotfiles
		\ nofastrun nofollowlinks nohlsearch nohls noiec noignorecase noic
		\ noincsearch nois nolaststatus nols nolsview nomillerview nonumber nonu
		\ noquickview norelativenumber nornu noscrollbind noscb norunexec
		\ nosmartcase noscs nosortnumbers nosyscalls notitle notrash novimhelp
		\ nowildmenu nowmnu nowrap nowrapscan nows

" Inverted boolean options
syntax keyword vifmOption contained invautochpos invcf invchaselinks invdotfiles
		\ invfastrun invfollowlinks invhlsearch invhls inviec invignorecase invic
		\ invincsearch invis invlaststatus invls invlsview invmillerview invnumber
		\ invnu invquickview invrelativenumber invrnu invscrollbind invscb
		\ invrunexec invsmartcase invscs invsortnumbers invsyscalls invtitle
		\ invtrash invvimhelp invwildmenu invwmnu invwrap invwrapscan invws

" Expressions
syntax region vifmStatement start='^\(\s\|:\)*'
		\ skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='$' keepend
		\ contains=vifmCommand,vifmCmdCommand,vifmCmdCommandSt,vifmMarkCommandSt
		\,vifmFtCommandSt,vifmCMapAbbr,vifmMap,vifmMapSt,vifmCMapSt,vifmExecute
		\,vifmComment,vifmInlineComment,vifmNotComment,vifmExprCommandSt,vifmNormalCommandSt
		\,vifmCdCommandSt,vifmSet,vifmArgument,vifmSoCommandSt,vifmPrefixCommands
		\,vifmAutocmdCommand,vifmAutoEvent,vifmPatternCommands
" Contained statement with highlighting of angle-brace notation.
syntax region vifmStatementCN start='\(\s\|:\)*'
		\ skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='$' keepend contained
		\ contains=vifmCommandCN,vifmCmdCommand,vifmCmdCommandSt,vifmMarkCommandSt
		\,vifmFtCommandStN,vifmCMapAbbr,vifmMap,vifmMapSt,vifmCMapSt,vifmExecute
		\,vifmComment,vifmInlineComment,vifmNotComment,vifmExprCommandSt,vifmNormalCommandSt
		\,vifmNotation,vifmCdCommandStN,vifmSetN,vifmArgument,vifmSoCommand
		\,vifmSoCommandStN,vifmInvertCommand,vifmInvertCommandStN,vifmPrefixCommands
		\,vifmLetCN
" Contained statement without highlighting of angle-brace notation.
syntax region vifmStatementC start='\(\s\|:\)*'
		\ skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='$' keepend contained
		\ contains=vifmCommand,vifmCmdCommand,vifmCmdCommandSt,vifmMarkCommandSt
		\,vifmFtCommandSt,vifmCMapAbbr,vifmMap,vifmMapSt,vifmCMapSt,vifmExecute
		\,vifmComment,vifmInlineComment,vifmNotComment,vifmExprCommandSt,vifmNormalCommandSt
		\,vifmCdCommandSt,vifmSet,vifmArgument,vifmSoCommand,vifmSoCommandSt
		\,vifmInvertCommand,vifmInvertCommandSt,vifmPrefixCommands
		\,vifmAutocmdCommand,vifmAutoEvent,vifmPatternCommands,vifmLetC,vifmUnletC
syntax region vifmCmdCommandSt start='^\(\s\|:\)*com\%[mand]\>'
		\ skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='$' keepend
		\ contains=vifmCmdCommand,vifmComment,vifmInlineComment,vifmNotComment
syntax region vifmCmdCommandName contained start='!\?\s\+[a-zA-Z]\+' end='\ze\s'
		\ skip='\(\s*\\\)\|\(\s*".*$\)'
		\ nextgroup=vifmCmdArgs
syntax region vifmCmdArgs start='\(\s*\n\s*\\\)\?\s*\S\+'
		\ end='\s' skip='\(\n\s*\\\)\|\(\n\s*".*$\)'
		\ contained
		\ contains=vifmColonSubcommand,vifmComment
syntax region vifmColoCommandSt start='^\(\s\|:\)*colo\%[rscheme]\>' end='$'
		\ keepend oneline contains=vifmColoCommand
syntax region vifmInvertCommandSt start='\(\s\|:\)*invert\>' end='$\||'
		\ keepend oneline contains=vifmInvertCommand
syntax region vifmInvertCommandStN start='\(\s\|:\)*invert\>' end='$\||'
		\ contained keepend oneline contains=vifmInvertCommand,vifmNotation
syntax region vifmSoCommandSt start='\(\s\|:\)*so\%[urce]\>' end='$\||'
		\ keepend oneline contains=vifmSoCommand,vifmEnvVar,vifmStringInExpr
syntax region vifmSoCommandStN start='\(\s\|:\)*so\%[urce]\>' end='$\||'
		\ contained keepend oneline
		\ contains=vifmSoCommand,vifmEnvVar,vifmNotation,vifmStringInExpr
syntax region vifmMarkCommandSt start='^\(\s\|:\)*ma\%[rk]\>' end='$' keepend
		\ oneline contains=vifmMarkCommand
syntax region vifmCdCommandSt start='\(\s\|:\)*cd\>' end='$\||' keepend oneline
		\ contains=vifmCdCommand,vifmEnvVar,vifmStringInExpr
" Highlight for :cd command with highlighting of angle-brace notation.
syntax region vifmCdCommandStN start='\(\s\|:\)*cd\>' end='$\||' keepend oneline
		\ contained
		\ contains=vifmCdCommand,vifmEnvVar,vifmNotation,vifmStringInExpr
syntax region vifmFtCommandSt start='\(\s\|:\)*file[tvx]'
		\ skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='$' keepend
		\ contains=vifmFtCommand,vifmComment,vifmFtBeginning
syntax region vifmFtCommandStN start='\(\s\|:\)*file[tvx]'
		\ skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='$\|\(<[cC][rR]>\)' keepend
		\ contains=vifmComment,vifmNotation,vifmFtBeginning
syntax region vifmMapSt start='^\(\s\|:\)*\(map\|mm\%[ap]\|mn\%[oremap]\|mu\%[nmap]\|nm\%[ap]\|nn\%[oremap]\|no\%[remap]\|nun\%[map]\|qm\%[ap]\|qn\%[oremap]\|qun\%[map]\|unm\%[ap]\|vm\%[ap]\|vn\%[oremap]\|vu\%[nmap]\)'
		\ skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='$' keepend
		\ contains=vifmMap
syntax region vifmCMapSt
		\ start='^\(\s\|:\)*\(cm\%[ap]\|cno\%[remap]\|cu\%[nmap]\)'
		\ skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='$' keepend
		\ contains=vifmCMapAbbr
syntax region vifmExprCommandSt
		\ start='\<\(if\|ec\%[ho]\|elsei\%[f]\|exe\%[cute]\)\>'
		\ end='$\||'
		\ contains=vifmExprCommand,vifmString,vifmStringInExpr,vifmBuiltinFunction
		\,vifmOperator,vifmEnvVar,vifmNumber
syntax region vifmNormalCommandSt start='\(\s\|:\)*norm\%[al]\>' end='$' keepend
		\ oneline
		\ contains=vifmNormalCommand,vifmComment
syntax region vifmExecute start='!' skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='$'
		\ keepend
		\ contains=vifmNotation,vifmComment
syntax region vifmMapArgs start='\ze\S\+'
		\ end='\ze.' skip='\(\n\s*\\\)\|\(\n\s*".*$\)'
		\ contained
		\ nextgroup=vifmMapArgList
syntax region vifmCMapArgs start='\S\+'
		\ end='\n\s*\\' skip='\(\n\s*\\\)\|\(\n\s*".*$\)'
		\ contained
		\ contains=vifmMapLhs,vifmMapCRhs
syntax region vifmMapLhs start='\S\+'
		\ end='\ze\s' skip='\(\s*\\\)\|\(\s*".*$\)'
		\ contained
		\ contains=vifmNotation,vifmComment
		\ nextgroup=vifmMapRhs
syntax region vifmMapRhs start='.'
		\ end='\ze<[cC][rR]>' skip='\(\s*\\\)\|\(\s*".*$\)'
		\ contained keepend
		\ contains=vifmNotation,vifmComment,vifmColonSubcommandN
		\ nextgroup=vifmMapRhs
syntax region vifmMapCRhs start='\s'
		\ end='<[cC][rR]>' skip='\(\s*\\\)\|\(\s*".*$\)'
		\ contained keepend
		\ contains=vifmNotation,vifmComment,vifmSubcommandN
syntax region vifmColonSubcommand start='\s*\(\s*\n\s*\\\)\?:\s*\S\+'
		\ end='$' skip='\s*\n\(\s*\\\)\|\(\s*".*$\)'
		\ contained
		\ contains=vifmStatementC
" Contained sub command with highlighting of angle-brace notation.
syntax region vifmColonSubcommandN start='\s*\(\s*\n\s*\\\)\?:\s*\S\+'
		\ end='\ze<[cC][rR]>\|$' skip='\s*\n\(\s*\\\)\|\(\s*".*$\)' keepend
		\ contained
		\ contains=vifmStatementCN
syntax region vifmSubcommandN start='\s*\(\s*\n\s*\\\)\?:\?\s*\S\+'
		\ end='\ze<[cC][rR]>\|$' skip='\s*\n\(\s*\\\)\|\(\s*".*$\)' keepend
		\ contained
		\ contains=vifmStatementCN
" Non-empty pattern or form [!][{]{*.ext,*.e}[}], [!][/]/regex/[/][iI] or
" <mime-type-globs>, possibly multi-line.
" [!]/regexp/[iI]+
syntax region vifmPattern contained
		\ start='!\?/\ze\(\n\s*\\\|\n\s*".*$\|[^/]\|\\/\)\+/'
		\ skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='/[iI]*\ze\s\|/\ze\S\+\s' keepend
		\ contains=vifmComment,vifmInlineComment,vifmNotComment,vifmNotPattern
" [!]//regexp//[iI]+
syntax region vifmPattern contained
		\ start='!\?//\ze\(/[^/]\|\n\s*\\\|\n\s*".*$\|[^/]\|\\/\)\+//'
		\ skip='/[^/]\|\(\n\s*\\\)\|\(\n\s*".*$\)' end='//[iI]*' keepend
		\ contains=vifmComment,vifmInlineComment,vifmNotComment,vifmNotPattern
" [!]{regexp}
syntax region vifmPattern contained
		\ start='!\?{[^}]' skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='}' keepend
		\ contains=vifmComment,vifmInlineComment,vifmNotComment,vifmNotPattern
" [!]{{regexp}}
syntax region vifmPattern contained
		\ start='!\?{{\ze.\{-}}}' skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='}}' keepend
		\ contains=vifmComment,vifmInlineComment,vifmNotComment,vifmNotPattern
" [!]<regexp>
syntax region vifmPattern contained
		\ start='!\?<[^>]' skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='>' keepend
		\ contains=vifmComment,vifmInlineComment,vifmNotComment,vifmNotPattern
syntax match vifmNotPattern contained '!\?\({{}}\|\<//\>\|////\)'
syntax region vifmHi
		\ start='^\(\s\|:\)*\<hi\%[ghlight]\>' skip='\(\n\s*\\\)\|\(\n\s*".*$\)'
		\ end='$' keepend
		\ contains=vifmHiCommand,vifmHiArgs,vifmHiGroups,vifmHiStyles,vifmHiColors
		\,vifmNumber,vifmComment,vifmInlineComment,vifmNotComment,vifmHiClear
		\,vifmPattern
syntax region vifmFtBeginning contained
		\ start='\<\(filet\%[ype]\|filext\%[ype]\|filev\%[iewer]\)\>\s\+\S'
		\ skip='\(\n\s*\\\)\|\(\n\s*".*$\)'
		\ end='\s' keepend
		\ contains=vifmFtCommand,vifmPattern

" common highlight for :command arguments without highlighting of angle-bracket
" notation
syntax region vifmArgs start='!\?\zs\(\s*\S\+\|[^a-zA-Z]\)'
		\ skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='|\|$'
		\ contained
		\ contains=vifmStringInExpr
" common highlight for :command arguments with highlighting of angle-bracket
" notation
syntax region vifmArgsCN start='!\?\zs\(\s*\S\+\|[^a-zA-Z]\)'
		\ skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='|\|$'
		\ contained
		\ contains=vifmStringInExpr,vifmNotation

syntax region vifmSet
		\ start='\(\s\|:\)*\<\(se\%[t]\|setg\%[lobal]\|setl\%[ocal]\)\>'
		\ skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='$'
		\ keepend
		\ contains=vifmSetCommand,vifmOption,vifmSetAssignSQS,vifmSetAssignDQS
		\,vifmSetAssignNS,vifmComment,vifmInlineComment,vifmNotComment
syntax region vifmSetN
		\ start='\(\s\|:\)*\<\(se\%[t]\|setg\%[lobal]\|setl\%[ocal]\)\>'
		\ skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='$'
		\ keepend
		\ contains=vifmSetCommand,vifmOption,vifmSetAssignSQS,vifmSetAssignDQS
		\,vifmSetAssignNSN,vifmComment,vifmInlineComment,vifmNotComment,vifmNotation
syntax region vifmSet2 contained
		\ start='^\(\s\|:\)*\<\(se\%[t]\|setg\%[lobal]\|setl\%[ocal]\)\>'
		\ skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='$'
		\ keepend
		\ contains=vifmSetCommand,vifmOption,vifmSetAssignSQS,vifmSetAssignDQS
		\,vifmSetAssignNSN,vifmComment,vifmInlineComment,vifmNotComment,vifmNotation

" Highlight for =value part of :set arguments of form option=value

" For single quoted string (check that it starts with =')
syntax region vifmSetAssignSQS contained
		\ start="='" skip=+\\\\\|\\'+ end=+'+ keepend
		\ contains=vifmString
" For double quoted string (check that it starts with =")
syntax region vifmSetAssignDQS contained
		\ start='="' skip=+\\\\\|\\"+ end=+"+ keepend
		\ contains=vifmString
" For not strings (check that it doesn't start with either =' or =")
syntax region vifmSetAssignNS contained
		\ start='=[^"'' ]' skip='\(\n\s*\\\)\|\(\n\s*".*$\)\|^.*\S.*\\\s' end='^\s*\\\s\|[^\\]\s\|$'
		\ extend
		\ contains=vifmNumber,vifmComment,vifmInlineComment
" For not strings (check that it doesn't start with either =' or =")
syntax region vifmSetAssignNSN contained
		\ start='=[^"'' ]' skip='\(\n\s*\\\)\|\(\n\s*".*$\)\|^.*\S.*\\\s' end='^\s*\\\s\|[^\\]\s\|$'
		\ extend
		\ contains=vifmNumber,vifmComment,vifmInlineComment,vifmNotation

" :let command with highlighting of angle-brace notation.
syntax region vifmLet
		\ start='^\(\s\|:\)*\<let\>' skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='$'
		\ keepend
		\ contains=vifmLetCommand,vifmEnvVar,vifmString,vifmStringInExpr,vifmComment
		\,vifmInlineComment,vifmNotComment
" Contained :let command without highlighting of angle-brace notation.
syntax region vifmLetC
		\ start='\<let\>' skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='$\||'
		\ keepend
		\ contains=vifmLetCommand,vifmEnvVar,vifmString,vifmStringInExpr,vifmComment
		\,vifmInlineComment,vifmNotComment,vifmBuiltinFunction
" Contained :let command with highlighting of angle-brace notation.
syntax region vifmLetCN
		\ start='\<let\>' skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='$\||'
		\ keepend
		\ contains=vifmLetCommand,vifmEnvVar,vifmString,vifmStringInExpr,vifmComment
		\,vifmInlineComment,vifmNotComment,vifmBuiltinFunction,vifmNotation
syntax region vifmUnlet
		\ start='^\(\s\|:\)*\<unl\%[et]\>' skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='$'
		\ keepend
		\ contains=vifmUnletCommand,vifmEnvVar,vifmComment,vifmInlineComment,vifmNotComment
syntax region vifmUnletC
		\ start='\<unl\%[et]\>' skip='\(\n\s*\\\)\|\(\n\s*".*$\)' end='$\||'
		\ keepend
		\ contains=vifmUnletCommand,vifmEnvVar,vifmComment,vifmInlineComment,vifmNotComment
syntax region vifmString contained start=+="+hs=s+1 skip=+\\\\\|\\"+  end=+"+
syntax region vifmString contained start=+='+hs=s+1 skip=+\\\\\|\\'+  end=+'+
syntax region vifmStringInExpr contained start=+=\@<="+hs=s+1 skip=+\\\\\|\\"+
		\ end=+"+
syntax region vifmStringInExpr contained start=+=\@<='+hs=s+1
		\ skip=+\\\\\|\\'\|''+  end=+'+
syntax region vifmStringInExpr contained start=+[.( ]"+hs=s+1 skip=+\\\\\|\\"+
		\ end=+"+
syntax region vifmStringInExpr contained start=+[.( ]'+hs=s+1
		\ skip=+\\\\\|\\'\|''+  end=+'+
syntax region vifmArgument contained start=+"+ skip=+\\\\\|\\"+  end=+"+
syntax region vifmArgument contained start=+'+ skip=+\\\\\|\\'\|''+  end=+'+
syntax match vifmEnvVar contained /\$[0-9a-zA-Z_]\+/
syntax match vifmNumber contained /\d\+/

" Optional map arguments right after command name
syntax match vifmMapArgList '\(<\(silent\|wait\)>\s*\)*' contained
		\ nextgroup=vifmMapLhs

" Ange-bracket notation
syntax case ignore
syntax match vifmNotation '<\(esc\|cr\|space\|del\|nop\|\(s-\)\?tab\|home\|end\|left\|right\|up\|down\|bs\|delete\|insert\|pageup\|pagedown\|\([acms]-\)\?f\d\{1,2\}\|c-s-[a-z[\]^_]\|s-c-[a-z[\]^_]\|c-[a-z[\]^_@]\|[am]-c-[a-z]\|c-[am]-[a-z]\|[am]-[a-z]\)>'
syntax case match

" Whole line comment
syntax region vifmComment contained contains=@Spell start='^\(\s\|:\)*"' end='$'
" Comment at the end of a line
syntax match vifmInlineComment contained contains=@Spell '\s"[^"]*$'
" This prevents highlighting non-first line of multi-line command
syntax match vifmNotComment contained '\s"[^"]*\(\n\s*\(\\\|"\)\)\@='

" Empty line
syntax match vifmEmpty /^\s*$/

" :highlight clear
syntax match vifmHiClear contained /\s*\<clear\>\s*/

" Check spelling only in syntax elements marked with @Spell
syntax spell notoplevel

" Highlight
highlight link vifmAutocmdCommand Statement
highlight link vifmPatternCommands Statement
highlight link vifmComment Comment
highlight link vifmInlineComment Comment
highlight link vifmCommand Statement
highlight link vifmCommandCN Statement
highlight link vifmPrefixCommands Statement
highlight link vifmCdCommand Statement
highlight link vifmCmdCommand Statement
highlight link vifmColoCommand Statement
highlight link vifmHiCommand Statement
highlight link vifmHiClear Statement
highlight link vifmInvertCommand Statement
highlight link vifmMarkCommand Statement
highlight link vifmFtCommand Statement
highlight link vifmExprCommand Statement
highlight link vifmNormalCommand Statement
highlight link vifmLetCommand Statement
highlight link vifmUnletCommand Statement
highlight link vifmSetCommand Statement
highlight link vifmSoCommand Statement
highlight link vifmBuiltinFunction Function
highlight link vifmOperator Operator
highlight link vifmMap Statement
highlight link vifmCMapAbbr Statement
highlight link vifmHiArgs Type
highlight link vifmAutoEvent Type
highlight link vifmHiGroups Identifier
highlight link vifmPattern String
highlight link vifmHiStyles PreProc
highlight link vifmHiColors Special
highlight link vifmOption PreProc
highlight link vifmNotation Special
highlight link vifmMapArgList Special
highlight link vifmString String
highlight link vifmStringInExpr String
highlight link vifmEnvVar PreProc
highlight link vifmNumber Number

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab cinoptions-=(0 :

endif
