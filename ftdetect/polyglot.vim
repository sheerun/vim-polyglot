" Vim support file to detect file types
"
" Maintainer:	Adam Stankiewicz <sheerun@sher.pl>
" URL: https://github.com/sheerun/vim-polyglot

" Listen very carefully, I will say this only once
if exists("did_load_polyglot")
  finish
endif


let did_load_polyglot = 1

" Switch to compatible mode for the time being
let s:cpo_save = &cpo
set cpo&vim

" It can happen vim filetype.vim loads first, then we need a reset
if exists("did_load_filetypes")
  au! filetypedetect
endif

" Prevent filetype.vim of vim from loading again
let did_load_filetypes = 1

" Be consistent across different systems
set nofileignorecase

function! s:SetDefault(name, value)
  if !exists(a:name)
    let {a:name} = a:value
  endif
endfunction

call s:SetDefault('g:markdown_enable_spell_checking', 0)
call s:SetDefault('g:markdown_enable_input_abbreviations', 0)
call s:SetDefault('g:markdown_enable_mappings', 0)

" Enable jsx syntax by default
call s:SetDefault('g:jsx_ext_required', 0)

" Needed for sql highlighting
call s:SetDefault('g:javascript_sql_dialect', 'sql')

" Make csv loading faster
call s:SetDefault('g:csv_start', 1)
call s:SetDefault('g:csv_end', 2)
call s:SetDefault('g:csv_default_delim', ',')

" Disable json concealing by default
call s:SetDefault('g:vim_json_syntax_conceal', 0)

call s:SetDefault('g:filetype_euphoria', 'elixir')

if !exists('g:python_highlight_all')
  call s:SetDefault('g:python_highlight_builtins', 1)
  call s:SetDefault('g:python_highlight_builtin_objs', 1)
  call s:SetDefault('g:python_highlight_builtin_types', 1)
  call s:SetDefault('g:python_highlight_builtin_funcs', 1)
  call s:SetDefault('g:python_highlight_builtin_funcs_kwarg', 1)
  call s:SetDefault('g:python_highlight_exceptions', 1)
  call s:SetDefault('g:python_highlight_string_formatting', 1)
  call s:SetDefault('g:python_highlight_string_format', 1)
  call s:SetDefault('g:python_highlight_string_templates', 1)
  call s:SetDefault('g:python_highlight_indent_errors', 1)
  call s:SetDefault('g:python_highlight_space_errors', 1)
  call s:SetDefault('g:python_highlight_doctests', 1)
  call s:SetDefault('g:python_highlight_func_calls', 1)
  call s:SetDefault('g:python_highlight_class_vars', 1)
  call s:SetDefault('g:python_highlight_operators', 1)
  call s:SetDefault('g:python_highlight_file_headers_as_comments', 1)
  call s:SetDefault('g:python_slow_sync', 1)
endif

" We need it because scripts.vim in vim uses "set ft=" which cannot be
" overridden with setf (and we can't use set ft= so our scripts.vim work)
func! s:Setf(ft)
  if &filetype !~# '\<'.a:ft.'\>'
    let &filetype = a:ft
  endif
endfunc

" Function used for patterns that end in a star: don't set the filetype if the
" file name matches ft_ignore_pat.
" When using this, the entry should probably be further down below with the
" other StarSetf() calls.
func! s:StarSetf(ft)
  if expand("<amatch>") !~ g:ft_ignore_pat
    exe 'setf ' . a:ft
  endif
endfunc

augroup polyglot-observer | augroup END

augroup filetypedetect

" Load user-defined filetype.vim and oter plugins ftdetect first
" This is to use polyglot-defined ftdetect always as fallback to user settings
runtime! filetype.vim
runtime! ftdetect/*.vim

" DO NOT EDIT CODE BELOW, IT IS GENERATED WITH MAKEFILE

if polyglot#util#IsEnabled('context', 'ftdetect')
  au BufNewFile,BufRead *.mkii,*.mkiv,*.mkvi setf context
endif

if polyglot#util#IsEnabled('xpm2', 'ftdetect')
  au BufNewFile,BufRead *.xpm2 setf xpm2
endif

if polyglot#util#IsEnabled('xpm', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.pm call polyglot#detect#Pm()
  au BufNewFile,BufRead *.xpm setf xpm
endif

if polyglot#util#IsEnabled('man', 'ftdetect')
  au BufNewFile,BufRead *.1,*.1in,*.1m,*.1x,*.2,*.3,*.3in,*.3m,*.3p,*.3pm,*.3qt,*.3x,*.4,*.5,*.6,*.7,*.8,*.9,*.man,*.mdoc setf man
endif

if polyglot#util#IsEnabled('xf86conf', 'ftdetect')
  au BufNewFile,BufRead */xorg.conf.d/*.conf,xorg.conf,xorg.conf-4 setf xf86conf
  au BufNewFile,BufRead XF86Config-4* call s:StarSetf('xf86conf')
  au BufNewFile,BufRead XF86Config* call s:StarSetf('xf86conf')
endif

if polyglot#util#IsEnabled('pullrequest', 'ftdetect')
  au BufNewFile,BufRead PULLREQ_EDITMSG setf pullrequest
endif

if polyglot#util#IsEnabled('text', 'ftdetect')
  au BufNewFile,BufRead *.text,README setf text
endif

if polyglot#util#IsEnabled('svn', 'ftdetect')
  au BufNewFile,BufRead svn-commit*.tmp setf svn
endif

if polyglot#util#IsEnabled('logcheck', 'ftdetect')
  au BufNewFile,BufRead */etc/logcheck/*.d*/* call s:StarSetf('logcheck')
endif

if polyglot#util#IsEnabled('fvwm', 'ftdetect')
  au BufNewFile,BufRead */.fvwm/* call s:StarSetf('fvwm')
endif

if polyglot#util#IsEnabled('crontab', 'ftdetect')
  au BufNewFile,BufRead crontab setf crontab
  au BufNewFile,BufRead crontab.* call s:StarSetf('crontab')
  au BufNewFile,BufRead */etc/cron.d/* call s:StarSetf('crontab')
endif

if polyglot#util#IsEnabled('bzr', 'ftdetect')
  au BufNewFile,BufRead bzr_log.* call s:StarSetf('bzr')
endif

if polyglot#util#IsEnabled('asteriskvm', 'ftdetect')
  au BufNewFile,BufRead *asterisk*/*voicemail.conf* call s:StarSetf('asteriskvm')
endif

if polyglot#util#IsEnabled('asterisk', 'ftdetect')
  au BufNewFile,BufRead *asterisk/*.conf* call s:StarSetf('asterisk')
endif

if polyglot#util#IsEnabled('apachestyle', 'ftdetect')
  au BufNewFile,BufRead proftpd.conf* call s:StarSetf('apachestyle')
  au BufNewFile,BufRead */etc/proftpd/conf.*/* call s:StarSetf('apachestyle')
  au BufNewFile,BufRead */etc/proftpd/*.conf* call s:StarSetf('apachestyle')
endif

if polyglot#util#IsEnabled('z8a', 'ftdetect')
  au BufNewFile,BufRead *.z8a setf z8a
endif

if polyglot#util#IsEnabled('zimbutempl', 'ftdetect')
  au BufNewFile,BufRead *.zut setf zimbutempl
endif

if polyglot#util#IsEnabled('zimbu', 'ftdetect')
  au BufNewFile,BufRead *.zu setf zimbu
endif

if polyglot#util#IsEnabled('yacc', 'ftdetect')
  au BufNewFile,BufRead *.y++,*.yxx,*.yy setf yacc
endif

if polyglot#util#IsEnabled('xslt', 'ftdetect')
  au BufNewFile,BufRead *.xsl,*.xslt setf xslt
endif

if polyglot#util#IsEnabled('xsd', 'ftdetect')
  au BufNewFile,BufRead *.xsd setf xsd
endif

if polyglot#util#IsEnabled('xquery', 'ftdetect')
  au BufNewFile,BufRead *.xq,*.xql,*.xqm,*.xquery,*.xqy setf xquery
endif

if polyglot#util#IsEnabled('xmodmap', 'ftdetect')
  au BufNewFile,BufRead *Xmodmap setf xmodmap
  au BufNewFile,BufRead *xmodmap* call s:StarSetf('xmodmap')
endif

if polyglot#util#IsEnabled('xmath', 'ftdetect')
  au BufNewFile,BufRead *.msc,*.msf setf xmath
endif

if polyglot#util#IsEnabled('xdefaults', 'ftdetect')
  au BufNewFile,BufRead *.ad,{.,}Xdefaults,{.,}Xpdefaults,{.,}Xresources,xdm-config setf xdefaults
  au BufNewFile,BufRead Xresources* call s:StarSetf('xdefaults')
  au BufNewFile,BufRead */app-defaults/* call s:StarSetf('xdefaults')
  au BufNewFile,BufRead */Xresources/* call s:StarSetf('xdefaults')
endif

if polyglot#util#IsEnabled('xinetd', 'ftdetect')
  au BufNewFile,BufRead */etc/xinetd.conf setf xinetd
  au BufNewFile,BufRead */etc/xinetd.d/* call s:StarSetf('xinetd')
endif

if polyglot#util#IsEnabled('xhtml', 'ftdetect')
  au BufNewFile,BufRead *.xht,*.xhtml setf xhtml
endif

if polyglot#util#IsEnabled('wsh', 'ftdetect')
  au BufNewFile,BufRead *.ws[fc] setf wsh
endif

if polyglot#util#IsEnabled('cvs', 'ftdetect')
  au BufNewFile,BufRead cvs\d\+ setf cvs
endif

if polyglot#util#IsEnabled('cvsrc', 'ftdetect')
  au BufNewFile,BufRead {.,}cvsrc setf cvsrc
endif

if polyglot#util#IsEnabled('wvdial', 'ftdetect')
  au BufNewFile,BufRead {.,}wvdialrc,wvdial.conf setf wvdial
endif

if polyglot#util#IsEnabled('wsml', 'ftdetect')
  au BufNewFile,BufRead *.wsml setf wsml
endif

if polyglot#util#IsEnabled('winbatch', 'ftdetect')
  au BufNewFile,BufRead *.wbt setf winbatch
endif

if polyglot#util#IsEnabled('wml', 'ftdetect')
  au BufNewFile,BufRead *.wml setf wml
endif

if polyglot#util#IsEnabled('wget', 'ftdetect')
  au BufNewFile,BufRead {.,}wgetrc,wgetrc setf wget
endif

if polyglot#util#IsEnabled('webmacro', 'ftdetect')
  au BufNewFile,BufRead *.wm setf webmacro
endif

if polyglot#util#IsEnabled('wast', 'ftdetect')
  au BufNewFile,BufRead *.wast,*.wat setf wast
endif

if polyglot#util#IsEnabled('vroom', 'ftdetect')
  au BufNewFile,BufRead *.vroom setf vroom
endif

if polyglot#util#IsEnabled('vrml', 'ftdetect')
  au BufNewFile,BufRead *.wrl setf vrml
endif

if polyglot#util#IsEnabled('vgrindefs', 'ftdetect')
  au BufNewFile,BufRead vgrindefs setf vgrindefs
endif

if polyglot#util#IsEnabled('viminfo', 'ftdetect')
  au BufNewFile,BufRead {.,}viminfo,_viminfo setf viminfo
endif

if polyglot#util#IsEnabled('vim', 'ftdetect')
  au BufNewFile,BufRead *.vba,*.vim,{.,}exrc,_exrc setf vim
  au BufNewFile,BufRead *vimrc* call s:StarSetf('vim')
endif

if polyglot#util#IsEnabled('vhdl', 'ftdetect')
  au BufNewFile,BufRead *.hdl,*.vbe,*.vhd,*.vhdl,*.vho,*.vst setf vhdl
  au BufNewFile,BufRead *.vhdl_[0-9]* call s:StarSetf('vhdl')
endif

if polyglot#util#IsEnabled('systemverilog', 'ftdetect')
  au BufNewFile,BufRead *.sv,*.svh setf systemverilog
endif

if polyglot#util#IsEnabled('verilogams', 'ftdetect')
  au BufNewFile,BufRead *.va,*.vams setf verilogams
endif

if polyglot#util#IsEnabled('verilog', 'ftdetect')
  au BufNewFile,BufRead *.v setf verilog
endif

if polyglot#util#IsEnabled('vera', 'ftdetect')
  au BufNewFile,BufRead *.vr,*.vrh,*.vri setf vera
endif

if polyglot#util#IsEnabled('upstart', 'ftdetect')
  au BufNewFile,BufRead */.config/upstart/*.conf,*/.config/upstart/*.override,*/.init/*.conf,*/.init/*.override,*/etc/init/*.conf,*/etc/init/*.override,*/usr/share/upstart/*.conf,*/usr/share/upstart/*.override setf upstart
endif

if polyglot#util#IsEnabled('updatedb', 'ftdetect')
  au BufNewFile,BufRead */etc/updatedb.conf setf updatedb
endif

if polyglot#util#IsEnabled('uc', 'ftdetect')
  au BufNewFile,BufRead *.uc setf uc
endif

if polyglot#util#IsEnabled('udevperm', 'ftdetect')
  au BufNewFile,BufRead */etc/udev/permissions.d/*.permissions setf udevperm
endif

if polyglot#util#IsEnabled('udevconf', 'ftdetect')
  au BufNewFile,BufRead */etc/udev/udev.conf setf udevconf
endif

if polyglot#util#IsEnabled('uil', 'ftdetect')
  au BufNewFile,BufRead *.uil,*.uit setf uil
endif

if polyglot#util#IsEnabled('tsscl', 'ftdetect')
  au BufNewFile,BufRead *.tsscl setf tsscl
endif

if polyglot#util#IsEnabled('tssop', 'ftdetect')
  au BufNewFile,BufRead *.tssop setf tssop
endif

if polyglot#util#IsEnabled('tssgm', 'ftdetect')
  au BufNewFile,BufRead *.tssgm setf tssgm
endif

if polyglot#util#IsEnabled('trustees', 'ftdetect')
  au BufNewFile,BufRead trustees.conf setf trustees
endif

if polyglot#util#IsEnabled('treetop', 'ftdetect')
  au BufNewFile,BufRead *.treetop setf treetop
endif

if polyglot#util#IsEnabled('tpp', 'ftdetect')
  au BufNewFile,BufRead *.tpp setf tpp
endif

if polyglot#util#IsEnabled('tidy', 'ftdetect')
  au BufNewFile,BufRead {.,}tidyrc,tidy.conf,tidyrc setf tidy
endif

if polyglot#util#IsEnabled('texmf', 'ftdetect')
  au BufNewFile,BufRead texmf.cnf setf texmf
endif

if polyglot#util#IsEnabled('texinfo', 'ftdetect')
  au BufNewFile,BufRead *.texi,*.texinfo,*.txi setf texinfo
endif

if polyglot#util#IsEnabled('tex', 'ftdetect')
  au BufNewFile,BufRead *.bbl,*.dtx,*.latex,*.ltx,*.sty setf tex
endif

if polyglot#util#IsEnabled('terminfo', 'ftdetect')
  au BufNewFile,BufRead *.ti setf terminfo
endif

if polyglot#util#IsEnabled('teraterm', 'ftdetect')
  au BufNewFile,BufRead *.ttl setf teraterm
endif

if polyglot#util#IsEnabled('tsalt', 'ftdetect')
  au BufNewFile,BufRead *.slt setf tsalt
endif

if polyglot#util#IsEnabled('tli', 'ftdetect')
  au BufNewFile,BufRead *.tli setf tli
endif

if polyglot#util#IsEnabled('tcl', 'ftdetect')
  au BufNewFile,BufRead *.itcl,*.itk,*.jacl,*.tcl,*.tk setf tcl
endif

if polyglot#util#IsEnabled('taskedit', 'ftdetect')
  au BufNewFile,BufRead *.task setf taskedit
endif

if polyglot#util#IsEnabled('taskdata', 'ftdetect')
  au BufNewFile,BufRead {pending,completed,undo}.data setf taskdata
endif

if polyglot#util#IsEnabled('tak', 'ftdetect')
  au BufNewFile,BufRead *.tak setf tak
endif

if polyglot#util#IsEnabled('tags', 'ftdetect')
  au BufNewFile,BufRead tags setf tags
endif

if polyglot#util#IsEnabled('sudoers', 'ftdetect')
  au BufNewFile,BufRead */etc/sudoers,sudoers.tmp setf sudoers
endif

if polyglot#util#IsEnabled('sdc', 'ftdetect')
  au BufNewFile,BufRead *.sdc setf sdc
endif

if polyglot#util#IsEnabled('sysctl', 'ftdetect')
  au BufNewFile,BufRead */etc/sysctl.conf,*/etc/sysctl.d/*.conf setf sysctl
endif

if polyglot#util#IsEnabled('sil', 'ftdetect')
  au BufNewFile,BufRead *.sil setf sil
endif

if polyglot#util#IsEnabled('swiftgyb', 'ftdetect')
  au BufNewFile,BufRead *.swift.gyb setf swiftgyb
endif

if polyglot#util#IsEnabled('voscm', 'ftdetect')
  au BufNewFile,BufRead *.cm setf voscm
endif

if polyglot#util#IsEnabled('sml', 'ftdetect')
  au BufNewFile,BufRead *.sml setf sml
endif

if polyglot#util#IsEnabled('stp', 'ftdetect')
  au BufNewFile,BufRead *.stp setf stp
endif

if polyglot#util#IsEnabled('smcl', 'ftdetect')
  au BufNewFile,BufRead *.hlp,*.ihlp,*.smcl setf smcl
endif

if polyglot#util#IsEnabled('stata', 'ftdetect')
  au BufNewFile,BufRead *.ado,*.do,*.imata,*.mata setf stata
endif

if polyglot#util#IsEnabled('sshdconfig', 'ftdetect')
  au BufNewFile,BufRead */etc/ssh/sshd_config.d/*.conf,sshd_config setf sshdconfig
endif

if polyglot#util#IsEnabled('sshconfig', 'ftdetect')
  au BufNewFile,BufRead */.ssh/config,*/etc/ssh/ssh_config.d/*.conf,ssh_config setf sshconfig
endif

if polyglot#util#IsEnabled('sqr', 'ftdetect')
  au BufNewFile,BufRead *.sqi,*.sqr setf sqr
endif

if polyglot#util#IsEnabled('sqlj', 'ftdetect')
  au BufNewFile,BufRead *.sqlj setf sqlj
endif

if polyglot#util#IsEnabled('squid', 'ftdetect')
  au BufNewFile,BufRead squid.conf setf squid
endif

if polyglot#util#IsEnabled('spice', 'ftdetect')
  au BufNewFile,BufRead *.sp,*.spice setf spice
endif

if polyglot#util#IsEnabled('slice', 'ftdetect')
  au BufNewFile,BufRead *.ice setf slice
endif

if polyglot#util#IsEnabled('spup', 'ftdetect')
  au BufNewFile,BufRead *.spd,*.spdata,*.speedup setf spup
endif

if polyglot#util#IsEnabled('hog', 'ftdetect')
  au BufNewFile,BufRead *.hog,snort.conf,vision.conf setf hog
endif

if polyglot#util#IsEnabled('mib', 'ftdetect')
  au BufNewFile,BufRead *.mib,*.my setf mib
endif

if polyglot#util#IsEnabled('snobol4', 'ftdetect')
  au BufNewFile,BufRead *.sno,*.spt setf snobol4
endif

if polyglot#util#IsEnabled('smith', 'ftdetect')
  au BufNewFile,BufRead *.smith,*.smt setf smith
endif

if polyglot#util#IsEnabled('st', 'ftdetect')
  au BufNewFile,BufRead *.st setf st
endif

if polyglot#util#IsEnabled('slrnsc', 'ftdetect')
  au BufNewFile,BufRead *.score setf slrnsc
endif

if polyglot#util#IsEnabled('slrnrc', 'ftdetect')
  au BufNewFile,BufRead {.,}slrnrc setf slrnrc
endif

if polyglot#util#IsEnabled('skill', 'ftdetect')
  au BufNewFile,BufRead *.cdf,*.il,*.ils setf skill
endif

if polyglot#util#IsEnabled('sisu', 'ftdetect')
  au BufNewFile,BufRead *.-sst,*.-sst.meta,*._sst,*._sst.meta,*.ssi,*.ssm,*.sst,*.sst.meta setf sisu
endif

if polyglot#util#IsEnabled('sinda', 'ftdetect')
  au BufNewFile,BufRead *.s85,*.sin setf sinda
endif

if polyglot#util#IsEnabled('simula', 'ftdetect')
  au BufNewFile,BufRead *.sim setf simula
endif

if polyglot#util#IsEnabled('screen', 'ftdetect')
  au BufNewFile,BufRead {.,}screenrc,screenrc setf screen
endif

if polyglot#util#IsEnabled('scheme', 'ftdetect')
  au BufNewFile,BufRead *.rkt,*.scm,*.ss setf scheme
endif

if polyglot#util#IsEnabled('catalog', 'ftdetect')
  au BufNewFile,BufRead catalog setf catalog
  au BufNewFile,BufRead sgml.catalog* call s:StarSetf('catalog')
endif

if polyglot#util#IsEnabled('setserial', 'ftdetect')
  au BufNewFile,BufRead */etc/serial.conf setf setserial
endif

if polyglot#util#IsEnabled('slpspi', 'ftdetect')
  au BufNewFile,BufRead */etc/slp.spi setf slpspi
endif

if polyglot#util#IsEnabled('spyce', 'ftdetect')
  au BufNewFile,BufRead *.spi,*.spy setf spyce
endif

if polyglot#util#IsEnabled('slpreg', 'ftdetect')
  au BufNewFile,BufRead */etc/slp.reg setf slpreg
endif

if polyglot#util#IsEnabled('slpconf', 'ftdetect')
  au BufNewFile,BufRead */etc/slp.conf setf slpconf
endif

if polyglot#util#IsEnabled('services', 'ftdetect')
  au BufNewFile,BufRead */etc/services setf services
endif

if polyglot#util#IsEnabled('sm', 'ftdetect')
  au BufNewFile,BufRead sendmail.cf setf sm
endif

if polyglot#util#IsEnabled('sieve', 'ftdetect')
  au BufNewFile,BufRead *.sieve,*.siv setf sieve
endif

if polyglot#util#IsEnabled('sdl', 'ftdetect')
  au BufNewFile,BufRead *.pr,*.sdl setf sdl
endif

if polyglot#util#IsEnabled('sd', 'ftdetect')
  au BufNewFile,BufRead *.sd setf sd
endif

if polyglot#util#IsEnabled('scilab', 'ftdetect')
  au BufNewFile,BufRead *.sce,*.sci setf scilab
endif

if polyglot#util#IsEnabled('sbt', 'ftdetect')
  au BufNewFile,BufRead *.sbt setf sbt
endif

if polyglot#util#IsEnabled('sather', 'ftdetect')
  au BufNewFile,BufRead *.sa setf sather
endif

if polyglot#util#IsEnabled('sass', 'ftdetect')
  au BufNewFile,BufRead *.sass setf sass
endif

if polyglot#util#IsEnabled('sas', 'ftdetect')
  au BufNewFile,BufRead *.sas setf sas
endif

if polyglot#util#IsEnabled('samba', 'ftdetect')
  au BufNewFile,BufRead smb.conf setf samba
endif

if polyglot#util#IsEnabled('slang', 'ftdetect')
  au BufNewFile,BufRead *.sl setf slang
endif

if polyglot#util#IsEnabled('rtf', 'ftdetect')
  au BufNewFile,BufRead *.rtf setf rtf
endif

if polyglot#util#IsEnabled('rpcgen', 'ftdetect')
  au BufNewFile,BufRead *.x setf rpcgen
endif

if polyglot#util#IsEnabled('robots', 'ftdetect')
  au BufNewFile,BufRead robots.txt setf robots
endif

if polyglot#util#IsEnabled('rpl', 'ftdetect')
  au BufNewFile,BufRead *.rpl setf rpl
endif

if polyglot#util#IsEnabled('rng', 'ftdetect')
  au BufNewFile,BufRead *.rng setf rng
endif

if polyglot#util#IsEnabled('rnc', 'ftdetect')
  au BufNewFile,BufRead *.rnc setf rnc
endif

if polyglot#util#IsEnabled('resolv', 'ftdetect')
  au BufNewFile,BufRead resolv.conf setf resolv
endif

if polyglot#util#IsEnabled('remind', 'ftdetect')
  au BufNewFile,BufRead *.rem,*.remind,{.,}reminders setf remind
  au BufNewFile,BufRead .reminders* call s:StarSetf('remind')
endif

if polyglot#util#IsEnabled('rrst', 'ftdetect')
  au BufNewFile,BufRead *.rrst,*.srst setf rrst
endif

if polyglot#util#IsEnabled('rmd', 'ftdetect')
  au BufNewFile,BufRead *.rmd,*.smd setf rmd
endif

if polyglot#util#IsEnabled('rnoweb', 'ftdetect')
  au BufNewFile,BufRead *.rnw,*.snw setf rnoweb
endif

if polyglot#util#IsEnabled('rexx', 'ftdetect')
  au BufNewFile,BufRead *.jrexx,*.orx,*.rex,*.rexx,*.rexxj,*.rxj,*.rxo,*.testGroup,*.testUnit setf rexx
endif

if polyglot#util#IsEnabled('rego', 'ftdetect')
  au BufNewFile,BufRead *.rego setf rego
endif

if polyglot#util#IsEnabled('rib', 'ftdetect')
  au BufNewFile,BufRead *.rib setf rib
endif

if polyglot#util#IsEnabled('readline', 'ftdetect')
  au BufNewFile,BufRead {.,}inputrc,inputrc setf readline
endif

if polyglot#util#IsEnabled('rcs', 'ftdetect')
  au BufNewFile,BufRead *\,v setf rcs
endif

if polyglot#util#IsEnabled('ratpoison', 'ftdetect')
  au BufNewFile,BufRead {.,}ratpoisonrc,ratpoisonrc setf ratpoison
endif

if polyglot#util#IsEnabled('radiance', 'ftdetect')
  au BufNewFile,BufRead *.mat,*.rad setf radiance
endif

if polyglot#util#IsEnabled('pyrex', 'ftdetect')
  au BufNewFile,BufRead *.pxd,*.pyx setf pyrex
endif

if polyglot#util#IsEnabled('protocols', 'ftdetect')
  au BufNewFile,BufRead */etc/protocols setf protocols
endif

if polyglot#util#IsEnabled('promela', 'ftdetect')
  au BufNewFile,BufRead *.pml setf promela
endif

if polyglot#util#IsEnabled('psf', 'ftdetect')
  au BufNewFile,BufRead *.psf setf psf
endif

if polyglot#util#IsEnabled('procmail', 'ftdetect')
  au BufNewFile,BufRead {.,}procmail,{.,}procmailrc setf procmail
endif

if polyglot#util#IsEnabled('privoxy', 'ftdetect')
  au BufNewFile,BufRead *.action setf privoxy
endif

if polyglot#util#IsEnabled('proc', 'ftdetect')
  au BufNewFile,BufRead *.pc setf proc
endif

if polyglot#util#IsEnabled('obj', 'ftdetect')
  au BufNewFile,BufRead *.obj setf obj
endif

if polyglot#util#IsEnabled('ppwiz', 'ftdetect')
  au BufNewFile,BufRead *.ih,*.it setf ppwiz
endif

if polyglot#util#IsEnabled('pccts', 'ftdetect')
  au BufNewFile,BufRead *.g setf pccts
endif

if polyglot#util#IsEnabled('povini', 'ftdetect')
  au BufNewFile,BufRead {.,}povrayrc setf povini
endif

if polyglot#util#IsEnabled('pov', 'ftdetect')
  au BufNewFile,BufRead *.pov setf pov
endif

if polyglot#util#IsEnabled('ppd', 'ftdetect')
  au BufNewFile,BufRead *.ppd setf ppd
endif

if polyglot#util#IsEnabled('postscr', 'ftdetect')
  au BufNewFile,BufRead *.afm,*.ai,*.eps,*.epsf,*.epsi,*.pfa,*.ps setf postscr
endif

if polyglot#util#IsEnabled('pfmain', 'ftdetect')
  au BufNewFile,BufRead main.cf setf pfmain
endif

if polyglot#util#IsEnabled('po', 'ftdetect')
  au BufNewFile,BufRead *.po,*.pot setf po
endif

if polyglot#util#IsEnabled('plp', 'ftdetect')
  au BufNewFile,BufRead *.plp setf plp
endif

if polyglot#util#IsEnabled('plsql', 'ftdetect')
  au BufNewFile,BufRead *.pls,*.plsql setf plsql
endif

if polyglot#util#IsEnabled('plm', 'ftdetect')
  au BufNewFile,BufRead *.p36,*.pac,*.plm setf plm
endif

if polyglot#util#IsEnabled('pli', 'ftdetect')
  au BufNewFile,BufRead *.pl1,*.pli setf pli
endif

if polyglot#util#IsEnabled('pine', 'ftdetect')
  au BufNewFile,BufRead {.,}pinerc,{.,}pinercex,pinerc,pinercex setf pine
endif

if polyglot#util#IsEnabled('pilrc', 'ftdetect')
  au BufNewFile,BufRead *.rcp setf pilrc
endif

if polyglot#util#IsEnabled('pinfo', 'ftdetect')
  au BufNewFile,BufRead */.pinforc,*/etc/pinforc setf pinfo
endif

if polyglot#util#IsEnabled('cmod', 'ftdetect')
  au BufNewFile,BufRead *.cmod setf cmod
endif

if polyglot#util#IsEnabled('pike', 'ftdetect')
  au BufNewFile,BufRead *.pike,*.pmod setf pike
endif

if polyglot#util#IsEnabled('pcmk', 'ftdetect')
  au BufNewFile,BufRead *.pcmk setf pcmk
endif

if polyglot#util#IsEnabled('pdf', 'ftdetect')
  au BufNewFile,BufRead *.pdf setf pdf
endif

if polyglot#util#IsEnabled('pascal', 'ftdetect')
  au BufNewFile,BufRead *.dpr,*.lpr,*.pas,*.pp setf pascal
endif

if polyglot#util#IsEnabled('passwd', 'ftdetect')
  au BufNewFile,BufRead */etc/passwd,*/etc/passwd-,*/etc/passwd.edit,*/etc/shadow,*/etc/shadow-,*/etc/shadow.edit,*/var/backups/passwd.bak,*/var/backups/shadow.bak setf passwd
endif

if polyglot#util#IsEnabled('papp', 'ftdetect')
  au BufNewFile,BufRead *.papp,*.pxml,*.pxsl setf papp
endif

if polyglot#util#IsEnabled('pamenv', 'ftdetect')
  au BufNewFile,BufRead {.,}pam_environment,pam_env.conf setf pamenv
endif

if polyglot#util#IsEnabled('pamconf', 'ftdetect')
  au BufNewFile,BufRead */etc/pam.conf setf pamconf
  au BufNewFile,BufRead */etc/pam.d/* call s:StarSetf('pamconf')
endif

if polyglot#util#IsEnabled('pf', 'ftdetect')
  au BufNewFile,BufRead pf.conf setf pf
endif

if polyglot#util#IsEnabled('ora', 'ftdetect')
  au BufNewFile,BufRead *.ora setf ora
endif

if polyglot#util#IsEnabled('opl', 'ftdetect')
  au BufNewFile,BufRead *.[Oo][Pp][Ll] setf opl
endif

if polyglot#util#IsEnabled('openroad', 'ftdetect')
  au BufNewFile,BufRead *.or setf openroad
endif

if polyglot#util#IsEnabled('omnimark', 'ftdetect')
  au BufNewFile,BufRead *.xin,*.xom setf omnimark
endif

if polyglot#util#IsEnabled('occam', 'ftdetect')
  au BufNewFile,BufRead *.occ setf occam
endif

if polyglot#util#IsEnabled('nsis', 'ftdetect')
  au BufNewFile,BufRead *.nsh,*.nsi setf nsis
endif

if polyglot#util#IsEnabled('nqc', 'ftdetect')
  au BufNewFile,BufRead *.nqc setf nqc
endif

if polyglot#util#IsEnabled('nroff', 'ftdetect')
  au BufNewFile,BufRead *.mom,*.nr,*.roff,*.tmac,*.tr setf nroff
  au BufNewFile,BufRead tmac.* call s:StarSetf('nroff')
endif

if polyglot#util#IsEnabled('ncf', 'ftdetect')
  au BufNewFile,BufRead *.ncf setf ncf
endif

if polyglot#util#IsEnabled('ninja', 'ftdetect')
  au BufNewFile,BufRead *.ninja setf ninja
endif

if polyglot#util#IsEnabled('netrc', 'ftdetect')
  au BufNewFile,BufRead {.,}netrc setf netrc
endif

if polyglot#util#IsEnabled('neomuttrc', 'ftdetect')
  au BufNewFile,BufRead Neomuttrc setf neomuttrc
  au BufNewFile,BufRead neomuttrc* call s:StarSetf('neomuttrc')
  au BufNewFile,BufRead Neomuttrc* call s:StarSetf('neomuttrc')
  au BufNewFile,BufRead .neomuttrc* call s:StarSetf('neomuttrc')
  au BufNewFile,BufRead */.neomutt/neomuttrc* call s:StarSetf('neomuttrc')
endif

if polyglot#util#IsEnabled('natural', 'ftdetect')
  au BufNewFile,BufRead *.NS[ACGLMNPS] setf natural
endif

if polyglot#util#IsEnabled('nanorc', 'ftdetect')
  au BufNewFile,BufRead *.nanorc,*/etc/nanorc setf nanorc
endif

if polyglot#util#IsEnabled('n1ql', 'ftdetect')
  au BufNewFile,BufRead *.n1ql,*.nql setf n1ql
endif

if polyglot#util#IsEnabled('mush', 'ftdetect')
  au BufNewFile,BufRead *.mush setf mush
endif

if polyglot#util#IsEnabled('mupad', 'ftdetect')
  au BufNewFile,BufRead *.mu setf mupad
endif

if polyglot#util#IsEnabled('muttrc', 'ftdetect')
  au BufNewFile,BufRead Mutt{ng,}rc setf muttrc
  au BufNewFile,BufRead mutt{ng,}rc* call s:StarSetf('muttrc')
  au BufNewFile,BufRead Mutt{ng,}rc* call s:StarSetf('muttrc')
  au BufNewFile,BufRead .mutt{ng,}rc* call s:StarSetf('muttrc')
  au BufNewFile,BufRead */etc/Muttrc.d/* call s:StarSetf('muttrc')
  au BufNewFile,BufRead */.mutt{ng,}/mutt{ng,}rc* call s:StarSetf('muttrc')
endif

if polyglot#util#IsEnabled('msql', 'ftdetect')
  au BufNewFile,BufRead *.msql setf msql
endif

if polyglot#util#IsEnabled('mrxvtrc', 'ftdetect')
  au BufNewFile,BufRead {.,}mrxvtrc,mrxvtrc setf mrxvtrc
endif

if polyglot#util#IsEnabled('srec', 'ftdetect')
  au BufNewFile,BufRead *.mot,*.s19,*.s28,*.s37,*.srec setf srec
endif

if polyglot#util#IsEnabled('mplayerconf', 'ftdetect')
  au BufNewFile,BufRead */.mplayer/config,mplayer.conf setf mplayerconf
endif

if polyglot#util#IsEnabled('modconf', 'ftdetect')
  au BufNewFile,BufRead */etc/conf.modules,*/etc/modules,*/etc/modules.conf setf modconf
  au BufNewFile,BufRead */etc/modprobe.* call s:StarSetf('modconf')
endif

if polyglot#util#IsEnabled('moo', 'ftdetect')
  au BufNewFile,BufRead *.moo setf moo
endif

if polyglot#util#IsEnabled('monk', 'ftdetect')
  au BufNewFile,BufRead *.isc,*.monk,*.ssc,*.tsc setf monk
endif

if polyglot#util#IsEnabled('modula3', 'ftdetect')
  au BufNewFile,BufRead *.[mi][3g] setf modula3
endif

if polyglot#util#IsEnabled('modula2', 'ftdetect')
  au BufNewFile,BufRead *.DEF,*.MOD,*.m2,*.mi setf modula2
endif

if polyglot#util#IsEnabled('mmp', 'ftdetect')
  au BufNewFile,BufRead *.mmp setf mmp
endif

if polyglot#util#IsEnabled('mix', 'ftdetect')
  au BufNewFile,BufRead *.mix,*.mixal setf mix
endif

if polyglot#util#IsEnabled('mgl', 'ftdetect')
  au BufNewFile,BufRead *.mgl setf mgl
endif

if polyglot#util#IsEnabled('mp', 'ftdetect')
  au BufNewFile,BufRead *.mp setf mp
endif

if polyglot#util#IsEnabled('mf', 'ftdetect')
  au BufNewFile,BufRead *.mf setf mf
endif

if polyglot#util#IsEnabled('messages', 'ftdetect')
  au BufNewFile,BufRead */log/{auth,cron,daemon,debug,kern,lpr,mail,messages,news/news,syslog,user}{,.log,.err,.info,.warn,.crit,.notice}{,.[0-9]*,-[0-9]*} setf messages
endif

if polyglot#util#IsEnabled('hgcommit', 'ftdetect')
  au BufNewFile,BufRead hg-editor-*.txt setf hgcommit
endif

if polyglot#util#IsEnabled('mel', 'ftdetect')
  au BufNewFile,BufRead *.mel setf mel
endif

if polyglot#util#IsEnabled('map', 'ftdetect')
  au BufNewFile,BufRead *.map setf map
endif

if polyglot#util#IsEnabled('maple', 'ftdetect')
  au BufNewFile,BufRead *.mpl,*.mv,*.mws setf maple
endif

if polyglot#util#IsEnabled('manconf', 'ftdetect')
  au BufNewFile,BufRead */etc/man.conf,man.config setf manconf
endif

if polyglot#util#IsEnabled('mallard', 'ftdetect')
  au BufNewFile,BufRead *.page setf mallard
endif

if polyglot#util#IsEnabled('ist', 'ftdetect')
  au BufNewFile,BufRead *.ist,*.mst setf ist
endif

if polyglot#util#IsEnabled('mailcap', 'ftdetect')
  au BufNewFile,BufRead {.,}mailcap,mailcap setf mailcap
endif

if polyglot#util#IsEnabled('mailaliases', 'ftdetect')
  au BufNewFile,BufRead */etc/aliases,*/etc/mail/aliases setf mailaliases
endif

if polyglot#util#IsEnabled('mail', 'ftdetect')
  au BufNewFile,BufRead *.eml,{.,}article,{.,}article.\d\+,{.,}followup,{.,}letter,{.,}letter.\d\+,/tmp/SLRN[0-9A-Z.]\+,ae\d\+.txt,mutt[[:alnum:]_-]\\\{6\},mutt{ng,}-*-\w\+,neomutt-*-\w\+,neomutt[[:alnum:]_-]\\\{6\},pico.\d\+,snd.\d\+,{neo,}mutt[[:alnum:]._-]\\\{6\} setf mail
  au BufNewFile,BufRead reportbug-* call s:StarSetf('mail')
endif

if polyglot#util#IsEnabled('mgp', 'ftdetect')
  au BufNewFile,BufRead *.mgp setf mgp
endif

if polyglot#util#IsEnabled('lss', 'ftdetect')
  au BufNewFile,BufRead *.lss setf lss
endif

if polyglot#util#IsEnabled('lsl', 'ftdetect')
  au BufNewFile,BufRead *.lsl setf lsl
endif

if polyglot#util#IsEnabled('lout', 'ftdetect')
  au BufNewFile,BufRead *.lou,*.lout setf lout
endif

if polyglot#util#IsEnabled('lotos', 'ftdetect')
  au BufNewFile,BufRead *.lot,*.lotos setf lotos
endif

if polyglot#util#IsEnabled('logtalk', 'ftdetect')
  au BufNewFile,BufRead *.lgt setf logtalk
endif

if polyglot#util#IsEnabled('logindefs', 'ftdetect')
  au BufNewFile,BufRead */etc/login.defs setf logindefs
endif

if polyglot#util#IsEnabled('loginaccess', 'ftdetect')
  au BufNewFile,BufRead */etc/login.access setf loginaccess
endif

if polyglot#util#IsEnabled('litestep', 'ftdetect')
  au BufNewFile,BufRead */LiteStep/*/*.rc setf litestep
endif

if polyglot#util#IsEnabled('lite', 'ftdetect')
  au BufNewFile,BufRead *.lite,*.lt setf lite
endif

if polyglot#util#IsEnabled('liquid', 'ftdetect')
  au BufNewFile,BufRead *.liquid setf liquid
endif

if polyglot#util#IsEnabled('lisp', 'ftdetect')
  au BufNewFile,BufRead *.cl,*.el,*.lisp,*.lsp,{.,}emacs,{.,}sawfishrc,{.,}sbclrc,sbclrc setf lisp
endif

if polyglot#util#IsEnabled('lilo', 'ftdetect')
  au BufNewFile,BufRead lilo.conf setf lilo
  au BufNewFile,BufRead lilo.conf* call s:StarSetf('lilo')
endif

if polyglot#util#IsEnabled('lifelines', 'ftdetect')
  au BufNewFile,BufRead *.ll setf lifelines
endif

if polyglot#util#IsEnabled('lftp', 'ftdetect')
  au BufNewFile,BufRead *lftp/rc,{.,}lftprc,lftp.conf setf lftp
endif

if polyglot#util#IsEnabled('sensors', 'ftdetect')
  au BufNewFile,BufRead */etc/sensors.conf,*/etc/sensors3.conf setf sensors
endif

if polyglot#util#IsEnabled('libao', 'ftdetect')
  au BufNewFile,BufRead */.libao,*/etc/libao.conf setf libao
endif

if polyglot#util#IsEnabled('lex', 'ftdetect')
  au BufNewFile,BufRead *.l,*.l++,*.lex,*.lxx setf lex
endif

if polyglot#util#IsEnabled('ld', 'ftdetect')
  au BufNewFile,BufRead *.ld setf ld
endif

if polyglot#util#IsEnabled('ldif', 'ftdetect')
  au BufNewFile,BufRead *.ldif setf ldif
endif

if polyglot#util#IsEnabled('lprolog', 'ftdetect')
  au BufNewFile,BufRead *.sig setf lprolog
endif

if polyglot#util#IsEnabled('limits', 'ftdetect')
  au BufNewFile,BufRead */etc/*limits.conf,*/etc/*limits.d/*.conf,*/etc/limits setf limits
endif

if polyglot#util#IsEnabled('latte', 'ftdetect')
  au BufNewFile,BufRead *.latte,*.lte setf latte
endif

if polyglot#util#IsEnabled('lace', 'ftdetect')
  au BufNewFile,BufRead *.ACE,*.ace setf lace
endif

if polyglot#util#IsEnabled('kconfig', 'ftdetect')
  au BufNewFile,BufRead Kconfig,Kconfig.debug setf kconfig
  au BufNewFile,BufRead Kconfig.* call s:StarSetf('kconfig')
endif

if polyglot#util#IsEnabled('kscript', 'ftdetect')
  au BufNewFile,BufRead *.ks setf kscript
endif

if polyglot#util#IsEnabled('kivy', 'ftdetect')
  au BufNewFile,BufRead *.kv setf kivy
endif

if polyglot#util#IsEnabled('kwt', 'ftdetect')
  au BufNewFile,BufRead *.k setf kwt
endif

if polyglot#util#IsEnabled('kix', 'ftdetect')
  au BufNewFile,BufRead *.kix setf kix
endif

if polyglot#util#IsEnabled('jovial', 'ftdetect')
  au BufNewFile,BufRead *.j73,*.jov,*.jovial setf jovial
endif

if polyglot#util#IsEnabled('jgraph', 'ftdetect')
  au BufNewFile,BufRead *.jgr setf jgraph
endif

if polyglot#util#IsEnabled('jess', 'ftdetect')
  au BufNewFile,BufRead *.clp setf jess
endif

if polyglot#util#IsEnabled('jproperties', 'ftdetect')
  au BufNewFile,BufRead *.properties,*.properties_??,*.properties_??_?? setf jproperties
  au BufNewFile,BufRead *.properties_??_??_* call s:StarSetf('jproperties')
endif

if polyglot#util#IsEnabled('jsp', 'ftdetect')
  au BufNewFile,BufRead *.jsp setf jsp
endif

if polyglot#util#IsEnabled('javacc', 'ftdetect')
  au BufNewFile,BufRead *.jj,*.jjt setf javacc
endif

if polyglot#util#IsEnabled('java', 'ftdetect')
  au BufNewFile,BufRead *.jav,*.java setf java
endif

if polyglot#util#IsEnabled('jam', 'ftdetect')
  au BufNewFile,BufRead *.jpl,*.jpr setf jam
  au BufNewFile,BufRead Prl*.* call s:StarSetf('jam')
  au BufNewFile,BufRead JAM*.* call s:StarSetf('jam')
endif

if polyglot#util#IsEnabled('jal', 'ftdetect')
  au BufNewFile,BufRead *.JAL,*.jal setf jal
endif

if polyglot#util#IsEnabled('j', 'ftdetect')
  au BufNewFile,BufRead *.ijs setf j
endif

if polyglot#util#IsEnabled('iss', 'ftdetect')
  au BufNewFile,BufRead *.iss setf iss
endif

if polyglot#util#IsEnabled('inittab', 'ftdetect')
  au BufNewFile,BufRead inittab setf inittab
endif

if polyglot#util#IsEnabled('fgl', 'ftdetect')
  au BufNewFile,BufRead *.4gh,*.4gl,*.m4gl setf fgl
endif

if polyglot#util#IsEnabled('ipfilter', 'ftdetect')
  au BufNewFile,BufRead ipf.conf,ipf.rules,ipf6.conf setf ipfilter
endif

if polyglot#util#IsEnabled('usw2kagtlog', 'ftdetect')
  au BufNewFile,BufRead *.usw2kagt.log\c,usw2kagt.*.log\c,usw2kagt.log\c setf usw2kagtlog
endif

if polyglot#util#IsEnabled('usserverlog', 'ftdetect')
  au BufNewFile,BufRead *.usserver.log\c,usserver.*.log\c,usserver.log\c setf usserverlog
endif

if polyglot#util#IsEnabled('upstreaminstalllog', 'ftdetect')
  au BufNewFile,BufRead *.upstreaminstall.log\c,upstreaminstall.*.log\c,upstreaminstall.log\c setf upstreaminstalllog
endif

if polyglot#util#IsEnabled('upstreamlog', 'ftdetect')
  au BufNewFile,BufRead *.upstream.log\c,UPSTREAM-*.log\c,fdrupstream.log,upstream.*.log\c,upstream.log\c setf upstreamlog
endif

if polyglot#util#IsEnabled('upstreamdat', 'ftdetect')
  au BufNewFile,BufRead *.upstream.dat\c,upstream.*.dat\c,upstream.dat\c setf upstreamdat
endif

if polyglot#util#IsEnabled('initng', 'ftdetect')
  au BufNewFile,BufRead *.ii,*/etc/initng/*/*.i setf initng
endif

if polyglot#util#IsEnabled('inform', 'ftdetect')
  au BufNewFile,BufRead *.INF,*.inf setf inform
endif

if polyglot#util#IsEnabled('indent', 'ftdetect')
  au BufNewFile,BufRead {.,}indent.pro,indentrc setf indent
endif

if polyglot#util#IsEnabled('icemenu', 'ftdetect')
  au BufNewFile,BufRead */.icewm/menu setf icemenu
endif

if polyglot#util#IsEnabled('msidl', 'ftdetect')
  au BufNewFile,BufRead *.mof,*.odl setf msidl
endif

if polyglot#util#IsEnabled('icon', 'ftdetect')
  au BufNewFile,BufRead *.icn setf icon
endif

if polyglot#util#IsEnabled('httest', 'ftdetect')
  au BufNewFile,BufRead *.htb,*.htt setf httest
endif

if polyglot#util#IsEnabled('hb', 'ftdetect')
  au BufNewFile,BufRead *.hb setf hb
endif

if polyglot#util#IsEnabled('hostsaccess', 'ftdetect')
  au BufNewFile,BufRead */etc/hosts.allow,*/etc/hosts.deny setf hostsaccess
endif

if polyglot#util#IsEnabled('hostconf', 'ftdetect')
  au BufNewFile,BufRead */etc/host.conf setf hostconf
endif

if polyglot#util#IsEnabled('template', 'ftdetect')
  au BufNewFile,BufRead *.tmpl setf template
endif

if polyglot#util#IsEnabled('htmlm4', 'ftdetect')
  au BufNewFile,BufRead *.html.m4 setf htmlm4
endif

if polyglot#util#IsEnabled('tilde', 'ftdetect')
  au BufNewFile,BufRead *.t.html setf tilde
endif

if polyglot#util#IsEnabled('html', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.html call polyglot#detect#Html()
  au BufNewFile,BufRead *.htm,*.html.hl,*.inc,*.st,*.xht,*.xhtml setf html
endif

if polyglot#util#IsEnabled('hollywood', 'ftdetect')
  au BufNewFile,BufRead *.hws setf hollywood
endif

if polyglot#util#IsEnabled('hex', 'ftdetect')
  au BufNewFile,BufRead *.h32,*.hex setf hex
endif

if polyglot#util#IsEnabled('hercules', 'ftdetect')
  au BufNewFile,BufRead *.errsum,*.ev,*.sum,*.vc setf hercules
endif

if polyglot#util#IsEnabled('hastepreproc', 'ftdetect')
  au BufNewFile,BufRead *.htpp setf hastepreproc
endif

if polyglot#util#IsEnabled('haste', 'ftdetect')
  au BufNewFile,BufRead *.ht setf haste
endif

if polyglot#util#IsEnabled('chaskell', 'ftdetect')
  au BufNewFile,BufRead *.chs setf chaskell
endif

if polyglot#util#IsEnabled('lhaskell', 'ftdetect')
  au BufNewFile,BufRead *.lhs setf lhaskell
endif

if polyglot#util#IsEnabled('gtkrc', 'ftdetect')
  au BufNewFile,BufRead {.,}gtkrc,gtkrc setf gtkrc
  au BufNewFile,BufRead gtkrc* call s:StarSetf('gtkrc')
  au BufNewFile,BufRead .gtkrc* call s:StarSetf('gtkrc')
endif

if polyglot#util#IsEnabled('group', 'ftdetect')
  au BufNewFile,BufRead */etc/group,*/etc/group-,*/etc/group.edit,*/etc/gshadow,*/etc/gshadow-,*/etc/gshadow.edit,*/var/backups/group.bak,*/var/backups/gshadow.bak setf group
endif

if polyglot#util#IsEnabled('gsp', 'ftdetect')
  au BufNewFile,BufRead *.gsp setf gsp
endif

if polyglot#util#IsEnabled('gretl', 'ftdetect')
  au BufNewFile,BufRead *.gretl setf gretl
endif

if polyglot#util#IsEnabled('grads', 'ftdetect')
  au BufNewFile,BufRead *.gs setf grads
endif

if polyglot#util#IsEnabled('gitolite', 'ftdetect')
  au BufNewFile,BufRead gitolite.conf setf gitolite
  au BufNewFile,BufRead */gitolite-admin/conf/* call s:StarSetf('gitolite')
endif

if polyglot#util#IsEnabled('gnash', 'ftdetect')
  au BufNewFile,BufRead {.,}gnashpluginrc,{.,}gnashrc,gnashpluginrc,gnashrc setf gnash
endif

if polyglot#util#IsEnabled('gpg', 'ftdetect')
  au BufNewFile,BufRead */.gnupg/gpg.conf,*/.gnupg/options,*/usr/*/gnupg/options.skel setf gpg
endif

if polyglot#util#IsEnabled('gp', 'ftdetect')
  au BufNewFile,BufRead *.gp,{.,}gprc setf gp
endif

if polyglot#util#IsEnabled('gkrellmrc', 'ftdetect')
  au BufNewFile,BufRead gkrellmrc,gkrellmrc_? setf gkrellmrc
endif

if polyglot#util#IsEnabled('gedcom', 'ftdetect')
  au BufNewFile,BufRead *.ged,lltxxxxx.txt setf gedcom
  au BufNewFile,BufRead */tmp/lltmp* call s:StarSetf('gedcom')
endif

if polyglot#util#IsEnabled('gdmo', 'ftdetect')
  au BufNewFile,BufRead *.gdmo,*.mo setf gdmo
endif

if polyglot#util#IsEnabled('gdb', 'ftdetect')
  au BufNewFile,BufRead {.,}gdbinit setf gdb
endif

if polyglot#util#IsEnabled('fstab', 'ftdetect')
  au BufNewFile,BufRead fstab,mtab setf fstab
endif

if polyglot#util#IsEnabled('framescript', 'ftdetect')
  au BufNewFile,BufRead *.fsl setf framescript
endif

if polyglot#util#IsEnabled('fortran', 'ftdetect')
  au BufNewFile,BufRead *.f,*.f03,*.f08,*.f77,*.f90,*.f95,*.for,*.fortran,*.fpp,*.ftn setf fortran
endif

if polyglot#util#IsEnabled('reva', 'ftdetect')
  au BufNewFile,BufRead *.frt setf reva
endif

if polyglot#util#IsEnabled('focexec', 'ftdetect')
  au BufNewFile,BufRead *.fex,*.focexec setf focexec
endif

if polyglot#util#IsEnabled('fetchmail', 'ftdetect')
  au BufNewFile,BufRead {.,}fetchmailrc setf fetchmail
endif

if polyglot#util#IsEnabled('factor', 'ftdetect')
  au BufNewFile,BufRead *.factor setf factor
endif

if polyglot#util#IsEnabled('fan', 'ftdetect')
  au BufNewFile,BufRead *.fan,*.fwt setf fan
endif

if polyglot#util#IsEnabled('falcon', 'ftdetect')
  au BufNewFile,BufRead *.fal setf falcon
endif

if polyglot#util#IsEnabled('exports', 'ftdetect')
  au BufNewFile,BufRead exports setf exports
endif

if polyglot#util#IsEnabled('expect', 'ftdetect')
  au BufNewFile,BufRead *.exp setf expect
endif

if polyglot#util#IsEnabled('exim', 'ftdetect')
  au BufNewFile,BufRead exim.conf setf exim
endif

if polyglot#util#IsEnabled('csc', 'ftdetect')
  au BufNewFile,BufRead *.csc setf csc
endif

if polyglot#util#IsEnabled('esterel', 'ftdetect')
  au BufNewFile,BufRead *.strl setf esterel
endif

if polyglot#util#IsEnabled('esqlc', 'ftdetect')
  au BufNewFile,BufRead *.EC,*.ec setf esqlc
endif

if polyglot#util#IsEnabled('esmtprc', 'ftdetect')
  au BufNewFile,BufRead *esmtprc setf esmtprc
endif

if polyglot#util#IsEnabled('elmfilt', 'ftdetect')
  au BufNewFile,BufRead filter-rules setf elmfilt
endif

if polyglot#util#IsEnabled('elinks', 'ftdetect')
  au BufNewFile,BufRead elinks.conf setf elinks
endif

if polyglot#util#IsEnabled('ecd', 'ftdetect')
  au BufNewFile,BufRead *.ecd setf ecd
endif

if polyglot#util#IsEnabled('edif', 'ftdetect')
  au BufNewFile,BufRead *.ed\(f\|if\|o\) setf edif
endif

if polyglot#util#IsEnabled('dts', 'ftdetect')
  au BufNewFile,BufRead *.dts,*.dtsi setf dts
endif

if polyglot#util#IsEnabled('dtd', 'ftdetect')
  au BufNewFile,BufRead *.dtd setf dtd
endif

if polyglot#util#IsEnabled('dsl', 'ftdetect')
  au BufNewFile,BufRead *.dsl setf dsl
endif

if polyglot#util#IsEnabled('datascript', 'ftdetect')
  au BufNewFile,BufRead *.ds setf datascript
endif

if polyglot#util#IsEnabled('dracula', 'ftdetect')
  au BufNewFile,BufRead *.drac,*.drc,*lpe,*lvs setf dracula
  au BufNewFile,BufRead drac.* call s:StarSetf('dracula')
endif

if polyglot#util#IsEnabled('def', 'ftdetect')
  au BufNewFile,BufRead *.def setf def
endif

if polyglot#util#IsEnabled('dylan', 'ftdetect')
  au BufNewFile,BufRead *.dylan setf dylan
endif

if polyglot#util#IsEnabled('dylanintr', 'ftdetect')
  au BufNewFile,BufRead *.intr setf dylanintr
endif

if polyglot#util#IsEnabled('dylanlid', 'ftdetect')
  au BufNewFile,BufRead *.lid setf dylanlid
endif

if polyglot#util#IsEnabled('dot', 'ftdetect')
  au BufNewFile,BufRead *.dot,*.gv setf dot
endif

if polyglot#util#IsEnabled('dircolors', 'ftdetect')
  au BufNewFile,BufRead */etc/DIR_COLORS,{.,}dir_colors,{.,}dircolors setf dircolors
endif

if polyglot#util#IsEnabled('diff', 'ftdetect')
  au BufNewFile,BufRead *.diff,*.rej setf diff
endif

if polyglot#util#IsEnabled('dictdconf', 'ftdetect')
  au BufNewFile,BufRead dictd.conf setf dictdconf
endif

if polyglot#util#IsEnabled('dictconf', 'ftdetect')
  au BufNewFile,BufRead {.,}dictrc,dict.conf setf dictconf
endif

if polyglot#util#IsEnabled('desktop', 'ftdetect')
  au BufNewFile,BufRead *.desktop,*.directory setf desktop
endif

if polyglot#util#IsEnabled('desc', 'ftdetect')
  au BufNewFile,BufRead *.desc setf desc
endif

if polyglot#util#IsEnabled('dnsmasq', 'ftdetect')
  au BufNewFile,BufRead */etc/dnsmasq.conf setf dnsmasq
  au BufNewFile,BufRead */etc/dnsmasq.d/* call s:StarSetf('dnsmasq')
endif

if polyglot#util#IsEnabled('denyhosts', 'ftdetect')
  au BufNewFile,BufRead denyhosts.conf setf denyhosts
endif

if polyglot#util#IsEnabled('debsources', 'ftdetect')
  au BufNewFile,BufRead */etc/apt/sources.list,*/etc/apt/sources.list.d/*.list setf debsources
endif

if polyglot#util#IsEnabled('debcopyright', 'ftdetect')
  au BufNewFile,BufRead */debian/copyright setf debcopyright
endif

if polyglot#util#IsEnabled('debcontrol', 'ftdetect')
  au BufNewFile,BufRead */debian/control setf debcontrol
endif

if polyglot#util#IsEnabled('cuplsim', 'ftdetect')
  au BufNewFile,BufRead *.si setf cuplsim
endif

if polyglot#util#IsEnabled('cupl', 'ftdetect')
  au BufNewFile,BufRead *.pld setf cupl
endif

if polyglot#util#IsEnabled('csp', 'ftdetect')
  au BufNewFile,BufRead *.csp,*.fdr setf csp
endif

if polyglot#util#IsEnabled('quake', 'ftdetect')
  au BufNewFile,BufRead *baseq[2-3]/*.cfg,*id1/*.cfg,*quake[1-3]/*.cfg setf quake
endif

if polyglot#util#IsEnabled('lynx', 'ftdetect')
  au BufNewFile,BufRead lynx.cfg setf lynx
endif

if polyglot#util#IsEnabled('eterm', 'ftdetect')
  au BufNewFile,BufRead *Eterm/*.cfg setf eterm
endif

if polyglot#util#IsEnabled('dcd', 'ftdetect')
  au BufNewFile,BufRead *.dcd setf dcd
endif

if polyglot#util#IsEnabled('dockerfile', 'ftdetect')
  au BufNewFile,BufRead *.Dockerfile,*.dock,Containerfile,Dockerfile,dockerfile setf dockerfile
  au BufNewFile,BufRead Dockerfile* call s:StarSetf('dockerfile')
endif

if polyglot#util#IsEnabled('cuda', 'ftdetect')
  au BufNewFile,BufRead *.cu,*.cuh setf cuda
endif

if polyglot#util#IsEnabled('config', 'ftdetect')
  au BufNewFile,BufRead Pipfile,configure.ac,configure.in setf config
  au BufNewFile,BufRead /etc/hostname.* call s:StarSetf('config')
endif

if polyglot#util#IsEnabled('cf', 'ftdetect')
  au BufNewFile,BufRead *.cfc,*.cfi,*.cfm setf cf
endif

if polyglot#util#IsEnabled('coco', 'ftdetect')
  au BufNewFile,BufRead *.atg setf coco
endif

if polyglot#util#IsEnabled('cobol', 'ftdetect')
  au BufNewFile,BufRead *.cbl,*.cob,*.lib setf cobol
endif

if polyglot#util#IsEnabled('cmusrc', 'ftdetect')
  au BufNewFile,BufRead */.cmus/{autosave,rc,command-history,*.theme},*/cmus/{rc,*.theme} setf cmusrc
endif

if polyglot#util#IsEnabled('cl', 'ftdetect')
  au BufNewFile,BufRead *.eni setf cl
endif

if polyglot#util#IsEnabled('clean', 'ftdetect')
  au BufNewFile,BufRead *.dcl,*.icl setf clean
endif

if polyglot#util#IsEnabled('chordpro', 'ftdetect')
  au BufNewFile,BufRead *.cho,*.chopro,*.chordpro,*.crd,*.crdpro setf chordpro
endif

if polyglot#util#IsEnabled('chill', 'ftdetect')
  au BufNewFile,BufRead *..ch setf chill
endif

if polyglot#util#IsEnabled('debchangelog', 'ftdetect')
  au BufNewFile,BufRead */debian/changelog,NEWS.Debian,NEWS.dch,changelog.Debian,changelog.dch setf debchangelog
endif

if polyglot#util#IsEnabled('cterm', 'ftdetect')
  au BufNewFile,BufRead *.con setf cterm
endif

if polyglot#util#IsEnabled('css', 'ftdetect')
  au BufNewFile,BufRead *.css setf css
endif

if polyglot#util#IsEnabled('ch', 'ftdetect')
  au BufNewFile,BufRead *.chf setf ch
endif

if polyglot#util#IsEnabled('cynpp', 'ftdetect')
  au BufNewFile,BufRead *.cyn setf cynpp
endif

if polyglot#util#IsEnabled('crm', 'ftdetect')
  au BufNewFile,BufRead *.crm setf crm
endif

if polyglot#util#IsEnabled('conaryrecipe', 'ftdetect')
  au BufNewFile,BufRead *.recipe setf conaryrecipe
endif

if polyglot#util#IsEnabled('cdl', 'ftdetect')
  au BufNewFile,BufRead *.cdl setf cdl
endif

if polyglot#util#IsEnabled('chaiscript', 'ftdetect')
  au BufNewFile,BufRead *.chai setf chaiscript
endif

if polyglot#util#IsEnabled('cfengine', 'ftdetect')
  au BufNewFile,BufRead cfengine.conf setf cfengine
endif

if polyglot#util#IsEnabled('cdrdaoconf', 'ftdetect')
  au BufNewFile,BufRead */etc/cdrdao.conf,*/etc/default/cdrdao,*/etc/defaults/cdrdao,{.,}cdrdao setf cdrdaoconf
endif

if polyglot#util#IsEnabled('cdrtoc', 'ftdetect')
  au BufNewFile,BufRead *.toc setf cdrtoc
endif

if polyglot#util#IsEnabled('cabal', 'ftdetect')
  au BufNewFile,BufRead *.cabal setf cabal
endif

if polyglot#util#IsEnabled('csdl', 'ftdetect')
  au BufNewFile,BufRead *.csdl setf csdl
endif

if polyglot#util#IsEnabled('cs', 'ftdetect')
  au BufNewFile,BufRead *.cs setf cs
endif

if polyglot#util#IsEnabled('calendar', 'ftdetect')
  au BufNewFile,BufRead calendar setf calendar
  au BufNewFile,BufRead */share/calendar/calendar.* call s:StarSetf('calendar')
  au BufNewFile,BufRead */share/calendar/*/calendar.* call s:StarSetf('calendar')
  au BufNewFile,BufRead */.calendar/* call s:StarSetf('calendar')
endif

if polyglot#util#IsEnabled('lpc', 'ftdetect')
  au BufNewFile,BufRead *.lpc,*.ulpc setf lpc
endif

if polyglot#util#IsEnabled('bsdl', 'ftdetect')
  au BufNewFile,BufRead *.bsdl,*bsd setf bsdl
endif

if polyglot#util#IsEnabled('blank', 'ftdetect')
  au BufNewFile,BufRead *.bl setf blank
endif

if polyglot#util#IsEnabled('bindzone', 'ftdetect')
  au BufNewFile,BufRead named.root setf bindzone
  au BufNewFile,BufRead */named/db.* call s:StarSetf('bindzone')
  au BufNewFile,BufRead */bind/db.* call s:StarSetf('bindzone')
endif

if polyglot#util#IsEnabled('named', 'ftdetect')
  au BufNewFile,BufRead named*.conf,rndc*.conf,rndc*.key setf named
endif

if polyglot#util#IsEnabled('bst', 'ftdetect')
  au BufNewFile,BufRead *.bst setf bst
endif

if polyglot#util#IsEnabled('bib', 'ftdetect')
  au BufNewFile,BufRead *.bib setf bib
endif

if polyglot#util#IsEnabled('bdf', 'ftdetect')
  au BufNewFile,BufRead *.bdf setf bdf
endif

if polyglot#util#IsEnabled('bc', 'ftdetect')
  au BufNewFile,BufRead *.bc setf bc
endif

if polyglot#util#IsEnabled('dosbatch', 'ftdetect')
  au BufNewFile,BufRead *.bat,*.sys setf dosbatch
endif

if polyglot#util#IsEnabled('hamster', 'ftdetect')
  au BufNewFile,BufRead *.hsc,*.hsm setf hamster
endif

if polyglot#util#IsEnabled('freebasic', 'ftdetect')
  au BufNewFile,BufRead *.bi,*.fb setf freebasic
endif

if polyglot#util#IsEnabled('ibasic', 'ftdetect')
  au BufNewFile,BufRead *.iba,*.ibi setf ibasic
endif

if polyglot#util#IsEnabled('b', 'ftdetect')
  au BufNewFile,BufRead *.imp,*.mch,*.ref setf b
endif

if polyglot#util#IsEnabled('sql', 'ftdetect')
  au BufNewFile,BufRead *.bdy,*.ddl,*.fnc,*.pck,*.pkb,*.pks,*.plb,*.pls,*.plsql,*.prc,*.spc,*.sql,*.tpb,*.tps,*.trg,*.tyb,*.tyc,*.typ,*.vw setf sql
endif

if polyglot#util#IsEnabled('gitignore', 'ftdetect')
  au BufNewFile,BufRead *.git/info/exclude,*/.config/git/ignore,{.,}gitignore setf gitignore
endif

if polyglot#util#IsEnabled('tads', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.t call polyglot#detect#T()
endif

if polyglot#util#IsEnabled('prolog', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.pl call polyglot#detect#Pl()
  au BufNewFile,BufRead *.pdb,*.pro,*.prolog,*.yap setf prolog
endif

if polyglot#util#IsEnabled('bzl', 'ftdetect')
  au BufNewFile,BufRead *.BUILD,*.bazel,*.bzl,BUCK,BUILD,BUILD.bazel,Tiltfile,WORKSPACE setf bzl
endif

if polyglot#util#IsEnabled('odin', 'ftdetect')
  au BufNewFile,BufRead *.odin setf odin
endif

if polyglot#util#IsEnabled('dosini', 'ftdetect')
  au BufNewFile,BufRead *.dof,*.ini,*.lektorproject,*.prefs,*.pro,*.properties,*/etc/pacman.conf,*/etc/yum.conf,{.,}editorconfig,{.,}npmrc,buildozer.spec setf dosini
  au BufNewFile,BufRead php.ini-* call s:StarSetf('dosini')
  au BufNewFile,BufRead */etc/yum.repos.d/* call s:StarSetf('dosini')
endif

if polyglot#util#IsEnabled('spec', 'ftdetect')
  au BufNewFile,BufRead *.spec setf spec
endif

if polyglot#util#IsEnabled('visual-basic', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.bas call polyglot#detect#Bas()
  au BufNewFile,BufRead *.cls,*.ctl,*.dsm,*.frm,*.frx,*.sba,*.vba,*.vbs setf vb
endif

if polyglot#util#IsEnabled('basic', 'ftdetect')
  au BufNewFile,BufRead *.basic setf basic
endif

if polyglot#util#IsEnabled('trasys', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.inp call polyglot#detect#Inp()
endif

if polyglot#util#IsEnabled('zig', 'ftdetect')
  au BufNewFile,BufRead *.zir setf zir
  au BufNewFile,BufRead *.zig,*.zir setf zig
endif

if polyglot#util#IsEnabled('zephir', 'ftdetect')
  au BufNewFile,BufRead *.zep setf zephir
endif

if polyglot#util#IsEnabled('help', 'ftdetect')
  au BufNewFile,BufRead $VIMRUNTIME/doc/*.txt setf help
endif

if polyglot#util#IsEnabled('helm', 'ftdetect')
  au BufNewFile,BufRead */templates/*.tpl,*/templates/*.yaml setf helm
endif

if polyglot#util#IsEnabled('smarty', 'ftdetect')
  au BufNewFile,BufRead *.tpl setf smarty
endif

if polyglot#util#IsEnabled('ansible', 'ftdetect')
  au BufNewFile,BufRead handlers.*.y{a,}ml,local.y{a,}ml,main.y{a,}ml,playbook.y{a,}ml,requirements.y{a,}ml,roles.*.y{a,}ml,site.y{a,}ml,tasks.*.y{a,}ml setf yaml.ansible
  au BufNewFile,BufRead host_vars/* call s:StarSetf('yaml.ansible')
  au BufNewFile,BufRead group_vars/* call s:StarSetf('yaml.ansible')
endif

if polyglot#util#IsEnabled('xsl', 'ftdetect')
  au BufNewFile,BufRead *.xsl,*.xslt setf xsl
endif

if polyglot#util#IsEnabled('xdc', 'ftdetect')
  au BufNewFile,BufRead *.xdc setf xdc
endif

if polyglot#util#IsEnabled('vue', 'ftdetect')
  au BufNewFile,BufRead *.vue,*.wpy setf vue
endif

if polyglot#util#IsEnabled('vmasm', 'ftdetect')
  au BufNewFile,BufRead *.mar setf vmasm
endif

if polyglot#util#IsEnabled('velocity', 'ftdetect')
  au BufNewFile,BufRead *.vm setf velocity
endif

if polyglot#util#IsEnabled('vcl', 'ftdetect')
  au BufNewFile,BufRead *.vcl setf vcl
endif

if polyglot#util#IsEnabled('vbnet', 'ftdetect')
  au BufNewFile,BufRead *.vb,*.vbhtml setf vbnet
endif

if polyglot#util#IsEnabled('vala', 'ftdetect')
  au BufNewFile,BufRead *.vala,*.valadoc,*.vapi setf vala
endif

if polyglot#util#IsEnabled('v', 'ftdetect')
  au BufNewFile,BufRead *.v,*.vsh,*.vv setf vlang
endif

if polyglot#util#IsEnabled('unison', 'ftdetect')
  au BufNewFile,BufRead *.u,*.uu setf unison
endif

if polyglot#util#IsEnabled('typescript', 'ftdetect')
  au BufNewFile,BufRead *.ts setf typescript
  au BufNewFile,BufRead *.tsx setf typescriptreact
endif

if polyglot#util#IsEnabled('twig', 'ftdetect')
  au BufNewFile,BufRead *.twig setf html.twig
  au BufNewFile,BufRead *.xml.twig setf xml.twig
endif

if polyglot#util#IsEnabled('tptp', 'ftdetect')
  au BufNewFile,BufRead *.ax,*.p,*.tptp setf tptp
endif

if polyglot#util#IsEnabled('toml', 'ftdetect')
  au BufNewFile,BufRead *.toml,*/.cargo/config,*/.cargo/credentials,Cargo.lock,Gopkg.lock,Pipfile,poetry.lock setf toml
endif

if polyglot#util#IsEnabled('tmux', 'ftdetect')
  au BufNewFile,BufRead {.,}tmux*.conf setf tmux
endif

if polyglot#util#IsEnabled('thrift', 'ftdetect')
  au BufNewFile,BufRead *.thrift setf thrift
endif

if polyglot#util#IsEnabled('textile', 'ftdetect')
  au BufNewFile,BufRead *.textile setf textile
endif

if polyglot#util#IsEnabled('terraform', 'ftdetect')
  au BufNewFile,BufRead *.tf,*.tfvars setf terraform
endif

if polyglot#util#IsEnabled('tf', 'ftdetect')
  au BufNewFile,BufRead *.tf,{.,}tfrc,tfrc setf tf
endif

if polyglot#util#IsEnabled('systemd', 'ftdetect')
  au BufNewFile,BufRead *.automount,*.dnssd,*.link,*.mount,*.netdev,*.network,*.nspawn,*.path,*.service,*.slice,*.socket,*.swap,*.target,*.timer,*/systemd/*.conf setf systemd
  au BufNewFile,BufRead *.#* call s:StarSetf('systemd')
endif

if polyglot#util#IsEnabled('sxhkd', 'ftdetect')
  au BufNewFile,BufRead *.sxhkdrc,sxhkdrc setf sxhkdrc
endif

if polyglot#util#IsEnabled('swift', 'ftdetect')
  au BufNewFile,BufRead *.swift setf swift
endif

if polyglot#util#IsEnabled('svg', 'ftdetect')
  au BufNewFile,BufRead *.svg setf svg
endif

if polyglot#util#IsEnabled('svelte', 'ftdetect')
  au BufNewFile,BufRead *.svelte setf svelte
endif

if polyglot#util#IsEnabled('stylus', 'ftdetect')
  au BufNewFile,BufRead *.styl,*.stylus setf stylus
endif

if polyglot#util#IsEnabled('solidity', 'ftdetect')
  au BufNewFile,BufRead *.sol setf solidity
endif

if polyglot#util#IsEnabled('smt2', 'ftdetect')
  au BufNewFile,BufRead *.smt,*.smt2 setf smt2
endif

if polyglot#util#IsEnabled('slime', 'ftdetect')
  au BufNewFile,BufRead *.slime setf slime
endif

if polyglot#util#IsEnabled('slim', 'ftdetect')
  au BufNewFile,BufRead *.slim setf slim
endif

if polyglot#util#IsEnabled('sh', 'ftdetect')
  au BufNewFile,BufRead *.bash,*.bats,*.cgi,*.command,*.env,*.fcgi,*.ksh,*.sh,*.sh.in,*.tmux,*.tool,*/etc/udev/cdsymlinks.conf,{.,}bash_aliases,{.,}bash_history,{.,}bash_logout,{.,}bash_profile,{.,}bashrc,{.,}cshrc,{.,}env,{.,}env.example,{.,}flaskenv,{.,}login,{.,}profile,9fs,PKGBUILD,bash_aliases,bash_logout,bash_profile,bashrc,cshrc,gradlew,login,man,profile setf sh
  au BufNewFile,BufRead *.zsh,*/etc/zprofile,{.,}zfbfmarks,{.,}zlogin,{.,}zlogout,{.,}zprofile,{.,}zshenv,{.,}zshrc setf zsh
  au BufNewFile,BufRead .zsh* call s:StarSetf('zsh')
  au BufNewFile,BufRead .zlog* call s:StarSetf('zsh')
  au BufNewFile,BufRead .zcompdump* call s:StarSetf('zsh')
endif

if polyglot#util#IsEnabled('scss', 'ftdetect')
  au BufNewFile,BufRead *.scss setf scss
endif

if polyglot#util#IsEnabled('scala', 'ftdetect')
  au BufNewFile,BufRead *.kojo,*.sc,*.scala setf scala
endif

if polyglot#util#IsEnabled('rust', 'ftdetect')
  au BufNewFile,BufRead *.rs,*.rs.in setf rust
endif

if polyglot#util#IsEnabled('brewfile', 'ftdetect')
  au BufNewFile,BufRead Brewfile setf brewfile
endif

if polyglot#util#IsEnabled('rspec', 'ftdetect')
  au BufNewFile,BufRead *_spec.rb set ft=ruby syntax=rspec
endif

if polyglot#util#IsEnabled('ruby', 'ftdetect')
  au BufNewFile,BufRead *.axlsx,*.builder,*.cap,*.eye,*.fcgi,*.gemspec,*.god,*.jbuilder,*.mspec,*.opal,*.pluginspec,*.podspec,*.rabl,*.rake,*.rant,*.rb,*.rbi,*.rbuild,*.rbw,*.rbx,*.rjs,*.ru,*.ruby,*.rxml,*.spec,*.thor,*.watchr,{.,}Brewfile,{.,}Guardfile,{.,}autotest,{.,}irbrc,{.,}pryrc,{.,}simplecov,Appraisals,Berksfile,Buildfile,Capfile,Cheffile,Dangerfile,Deliverfile,Fastfile,Gemfile,Gemfile.lock,Guardfile,Jarfile,KitchenSink,Mavenfile,Podfile,Puppetfile,Rakefile,Routefile,Snapfile,Thorfile,Vagrantfile,[Rr]antfile,buildfile,vagrantfile setf ruby
  au BufNewFile,BufRead [Rr]akefile* call s:StarSetf('ruby')
  au BufNewFile,BufRead *.erb,*.erb.deface,*.rhtml setf eruby
endif

if polyglot#util#IsEnabled('rst', 'ftdetect')
  au BufNewFile,BufRead *.rest,*.rest.txt,*.rst,*.rst.txt setf rst
endif

if polyglot#util#IsEnabled('reason', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.re call polyglot#detect#Re()
  au BufNewFile,BufRead *.rei setf reason
endif

if polyglot#util#IsEnabled('razor', 'ftdetect')
  au BufNewFile,BufRead *.cshtml,*.razor setf razor
endif

if polyglot#util#IsEnabled('raml', 'ftdetect')
  au BufNewFile,BufRead *.raml setf raml
endif

if polyglot#util#IsEnabled('raku', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.t call polyglot#detect#T()
  au BufNewFile,BufRead,BufWritePost *.pm call polyglot#detect#Pm()
  au BufNewFile,BufRead,BufWritePost *.pl call polyglot#detect#Pl()
  au BufNewFile,BufRead *.6pl,*.6pm,*.nqp,*.p6,*.p6l,*.p6m,*.pl6,*.pm6,*.pod6,*.raku,*.rakudoc,*.rakumod,*.rakutest,*.t6 setf raku
endif

if polyglot#util#IsEnabled('ragel', 'ftdetect')
  au BufNewFile,BufRead *.rl setf ragel
endif

if polyglot#util#IsEnabled('racket', 'ftdetect')
  au BufNewFile,BufRead *.rkt,*.rktd,*.rktl,*.scrbl setf racket
endif

if polyglot#util#IsEnabled('r-lang', 'ftdetect')
  au BufNewFile,BufRead *.S,*.r,*.rsx,*.s,{.,}Rprofile,expr-dist setf r
  au BufNewFile,BufRead *.rd setf rhelp
endif

if polyglot#util#IsEnabled('qml', 'ftdetect')
  au BufNewFile,BufRead *.qbs,*.qml setf qml
endif

if polyglot#util#IsEnabled('qmake', 'ftdetect')
  au BufNewFile,BufRead *.pri,*.pro setf qmake
endif

if polyglot#util#IsEnabled('requirements', 'ftdetect')
  au BufNewFile,BufRead *.pip,*require.{txt,in},*requirements.{txt,in},constraints.{txt,in} setf requirements
endif

if polyglot#util#IsEnabled('python', 'ftdetect')
  au BufNewFile,BufRead *.cgi,*.fcgi,*.gyp,*.gypi,*.lmi,*.ptl,*.py,*.py3,*.pyde,*.pyi,*.pyp,*.pyt,*.pyw,*.rpy,*.smk,*.spec,*.tac,*.wsgi,*.xpy,{.,}gclient,{.,}pythonrc,{.,}pythonstartup,DEPS,SConscript,SConstruct,Snakefile,wscript setf python
endif

if polyglot#util#IsEnabled('purescript', 'ftdetect')
  au BufNewFile,BufRead *.purs setf purescript
endif

if polyglot#util#IsEnabled('puppet', 'ftdetect')
  au BufNewFile,BufRead *.pp,Modulefile setf puppet
  au BufNewFile,BufRead *.epp setf embeddedpuppet
endif

if polyglot#util#IsEnabled('pug', 'ftdetect')
  au BufNewFile,BufRead *.jade,*.pug setf pug
endif

if polyglot#util#IsEnabled('protobuf', 'ftdetect')
  au BufNewFile,BufRead *.proto setf proto
endif

if polyglot#util#IsEnabled('powershell', 'ftdetect')
  au BufNewFile,BufRead *.ps1,*.psd1,*.psm1,*.pssc setf ps1
  au BufNewFile,BufRead *.ps1xml setf ps1xml
endif

if polyglot#util#IsEnabled('pony', 'ftdetect')
  au BufNewFile,BufRead *.pony setf pony
endif

if polyglot#util#IsEnabled('plantuml', 'ftdetect')
  au BufNewFile,BufRead *.iuml,*.plantuml,*.pu,*.puml,*.uml setf plantuml
endif

if polyglot#util#IsEnabled('blade', 'ftdetect')
  au BufNewFile,BufRead *.blade,*.blade.php setf blade
endif

if polyglot#util#IsEnabled('php', 'ftdetect')
  au BufNewFile,BufRead *.aw,*.ctp,*.fcgi,*.inc,*.php,*.php3,*.php4,*.php5,*.php9,*.phps,*.phpt,*.phtml,{.,}php,{.,}php_cs,{.,}php_cs.dist,Phakefile setf php
endif

if polyglot#util#IsEnabled('cql', 'ftdetect')
  au BufNewFile,BufRead *.cql setf cql
endif

if polyglot#util#IsEnabled('pgsql', 'ftdetect')
  au BufNewFile,BufRead *.pgsql let b:sql_type_override='pgsql' | set ft=sql
endif

if polyglot#util#IsEnabled('perl', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.t call polyglot#detect#T()
  au BufNewFile,BufRead,BufWritePost *.pm call polyglot#detect#Pm()
  au BufNewFile,BufRead,BufWritePost *.pl call polyglot#detect#Pl()
  au BufNewFile,BufRead *.al,*.cgi,*.fcgi,*.perl,*.ph,*.plx,*.psgi,{.,}gitolite.rc,Makefile.PL,Rexfile,ack,cpanfile,example.gitolite.rc setf perl
  au BufNewFile,BufRead *.pod setf pod
  au BufNewFile,BufRead *.comp,*.mason,*.mhtml setf mason
  au BufNewFile,BufRead,BufWritePost *.tt2 call polyglot#detect#Tt2()
  au BufNewFile,BufRead,BufWritePost *.tt2 call polyglot#detect#Tt2()
  au BufNewFile,BufRead *.xs setf xs
endif

if polyglot#util#IsEnabled('rc', 'ftdetect')
  au BufNewFile,BufRead *.rc,*.rch setf rc
endif

if polyglot#util#IsEnabled('opencl', 'ftdetect')
  au BufNewFile,BufRead *.cl,*.opencl setf opencl
endif

if polyglot#util#IsEnabled('octave', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.m call polyglot#detect#M()
  au BufNewFile,BufRead *.oct setf octave
endif

if polyglot#util#IsEnabled('ocaml', 'ftdetect')
  au BufNewFile,BufRead *.eliom,*.eliomi,*.ml,*.ml.cppo,*.ml4,*.mli,*.mli.cppo,*.mlip,*.mll,*.mlp,*.mlt,*.mly,{.,}ocamlinit setf ocaml
  au BufNewFile,BufRead *.om,OMakefile,OMakeroot,OMakeroot.in setf omake
  au BufNewFile,BufRead *.opam,*.opam.template,opam setf opam
  au BufNewFile,BufRead _oasis setf oasis
  au BufNewFile,BufRead dune,dune-project,dune-workspace,jbuild setf dune
  au BufNewFile,BufRead _tags setf ocamlbuild_tags
  au BufNewFile,BufRead *.ocp setf ocpbuild
  au BufNewFile,BufRead *.root setf ocpbuildroot
  au BufNewFile,BufRead *.sexp setf sexplib
endif

if polyglot#util#IsEnabled('objc', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.m call polyglot#detect#M()
  au BufNewFile,BufRead,BufWritePost *.h call polyglot#detect#H()
endif

if polyglot#util#IsEnabled('nix', 'ftdetect')
  au BufNewFile,BufRead *.nix setf nix
endif

if polyglot#util#IsEnabled('nim', 'ftdetect')
  au BufNewFile,BufRead *.nim,*.nim.cfg,*.nimble,*.nimrod,*.nims,nim.cfg setf nim
endif

if polyglot#util#IsEnabled('nginx', 'ftdetect')
  au BufNewFile,BufRead *.nginx,*.nginxconf,*.vhost,*/nginx/*.conf,*nginx.conf,nginx*.conf,nginx.conf setf nginx
  au BufNewFile,BufRead */usr/local/nginx/conf/* call s:StarSetf('nginx')
  au BufNewFile,BufRead */etc/nginx/* call s:StarSetf('nginx')
endif

if polyglot#util#IsEnabled('murphi', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.m call polyglot#detect#M()
endif

if polyglot#util#IsEnabled('moonscript', 'ftdetect')
  au BufNewFile,BufRead *.moon setf moon
endif

if polyglot#util#IsEnabled('meson', 'ftdetect')
  au BufNewFile,BufRead meson.build,meson_options.txt setf meson
  au BufNewFile,BufRead *.wrap setf dosini
endif

if polyglot#util#IsEnabled('mdx', 'ftdetect')
  au BufNewFile,BufRead *.mdx setf markdown.mdx
endif

if polyglot#util#IsEnabled('mathematica', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.m call polyglot#detect#M()
  au BufNewFile,BufRead *.cdf,*.ma,*.mathematica,*.mma,*.mt,*.nb,*.nbp,*.wl,*.wls,*.wlt setf mma
endif

if polyglot#util#IsEnabled('mako', 'ftdetect')
  au BufNewFile,BufRead *.mako,*.mao setf mako
  au BufReadPre *.*.mao execute "do BufRead filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufNewFile *.*.mao execute "do BufNewFile filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufReadPre *.*.mako execute "do BufRead filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufNewFile *.*.mako execute "do BufNewFile filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
endif

if polyglot#util#IsEnabled('m4', 'ftdetect')
  au BufNewFile,BufRead *.at,*.m4 setf m4
endif

if polyglot#util#IsEnabled('lua', 'ftdetect')
  au BufNewFile,BufRead *.fcgi,*.lua,*.nse,*.p8,*.pd_lua,*.rbxs,*.rockspec,*.wlua,{.,}luacheckrc setf lua
endif

if polyglot#util#IsEnabled('log', 'ftdetect')
  au BufNewFile,BufRead *.LOG,*.log,*_LOG,*_log setf log
endif

if polyglot#util#IsEnabled('llvm', 'ftdetect')
  au BufNewFile,BufRead *.ll setf llvm
  au BufNewFile,BufRead *.td setf tablegen
endif

if polyglot#util#IsEnabled('livescript', 'ftdetect')
  au BufNewFile,BufRead *._ls,*.ls,Slakefile setf livescript
endif

if polyglot#util#IsEnabled('lilypond', 'ftdetect')
  au BufNewFile,BufRead *.ily,*.ly setf lilypond
endif

if polyglot#util#IsEnabled('less', 'ftdetect')
  au BufNewFile,BufRead *.less setf less
endif

if polyglot#util#IsEnabled('ledger', 'ftdetect')
  au BufNewFile,BufRead *.journal,*.ldg,*.ledger setf ledger
endif

if polyglot#util#IsEnabled('kotlin', 'ftdetect')
  au BufNewFile,BufRead *.kt,*.ktm,*.kts setf kotlin
endif

if polyglot#util#IsEnabled('julia', 'ftdetect')
  au BufNewFile,BufRead *.jl setf julia
endif

if polyglot#util#IsEnabled('jst', 'ftdetect')
  au BufNewFile,BufRead *.ect,*.ejs,*.jst setf jst
endif

if polyglot#util#IsEnabled('jsonnet', 'ftdetect')
  au BufNewFile,BufRead *.jsonnet,*.libsonnet setf jsonnet
endif

if polyglot#util#IsEnabled('json', 'ftdetect')
  au BufNewFile,BufRead *.JSON-tmLanguage,*.avsc,*.geojson,*.gltf,*.har,*.ice,*.json,*.jsonl,*.jsonp,*.mcmeta,*.template,*.tfstate,*.tfstate.backup,*.topojson,*.webapp,*.webmanifest,*.yy,*.yyp,{.,}arcconfig,{.,}htmlhintrc,{.,}tern-config,{.,}tern-project,{.,}watchmanconfig,Pipfile.lock,composer.lock,mcmod.info setf json
endif

if polyglot#util#IsEnabled('json5', 'ftdetect')
  au BufNewFile,BufRead *.json5 setf json5
endif

if polyglot#util#IsEnabled('jq', 'ftdetect')
  au BufNewFile,BufRead *.jq,{.,}jqrc setf jq
  au BufNewFile,BufRead .jqrc* call s:StarSetf('jq')
endif

if polyglot#util#IsEnabled('htmldjango', 'ftdetect')
  au BufNewFile,BufRead *.j2,*.jinja,*.jinja2,*.njk setf htmldjango
endif

if polyglot#util#IsEnabled('jenkins', 'ftdetect')
  au BufNewFile,BufRead *.Jenkinsfile,*.jenkinsfile,Jenkinsfile setf Jenkinsfile
  au BufNewFile,BufRead Jenkinsfile* call s:StarSetf('Jenkinsfile')
endif

if polyglot#util#IsEnabled('ion', 'ftdetect')
  au BufNewFile,BufRead *.ion,~/.config/ion/initrc setf ion
endif

if polyglot#util#IsEnabled('idris2', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.idr call polyglot#detect#Idr()
  au BufNewFile,BufRead *.ipkg,idris-response setf idris2
  au BufNewFile,BufRead,BufWritePost *.lidr call polyglot#detect#Lidr()
endif

if polyglot#util#IsEnabled('idris', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.lidr call polyglot#detect#Lidr()
  au BufNewFile,BufRead,BufWritePost *.idr call polyglot#detect#Idr()
  au BufNewFile,BufRead idris-response setf idris
endif

if polyglot#util#IsEnabled('icalendar', 'ftdetect')
  au BufNewFile,BufRead *.ics setf icalendar
endif

if polyglot#util#IsEnabled('i3', 'ftdetect')
  au BufNewFile,BufRead *.i3.config,*.i3config,{.,}i3.config,{.,}i3config,i3.config,i3config setf i3config
endif

if polyglot#util#IsEnabled('hive', 'ftdetect')
  au BufNewFile,BufRead *.hql,*.q,*.ql setf hive
endif

if polyglot#util#IsEnabled('hcl', 'ftdetect')
  au BufNewFile,BufRead *.hcl,*.nomad,*.workflow,Appfile setf hcl
endif

if polyglot#util#IsEnabled('haxe', 'ftdetect')
  au BufNewFile,BufRead *.hx,*.hxsl setf haxe
endif

if polyglot#util#IsEnabled('haskell', 'ftdetect')
  au BufNewFile,BufRead *.bpk,*.hs,*.hs-boot,*.hsc,*.hsig setf haskell
endif

if polyglot#util#IsEnabled('haproxy', 'ftdetect')
  au BufNewFile,BufRead haproxy*.conf* call s:StarSetf('haproxy')
  au BufNewFile,BufRead haproxy*.cfg* call s:StarSetf('haproxy')
endif

if polyglot#util#IsEnabled('handlebars', 'ftdetect')
  au BufNewFile,BufRead *.hjs,*.hogan,*.hulk,*.mustache setf html.mustache
  au BufNewFile,BufRead *.handlebars,*.hb,*.hbs,*.hdbs setf html.handlebars
endif

if polyglot#util#IsEnabled('haml', 'ftdetect')
  au BufNewFile,BufRead *.haml,*.haml.deface,*.hamlbars,*.hamlc setf haml
endif

if polyglot#util#IsEnabled('grub', 'ftdetect')
  au BufNewFile,BufRead */boot/grub/grub.conf,*/boot/grub/menu.lst,*/etc/grub.conf setf grub
endif

if polyglot#util#IsEnabled('groovy', 'ftdetect')
  au BufNewFile,BufRead *.gradle,*.groovy,*.grt,*.gtpl,*.gvy,Jenkinsfile setf groovy
endif

if polyglot#util#IsEnabled('graphql', 'ftdetect')
  au BufNewFile,BufRead *.gql,*.graphql,*.graphqls setf graphql
endif

if polyglot#util#IsEnabled('jsx', 'ftdetect')
  au BufNewFile,BufRead *.jsx setf javascriptreact
endif

if polyglot#util#IsEnabled('javascript', 'ftdetect')
  au BufNewFile,BufRead *._js,*.bones,*.cjs,*.es,*.es6,*.frag,*.gs,*.jake,*.javascript,*.js,*.jsb,*.jscad,*.jsfl,*.jsm,*.jss,*.mjs,*.njs,*.pac,*.sjs,*.ssjs,*.xsjs,*.xsjslib,Jakefile setf javascript
  au BufNewFile,BufRead *.flow setf flow
endif

if polyglot#util#IsEnabled('go', 'ftdetect')
  au BufNewFile,BufRead *.go setf go
  au BufNewFile,BufRead go.mod setf gomod
  au BufNewFile,BufRead *.tmpl setf gohtmltmpl
endif

if polyglot#util#IsEnabled('gnuplot', 'ftdetect')
  au BufNewFile,BufRead *.gnu,*.gnuplot,*.gp,*.gpi,*.p,*.plot,*.plt setf gnuplot
endif

if polyglot#util#IsEnabled('gmpl', 'ftdetect')
  au BufNewFile,BufRead *.mod setf gmpl
endif

if polyglot#util#IsEnabled('glsl', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.fs call polyglot#detect#Fs()
  au BufNewFile,BufRead *.comp,*.fp,*.frag,*.frg,*.fsh,*.fshader,*.geo,*.geom,*.glsl,*.glslf,*.glslv,*.gs,*.gshader,*.shader,*.tesc,*.tese,*.vert,*.vrx,*.vsh,*.vshader setf glsl
endif

if polyglot#util#IsEnabled('git', 'ftdetect')
  au BufNewFile,BufRead *.gitconfig,*.git/config,*.git/modules/*/config,*/.config/git/config,*/git/config,{.,}gitconfig,{.,}gitmodules setf gitconfig
  au BufNewFile,BufRead */{.,}gitconfig.d/* call s:StarSetf('gitconfig')
  au BufNewFile,BufRead git-rebase-todo setf gitrebase
  au BufNewFile,BufRead .gitsendemail.* call s:StarSetf('gitsendemail')
  au BufNewFile,BufRead COMMIT_EDITMSG,MERGE_MSG,TAG_EDITMSG setf gitcommit
endif

if polyglot#util#IsEnabled('gdscript', 'ftdetect')
  au BufNewFile,BufRead *.gd setf gdscript3
endif

if polyglot#util#IsEnabled('fsharp', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.fs call polyglot#detect#Fs()
  au BufNewFile,BufRead *.fsi,*.fsx setf fsharp
endif

if polyglot#util#IsEnabled('forth', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.fs call polyglot#detect#Fs()
  au BufNewFile,BufRead *.ft,*.fth setf forth
endif

if polyglot#util#IsEnabled('flatbuffers', 'ftdetect')
  au BufNewFile,BufRead *.fbs setf fbs
endif

if polyglot#util#IsEnabled('fish', 'ftdetect')
  au BufNewFile,BufRead *.fish setf fish
endif

if polyglot#util#IsEnabled('ferm', 'ftdetect')
  au BufNewFile,BufRead *.ferm,ferm.conf setf ferm
endif

if polyglot#util#IsEnabled('fennel', 'ftdetect')
  au BufNewFile,BufRead *.fnl setf fennel
endif

if polyglot#util#IsEnabled('erlang', 'ftdetect')
  au BufNewFile,BufRead *.app,*.app.src,*.erl,*.es,*.escript,*.hrl,*.xrl,*.yaws,*.yrl,Emakefile,rebar.config,rebar.config.lock,rebar.lock setf erlang
endif

if polyglot#util#IsEnabled('emblem', 'ftdetect')
  au BufNewFile,BufRead *.em,*.emblem setf emblem
endif

if polyglot#util#IsEnabled('emberscript', 'ftdetect')
  au BufNewFile,BufRead *.em,*.emberscript setf ember-script
endif

if polyglot#util#IsEnabled('elm', 'ftdetect')
  au BufNewFile,BufRead *.elm setf elm
endif

if polyglot#util#IsEnabled('elixir', 'ftdetect')
  au BufNewFile,BufRead *.ex,*.exs,mix.lock setf elixir
  au BufNewFile,BufRead *.eex,*.leex setf eelixir
endif

if polyglot#util#IsEnabled('docker-compose', 'ftdetect')
  au BufNewFile,BufRead docker-compose*.yaml,docker-compose*.yml setf yaml.docker-compose
endif

if polyglot#util#IsEnabled('yaml', 'ftdetect')
  au BufNewFile,BufRead *.mir,*.reek,*.rviz,*.sublime-syntax,*.syntax,*.yaml,*.yaml-tmlanguage,*.yaml.sed,*.yml,*.yml.mysql,{.,}clang-format,{.,}clang-tidy,{.,}gemrc,fish_history,fish_read_history,glide.lock,yarn.lock setf yaml
endif

if polyglot#util#IsEnabled('mysql', 'ftdetect')
  au BufNewFile,BufRead *.mysql setf mysql
endif

if polyglot#util#IsEnabled('sed', 'ftdetect')
  au BufNewFile,BufRead *.sed setf sed
endif

if polyglot#util#IsEnabled('dlang', 'ftdetect')
  au BufNewFile,BufRead *.d,*.di setf d
  au BufNewFile,BufRead *.lst setf dcov
  au BufNewFile,BufRead *.dd setf dd
  au BufNewFile,BufRead *.ddoc setf ddoc
  au BufNewFile,BufRead *.sdl setf dsdl
endif

if polyglot#util#IsEnabled('dhall', 'ftdetect')
  au BufNewFile,BufRead *.dhall setf dhall
endif

if polyglot#util#IsEnabled('dart', 'ftdetect')
  au BufNewFile,BufRead *.dart,*.drt setf dart
endif

if polyglot#util#IsEnabled('cue', 'ftdetect')
  au BufNewFile,BufRead *.cue setf cuesheet
endif

if polyglot#util#IsEnabled('cucumber', 'ftdetect')
  au BufNewFile,BufRead *.feature,*.story setf cucumber
endif

if polyglot#util#IsEnabled('crystal', 'ftdetect')
  au BufNewFile,BufRead *.cr,Projectfile setf crystal
  au BufNewFile,BufRead *.ecr setf ecrystal
endif

if polyglot#util#IsEnabled('cryptol', 'ftdetect')
  au BufNewFile,BufRead *.cry,*.cyl,*.lcry,*.lcyl setf cryptol
endif

if polyglot#util#IsEnabled('coffee-script', 'ftdetect')
  au BufNewFile,BufRead *._coffee,*.cake,*.cjsx,*.coffee,*.coffeekup,*.iced,Cakefile setf coffee
  au BufNewFile,BufRead *.coffee.md,*.litcoffee setf litcoffee
endif

if polyglot#util#IsEnabled('markdown', 'ftdetect')
  au BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mdwn,*.mkd,*.mkdn,*.mkdown,*.ronn,*.workbook,contents.lr setf markdown
endif

if polyglot#util#IsEnabled('cmake', 'ftdetect')
  au BufNewFile,BufRead *.cmake,*.cmake.in,CMakeLists.txt setf cmake
endif

if polyglot#util#IsEnabled('clojure', 'ftdetect')
  au BufNewFile,BufRead *.boot,*.cl2,*.clj,*.cljc,*.cljs,*.cljs.hl,*.cljscm,*.cljx,*.edn,*.hic,build.boot,profile.boot,riemann.config setf clojure
endif

if polyglot#util#IsEnabled('carp', 'ftdetect')
  au BufNewFile,BufRead *.carp setf carp
endif

if polyglot#util#IsEnabled('caddyfile', 'ftdetect')
  au BufNewFile,BufRead Caddyfile setf caddyfile
endif

if polyglot#util#IsEnabled('awk', 'ftdetect')
  au BufNewFile,BufRead *.awk,*.gawk setf awk
endif

if polyglot#util#IsEnabled('ave', 'ftdetect')
  au BufNewFile,BufRead *.ave setf ave
endif

if polyglot#util#IsEnabled('autoit', 'ftdetect')
  au BufNewFile,BufRead *.au3 setf autoit
endif

if polyglot#util#IsEnabled('atlas', 'ftdetect')
  au BufNewFile,BufRead *.as,*.atl setf atlas
endif

if polyglot#util#IsEnabled('aspperl', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.asp call polyglot#detect#Asp()
endif

if polyglot#util#IsEnabled('aspvbs', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.asp call polyglot#detect#Asp()
  au BufNewFile,BufRead,BufWritePost *.asa call polyglot#detect#Asa()
endif

if polyglot#util#IsEnabled('asn', 'ftdetect')
  au BufNewFile,BufRead *.asn,*.asn1 setf asn
endif

if polyglot#util#IsEnabled('automake', 'ftdetect')
  au BufNewFile,BufRead GNUmakefile.am,[mM]akefile.am setf automake
endif

if polyglot#util#IsEnabled('elf', 'ftdetect')
  au BufNewFile,BufRead *.am setf elf
endif

if polyglot#util#IsEnabled('make', 'ftdetect')
  au BufNewFile,BufRead *.dsp,*.mak,*.mk,*[mM]akefile setf make
endif

if polyglot#util#IsEnabled('autohotkey', 'ftdetect')
  au BufNewFile,BufRead *.ahk,*.ahkl setf autohotkey
endif

if polyglot#util#IsEnabled('asciidoc', 'ftdetect')
  au BufNewFile,BufRead *.adoc,*.asc,*.asciidoc setf asciidoc
endif

if polyglot#util#IsEnabled('art', 'ftdetect')
  au BufNewFile,BufRead *.art setf art
endif

if polyglot#util#IsEnabled('arduino', 'ftdetect')
  au BufNewFile,BufRead *.ino,*.pde setf arduino
endif

if polyglot#util#IsEnabled('c/c++', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.h call polyglot#detect#H()
  au BufNewFile,BufRead *.c++,*.cc,*.cp,*.cpp,*.cxx,*.h++,*.hh,*.hpp,*.hxx,*.inc,*.inl,*.ipp,*.moc,*.tcc,*.tlh,*.tpp setf cpp
  au BufNewFile,BufRead,BufWritePost *.h call polyglot#detect#H()
  au BufNewFile,BufRead *.c,*.cats,*.idc,*.qc,*enlightenment/*.cfg setf c
endif

if polyglot#util#IsEnabled('arch', 'ftdetect')
  au BufNewFile,BufRead {.,}arch-inventory,=tagging-method setf arch
endif

if polyglot#util#IsEnabled('aptconf', 'ftdetect')
  au BufNewFile,BufRead */.aptitude/config,*/etc/apt/apt.conf.d/*.conf,apt.conf setf aptconf
  au BufNewFile,BufRead */etc/apt/apt.conf.d/[^.]* call s:StarSetf('aptconf')
endif

if polyglot#util#IsEnabled('applescript', 'ftdetect')
  au BufNewFile,BufRead *.applescript,*.scpt setf applescript
endif

if polyglot#util#IsEnabled('apiblueprint', 'ftdetect')
  au BufNewFile,BufRead *.apib setf apiblueprint
endif

if polyglot#util#IsEnabled('apache', 'ftdetect')
  au BufNewFile,BufRead */etc/apache2/sites-*/*.com,*/etc/httpd/*.conf,{.,}htaccess setf apache
  au BufNewFile,BufRead srm.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead httpd.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead apache2.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead apache.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead access.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead */etc/httpd/conf.d/*.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead */etc/apache2/sites-*/* call s:StarSetf('apache')
  au BufNewFile,BufRead */etc/apache2/mods-*/* call s:StarSetf('apache')
  au BufNewFile,BufRead */etc/apache2/conf.*/* call s:StarSetf('apache')
  au BufNewFile,BufRead */etc/apache2/*.conf* call s:StarSetf('apache')
endif

if polyglot#util#IsEnabled('ant', 'ftdetect')
  au BufNewFile,BufRead build.xml setf ant
endif

if polyglot#util#IsEnabled('xml', 'ftdetect')
  au BufNewFile,BufRead *.adml,*.admx,*.ant,*.axml,*.builds,*.ccproj,*.ccxml,*.cdxml,*.clixml,*.cproject,*.cscfg,*.csdef,*.csl,*.csproj,*.csproj.user,*.ct,*.depproj,*.dita,*.ditamap,*.ditaval,*.dll.config,*.dotsettings,*.filters,*.fsproj,*.fxml,*.glade,*.gml,*.gmx,*.grxml,*.gst,*.iml,*.ivy,*.jelly,*.jsproj,*.kml,*.launch,*.mdpolicy,*.mjml,*.mm,*.mod,*.mxml,*.natvis,*.ncl,*.ndproj,*.nproj,*.nuspec,*.odd,*.osm,*.pkgproj,*.pluginspec,*.proj,*.props,*.psc1,*.pt,*.rdf,*.resx,*.rss,*.sch,*.scxml,*.sfproj,*.shproj,*.srdf,*.storyboard,*.sublime-snippet,*.targets,*.tml,*.tpm,*.ui,*.urdf,*.ux,*.vbproj,*.vcxproj,*.vsixmanifest,*.vssettings,*.vstemplate,*.vxml,*.wixproj,*.workflow,*.wpl,*.wsdl,*.wsf,*.wxi,*.wxl,*.wxs,*.x3d,*.xacro,*.xaml,*.xib,*.xlf,*.xliff,*.xmi,*.xml,*.xml.dist,*.xproj,*.xsd,*.xspec,*.xul,*.zcml,*/etc/blkid.tab,*/etc/blkid.tab.old,*/etc/xdg/menus/*.menu,*fglrxrc,{.,}classpath,{.,}cproject,{.,}project,App.config,NuGet.config,Settings.StyleCop,Web.Debug.config,Web.Release.config,Web.config,packages.config setf xml
endif

if polyglot#util#IsEnabled('csv', 'ftdetect')
  au BufNewFile,BufRead *.csv,*.tab,*.tsv setf csv
endif

if polyglot#util#IsEnabled('ampl', 'ftdetect')
  " AMPL
  au BufNewFile,BufRead *.run setf ampl
endif

if polyglot#util#IsEnabled('aml', 'ftdetect')
  au BufNewFile,BufRead *.aml setf aml
endif

if polyglot#util#IsEnabled('alsaconf', 'ftdetect')
  au BufNewFile,BufRead */etc/asound.conf,*/usr/share/alsa/alsa.conf,{.,}asoundrc setf alsaconf
endif

if polyglot#util#IsEnabled('conf', 'ftdetect')
  au BufNewFile,BufRead *.conf,*/etc/hosts,auto.master,config setf conf
endif

if polyglot#util#IsEnabled('master', 'ftdetect')
  au BufNewFile,BufRead *.mas,*.master setf master
endif

if polyglot#util#IsEnabled('aidl', 'ftdetect')
  " AIDL
  au BufNewFile,BufRead *.aidl setf aidl
endif

if polyglot#util#IsEnabled('ahdl', 'ftdetect')
  " AHDL
  au BufNewFile,BufRead *.tdf setf ahdl
endif

if polyglot#util#IsEnabled('ada', 'ftdetect')
  " Ada (83, 9X, 95)
  au BufNewFile,BufRead *.ada,*.ada_m,*.adb,*.adc,*.ads,*.gpr setf ada
endif

if polyglot#util#IsEnabled('acpiasl', 'ftdetect')
  au BufNewFile,BufRead *.asl,*.dsl setf asl
endif

if polyglot#util#IsEnabled('acedb', 'ftdetect')
  " AceDB
  au BufNewFile,BufRead *.wrm setf acedb
endif

if polyglot#util#IsEnabled('abel', 'ftdetect')
  " ABEL
  au BufNewFile,BufRead *.abl setf abel
endif

if polyglot#util#IsEnabled('abc', 'ftdetect')
  " ABC music notation
  au BufNewFile,BufRead *.abc setf abc
endif

if polyglot#util#IsEnabled('abaqus', 'ftdetect')
  au BufNewFile,BufRead,BufWritePost *.inp call polyglot#detect#Inp()
endif

if polyglot#util#IsEnabled('abap', 'ftdetect')
  " ABAB/4
  au BufNewFile,BufRead *.abap setf abap
endif

if polyglot#util#IsEnabled('aap', 'ftdetect')
  " A-A-P recipe
  au BufNewFile,BufRead *.aap setf aap
endif

if polyglot#util#IsEnabled('a65', 'ftdetect')
  " XA65 MOS6510 cross assembler
  au BufNewFile,BufRead *.a65 setf a65
endif

if polyglot#util#IsEnabled('a2ps', 'ftdetect')
  au BufNewFile,BufRead */etc/a2ps.cfg,*/etc/a2ps/*.cfg,{.,}a2psrc,a2psrc setf a2ps
endif

if polyglot#util#IsEnabled('cfg', 'ftdetect')
  au BufNewFile,BufRead *.cfg,*.hgrc,*hgrc setf cfg
endif

if polyglot#util#IsEnabled('8th', 'ftdetect')
  " 8th (Firth-derivative)
  au BufNewFile,BufRead *.8th setf 8th
endif


" DO NOT EDIT CODE ABOVE, IT IS GENERATED WITH MAKEFILE

func! s:Observe(fn)
  let b:PolyglotObserve = function("polyglot#" . a:fn)
  augroup polyglot-observer
    au!
    au CursorHold,CursorHoldI,BufWritePost <buffer> call b:PolyglotObserve()
  augroup END
endfunc

au BufNewFile,BufRead,StdinReadPost * if expand("<afile>:e") == "" |
  \ call polyglot#shebang#Detect() | endif

au BufWinEnter * if &ft == "" && expand("<afile>:e") == ""  |
  \ call s:Observe('shebang#Detect') | endif

au FileType * au! polyglot-observer

augroup END


if polyglot#util#IsEnabled('autoindent', 'ftdetect')
  " Code below re-implements sleuth for vim-polyglot
  let g:loaded_sleuth = 1

  if &tabstop == 8
    let &tabstop = 2
  endif

  let s:default_shiftwidth = &shiftwidth

  func! s:get_shiftwidth(indents) abort
    let shiftwidth = 0
    let max_count = 0
    let final_counts = {}
    for [indent, indent_count] in items(a:indents)
      let indent_count = indent_count * 1.5
      for [indent2, indent2_count] in items(a:indents)
        if indent2 > indent && indent2 % indent == 0
          let indent_count = indent_count + indent2_count
        endif
      endfor
      let final_counts[indent] = indent_count
    endfor
    for [indent, final_count] in items(final_counts)
      if final_count > max_count
        let shiftwidth = indent
        let max_count = final_count
      endif
    endfor
    return shiftwidth
  endfunc

  func! s:guess(lines) abort
    let options = {}
    let ccomment = 0
    let podcomment = 0
    let triplequote = 0
    let backtick = 0
    let xmlcomment = 0
    let heredoc = ''
    let minindent = 10
    let spaces_minus_tabs = 0
    let lineno = 0
    let stack = [0]
    let indents = { '2': 0, '3': 0, '4': 0, '6': 0, '8': 0 }

    for line in a:lines
      let lineno += 1

      if line =~# '^\s*$'
        continue
      endif

      if line =~# '^\s*/\*'
        let ccomment = 1
      endif
      if ccomment
        if line =~# '\*/'
          let ccomment = 0
        endif
        continue
      endif

      if line =~# '^=\w'
        let podcomment = 1
      endif
      if podcomment
        if line =~# '^=\%(end\|cut\)\>'
          let podcomment = 0
        endif
        continue
      endif

      if triplequote
        if line =~# '^[^"]*"""[^"]*$'
          let triplequote = 0
        endif
        continue
      elseif line =~# '^[^"]*"""[^"]*$'
        let triplequote = 1
      endif

      if backtick
        if line =~# '^[^`]*`[^`]*$'
          let backtick = 0
        endif
        continue
      elseif &filetype ==# 'go' && line =~# '^[^`]*`[^`]*$'
        let backtick = 1
      endif

      if line =~# '^\s*<\!--'
        let xmlcomment = 1
      endif
      if xmlcomment
        if line =~# '-->'
          let xmlcomment = 0
        endif
        continue
      endif

      " This is correct order because both "<<EOF" and "EOF" matches end
      if heredoc != ''
        if line =~# heredoc
          let heredoc = ''
        endif
        continue
      endif
      let herematch = matchlist(line, '\C<<\W*\([A-Z]\+\)\s*$')
      if len(herematch) > 0
        let heredoc = herematch[1] . '$'
      endif

      if line[0] == "\t"
        let spaces_minus_tabs -= 1
      else
        if line[0] == " "
          let spaces_minus_tabs += 1
        endif
        let indent = len(matchstr(line, '^ *'))
        while stack[-1] > indent
          call remove(stack, -1)
        endwhile

        let indent_inc = indent - stack[-1]

        if indent_inc == 0 && len(stack) > 1
          let indent_inc = indent - stack[-2]
        endif

        if has_key(indents, indent_inc)
          let indents[indent_inc] += 1
          let prev_indent = indent
        endif

        if stack[-1] != indent
          call add(stack, indent)
        endif
      endif
    endfor

    if spaces_minus_tabs < 0
      setlocal noexpandtab
      let &l:shiftwidth=&tabstop
      return 1
    endif

    let shiftwidth = s:get_shiftwidth(indents)

    if shiftwidth > 0
      setlocal expandtab
      let &l:shiftwidth=shiftwidth
      try
        " Sunchronize tabstop with shiftwidth
        let &l:softtabstop = -1
      catch /^Vim\%((\a\+)\)\=:E487/
        " -1 was not supported before Vim 7.4
        let &l:softtabstop = a:num_spaces
      endtry
      return 1
    endif

    return 0
  endfunc

  func! s:detect_indent() abort
    if &buftype ==# 'help'
      return
    endif

    " Do not autodetect indent if language or user sets it
    if &l:shiftwidth != s:default_shiftwidth
      return
    endif

    let b:sleuth_culprit = expand("<afile>:p")
    if s:guess(getline(1, 128))
      return
    endif
    if s:guess(getline(1, 1024))
      return
    endif
    let pattern = polyglot#sleuth#GlobForFiletype(&filetype)
    if len(pattern) == 0
      return
    endif
    let pattern = '{' . pattern . ',.git,.svn,.hg}'
    let dir = expand('%:p:h')
    let level = 3
    while isdirectory(dir) && dir !=# fnamemodify(dir, ':h') && level > 0
      " Ignore files from homedir and root 
      if dir == expand('~') || dir == '/'
        unlet b:sleuth_culprit
        return
      endif
      for neighbor in glob(dir . '/' . pattern, 0, 1)[0:level]
        let b:sleuth_culprit = neighbor
        " Do not consider directories above .git, .svn or .hg
        if fnamemodify(neighbor, ":h:t")[0] == "."
          let level = 0
          continue
        endif
        if neighbor !=# expand('%:p') && filereadable(neighbor)
          if s:guess(readfile(neighbor, '', 32))
            return
          endif
        endif
      endfor

      let dir = fnamemodify(dir, ':h')
      let level -= 1
    endwhile

    let b:sleuth_culprit = "default"
  endfunc

  set smarttab

  func! SleuthIndicator() abort
    let sw = &shiftwidth ? &shiftwidth : &tabstop
    if &expandtab
      return 'sw='.sw
    elseif &tabstop == sw
      return 'ts='.&tabstop
    else
      return 'sw='.sw.',ts='.&tabstop
    endif
  endfunc

  augroup polyglot-sleuth
    au!
    au BufEnter * call s:detect_indent()
    au User Flags call Hoist('buffer', 5, 'SleuthIndicator')
  augroup END

  command! -bar -bang Sleuth call s:detect_indent()
endif

au VimEnter * call polyglot#util#Verify()

augroup filetypedetect

" Ignored extensions
if exists("*fnameescape")
au BufNewFile,BufRead ?\+.orig,?\+.bak,?\+.old,?\+.new,?\+.dpkg-dist,?\+.dpkg-old,?\+.dpkg-new,?\+.dpkg-bak,?\+.rpmsave,?\+.rpmnew,?\+.pacsave,?\+.pacnew
	\ exe "doau filetypedetect BufRead " . fnameescape(expand("<afile>:r"))
au BufNewFile,BufRead *~
	\ let s:name = expand("<afile>") |
	\ let s:short = substitute(s:name, '\~$', '', '') |
	\ if s:name != s:short && s:short != "" |
	\   exe "doau filetypedetect BufRead " . fnameescape(s:short) |
	\ endif |
	\ unlet! s:name s:short
au BufNewFile,BufRead ?\+.in
	\ if expand("<afile>:t") != "configure.in" |
	\   exe "doau filetypedetect BufRead " . fnameescape(expand("<afile>:r")) |
	\ endif
elseif &verbose > 0
  echomsg "Warning: some filetypes will not be recognized because this version of Vim does not have fnameescape()"
endif

" Pattern used to match file names which should not be inspected.
" Currently finds compressed files.
if !exists("g:ft_ignore_pat")
  let g:ft_ignore_pat = '\.\(Z\|gz\|bz2\|zip\|tgz\)$'
endif

" *.cmd is close to a Batch file, but on OS/2 Rexx files also use *.cmd.
au BufNewFile,BufRead *.cmd
	\ if getline(1) =~ '^/\*' | setf rexx | else | setf dosbatch | endif

" Batch file for 4DOS
au BufNewFile,BufRead *.btm			call polyglot#ft#FTbtm()

" BIND zone
au BufNewFile,BufRead *.db			call polyglot#ft#BindzoneCheck('')

" C or lpc
au BufNewFile,BufRead *.c			call polyglot#ft#FTlpc()

" Cynlib
" .cc and .cpp files can be C++ or Cynlib.
au BufNewFile,BufRead *.cpp if exists("cynlib_syntax_for_cpp")|setf cynlib|else|setf cpp|endif

au BufNewFile,BufRead *.h			call polyglot#ft#FTheader()

au BufNewFile,BufRead [cC]hange[lL]og
	\  if getline(1) =~ '; urgency='
	\|   setf debchangelog
	\| else
	\|   setf changelog
	\| endif

au BufNewFile,BufRead NEWS
	\  if getline(1) =~ '; urgency='
	\|   setf debchangelog
	\| endif

" Changes for WEB and CWEB or CHILL
au BufNewFile,BufRead *.ch			call polyglot#ft#FTchange()

" Clever or dtd
au BufNewFile,BufRead *.ent			call polyglot#ft#FTent()

" Clipper (or FoxPro; could also be eviews)
au BufNewFile,BufRead *.prg
	\ if exists("g:filetype_prg") |
	\   exe "setf " . g:filetype_prg |
	\ else |
	\   setf clipper |
	\ endif

au BufNewFile,BufRead *.cpy
	\ if getline(1) =~ '^##' |
	\   setf python |
	\ else |
	\   setf cobol |
	\ endif

" Euphoria 3 or 4
au BufNewFile,BufRead *.eu,*.ew,*.ex,*.exu,*.exw  call polyglot#ft#EuphoriaCheck()
if has("fname_case")
   au BufNewFile,BufRead *.EU,*.EW,*.EX,*.EXU,*.EXW  call polyglot#ft#EuphoriaCheck()
endif

au BufNewFile,BufRead control
	\  if getline(1) =~ '^Source:'
	\|   setf debcontrol
	\| endif

au BufNewFile,BufRead copyright
	\  if getline(1) =~ '^Format:'
	\|   setf debcopyright
	\| endif

" the D language or dtrace
au BufNewFile,BufRead *.d			call polyglot#ft#DtraceCheck()

au BufNewFile,BufRead *.patch
	\ if getline(1) =~ '^From [0-9a-f]\{40\} Mon Sep 17 00:00:00 2001$' |
	\   setf gitsendemail |
	\ else |
	\   setf diff |
	\ endif

" Diva (with Skill) or InstallShield
au BufNewFile,BufRead *.rul
	\ if getline(1).getline(2).getline(3).getline(4).getline(5).getline(6) =~? 'InstallShield' |
	\   setf ishd |
	\ else |
	\   setf diva |
	\ endif

" DCL (Digital Command Language - vms) or DNS zone file
au BufNewFile,BufRead *.com			call polyglot#ft#BindzoneCheck('dcl')

au BufNewFile,BufRead *.edn
	\ if getline(1) =~ '^\s*(\s*edif\>' |
	\   setf edif |
	\ else |
	\   setf clojure |
	\ endif

" Eiffel or Specman or Euphoria
au BufNewFile,BufRead *.e,*.E			call polyglot#ft#FTe()

if !empty($XDG_CONFIG_HOME)
  au BufNewFile,BufRead $XDG_CONFIG_HOME/git/config		setf gitconfig
endif

au BufNewFile,BufRead .msg.[0-9]*
      \ if getline(1) =~ '^From.*# This line is ignored.$' |
      \   setf gitsendemail |
      \ endif
au BufNewFile,BufRead *.git/*
      \ if getline(1) =~ '^\x\{40\}\>\|^ref: ' |
      \   setf git |
      \ endif

if !empty($GNUPGHOME)
  au BufNewFile,BufRead $GNUPGHOME/options	setf gpg
  au BufNewFile,BufRead $GNUPGHOME/gpg.conf	setf gpg
endif

" HTML (.shtml and .stm for server side)
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm  call polyglot#ft#FThtml()

" IDL (Interface Description Language)
au BufNewFile,BufRead *.idl			call polyglot#ft#FTidl()

au BufNewFile,BufRead indent.pro		call polyglot#ft#ProtoCheck('indent')

" IDL (Interactive Data Language)
au BufNewFile,BufRead *.pro			call polyglot#ft#ProtoCheck('idlang')

" M4
au BufNewFile,BufRead *.m4
	\ if expand("<afile>") !~? 'html.m4$\|fvwm2rc' | setf m4 | endif

" Mathematica, Matlab, Murphi or Objective C
au BufNewFile,BufRead *.m			call polyglot#ft#FTm()

" MMIX or VMS makefile
au BufNewFile,BufRead *.mms			call polyglot#ft#FTmms()

" Modsim III (or LambdaProlog)
au BufNewFile,BufRead *.mod
	\ if getline(1) =~ '\<module\>' |
	\   setf lprolog |
	\ else |
	\   setf modsim3 |
	\ endif

" Mutt setup files (must be before catch *.rc)
au BufNewFile,BufRead */etc/Muttrc.d/*		call s:StarSetf('muttrc')

" Nroff/Troff (*.ms and *.t are checked below)
au BufNewFile,BufRead *.me
	\ if expand("<afile>") != "read.me" && expand("<afile>") != "click.me" |
	\   setf nroff |
	\ endif
au BufNewFile,BufRead *.[1-9]			call polyglot#ft#FTnroff()

" Nroff or Objective C++
au BufNewFile,BufRead *.mm			call polyglot#ft#FTmm()

" Pacman hooks
au BufNewFile,BufRead *.hook
	\ if getline(1) == '[Trigger]' |
	\   setf dosini |
	\ endif

" Perl
au BufNewFile,BufRead *.pl			call polyglot#ft#FTpl()

" Perl, XPM or XPM2
au BufNewFile,BufRead *.pm
	\ if getline(1) =~ "XPM2" |
	\   setf xpm2 |
	\ elseif getline(1) =~ "XPM" |
	\   setf xpm |
	\ else |
	\   setf perl |
	\ endif

" Povray, PHP or assembly
au BufNewFile,BufRead *.inc			call polyglot#ft#FTinc()

" Printcap and Termcap
au BufNewFile,BufRead *printcap
	\ let b:ptcap_type = "print" | setf ptcap
au BufNewFile,BufRead *termcap
	\ let b:ptcap_type = "term" | setf ptcap

" Progress or CWEB
au BufNewFile,BufRead *.w			call polyglot#ft#FTprogress_cweb()

" Progress or assembly
au BufNewFile,BufRead *.i			call polyglot#ft#FTprogress_asm()

" Progress or Pascal
au BufNewFile,BufRead *.p			call polyglot#ft#FTprogress_pascal()

" Software Distributor Product Specification File (POSIX 1387.2-1995)
au BufNewFile,BufRead INDEX,INFO
	\ if getline(1) =~ '^\s*\(distribution\|installed_software\|root\|bundle\|product\)\s*$' |
	\   setf psf |
	\ endif

" Registry for MS-Windows
au BufNewFile,BufRead *.reg
	\ if getline(1) =~? '^REGEDIT[0-9]*\s*$\|^Windows Registry Editor Version \d*\.\d*\s*$' | setf registry | endif

" Rexx, Rebol or R
au BufNewFile,BufRead *.r,*.R				call polyglot#ft#FTr()

" Sendmail .mc files are actually m4.  Could also be MS Message text file.
au BufNewFile,BufRead *.mc			call polyglot#ft#McSetf()

" SGML
au BufNewFile,BufRead *.sgm,*.sgml
	\ if getline(1).getline(2).getline(3).getline(4).getline(5) =~? 'linuxdoc' |
	\   setf sgmllnx |
	\ elseif getline(1) =~ '<!DOCTYPE.*DocBook' || getline(2) =~ '<!DOCTYPE.*DocBook' |
	\   let b:docbk_type = "sgml" |
	\   let b:docbk_ver = 4 |
	\   setf docbk |
	\ else |
	\   setf sgml |
	\ endif

" SGMLDECL
au BufNewFile,BufRead *.decl,*.dcl,*.dec
	\ if getline(1).getline(2).getline(3) =~? '^<!SGML' |
	\    setf sgmldecl |
	\ endif

" Shell scripts (sh, ksh, bash, bash2, csh); Allow .profile_foo etc.
" Gentoo ebuilds and Arch Linux PKGBUILDs are actually bash scripts
" NOTE: Patterns ending in a star are further down, these have lower priority.
au BufNewFile,BufRead .bashrc,bashrc,bash.bashrc,.bash[_-]profile,.bash[_-]logout,.bash[_-]aliases,bash-fc[-.],*.bash,*/{,.}bash[_-]completion{,.d,.sh}{,/*},*.ebuild,*.eclass,PKGBUILD call polyglot#ft#SetFileTypeSH("bash")
au BufNewFile,BufRead .kshrc,*.ksh call polyglot#ft#SetFileTypeSH("ksh")
au BufNewFile,BufRead */etc/profile,.profile,*.sh,*.env call polyglot#ft#SetFileTypeSH(getline(1))


" Shell script (Arch Linux) or PHP file (Drupal)
au BufNewFile,BufRead *.install
	\ if getline(1) =~ '<?php' |
	\   setf php |
	\ else |
	\   call polyglot#ft#SetFileTypeSH("bash") |
	\ endif

" tcsh scripts (patterns ending in a star further below)
au BufNewFile,BufRead .tcshrc,*.tcsh,tcsh.tcshrc,tcsh.login	call polyglot#ft#SetFileTypeShell("tcsh")

" csh scripts, but might also be tcsh scripts (on some systems csh is tcsh)
" (patterns ending in a start further below)
au BufNewFile,BufRead .login,.cshrc,csh.cshrc,csh.login,csh.logout,*.csh,.alias  call polyglot#ft#CSH()

au BufNewFile,BufRead *.cls
	\ if getline(1) =~ '^%' |
	\  setf tex |
	\ elseif getline(1)[0] == '#' && getline(1) =~ 'rexx' |
	\  setf rexx |
	\ else |
	\  setf st |
	\ endif

" SMIL or XML
au BufNewFile,BufRead *.smil
	\ if getline(1) =~ '<?\s*xml.*?>' |
	\   setf xml |
	\ else |
	\   setf smil |
	\ endif

" SMIL or SNMP MIB file
au BufNewFile,BufRead *.smi
	\ if getline(1) =~ '\<smil\>' |
	\   setf smil |
	\ else |
	\   setf mib |
	\ endif

au BufNewFile,BufRead *.rules			call polyglot#ft#FTRules()

" SQL
au BufNewFile,BufRead *.sql			call polyglot#ft#SQL()

" Also *.class, but not when it's a Java bytecode file
au BufNewFile,BufRead *.class
	\ if getline(1) !~ "^\xca\xfe\xba\xbe" | setf stata | endif

au BufNewFile,BufRead *.tex			call polyglot#ft#FTtex()

" Virata Config Script File or Drupal module
au BufRead,BufNewFile *.hw,*.module,*.pkg
	\ if getline(1) =~ '<?php' |
	\   setf php |
	\ else |
	\   setf virata |
	\ endif

" Visual Basic (also uses *.bas) or FORM
au BufNewFile,BufRead *.frm			call polyglot#ft#FTVB("form")

" WEB (*.web is also used for Winbatch: Guess, based on expecting "%" comment
" lines in a WEB file).
au BufNewFile,BufRead *.web
	\ if getline(1)[0].getline(2)[0].getline(3)[0].getline(4)[0].getline(5)[0] =~ "%" |
	\   setf web |
	\ else |
	\   setf winbatch |
	\ endif

" X Pixmap (dynamically sets colors, use BufEnter to make it work better)
au BufEnter *.xpm
	\ if getline(1) =~ "XPM2" |
	\   setf xpm2 |
	\ else |
	\   setf xpm |
	\ endif

" XFree86 config
au BufNewFile,BufRead XF86Config
	\ if getline(1) =~ '\<XConfigurator\>' |
	\   let b:xf86conf_xfree86_version = 3 |
	\ endif |
	\ setf xf86conf
au BufNewFile,BufRead */xorg.conf.d/*.conf
	\ let b:xf86conf_xfree86_version = 4 |
	\ setf xf86conf

" Xorg config
au BufNewFile,BufRead xorg.conf,xorg.conf-4	let b:xf86conf_xfree86_version = 4 | setf xf86conf

au BufNewFile,BufRead *.ms
	\ if !polyglot#ft#FTnroff() | setf xmath | endif

" XML  specific variants: docbk and xbl
au BufNewFile,BufRead *.xml			call polyglot#ft#FTxml()

" Yacc or racc
au BufNewFile,BufRead *.y			call polyglot#ft#FTy()

" Zope
"   dtml (zope dynamic template markup language), pt (zope page template),
"   cpt (zope form controller page template)
au BufNewFile,BufRead *.dtml,*.pt,*.cpt		call polyglot#ft#FThtml()
"   zsql (zope sql method)
au BufNewFile,BufRead *.zsql			call polyglot#ft#SQL()

augroup END


" Source the user-specified filetype file, for backwards compatibility with
" Vim 5.x.
if exists("myfiletypefile") && filereadable(expand(myfiletypefile))
  execute "source " . myfiletypefile
endif


" Check for "*" after loading myfiletypefile, so that scripts.vim is only used
" when there are no matching file name extensions.
" Don't do this for compressed files.
augroup filetypedetect
au BufNewFile,BufRead *
	\ if !did_filetype() && expand("<amatch>") !~ g:ft_ignore_pat
	\ | runtime! scripts.vim | endif
au StdinReadPost * if !did_filetype() | runtime! scripts.vim | endif


" Extra checks for when no filetype has been detected now.  Mostly used for
" patterns that end in "*".  E.g., "zsh*" matches "zsh.vim", but that's a Vim
" script file.
" Most of these should call s:StarSetf() to avoid names ending in .gz and the
" like are used.

" More Apache style config files
au BufNewFile,BufRead */etc/proftpd/*.conf*,*/etc/proftpd/conf.*/*	call s:StarSetf('apachestyle')
au BufNewFile,BufRead proftpd.conf*					call s:StarSetf('apachestyle')

" More Apache config files
au BufNewFile,BufRead access.conf*,apache.conf*,apache2.conf*,httpd.conf*,srm.conf*	call s:StarSetf('apache')
au BufNewFile,BufRead */etc/apache2/*.conf*,*/etc/apache2/conf.*/*,*/etc/apache2/mods-*/*,*/etc/apache2/sites-*/*,*/etc/httpd/conf.d/*.conf*		call s:StarSetf('apache')

" Asterisk config file
au BufNewFile,BufRead *asterisk/*.conf*		call s:StarSetf('asterisk')
au BufNewFile,BufRead *asterisk*/*voicemail.conf* call s:StarSetf('asteriskvm')

" BIND zone
au BufNewFile,BufRead */named/db.*,*/bind/db.*	call s:StarSetf('bindzone')

" Calendar
au BufNewFile,BufRead */.calendar/*,
	\*/share/calendar/*/calendar.*,*/share/calendar/calendar.*
	\					call s:StarSetf('calendar')

" Changelog
au BufNewFile,BufRead [cC]hange[lL]og*
	\ if getline(1) =~ '; urgency='
	\|  call s:StarSetf('debchangelog')
	\|else
	\|  call s:StarSetf('changelog')
	\|endif

" Crontab
au BufNewFile,BufRead crontab,crontab.*,*/etc/cron.d/*		call s:StarSetf('crontab')

" dnsmasq(8) configuration
au BufNewFile,BufRead */etc/dnsmasq.d/*		call s:StarSetf('dnsmasq')

" Dracula
au BufNewFile,BufRead drac.*			call s:StarSetf('dracula')

" Fvwm
au BufNewFile,BufRead */.fvwm/*			call s:StarSetf('fvwm')
au BufNewFile,BufRead *fvwmrc*,*fvwm95*.hook
	\ let b:fvwm_version = 1 | call s:StarSetf('fvwm')
au BufNewFile,BufRead *fvwm2rc*
	\ if expand("<afile>:e") == "m4"
	\|  call s:StarSetf('fvwm2m4')
	\|else
	\|  let b:fvwm_version = 2 | call s:StarSetf('fvwm')
	\|endif

" Gedcom
au BufNewFile,BufRead */tmp/lltmp*		call s:StarSetf('gedcom')

" Git
au BufNewFile,BufRead */.gitconfig.d/*,/etc/gitconfig.d/*	call s:StarSetf('gitconfig')

" Gitolite
au BufNewFile,BufRead */gitolite-admin/conf/*	call s:StarSetf('gitolite')

" GTK RC
au BufNewFile,BufRead .gtkrc*,gtkrc*		call s:StarSetf('gtkrc')

" Jam
au BufNewFile,BufRead Prl*.*,JAM*.*		call s:StarSetf('jam')

" Jargon
au! BufNewFile,BufRead *jarg*
	\ if getline(1).getline(2).getline(3).getline(4).getline(5) =~? 'THIS IS THE JARGON FILE'
	\|  call s:StarSetf('jargon')
	\|endif

" Java Properties resource file (note: doesn't catch font.properties.pl)
au BufNewFile,BufRead *.properties_??_??_*	call s:StarSetf('jproperties')

" Kconfig
au BufNewFile,BufRead Kconfig.*			call s:StarSetf('kconfig')

" Lilo: Linux loader
au BufNewFile,BufRead lilo.conf*		call s:StarSetf('lilo')

" Logcheck
au BufNewFile,BufRead */etc/logcheck/*.d*/*	call s:StarSetf('logcheck')

" Makefile
au BufNewFile,BufRead [mM]akefile*		call s:StarSetf('make')

" Ruby Makefile
au BufNewFile,BufRead [rR]akefile*		call s:StarSetf('ruby')

" Mail (also matches muttrc.vim, so this is below the other checks)
au BufNewFile,BufRead {neo,}mutt[[:alnum:]._-]\\\{6\}	setf mail

au BufNewFile,BufRead reportbug-*		call s:StarSetf('mail')

" Modconf
au BufNewFile,BufRead */etc/modutils/*
	\ if executable(expand("<afile>")) != 1
	\|  call s:StarSetf('modconf')
	\|endif
au BufNewFile,BufRead */etc/modprobe.*		call s:StarSetf('modconf')

" Mutt setup file
au BufNewFile,BufRead .mutt{ng,}rc*,*/.mutt{ng,}/mutt{ng,}rc*	call s:StarSetf('muttrc')
au BufNewFile,BufRead mutt{ng,}rc*,Mutt{ng,}rc*		call s:StarSetf('muttrc')

" Neomutt setup file
au BufNewFile,BufRead .neomuttrc*,*/.neomutt/neomuttrc*	call s:StarSetf('neomuttrc')
au BufNewFile,BufRead neomuttrc*,Neomuttrc*		call s:StarSetf('neomuttrc')

" Nroff macros
au BufNewFile,BufRead tmac.*			call s:StarSetf('nroff')

" OpenBSD hostname.if
au BufNewFile,BufRead /etc/hostname.*		call s:StarSetf('config')

" Pam conf
au BufNewFile,BufRead */etc/pam.d/*		call s:StarSetf('pamconf')

" Printcap and Termcap
au BufNewFile,BufRead *printcap*
	\ if !did_filetype()
	\|  let b:ptcap_type = "print" | call s:StarSetf('ptcap')
	\|endif
au BufNewFile,BufRead *termcap*
	\ if !did_filetype()
	\|  let b:ptcap_type = "term" | call s:StarSetf('ptcap')
	\|endif

" ReDIF
" Only used when the .rdf file was not detected to be XML.
au BufRead,BufNewFile *.rdf			call polyglot#ft#Redif()

" Remind
au BufNewFile,BufRead .reminders*		call s:StarSetf('remind')

" SGML catalog file
au BufNewFile,BufRead sgml.catalog*		call s:StarSetf('catalog')

" Shell scripts ending in a star
au BufNewFile,BufRead .bashrc*,.bash[_-]profile*,.bash[_-]logout*,.bash[_-]aliases*,bash-fc[-.]*,,PKGBUILD* call polyglot#ft#SetFileTypeSH("bash")
au BufNewFile,BufRead .kshrc* call polyglot#ft#SetFileTypeSH("ksh")
au BufNewFile,BufRead .profile* call polyglot#ft#SetFileTypeSH(getline(1))

" tcsh scripts ending in a star
au BufNewFile,BufRead .tcshrc*	call polyglot#ft#SetFileTypeShell("tcsh")

" csh scripts ending in a star
au BufNewFile,BufRead .login*,.cshrc*  call polyglot#ft#CSH()

" VHDL
au BufNewFile,BufRead *.vhdl_[0-9]*		call s:StarSetf('vhdl')

" Vim script
au BufNewFile,BufRead *vimrc*			call s:StarSetf('vim')

" Subversion commit file
au BufNewFile,BufRead svn-commit*.tmp		setf svn

" X resources file
au BufNewFile,BufRead Xresources*,*/app-defaults/*,*/Xresources/* call s:StarSetf('xdefaults')

" XFree86 config
au BufNewFile,BufRead XF86Config-4*
	\ let b:xf86conf_xfree86_version = 4 | call s:StarSetf('xf86conf')
au BufNewFile,BufRead XF86Config*
	\ if getline(1) =~ '\<XConfigurator\>'
	\|  let b:xf86conf_xfree86_version = 3
	\|endif
	\|call s:StarSetf('xf86conf')

" X11 xmodmap
au BufNewFile,BufRead *xmodmap*			call s:StarSetf('xmodmap')

" Xinetd conf
au BufNewFile,BufRead */etc/xinetd.d/*		call s:StarSetf('xinetd')

" yum conf (close enough to dosini)
au BufNewFile,BufRead */etc/yum.repos.d/*	call s:StarSetf('dosini')

" Z-Shell script ending in a star
au BufNewFile,BufRead .zsh*,.zlog*,.zcompdump*  call s:StarSetf('zsh')
au BufNewFile,BufRead zsh*,zlog*		call s:StarSetf('zsh')


" Help files match *.txt but should have a last line that is a modeline.
au BufNewFile,BufRead *.txt
	\  if getline('$') !~ 'vim:.*ft=help'
	\|   setf text
	\| endif


" NOTE: The above command could have ended the filetypedetect autocmd group
" and started another one. Let's make sure it has ended to get to a consistent
" state.
augroup END

" Use the filetype detect plugins.  They may overrule any of the previously
" detected filetypes. No need to load if everything is enabled
if exists("did_load_filetypes") && exists("g:polyglot_disabled")
  unlet did_load_filetypes
  runtime! extras/filetype.vim
endif


if polyglot#util#IsEnabled('sensible', 'ftdetect')
  " Reload unchanged files automatically.
  set autoread

  " Disable swap, it doesn't play well with autoread
  set noswapfile

  " Enable highlighted case-insensitive incremential search.
  set incsearch

  " Use utf-8 encoding by default
  set encoding=utf-8

  " Autoindent when starting new line, or using `o` or `O`.
  set autoindent
endif

" Restore 'cpoptions'
let &cpo = s:cpo_save
unlet s:cpo_save
