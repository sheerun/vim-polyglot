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

func! s:Observe(fn)
  let b:PolyglotObserve = function("polyglot#" . a:fn)
  augroup polyglot-observer
    au! CursorHold,CursorHoldI,BufWritePost <buffer>
          \ if b:PolyglotObserve() | au! polyglot-observer | endif
  augroup END
endfunc

let s:disabled_packages = {}
let s:new_polyglot_disabled = []

if exists('g:polyglot_disabled')
  for pkg in g:polyglot_disabled
    let base = split(pkg, '\.')
    if len(base) > 0
      let s:disabled_packages[pkg] = 1
      call add(s:new_polyglot_disabled, base[0]) 
    endif
  endfor
else
  let g:polyglot_disabled_not_set = 1
endif

function! s:SetDefault(name, value)
  if !exists(a:name)
    let {a:name} = a:value
  endif
endfunction

call s:SetDefault('g:polyglot_autoindent_guess_lines', [32, 1024])

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

augroup filetypedetect

" Load user-defined filetype.vim and oter plugins ftdetect first
" This is to use polyglot-defined ftdetect always as fallback to user settings
runtime! filetype.vim
runtime! ftdetect/*.vim

" DO NOT EDIT CODE BELOW, IT IS GENERATED WITH MAKEFILE

if !has_key(s:disabled_packages, 'context')
  au BufNewFile,BufRead *.mkii,*.mkiv,*.mkvi setf context
endif

if !has_key(s:disabled_packages, 'xpm2')
  au BufNewFile,BufRead *.xpm2 setf xpm2
endif

if !has_key(s:disabled_packages, 'xpm')
  au BufNewFile,BufRead,BufWritePost *.pm call polyglot#detect#Pm()
  au BufNewFile,BufRead *.xpm setf xpm
endif

if !has_key(s:disabled_packages, 'man')
  au BufNewFile,BufRead *.1,*.1in,*.1m,*.1x,*.2,*.3,*.3in,*.3m,*.3p,*.3pm,*.3qt,*.3x,*.4,*.5,*.6,*.7,*.8,*.9,*.man,*.mdoc setf man
endif

if !has_key(s:disabled_packages, 'xf86conf')
  au BufNewFile,BufRead */xorg.conf.d/*.conf,xorg.conf,xorg.conf-4 setf xf86conf
  au BufNewFile,BufRead XF86Config-4* call s:StarSetf('xf86conf')
  au BufNewFile,BufRead XF86Config* call s:StarSetf('xf86conf')
endif

if !has_key(s:disabled_packages, 'pullrequest')
  au BufNewFile,BufRead PULLREQ_EDITMSG setf pullrequest
endif

if !has_key(s:disabled_packages, 'text')
  au BufNewFile,BufRead *.text,README setf text
endif

if !has_key(s:disabled_packages, 'svn')
  au BufNewFile,BufRead svn-commit*.tmp setf svn
endif

if !has_key(s:disabled_packages, 'logcheck')
  au BufNewFile,BufRead */etc/logcheck/*.d*/* call s:StarSetf('logcheck')
endif

if !has_key(s:disabled_packages, 'fvwm')
  au BufNewFile,BufRead */.fvwm/* call s:StarSetf('fvwm')
endif

if !has_key(s:disabled_packages, 'crontab')
  au BufNewFile,BufRead crontab setf crontab
  au BufNewFile,BufRead crontab.* call s:StarSetf('crontab')
  au BufNewFile,BufRead */etc/cron.d/* call s:StarSetf('crontab')
endif

if !has_key(s:disabled_packages, 'bzr')
  au BufNewFile,BufRead bzr_log.* call s:StarSetf('bzr')
endif

if !has_key(s:disabled_packages, 'asteriskvm')
  au BufNewFile,BufRead *asterisk*/*voicemail.conf* call s:StarSetf('asteriskvm')
endif

if !has_key(s:disabled_packages, 'asterisk')
  au BufNewFile,BufRead *asterisk/*.conf* call s:StarSetf('asterisk')
endif

if !has_key(s:disabled_packages, 'apachestyle')
  au BufNewFile,BufRead proftpd.conf* call s:StarSetf('apachestyle')
  au BufNewFile,BufRead */etc/proftpd/conf.*/* call s:StarSetf('apachestyle')
  au BufNewFile,BufRead */etc/proftpd/*.conf* call s:StarSetf('apachestyle')
endif

if !has_key(s:disabled_packages, 'z8a')
  au BufNewFile,BufRead *.z8a setf z8a
endif

if !has_key(s:disabled_packages, 'zimbutempl')
  au BufNewFile,BufRead *.zut setf zimbutempl
endif

if !has_key(s:disabled_packages, 'zimbu')
  au BufNewFile,BufRead *.zu setf zimbu
endif

if !has_key(s:disabled_packages, 'yacc')
  au BufNewFile,BufRead *.y++,*.yxx,*.yy setf yacc
endif

if !has_key(s:disabled_packages, 'xslt')
  au BufNewFile,BufRead *.xsl,*.xslt setf xslt
endif

if !has_key(s:disabled_packages, 'xsd')
  au BufNewFile,BufRead *.xsd setf xsd
endif

if !has_key(s:disabled_packages, 'xquery')
  au BufNewFile,BufRead *.xq,*.xql,*.xqm,*.xquery,*.xqy setf xquery
endif

if !has_key(s:disabled_packages, 'xmodmap')
  au BufNewFile,BufRead *Xmodmap setf xmodmap
  au BufNewFile,BufRead *xmodmap* call s:StarSetf('xmodmap')
endif

if !has_key(s:disabled_packages, 'xmath')
  au BufNewFile,BufRead *.msc,*.msf setf xmath
endif

if !has_key(s:disabled_packages, 'xdefaults')
  au BufNewFile,BufRead *.ad,{.,}Xdefaults,{.,}Xpdefaults,{.,}Xresources,xdm-config setf xdefaults
  au BufNewFile,BufRead Xresources* call s:StarSetf('xdefaults')
  au BufNewFile,BufRead */app-defaults/* call s:StarSetf('xdefaults')
  au BufNewFile,BufRead */Xresources/* call s:StarSetf('xdefaults')
endif

if !has_key(s:disabled_packages, 'xinetd')
  au BufNewFile,BufRead */etc/xinetd.conf setf xinetd
  au BufNewFile,BufRead */etc/xinetd.d/* call s:StarSetf('xinetd')
endif

if !has_key(s:disabled_packages, 'xhtml')
  au BufNewFile,BufRead *.xht,*.xhtml setf xhtml
endif

if !has_key(s:disabled_packages, 'wsh')
  au BufNewFile,BufRead *.ws[fc] setf wsh
endif

if !has_key(s:disabled_packages, 'cvs')
  au BufNewFile,BufRead cvs\d\+ setf cvs
endif

if !has_key(s:disabled_packages, 'cvsrc')
  au BufNewFile,BufRead {.,}cvsrc setf cvsrc
endif

if !has_key(s:disabled_packages, 'wvdial')
  au BufNewFile,BufRead {.,}wvdialrc,wvdial.conf setf wvdial
endif

if !has_key(s:disabled_packages, 'wsml')
  au BufNewFile,BufRead *.wsml setf wsml
endif

if !has_key(s:disabled_packages, 'winbatch')
  au BufNewFile,BufRead *.wbt setf winbatch
endif

if !has_key(s:disabled_packages, 'wml')
  au BufNewFile,BufRead *.wml setf wml
endif

if !has_key(s:disabled_packages, 'wget')
  au BufNewFile,BufRead {.,}wgetrc,wgetrc setf wget
endif

if !has_key(s:disabled_packages, 'webmacro')
  au BufNewFile,BufRead *.wm setf webmacro
endif

if !has_key(s:disabled_packages, 'wast')
  au BufNewFile,BufRead *.wast,*.wat setf wast
endif

if !has_key(s:disabled_packages, 'vroom')
  au BufNewFile,BufRead *.vroom setf vroom
endif

if !has_key(s:disabled_packages, 'vrml')
  au BufNewFile,BufRead *.wrl setf vrml
endif

if !has_key(s:disabled_packages, 'vgrindefs')
  au BufNewFile,BufRead vgrindefs setf vgrindefs
endif

if !has_key(s:disabled_packages, 'viminfo')
  au BufNewFile,BufRead {.,}viminfo,_viminfo setf viminfo
endif

if !has_key(s:disabled_packages, 'vim')
  au BufNewFile,BufRead *.vba,*.vim,{.,}exrc,_exrc setf vim
  au BufNewFile,BufRead *vimrc* call s:StarSetf('vim')
endif

if !has_key(s:disabled_packages, 'vhdl')
  au BufNewFile,BufRead *.hdl,*.vbe,*.vhd,*.vhdl,*.vho,*.vst setf vhdl
  au BufNewFile,BufRead *.vhdl_[0-9]* call s:StarSetf('vhdl')
endif

if !has_key(s:disabled_packages, 'systemverilog')
  au BufNewFile,BufRead *.sv,*.svh setf systemverilog
endif

if !has_key(s:disabled_packages, 'verilogams')
  au BufNewFile,BufRead *.va,*.vams setf verilogams
endif

if !has_key(s:disabled_packages, 'verilog')
  au BufNewFile,BufRead *.v setf verilog
endif

if !has_key(s:disabled_packages, 'vera')
  au BufNewFile,BufRead *.vr,*.vrh,*.vri setf vera
endif

if !has_key(s:disabled_packages, 'upstart')
  au BufNewFile,BufRead */.config/upstart/*.conf,*/.config/upstart/*.override,*/.init/*.conf,*/.init/*.override,*/etc/init/*.conf,*/etc/init/*.override,*/usr/share/upstart/*.conf,*/usr/share/upstart/*.override setf upstart
endif

if !has_key(s:disabled_packages, 'updatedb')
  au BufNewFile,BufRead */etc/updatedb.conf setf updatedb
endif

if !has_key(s:disabled_packages, 'uc')
  au BufNewFile,BufRead *.uc setf uc
endif

if !has_key(s:disabled_packages, 'udevperm')
  au BufNewFile,BufRead */etc/udev/permissions.d/*.permissions setf udevperm
endif

if !has_key(s:disabled_packages, 'udevconf')
  au BufNewFile,BufRead */etc/udev/udev.conf setf udevconf
endif

if !has_key(s:disabled_packages, 'uil')
  au BufNewFile,BufRead *.uil,*.uit setf uil
endif

if !has_key(s:disabled_packages, 'tsscl')
  au BufNewFile,BufRead *.tsscl setf tsscl
endif

if !has_key(s:disabled_packages, 'tssop')
  au BufNewFile,BufRead *.tssop setf tssop
endif

if !has_key(s:disabled_packages, 'tssgm')
  au BufNewFile,BufRead *.tssgm setf tssgm
endif

if !has_key(s:disabled_packages, 'trustees')
  au BufNewFile,BufRead trustees.conf setf trustees
endif

if !has_key(s:disabled_packages, 'treetop')
  au BufNewFile,BufRead *.treetop setf treetop
endif

if !has_key(s:disabled_packages, 'tpp')
  au BufNewFile,BufRead *.tpp setf tpp
endif

if !has_key(s:disabled_packages, 'tidy')
  au BufNewFile,BufRead {.,}tidyrc,tidy.conf,tidyrc setf tidy
endif

if !has_key(s:disabled_packages, 'texmf')
  au BufNewFile,BufRead texmf.cnf setf texmf
endif

if !has_key(s:disabled_packages, 'texinfo')
  au BufNewFile,BufRead *.texi,*.texinfo,*.txi setf texinfo
endif

if !has_key(s:disabled_packages, 'tex')
  au BufNewFile,BufRead *.bbl,*.dtx,*.latex,*.ltx,*.sty setf tex
endif

if !has_key(s:disabled_packages, 'terminfo')
  au BufNewFile,BufRead *.ti setf terminfo
endif

if !has_key(s:disabled_packages, 'teraterm')
  au BufNewFile,BufRead *.ttl setf teraterm
endif

if !has_key(s:disabled_packages, 'tsalt')
  au BufNewFile,BufRead *.slt setf tsalt
endif

if !has_key(s:disabled_packages, 'tli')
  au BufNewFile,BufRead *.tli setf tli
endif

if !has_key(s:disabled_packages, 'tcl')
  au BufNewFile,BufRead *.itcl,*.itk,*.jacl,*.tcl,*.tk setf tcl
endif

if !has_key(s:disabled_packages, 'taskedit')
  au BufNewFile,BufRead *.task setf taskedit
endif

if !has_key(s:disabled_packages, 'taskdata')
  au BufNewFile,BufRead {pending,completed,undo}.data setf taskdata
endif

if !has_key(s:disabled_packages, 'tak')
  au BufNewFile,BufRead *.tak setf tak
endif

if !has_key(s:disabled_packages, 'tags')
  au BufNewFile,BufRead tags setf tags
endif

if !has_key(s:disabled_packages, 'sudoers')
  au BufNewFile,BufRead */etc/sudoers,sudoers.tmp setf sudoers
endif

if !has_key(s:disabled_packages, 'sdc')
  au BufNewFile,BufRead *.sdc setf sdc
endif

if !has_key(s:disabled_packages, 'sysctl')
  au BufNewFile,BufRead */etc/sysctl.conf,*/etc/sysctl.d/*.conf setf sysctl
endif

if !has_key(s:disabled_packages, 'sil')
  au BufNewFile,BufRead *.sil setf sil
endif

if !has_key(s:disabled_packages, 'swiftgyb')
  au BufNewFile,BufRead *.swift.gyb setf swiftgyb
endif

if !has_key(s:disabled_packages, 'voscm')
  au BufNewFile,BufRead *.cm setf voscm
endif

if !has_key(s:disabled_packages, 'sml')
  au BufNewFile,BufRead *.sml setf sml
endif

if !has_key(s:disabled_packages, 'stp')
  au BufNewFile,BufRead *.stp setf stp
endif

if !has_key(s:disabled_packages, 'smcl')
  au BufNewFile,BufRead *.hlp,*.ihlp,*.smcl setf smcl
endif

if !has_key(s:disabled_packages, 'stata')
  au BufNewFile,BufRead *.ado,*.do,*.imata,*.mata setf stata
endif

if !has_key(s:disabled_packages, 'sshdconfig')
  au BufNewFile,BufRead */etc/ssh/sshd_config.d/*.conf,sshd_config setf sshdconfig
endif

if !has_key(s:disabled_packages, 'sshconfig')
  au BufNewFile,BufRead */.ssh/config,*/etc/ssh/ssh_config.d/*.conf,ssh_config setf sshconfig
endif

if !has_key(s:disabled_packages, 'sqr')
  au BufNewFile,BufRead *.sqi,*.sqr setf sqr
endif

if !has_key(s:disabled_packages, 'sqlj')
  au BufNewFile,BufRead *.sqlj setf sqlj
endif

if !has_key(s:disabled_packages, 'squid')
  au BufNewFile,BufRead squid.conf setf squid
endif

if !has_key(s:disabled_packages, 'spice')
  au BufNewFile,BufRead *.sp,*.spice setf spice
endif

if !has_key(s:disabled_packages, 'slice')
  au BufNewFile,BufRead *.ice setf slice
endif

if !has_key(s:disabled_packages, 'spup')
  au BufNewFile,BufRead *.spd,*.spdata,*.speedup setf spup
endif

if !has_key(s:disabled_packages, 'hog')
  au BufNewFile,BufRead *.hog,snort.conf,vision.conf setf hog
endif

if !has_key(s:disabled_packages, 'mib')
  au BufNewFile,BufRead *.mib,*.my setf mib
endif

if !has_key(s:disabled_packages, 'snobol4')
  au BufNewFile,BufRead *.sno,*.spt setf snobol4
endif

if !has_key(s:disabled_packages, 'smith')
  au BufNewFile,BufRead *.smith,*.smt setf smith
endif

if !has_key(s:disabled_packages, 'st')
  au BufNewFile,BufRead *.st setf st
endif

if !has_key(s:disabled_packages, 'slrnsc')
  au BufNewFile,BufRead *.score setf slrnsc
endif

if !has_key(s:disabled_packages, 'slrnrc')
  au BufNewFile,BufRead {.,}slrnrc setf slrnrc
endif

if !has_key(s:disabled_packages, 'skill')
  au BufNewFile,BufRead *.cdf,*.il,*.ils setf skill
endif

if !has_key(s:disabled_packages, 'sisu')
  au BufNewFile,BufRead *.-sst,*.-sst.meta,*._sst,*._sst.meta,*.ssi,*.ssm,*.sst,*.sst.meta setf sisu
endif

if !has_key(s:disabled_packages, 'sinda')
  au BufNewFile,BufRead *.s85,*.sin setf sinda
endif

if !has_key(s:disabled_packages, 'simula')
  au BufNewFile,BufRead *.sim setf simula
endif

if !has_key(s:disabled_packages, 'screen')
  au BufNewFile,BufRead {.,}screenrc,screenrc setf screen
endif

if !has_key(s:disabled_packages, 'scheme')
  au BufNewFile,BufRead *.rkt,*.scm,*.ss setf scheme
endif

if !has_key(s:disabled_packages, 'catalog')
  au BufNewFile,BufRead catalog setf catalog
  au BufNewFile,BufRead sgml.catalog* call s:StarSetf('catalog')
endif

if !has_key(s:disabled_packages, 'setserial')
  au BufNewFile,BufRead */etc/serial.conf setf setserial
endif

if !has_key(s:disabled_packages, 'slpspi')
  au BufNewFile,BufRead */etc/slp.spi setf slpspi
endif

if !has_key(s:disabled_packages, 'spyce')
  au BufNewFile,BufRead *.spi,*.spy setf spyce
endif

if !has_key(s:disabled_packages, 'slpreg')
  au BufNewFile,BufRead */etc/slp.reg setf slpreg
endif

if !has_key(s:disabled_packages, 'slpconf')
  au BufNewFile,BufRead */etc/slp.conf setf slpconf
endif

if !has_key(s:disabled_packages, 'services')
  au BufNewFile,BufRead */etc/services setf services
endif

if !has_key(s:disabled_packages, 'sm')
  au BufNewFile,BufRead sendmail.cf setf sm
endif

if !has_key(s:disabled_packages, 'sieve')
  au BufNewFile,BufRead *.sieve,*.siv setf sieve
endif

if !has_key(s:disabled_packages, 'sdl')
  au BufNewFile,BufRead *.pr,*.sdl setf sdl
endif

if !has_key(s:disabled_packages, 'sd')
  au BufNewFile,BufRead *.sd setf sd
endif

if !has_key(s:disabled_packages, 'scilab')
  au BufNewFile,BufRead *.sce,*.sci setf scilab
endif

if !has_key(s:disabled_packages, 'sbt')
  au BufNewFile,BufRead *.sbt setf sbt
endif

if !has_key(s:disabled_packages, 'sather')
  au BufNewFile,BufRead *.sa setf sather
endif

if !has_key(s:disabled_packages, 'sass')
  au BufNewFile,BufRead *.sass setf sass
endif

if !has_key(s:disabled_packages, 'sas')
  au BufNewFile,BufRead *.sas setf sas
endif

if !has_key(s:disabled_packages, 'samba')
  au BufNewFile,BufRead smb.conf setf samba
endif

if !has_key(s:disabled_packages, 'slang')
  au BufNewFile,BufRead *.sl setf slang
endif

if !has_key(s:disabled_packages, 'rtf')
  au BufNewFile,BufRead *.rtf setf rtf
endif

if !has_key(s:disabled_packages, 'rpcgen')
  au BufNewFile,BufRead *.x setf rpcgen
endif

if !has_key(s:disabled_packages, 'robots')
  au BufNewFile,BufRead robots.txt setf robots
endif

if !has_key(s:disabled_packages, 'rpl')
  au BufNewFile,BufRead *.rpl setf rpl
endif

if !has_key(s:disabled_packages, 'rng')
  au BufNewFile,BufRead *.rng setf rng
endif

if !has_key(s:disabled_packages, 'rnc')
  au BufNewFile,BufRead *.rnc setf rnc
endif

if !has_key(s:disabled_packages, 'resolv')
  au BufNewFile,BufRead resolv.conf setf resolv
endif

if !has_key(s:disabled_packages, 'remind')
  au BufNewFile,BufRead *.rem,*.remind,{.,}reminders setf remind
  au BufNewFile,BufRead .reminders* call s:StarSetf('remind')
endif

if !has_key(s:disabled_packages, 'rrst')
  au BufNewFile,BufRead *.rrst,*.srst setf rrst
endif

if !has_key(s:disabled_packages, 'rmd')
  au BufNewFile,BufRead *.rmd,*.smd setf rmd
endif

if !has_key(s:disabled_packages, 'rnoweb')
  au BufNewFile,BufRead *.rnw,*.snw setf rnoweb
endif

if !has_key(s:disabled_packages, 'rexx')
  au BufNewFile,BufRead *.jrexx,*.orx,*.rex,*.rexx,*.rexxj,*.rxj,*.rxo,*.testGroup,*.testUnit setf rexx
endif

if !has_key(s:disabled_packages, 'rego')
  au BufNewFile,BufRead *.rego setf rego
endif

if !has_key(s:disabled_packages, 'rib')
  au BufNewFile,BufRead *.rib setf rib
endif

if !has_key(s:disabled_packages, 'readline')
  au BufNewFile,BufRead {.,}inputrc,inputrc setf readline
endif

if !has_key(s:disabled_packages, 'rcs')
  au BufNewFile,BufRead *\,v setf rcs
endif

if !has_key(s:disabled_packages, 'ratpoison')
  au BufNewFile,BufRead {.,}ratpoisonrc,ratpoisonrc setf ratpoison
endif

if !has_key(s:disabled_packages, 'radiance')
  au BufNewFile,BufRead *.mat,*.rad setf radiance
endif

if !has_key(s:disabled_packages, 'pyrex')
  au BufNewFile,BufRead *.pxd,*.pyx setf pyrex
endif

if !has_key(s:disabled_packages, 'protocols')
  au BufNewFile,BufRead */etc/protocols setf protocols
endif

if !has_key(s:disabled_packages, 'promela')
  au BufNewFile,BufRead *.pml setf promela
endif

if !has_key(s:disabled_packages, 'psf')
  au BufNewFile,BufRead *.psf setf psf
endif

if !has_key(s:disabled_packages, 'procmail')
  au BufNewFile,BufRead {.,}procmail,{.,}procmailrc setf procmail
endif

if !has_key(s:disabled_packages, 'privoxy')
  au BufNewFile,BufRead *.action setf privoxy
endif

if !has_key(s:disabled_packages, 'proc')
  au BufNewFile,BufRead *.pc setf proc
endif

if !has_key(s:disabled_packages, 'obj')
  au BufNewFile,BufRead *.obj setf obj
endif

if !has_key(s:disabled_packages, 'ppwiz')
  au BufNewFile,BufRead *.ih,*.it setf ppwiz
endif

if !has_key(s:disabled_packages, 'pccts')
  au BufNewFile,BufRead *.g setf pccts
endif

if !has_key(s:disabled_packages, 'povini')
  au BufNewFile,BufRead {.,}povrayrc setf povini
endif

if !has_key(s:disabled_packages, 'pov')
  au BufNewFile,BufRead *.pov setf pov
endif

if !has_key(s:disabled_packages, 'ppd')
  au BufNewFile,BufRead *.ppd setf ppd
endif

if !has_key(s:disabled_packages, 'postscr')
  au BufNewFile,BufRead *.afm,*.ai,*.eps,*.epsf,*.epsi,*.pfa,*.ps setf postscr
endif

if !has_key(s:disabled_packages, 'pfmain')
  au BufNewFile,BufRead main.cf setf pfmain
endif

if !has_key(s:disabled_packages, 'po')
  au BufNewFile,BufRead *.po,*.pot setf po
endif

if !has_key(s:disabled_packages, 'plp')
  au BufNewFile,BufRead *.plp setf plp
endif

if !has_key(s:disabled_packages, 'plsql')
  au BufNewFile,BufRead *.pls,*.plsql setf plsql
endif

if !has_key(s:disabled_packages, 'plm')
  au BufNewFile,BufRead *.p36,*.pac,*.plm setf plm
endif

if !has_key(s:disabled_packages, 'pli')
  au BufNewFile,BufRead *.pl1,*.pli setf pli
endif

if !has_key(s:disabled_packages, 'pine')
  au BufNewFile,BufRead {.,}pinerc,{.,}pinercex,pinerc,pinercex setf pine
endif

if !has_key(s:disabled_packages, 'pilrc')
  au BufNewFile,BufRead *.rcp setf pilrc
endif

if !has_key(s:disabled_packages, 'pinfo')
  au BufNewFile,BufRead */.pinforc,*/etc/pinforc setf pinfo
endif

if !has_key(s:disabled_packages, 'cmod')
  au BufNewFile,BufRead *.cmod setf cmod
endif

if !has_key(s:disabled_packages, 'pike')
  au BufNewFile,BufRead *.pike,*.pmod setf pike
endif

if !has_key(s:disabled_packages, 'pcmk')
  au BufNewFile,BufRead *.pcmk setf pcmk
endif

if !has_key(s:disabled_packages, 'pdf')
  au BufNewFile,BufRead *.pdf setf pdf
endif

if !has_key(s:disabled_packages, 'pascal')
  au BufNewFile,BufRead *.dpr,*.lpr,*.pas,*.pp setf pascal
endif

if !has_key(s:disabled_packages, 'passwd')
  au BufNewFile,BufRead */etc/passwd,*/etc/passwd-,*/etc/passwd.edit,*/etc/shadow,*/etc/shadow-,*/etc/shadow.edit,*/var/backups/passwd.bak,*/var/backups/shadow.bak setf passwd
endif

if !has_key(s:disabled_packages, 'papp')
  au BufNewFile,BufRead *.papp,*.pxml,*.pxsl setf papp
endif

if !has_key(s:disabled_packages, 'pamenv')
  au BufNewFile,BufRead {.,}pam_environment,pam_env.conf setf pamenv
endif

if !has_key(s:disabled_packages, 'pamconf')
  au BufNewFile,BufRead */etc/pam.conf setf pamconf
  au BufNewFile,BufRead */etc/pam.d/* call s:StarSetf('pamconf')
endif

if !has_key(s:disabled_packages, 'pf')
  au BufNewFile,BufRead pf.conf setf pf
endif

if !has_key(s:disabled_packages, 'ora')
  au BufNewFile,BufRead *.ora setf ora
endif

if !has_key(s:disabled_packages, 'opl')
  au BufNewFile,BufRead *.[Oo][Pp][Ll] setf opl
endif

if !has_key(s:disabled_packages, 'openroad')
  au BufNewFile,BufRead *.or setf openroad
endif

if !has_key(s:disabled_packages, 'omnimark')
  au BufNewFile,BufRead *.xin,*.xom setf omnimark
endif

if !has_key(s:disabled_packages, 'occam')
  au BufNewFile,BufRead *.occ setf occam
endif

if !has_key(s:disabled_packages, 'nsis')
  au BufNewFile,BufRead *.nsh,*.nsi setf nsis
endif

if !has_key(s:disabled_packages, 'nqc')
  au BufNewFile,BufRead *.nqc setf nqc
endif

if !has_key(s:disabled_packages, 'nroff')
  au BufNewFile,BufRead *.mom,*.nr,*.roff,*.tmac,*.tr setf nroff
  au BufNewFile,BufRead tmac.* call s:StarSetf('nroff')
endif

if !has_key(s:disabled_packages, 'ncf')
  au BufNewFile,BufRead *.ncf setf ncf
endif

if !has_key(s:disabled_packages, 'ninja')
  au BufNewFile,BufRead *.ninja setf ninja
endif

if !has_key(s:disabled_packages, 'netrc')
  au BufNewFile,BufRead {.,}netrc setf netrc
endif

if !has_key(s:disabled_packages, 'neomuttrc')
  au BufNewFile,BufRead Neomuttrc setf neomuttrc
  au BufNewFile,BufRead neomuttrc* call s:StarSetf('neomuttrc')
  au BufNewFile,BufRead Neomuttrc* call s:StarSetf('neomuttrc')
  au BufNewFile,BufRead .neomuttrc* call s:StarSetf('neomuttrc')
  au BufNewFile,BufRead */.neomutt/neomuttrc* call s:StarSetf('neomuttrc')
endif

if !has_key(s:disabled_packages, 'natural')
  au BufNewFile,BufRead *.NS[ACGLMNPS] setf natural
endif

if !has_key(s:disabled_packages, 'nanorc')
  au BufNewFile,BufRead *.nanorc,*/etc/nanorc setf nanorc
endif

if !has_key(s:disabled_packages, 'n1ql')
  au BufNewFile,BufRead *.n1ql,*.nql setf n1ql
endif

if !has_key(s:disabled_packages, 'mush')
  au BufNewFile,BufRead *.mush setf mush
endif

if !has_key(s:disabled_packages, 'mupad')
  au BufNewFile,BufRead *.mu setf mupad
endif

if !has_key(s:disabled_packages, 'muttrc')
  au BufNewFile,BufRead Mutt{ng,}rc setf muttrc
  au BufNewFile,BufRead mutt{ng,}rc* call s:StarSetf('muttrc')
  au BufNewFile,BufRead Mutt{ng,}rc* call s:StarSetf('muttrc')
  au BufNewFile,BufRead .mutt{ng,}rc* call s:StarSetf('muttrc')
  au BufNewFile,BufRead */etc/Muttrc.d/* call s:StarSetf('muttrc')
  au BufNewFile,BufRead */.mutt{ng,}/mutt{ng,}rc* call s:StarSetf('muttrc')
endif

if !has_key(s:disabled_packages, 'msql')
  au BufNewFile,BufRead *.msql setf msql
endif

if !has_key(s:disabled_packages, 'mrxvtrc')
  au BufNewFile,BufRead {.,}mrxvtrc,mrxvtrc setf mrxvtrc
endif

if !has_key(s:disabled_packages, 'srec')
  au BufNewFile,BufRead *.mot,*.s19,*.s28,*.s37,*.srec setf srec
endif

if !has_key(s:disabled_packages, 'mplayerconf')
  au BufNewFile,BufRead */.mplayer/config,mplayer.conf setf mplayerconf
endif

if !has_key(s:disabled_packages, 'modconf')
  au BufNewFile,BufRead */etc/conf.modules,*/etc/modules,*/etc/modules.conf setf modconf
  au BufNewFile,BufRead */etc/modprobe.* call s:StarSetf('modconf')
endif

if !has_key(s:disabled_packages, 'moo')
  au BufNewFile,BufRead *.moo setf moo
endif

if !has_key(s:disabled_packages, 'monk')
  au BufNewFile,BufRead *.isc,*.monk,*.ssc,*.tsc setf monk
endif

if !has_key(s:disabled_packages, 'modula3')
  au BufNewFile,BufRead *.[mi][3g] setf modula3
endif

if !has_key(s:disabled_packages, 'modula2')
  au BufNewFile,BufRead *.DEF,*.MOD,*.m2,*.mi setf modula2
endif

if !has_key(s:disabled_packages, 'mmp')
  au BufNewFile,BufRead *.mmp setf mmp
endif

if !has_key(s:disabled_packages, 'mix')
  au BufNewFile,BufRead *.mix,*.mixal setf mix
endif

if !has_key(s:disabled_packages, 'mgl')
  au BufNewFile,BufRead *.mgl setf mgl
endif

if !has_key(s:disabled_packages, 'mp')
  au BufNewFile,BufRead *.mp setf mp
endif

if !has_key(s:disabled_packages, 'mf')
  au BufNewFile,BufRead *.mf setf mf
endif

if !has_key(s:disabled_packages, 'messages')
  au BufNewFile,BufRead */log/{auth,cron,daemon,debug,kern,lpr,mail,messages,news/news,syslog,user}{,.log,.err,.info,.warn,.crit,.notice}{,.[0-9]*,-[0-9]*} setf messages
endif

if !has_key(s:disabled_packages, 'hgcommit')
  au BufNewFile,BufRead hg-editor-*.txt setf hgcommit
endif

if !has_key(s:disabled_packages, 'mel')
  au BufNewFile,BufRead *.mel setf mel
endif

if !has_key(s:disabled_packages, 'map')
  au BufNewFile,BufRead *.map setf map
endif

if !has_key(s:disabled_packages, 'maple')
  au BufNewFile,BufRead *.mpl,*.mv,*.mws setf maple
endif

if !has_key(s:disabled_packages, 'manconf')
  au BufNewFile,BufRead */etc/man.conf,man.config setf manconf
endif

if !has_key(s:disabled_packages, 'mallard')
  au BufNewFile,BufRead *.page setf mallard
endif

if !has_key(s:disabled_packages, 'ist')
  au BufNewFile,BufRead *.ist,*.mst setf ist
endif

if !has_key(s:disabled_packages, 'mailcap')
  au BufNewFile,BufRead {.,}mailcap,mailcap setf mailcap
endif

if !has_key(s:disabled_packages, 'mailaliases')
  au BufNewFile,BufRead */etc/aliases,*/etc/mail/aliases setf mailaliases
endif

if !has_key(s:disabled_packages, 'mail')
  au BufNewFile,BufRead *.eml,{.,}article,{.,}article.\d\+,{.,}followup,{.,}letter,{.,}letter.\d\+,/tmp/SLRN[0-9A-Z.]\+,ae\d\+.txt,mutt[[:alnum:]_-]\\\{6\},mutt{ng,}-*-\w\+,neomutt-*-\w\+,neomutt[[:alnum:]_-]\\\{6\},pico.\d\+,snd.\d\+,{neo,}mutt[[:alnum:]._-]\\\{6\} setf mail
  au BufNewFile,BufRead reportbug-* call s:StarSetf('mail')
endif

if !has_key(s:disabled_packages, 'mgp')
  au BufNewFile,BufRead *.mgp setf mgp
endif

if !has_key(s:disabled_packages, 'lss')
  au BufNewFile,BufRead *.lss setf lss
endif

if !has_key(s:disabled_packages, 'lsl')
  au BufNewFile,BufRead *.lsl setf lsl
endif

if !has_key(s:disabled_packages, 'lout')
  au BufNewFile,BufRead *.lou,*.lout setf lout
endif

if !has_key(s:disabled_packages, 'lotos')
  au BufNewFile,BufRead *.lot,*.lotos setf lotos
endif

if !has_key(s:disabled_packages, 'logtalk')
  au BufNewFile,BufRead *.lgt setf logtalk
endif

if !has_key(s:disabled_packages, 'logindefs')
  au BufNewFile,BufRead */etc/login.defs setf logindefs
endif

if !has_key(s:disabled_packages, 'loginaccess')
  au BufNewFile,BufRead */etc/login.access setf loginaccess
endif

if !has_key(s:disabled_packages, 'litestep')
  au BufNewFile,BufRead */LiteStep/*/*.rc setf litestep
endif

if !has_key(s:disabled_packages, 'lite')
  au BufNewFile,BufRead *.lite,*.lt setf lite
endif

if !has_key(s:disabled_packages, 'liquid')
  au BufNewFile,BufRead *.liquid setf liquid
endif

if !has_key(s:disabled_packages, 'lisp')
  au BufNewFile,BufRead *.cl,*.el,*.lisp,*.lsp,{.,}emacs,{.,}sawfishrc,{.,}sbclrc,sbclrc setf lisp
endif

if !has_key(s:disabled_packages, 'lilo')
  au BufNewFile,BufRead lilo.conf setf lilo
  au BufNewFile,BufRead lilo.conf* call s:StarSetf('lilo')
endif

if !has_key(s:disabled_packages, 'lifelines')
  au BufNewFile,BufRead *.ll setf lifelines
endif

if !has_key(s:disabled_packages, 'lftp')
  au BufNewFile,BufRead *lftp/rc,{.,}lftprc,lftp.conf setf lftp
endif

if !has_key(s:disabled_packages, 'sensors')
  au BufNewFile,BufRead */etc/sensors.conf,*/etc/sensors3.conf setf sensors
endif

if !has_key(s:disabled_packages, 'libao')
  au BufNewFile,BufRead */.libao,*/etc/libao.conf setf libao
endif

if !has_key(s:disabled_packages, 'lex')
  au BufNewFile,BufRead *.l,*.l++,*.lex,*.lxx setf lex
endif

if !has_key(s:disabled_packages, 'ld')
  au BufNewFile,BufRead *.ld setf ld
endif

if !has_key(s:disabled_packages, 'ldif')
  au BufNewFile,BufRead *.ldif setf ldif
endif

if !has_key(s:disabled_packages, 'lprolog')
  au BufNewFile,BufRead *.sig setf lprolog
endif

if !has_key(s:disabled_packages, 'limits')
  au BufNewFile,BufRead */etc/*limits.conf,*/etc/*limits.d/*.conf,*/etc/limits setf limits
endif

if !has_key(s:disabled_packages, 'latte')
  au BufNewFile,BufRead *.latte,*.lte setf latte
endif

if !has_key(s:disabled_packages, 'lace')
  au BufNewFile,BufRead *.ACE,*.ace setf lace
endif

if !has_key(s:disabled_packages, 'kconfig')
  au BufNewFile,BufRead Kconfig,Kconfig.debug setf kconfig
  au BufNewFile,BufRead Kconfig.* call s:StarSetf('kconfig')
endif

if !has_key(s:disabled_packages, 'kscript')
  au BufNewFile,BufRead *.ks setf kscript
endif

if !has_key(s:disabled_packages, 'kivy')
  au BufNewFile,BufRead *.kv setf kivy
endif

if !has_key(s:disabled_packages, 'kwt')
  au BufNewFile,BufRead *.k setf kwt
endif

if !has_key(s:disabled_packages, 'kix')
  au BufNewFile,BufRead *.kix setf kix
endif

if !has_key(s:disabled_packages, 'jovial')
  au BufNewFile,BufRead *.j73,*.jov,*.jovial setf jovial
endif

if !has_key(s:disabled_packages, 'jgraph')
  au BufNewFile,BufRead *.jgr setf jgraph
endif

if !has_key(s:disabled_packages, 'jess')
  au BufNewFile,BufRead *.clp setf jess
endif

if !has_key(s:disabled_packages, 'jproperties')
  au BufNewFile,BufRead *.properties,*.properties_??,*.properties_??_?? setf jproperties
  au BufNewFile,BufRead *.properties_??_??_* call s:StarSetf('jproperties')
endif

if !has_key(s:disabled_packages, 'jsp')
  au BufNewFile,BufRead *.jsp setf jsp
endif

if !has_key(s:disabled_packages, 'javacc')
  au BufNewFile,BufRead *.jj,*.jjt setf javacc
endif

if !has_key(s:disabled_packages, 'java')
  au BufNewFile,BufRead *.jav,*.java setf java
endif

if !has_key(s:disabled_packages, 'jam')
  au BufNewFile,BufRead *.jpl,*.jpr setf jam
  au BufNewFile,BufRead Prl*.* call s:StarSetf('jam')
  au BufNewFile,BufRead JAM*.* call s:StarSetf('jam')
endif

if !has_key(s:disabled_packages, 'jal')
  au BufNewFile,BufRead *.JAL,*.jal setf jal
endif

if !has_key(s:disabled_packages, 'j')
  au BufNewFile,BufRead *.ijs setf j
endif

if !has_key(s:disabled_packages, 'iss')
  au BufNewFile,BufRead *.iss setf iss
endif

if !has_key(s:disabled_packages, 'inittab')
  au BufNewFile,BufRead inittab setf inittab
endif

if !has_key(s:disabled_packages, 'fgl')
  au BufNewFile,BufRead *.4gh,*.4gl,*.m4gl setf fgl
endif

if !has_key(s:disabled_packages, 'ipfilter')
  au BufNewFile,BufRead ipf.conf,ipf.rules,ipf6.conf setf ipfilter
endif

if !has_key(s:disabled_packages, 'usw2kagtlog')
  au BufNewFile,BufRead *.usw2kagt.log\c,usw2kagt.*.log\c,usw2kagt.log\c setf usw2kagtlog
endif

if !has_key(s:disabled_packages, 'usserverlog')
  au BufNewFile,BufRead *.usserver.log\c,usserver.*.log\c,usserver.log\c setf usserverlog
endif

if !has_key(s:disabled_packages, 'upstreaminstalllog')
  au BufNewFile,BufRead *.upstreaminstall.log\c,upstreaminstall.*.log\c,upstreaminstall.log\c setf upstreaminstalllog
endif

if !has_key(s:disabled_packages, 'upstreamlog')
  au BufNewFile,BufRead *.upstream.log\c,UPSTREAM-*.log\c,fdrupstream.log,upstream.*.log\c,upstream.log\c setf upstreamlog
endif

if !has_key(s:disabled_packages, 'upstreamdat')
  au BufNewFile,BufRead *.upstream.dat\c,upstream.*.dat\c,upstream.dat\c setf upstreamdat
endif

if !has_key(s:disabled_packages, 'initng')
  au BufNewFile,BufRead *.ii,*/etc/initng/*/*.i setf initng
endif

if !has_key(s:disabled_packages, 'inform')
  au BufNewFile,BufRead *.INF,*.inf setf inform
endif

if !has_key(s:disabled_packages, 'indent')
  au BufNewFile,BufRead {.,}indent.pro,indentrc setf indent
endif

if !has_key(s:disabled_packages, 'icemenu')
  au BufNewFile,BufRead */.icewm/menu setf icemenu
endif

if !has_key(s:disabled_packages, 'msidl')
  au BufNewFile,BufRead *.mof,*.odl setf msidl
endif

if !has_key(s:disabled_packages, 'icon')
  au BufNewFile,BufRead *.icn setf icon
endif

if !has_key(s:disabled_packages, 'httest')
  au BufNewFile,BufRead *.htb,*.htt setf httest
endif

if !has_key(s:disabled_packages, 'hb')
  au BufNewFile,BufRead *.hb setf hb
endif

if !has_key(s:disabled_packages, 'hostsaccess')
  au BufNewFile,BufRead */etc/hosts.allow,*/etc/hosts.deny setf hostsaccess
endif

if !has_key(s:disabled_packages, 'hostconf')
  au BufNewFile,BufRead */etc/host.conf setf hostconf
endif

if !has_key(s:disabled_packages, 'template')
  au BufNewFile,BufRead *.tmpl setf template
endif

if !has_key(s:disabled_packages, 'htmlm4')
  au BufNewFile,BufRead *.html.m4 setf htmlm4
endif

if !has_key(s:disabled_packages, 'tilde')
  au BufNewFile,BufRead *.t.html setf tilde
endif

if !has_key(s:disabled_packages, 'html')
  au BufNewFile,BufRead,BufWritePost *.html call polyglot#detect#Html()
  au BufNewFile,BufRead *.htm,*.html.hl,*.inc,*.st,*.xht,*.xhtml setf html
endif

if !has_key(s:disabled_packages, 'hollywood')
  au BufNewFile,BufRead *.hws setf hollywood
endif

if !has_key(s:disabled_packages, 'hex')
  au BufNewFile,BufRead *.h32,*.hex setf hex
endif

if !has_key(s:disabled_packages, 'hercules')
  au BufNewFile,BufRead *.errsum,*.ev,*.sum,*.vc setf hercules
endif

if !has_key(s:disabled_packages, 'hastepreproc')
  au BufNewFile,BufRead *.htpp setf hastepreproc
endif

if !has_key(s:disabled_packages, 'haste')
  au BufNewFile,BufRead *.ht setf haste
endif

if !has_key(s:disabled_packages, 'chaskell')
  au BufNewFile,BufRead *.chs setf chaskell
endif

if !has_key(s:disabled_packages, 'lhaskell')
  au BufNewFile,BufRead *.lhs setf lhaskell
endif

if !has_key(s:disabled_packages, 'gtkrc')
  au BufNewFile,BufRead {.,}gtkrc,gtkrc setf gtkrc
  au BufNewFile,BufRead gtkrc* call s:StarSetf('gtkrc')
  au BufNewFile,BufRead .gtkrc* call s:StarSetf('gtkrc')
endif

if !has_key(s:disabled_packages, 'group')
  au BufNewFile,BufRead */etc/group,*/etc/group-,*/etc/group.edit,*/etc/gshadow,*/etc/gshadow-,*/etc/gshadow.edit,*/var/backups/group.bak,*/var/backups/gshadow.bak setf group
endif

if !has_key(s:disabled_packages, 'gsp')
  au BufNewFile,BufRead *.gsp setf gsp
endif

if !has_key(s:disabled_packages, 'gretl')
  au BufNewFile,BufRead *.gretl setf gretl
endif

if !has_key(s:disabled_packages, 'grads')
  au BufNewFile,BufRead *.gs setf grads
endif

if !has_key(s:disabled_packages, 'gitolite')
  au BufNewFile,BufRead gitolite.conf setf gitolite
  au BufNewFile,BufRead */gitolite-admin/conf/* call s:StarSetf('gitolite')
endif

if !has_key(s:disabled_packages, 'gnash')
  au BufNewFile,BufRead {.,}gnashpluginrc,{.,}gnashrc,gnashpluginrc,gnashrc setf gnash
endif

if !has_key(s:disabled_packages, 'gpg')
  au BufNewFile,BufRead */.gnupg/gpg.conf,*/.gnupg/options,*/usr/*/gnupg/options.skel setf gpg
endif

if !has_key(s:disabled_packages, 'gp')
  au BufNewFile,BufRead *.gp,{.,}gprc setf gp
endif

if !has_key(s:disabled_packages, 'gkrellmrc')
  au BufNewFile,BufRead gkrellmrc,gkrellmrc_? setf gkrellmrc
endif

if !has_key(s:disabled_packages, 'gedcom')
  au BufNewFile,BufRead *.ged,lltxxxxx.txt setf gedcom
  au BufNewFile,BufRead */tmp/lltmp* call s:StarSetf('gedcom')
endif

if !has_key(s:disabled_packages, 'gdmo')
  au BufNewFile,BufRead *.gdmo,*.mo setf gdmo
endif

if !has_key(s:disabled_packages, 'gdb')
  au BufNewFile,BufRead {.,}gdbinit setf gdb
endif

if !has_key(s:disabled_packages, 'fstab')
  au BufNewFile,BufRead fstab,mtab setf fstab
endif

if !has_key(s:disabled_packages, 'framescript')
  au BufNewFile,BufRead *.fsl setf framescript
endif

if !has_key(s:disabled_packages, 'fortran')
  au BufNewFile,BufRead *.f,*.f03,*.f08,*.f77,*.f90,*.f95,*.for,*.fortran,*.fpp,*.ftn setf fortran
endif

if !has_key(s:disabled_packages, 'reva')
  au BufNewFile,BufRead *.frt setf reva
endif

if !has_key(s:disabled_packages, 'focexec')
  au BufNewFile,BufRead *.fex,*.focexec setf focexec
endif

if !has_key(s:disabled_packages, 'fetchmail')
  au BufNewFile,BufRead {.,}fetchmailrc setf fetchmail
endif

if !has_key(s:disabled_packages, 'factor')
  au BufNewFile,BufRead *.factor setf factor
endif

if !has_key(s:disabled_packages, 'fan')
  au BufNewFile,BufRead *.fan,*.fwt setf fan
endif

if !has_key(s:disabled_packages, 'falcon')
  au BufNewFile,BufRead *.fal setf falcon
endif

if !has_key(s:disabled_packages, 'exports')
  au BufNewFile,BufRead exports setf exports
endif

if !has_key(s:disabled_packages, 'expect')
  au BufNewFile,BufRead *.exp setf expect
endif

if !has_key(s:disabled_packages, 'exim')
  au BufNewFile,BufRead exim.conf setf exim
endif

if !has_key(s:disabled_packages, 'csc')
  au BufNewFile,BufRead *.csc setf csc
endif

if !has_key(s:disabled_packages, 'esterel')
  au BufNewFile,BufRead *.strl setf esterel
endif

if !has_key(s:disabled_packages, 'esqlc')
  au BufNewFile,BufRead *.EC,*.ec setf esqlc
endif

if !has_key(s:disabled_packages, 'esmtprc')
  au BufNewFile,BufRead *esmtprc setf esmtprc
endif

if !has_key(s:disabled_packages, 'elmfilt')
  au BufNewFile,BufRead filter-rules setf elmfilt
endif

if !has_key(s:disabled_packages, 'elinks')
  au BufNewFile,BufRead elinks.conf setf elinks
endif

if !has_key(s:disabled_packages, 'ecd')
  au BufNewFile,BufRead *.ecd setf ecd
endif

if !has_key(s:disabled_packages, 'edif')
  au BufNewFile,BufRead *.ed\(f\|if\|o\) setf edif
endif

if !has_key(s:disabled_packages, 'dts')
  au BufNewFile,BufRead *.dts,*.dtsi setf dts
endif

if !has_key(s:disabled_packages, 'dtd')
  au BufNewFile,BufRead *.dtd setf dtd
endif

if !has_key(s:disabled_packages, 'dsl')
  au BufNewFile,BufRead *.dsl setf dsl
endif

if !has_key(s:disabled_packages, 'datascript')
  au BufNewFile,BufRead *.ds setf datascript
endif

if !has_key(s:disabled_packages, 'dracula')
  au BufNewFile,BufRead *.drac,*.drc,*lpe,*lvs setf dracula
  au BufNewFile,BufRead drac.* call s:StarSetf('dracula')
endif

if !has_key(s:disabled_packages, 'def')
  au BufNewFile,BufRead *.def setf def
endif

if !has_key(s:disabled_packages, 'dylan')
  au BufNewFile,BufRead *.dylan setf dylan
endif

if !has_key(s:disabled_packages, 'dylanintr')
  au BufNewFile,BufRead *.intr setf dylanintr
endif

if !has_key(s:disabled_packages, 'dylanlid')
  au BufNewFile,BufRead *.lid setf dylanlid
endif

if !has_key(s:disabled_packages, 'dot')
  au BufNewFile,BufRead *.dot,*.gv setf dot
endif

if !has_key(s:disabled_packages, 'dircolors')
  au BufNewFile,BufRead */etc/DIR_COLORS,{.,}dir_colors,{.,}dircolors setf dircolors
endif

if !has_key(s:disabled_packages, 'diff')
  au BufNewFile,BufRead *.diff,*.rej setf diff
endif

if !has_key(s:disabled_packages, 'dictdconf')
  au BufNewFile,BufRead dictd.conf setf dictdconf
endif

if !has_key(s:disabled_packages, 'dictconf')
  au BufNewFile,BufRead {.,}dictrc,dict.conf setf dictconf
endif

if !has_key(s:disabled_packages, 'desktop')
  au BufNewFile,BufRead *.desktop,*.directory setf desktop
endif

if !has_key(s:disabled_packages, 'desc')
  au BufNewFile,BufRead *.desc setf desc
endif

if !has_key(s:disabled_packages, 'dnsmasq')
  au BufNewFile,BufRead */etc/dnsmasq.conf setf dnsmasq
  au BufNewFile,BufRead */etc/dnsmasq.d/* call s:StarSetf('dnsmasq')
endif

if !has_key(s:disabled_packages, 'denyhosts')
  au BufNewFile,BufRead denyhosts.conf setf denyhosts
endif

if !has_key(s:disabled_packages, 'debsources')
  au BufNewFile,BufRead */etc/apt/sources.list,*/etc/apt/sources.list.d/*.list setf debsources
endif

if !has_key(s:disabled_packages, 'debcopyright')
  au BufNewFile,BufRead */debian/copyright setf debcopyright
endif

if !has_key(s:disabled_packages, 'debcontrol')
  au BufNewFile,BufRead */debian/control setf debcontrol
endif

if !has_key(s:disabled_packages, 'cuplsim')
  au BufNewFile,BufRead *.si setf cuplsim
endif

if !has_key(s:disabled_packages, 'cupl')
  au BufNewFile,BufRead *.pld setf cupl
endif

if !has_key(s:disabled_packages, 'csp')
  au BufNewFile,BufRead *.csp,*.fdr setf csp
endif

if !has_key(s:disabled_packages, 'quake')
  au BufNewFile,BufRead *baseq[2-3]/*.cfg,*id1/*.cfg,*quake[1-3]/*.cfg setf quake
endif

if !has_key(s:disabled_packages, 'lynx')
  au BufNewFile,BufRead lynx.cfg setf lynx
endif

if !has_key(s:disabled_packages, 'eterm')
  au BufNewFile,BufRead *Eterm/*.cfg setf eterm
endif

if !has_key(s:disabled_packages, 'dcd')
  au BufNewFile,BufRead *.dcd setf dcd
endif

if !has_key(s:disabled_packages, 'dockerfile')
  au BufNewFile,BufRead *.Dockerfile,*.dock,Containerfile,Dockerfile,dockerfile setf dockerfile
  au BufNewFile,BufRead Dockerfile* call s:StarSetf('dockerfile')
endif

if !has_key(s:disabled_packages, 'cuda')
  au BufNewFile,BufRead *.cu,*.cuh setf cuda
endif

if !has_key(s:disabled_packages, 'config')
  au BufNewFile,BufRead Pipfile,configure.ac,configure.in setf config
  au BufNewFile,BufRead /etc/hostname.* call s:StarSetf('config')
endif

if !has_key(s:disabled_packages, 'cf')
  au BufNewFile,BufRead *.cfc,*.cfi,*.cfm setf cf
endif

if !has_key(s:disabled_packages, 'coco')
  au BufNewFile,BufRead *.atg setf coco
endif

if !has_key(s:disabled_packages, 'cobol')
  au BufNewFile,BufRead *.cbl,*.cob,*.lib setf cobol
endif

if !has_key(s:disabled_packages, 'cmusrc')
  au BufNewFile,BufRead */.cmus/{autosave,rc,command-history,*.theme},*/cmus/{rc,*.theme} setf cmusrc
endif

if !has_key(s:disabled_packages, 'cl')
  au BufNewFile,BufRead *.eni setf cl
endif

if !has_key(s:disabled_packages, 'clean')
  au BufNewFile,BufRead *.dcl,*.icl setf clean
endif

if !has_key(s:disabled_packages, 'chordpro')
  au BufNewFile,BufRead *.cho,*.chopro,*.chordpro,*.crd,*.crdpro setf chordpro
endif

if !has_key(s:disabled_packages, 'chill')
  au BufNewFile,BufRead *..ch setf chill
endif

if !has_key(s:disabled_packages, 'debchangelog')
  au BufNewFile,BufRead */debian/changelog,NEWS.Debian,NEWS.dch,changelog.Debian,changelog.dch setf debchangelog
endif

if !has_key(s:disabled_packages, 'cterm')
  au BufNewFile,BufRead *.con setf cterm
endif

if !has_key(s:disabled_packages, 'css')
  au BufNewFile,BufRead *.css setf css
endif

if !has_key(s:disabled_packages, 'ch')
  au BufNewFile,BufRead *.chf setf ch
endif

if !has_key(s:disabled_packages, 'cynpp')
  au BufNewFile,BufRead *.cyn setf cynpp
endif

if !has_key(s:disabled_packages, 'crm')
  au BufNewFile,BufRead *.crm setf crm
endif

if !has_key(s:disabled_packages, 'conaryrecipe')
  au BufNewFile,BufRead *.recipe setf conaryrecipe
endif

if !has_key(s:disabled_packages, 'cdl')
  au BufNewFile,BufRead *.cdl setf cdl
endif

if !has_key(s:disabled_packages, 'chaiscript')
  au BufNewFile,BufRead *.chai setf chaiscript
endif

if !has_key(s:disabled_packages, 'cfengine')
  au BufNewFile,BufRead cfengine.conf setf cfengine
endif

if !has_key(s:disabled_packages, 'cdrdaoconf')
  au BufNewFile,BufRead */etc/cdrdao.conf,*/etc/default/cdrdao,*/etc/defaults/cdrdao,{.,}cdrdao setf cdrdaoconf
endif

if !has_key(s:disabled_packages, 'cdrtoc')
  au BufNewFile,BufRead *.toc setf cdrtoc
endif

if !has_key(s:disabled_packages, 'cabal')
  au BufNewFile,BufRead *.cabal setf cabal
endif

if !has_key(s:disabled_packages, 'csdl')
  au BufNewFile,BufRead *.csdl setf csdl
endif

if !has_key(s:disabled_packages, 'cs')
  au BufNewFile,BufRead *.cs setf cs
endif

if !has_key(s:disabled_packages, 'calendar')
  au BufNewFile,BufRead calendar setf calendar
  au BufNewFile,BufRead */share/calendar/calendar.* call s:StarSetf('calendar')
  au BufNewFile,BufRead */share/calendar/*/calendar.* call s:StarSetf('calendar')
  au BufNewFile,BufRead */.calendar/* call s:StarSetf('calendar')
endif

if !has_key(s:disabled_packages, 'lpc')
  au BufNewFile,BufRead *.lpc,*.ulpc setf lpc
endif

if !has_key(s:disabled_packages, 'bsdl')
  au BufNewFile,BufRead *.bsdl,*bsd setf bsdl
endif

if !has_key(s:disabled_packages, 'blank')
  au BufNewFile,BufRead *.bl setf blank
endif

if !has_key(s:disabled_packages, 'bindzone')
  au BufNewFile,BufRead named.root setf bindzone
  au BufNewFile,BufRead */named/db.* call s:StarSetf('bindzone')
  au BufNewFile,BufRead */bind/db.* call s:StarSetf('bindzone')
endif

if !has_key(s:disabled_packages, 'named')
  au BufNewFile,BufRead named*.conf,rndc*.conf,rndc*.key setf named
endif

if !has_key(s:disabled_packages, 'bst')
  au BufNewFile,BufRead *.bst setf bst
endif

if !has_key(s:disabled_packages, 'bib')
  au BufNewFile,BufRead *.bib setf bib
endif

if !has_key(s:disabled_packages, 'bdf')
  au BufNewFile,BufRead *.bdf setf bdf
endif

if !has_key(s:disabled_packages, 'bc')
  au BufNewFile,BufRead *.bc setf bc
endif

if !has_key(s:disabled_packages, 'dosbatch')
  au BufNewFile,BufRead *.bat,*.sys setf dosbatch
endif

if !has_key(s:disabled_packages, 'hamster')
  au BufNewFile,BufRead *.hsc,*.hsm setf hamster
endif

if !has_key(s:disabled_packages, 'freebasic')
  au BufNewFile,BufRead *.bi,*.fb setf freebasic
endif

if !has_key(s:disabled_packages, 'ibasic')
  au BufNewFile,BufRead *.iba,*.ibi setf ibasic
endif

if !has_key(s:disabled_packages, 'b')
  au BufNewFile,BufRead *.imp,*.mch,*.ref setf b
endif

if !has_key(s:disabled_packages, 'sql')
  au BufNewFile,BufRead *.bdy,*.ddl,*.fnc,*.pck,*.pkb,*.pks,*.plb,*.pls,*.plsql,*.prc,*.spc,*.sql,*.tpb,*.tps,*.trg,*.tyb,*.tyc,*.typ,*.vw setf sql
endif

if !has_key(s:disabled_packages, 'gitignore')
  au BufNewFile,BufRead *.git/info/exclude,*/.config/git/ignore,{.,}gitignore setf gitignore
endif

if !has_key(s:disabled_packages, 'tads')
  au BufNewFile,BufRead,BufWritePost *.t call polyglot#detect#T()
endif

if !has_key(s:disabled_packages, 'prolog')
  au BufNewFile,BufRead,BufWritePost *.pl call polyglot#detect#Pl()
  au BufNewFile,BufRead *.pdb,*.pro,*.prolog,*.yap setf prolog
endif

if !has_key(s:disabled_packages, 'bzl')
  au BufNewFile,BufRead *.BUILD,*.bazel,*.bzl,BUCK,BUILD,BUILD.bazel,Tiltfile,WORKSPACE setf bzl
endif

if !has_key(s:disabled_packages, 'odin')
  au BufNewFile,BufRead *.odin setf odin
endif

if !has_key(s:disabled_packages, 'dosini')
  au BufNewFile,BufRead *.dof,*.ini,*.lektorproject,*.prefs,*.pro,*.properties,*/etc/pacman.conf,*/etc/yum.conf,{.,}editorconfig,{.,}npmrc,buildozer.spec setf dosini
  au BufNewFile,BufRead php.ini-* call s:StarSetf('dosini')
  au BufNewFile,BufRead */etc/yum.repos.d/* call s:StarSetf('dosini')
endif

if !has_key(s:disabled_packages, 'spec')
  au BufNewFile,BufRead *.spec setf spec
endif

if !has_key(s:disabled_packages, 'visual-basic')
  au BufNewFile,BufRead,BufWritePost *.bas call polyglot#detect#Bas()
  au BufNewFile,BufRead *.cls,*.ctl,*.dsm,*.frm,*.frx,*.sba,*.vba,*.vbs setf vb
endif

if !has_key(s:disabled_packages, 'basic')
  au BufNewFile,BufRead *.basic setf basic
endif

if !has_key(s:disabled_packages, 'trasys')
  au BufNewFile,BufRead,BufWritePost *.inp call polyglot#detect#Inp()
endif

if !has_key(s:disabled_packages, 'zig')
  au BufNewFile,BufRead *.zir setf zir
  au BufNewFile,BufRead *.zig,*.zir setf zig
endif

if !has_key(s:disabled_packages, 'zephir')
  au BufNewFile,BufRead *.zep setf zephir
endif

if !has_key(s:disabled_packages, 'help')
  au BufNewFile,BufRead $VIMRUNTIME/doc/*.txt setf help
endif

if !has_key(s:disabled_packages, 'helm')
  au BufNewFile,BufRead */templates/*.tpl,*/templates/*.yaml setf helm
endif

if !has_key(s:disabled_packages, 'smarty')
  au BufNewFile,BufRead *.tpl setf smarty
endif

if !has_key(s:disabled_packages, 'ansible')
  au BufNewFile,BufRead handlers.*.y{a,}ml,local.y{a,}ml,main.y{a,}ml,playbook.y{a,}ml,requirements.y{a,}ml,roles.*.y{a,}ml,site.y{a,}ml,tasks.*.y{a,}ml setf yaml.ansible
  au BufNewFile,BufRead host_vars/* call s:StarSetf('yaml.ansible')
  au BufNewFile,BufRead group_vars/* call s:StarSetf('yaml.ansible')
endif

if !has_key(s:disabled_packages, 'xsl')
  au BufNewFile,BufRead *.xsl,*.xslt setf xsl
endif

if !has_key(s:disabled_packages, 'xdc')
  au BufNewFile,BufRead *.xdc setf xdc
endif

if !has_key(s:disabled_packages, 'vue')
  au BufNewFile,BufRead *.vue,*.wpy setf vue
endif

if !has_key(s:disabled_packages, 'vmasm')
  au BufNewFile,BufRead *.mar setf vmasm
endif

if !has_key(s:disabled_packages, 'velocity')
  au BufNewFile,BufRead *.vm setf velocity
endif

if !has_key(s:disabled_packages, 'vcl')
  au BufNewFile,BufRead *.vcl setf vcl
endif

if !has_key(s:disabled_packages, 'vbnet')
  au BufNewFile,BufRead *.vb,*.vbhtml setf vbnet
endif

if !has_key(s:disabled_packages, 'vala')
  au BufNewFile,BufRead *.vala,*.valadoc,*.vapi setf vala
endif

if !has_key(s:disabled_packages, 'v')
  au BufNewFile,BufRead *.v,*.vsh,*.vv setf vlang
endif

if !has_key(s:disabled_packages, 'unison')
  au BufNewFile,BufRead *.u,*.uu setf unison
endif

if !has_key(s:disabled_packages, 'typescript')
  au BufNewFile,BufRead *.ts setf typescript
  au BufNewFile,BufRead *.tsx setf typescriptreact
endif

if !has_key(s:disabled_packages, 'twig')
  au BufNewFile,BufRead *.twig setf html.twig
  au BufNewFile,BufRead *.xml.twig setf xml.twig
endif

if !has_key(s:disabled_packages, 'tptp')
  au BufNewFile,BufRead *.ax,*.p,*.tptp setf tptp
endif

if !has_key(s:disabled_packages, 'toml')
  au BufNewFile,BufRead *.toml,*/.cargo/config,*/.cargo/credentials,Cargo.lock,Gopkg.lock,Pipfile,poetry.lock setf toml
endif

if !has_key(s:disabled_packages, 'tmux')
  au BufNewFile,BufRead {.,}tmux*.conf setf tmux
endif

if !has_key(s:disabled_packages, 'thrift')
  au BufNewFile,BufRead *.thrift setf thrift
endif

if !has_key(s:disabled_packages, 'textile')
  au BufNewFile,BufRead *.textile setf textile
endif

if !has_key(s:disabled_packages, 'terraform')
  au BufNewFile,BufRead *.tf,*.tfvars setf terraform
endif

if !has_key(s:disabled_packages, 'tf')
  au BufNewFile,BufRead *.tf,{.,}tfrc,tfrc setf tf
endif

if !has_key(s:disabled_packages, 'systemd')
  au BufNewFile,BufRead *.automount,*.dnssd,*.link,*.mount,*.netdev,*.network,*.nspawn,*.path,*.service,*.slice,*.socket,*.swap,*.target,*.timer,*/systemd/*.conf setf systemd
  au BufNewFile,BufRead *.#* call s:StarSetf('systemd')
endif

if !has_key(s:disabled_packages, 'sxhkd')
  au BufNewFile,BufRead *.sxhkdrc,sxhkdrc setf sxhkdrc
endif

if !has_key(s:disabled_packages, 'swift')
  au BufNewFile,BufRead *.swift setf swift
endif

if !has_key(s:disabled_packages, 'svg')
  au BufNewFile,BufRead *.svg setf svg
endif

if !has_key(s:disabled_packages, 'svelte')
  au BufNewFile,BufRead *.svelte setf svelte
endif

if !has_key(s:disabled_packages, 'stylus')
  au BufNewFile,BufRead *.styl,*.stylus setf stylus
endif

if !has_key(s:disabled_packages, 'solidity')
  au BufNewFile,BufRead *.sol setf solidity
endif

if !has_key(s:disabled_packages, 'smt2')
  au BufNewFile,BufRead *.smt,*.smt2 setf smt2
endif

if !has_key(s:disabled_packages, 'slime')
  au BufNewFile,BufRead *.slime setf slime
endif

if !has_key(s:disabled_packages, 'slim')
  au BufNewFile,BufRead *.slim setf slim
endif

if !has_key(s:disabled_packages, 'sh')
  au BufNewFile,BufRead *.bash,*.bats,*.cgi,*.command,*.env,*.fcgi,*.ksh,*.sh,*.sh.in,*.tmux,*.tool,*/etc/udev/cdsymlinks.conf,{.,}bash_aliases,{.,}bash_history,{.,}bash_logout,{.,}bash_profile,{.,}bashrc,{.,}cshrc,{.,}env,{.,}env.example,{.,}flaskenv,{.,}login,{.,}profile,9fs,PKGBUILD,bash_aliases,bash_logout,bash_profile,bashrc,cshrc,gradlew,login,man,profile setf sh
  au BufNewFile,BufRead *.zsh,*/etc/zprofile,{.,}zfbfmarks,{.,}zlogin,{.,}zlogout,{.,}zprofile,{.,}zshenv,{.,}zshrc setf zsh
  au BufNewFile,BufRead .zsh* call s:StarSetf('zsh')
  au BufNewFile,BufRead .zlog* call s:StarSetf('zsh')
  au BufNewFile,BufRead .zcompdump* call s:StarSetf('zsh')
endif

if !has_key(s:disabled_packages, 'scss')
  au BufNewFile,BufRead *.scss setf scss
endif

if !has_key(s:disabled_packages, 'scala')
  au BufNewFile,BufRead *.kojo,*.sc,*.scala setf scala
endif

if !has_key(s:disabled_packages, 'rust')
  au BufNewFile,BufRead *.rs,*.rs.in setf rust
endif

if !has_key(s:disabled_packages, 'brewfile')
  au BufNewFile,BufRead Brewfile setf brewfile
endif

if !has_key(s:disabled_packages, 'rspec')
  au BufNewFile,BufRead *_spec.rb set ft=ruby syntax=rspec
endif

if !has_key(s:disabled_packages, 'ruby')
  au BufNewFile,BufRead *.axlsx,*.builder,*.cap,*.eye,*.fcgi,*.gemspec,*.god,*.jbuilder,*.mspec,*.opal,*.pluginspec,*.podspec,*.rabl,*.rake,*.rant,*.rb,*.rbi,*.rbuild,*.rbw,*.rbx,*.rjs,*.ru,*.ruby,*.rxml,*.spec,*.thor,*.watchr,{.,}Brewfile,{.,}Guardfile,{.,}autotest,{.,}irbrc,{.,}pryrc,{.,}simplecov,Appraisals,Berksfile,Buildfile,Capfile,Cheffile,Dangerfile,Deliverfile,Fastfile,Gemfile,Gemfile.lock,Guardfile,Jarfile,KitchenSink,Mavenfile,Podfile,Puppetfile,Rakefile,Routefile,Snapfile,Thorfile,Vagrantfile,[Rr]antfile,buildfile,vagrantfile setf ruby
  au BufNewFile,BufRead [Rr]akefile* call s:StarSetf('ruby')
  au BufNewFile,BufRead *.erb,*.erb.deface,*.rhtml setf eruby
endif

if !has_key(s:disabled_packages, 'rst')
  au BufNewFile,BufRead *.rest,*.rest.txt,*.rst,*.rst.txt setf rst
endif

if !has_key(s:disabled_packages, 'reason')
  au BufNewFile,BufRead,BufWritePost *.re call polyglot#detect#Re()
  au BufNewFile,BufRead *.rei setf reason
endif

if !has_key(s:disabled_packages, 'razor')
  au BufNewFile,BufRead *.cshtml,*.razor setf razor
endif

if !has_key(s:disabled_packages, 'raml')
  au BufNewFile,BufRead *.raml setf raml
endif

if !has_key(s:disabled_packages, 'raku')
  au BufNewFile,BufRead,BufWritePost *.t call polyglot#detect#T()
  au BufNewFile,BufRead,BufWritePost *.pm call polyglot#detect#Pm()
  au BufNewFile,BufRead,BufWritePost *.pl call polyglot#detect#Pl()
  au BufNewFile,BufRead *.6pl,*.6pm,*.nqp,*.p6,*.p6l,*.p6m,*.pl6,*.pm6,*.pod6,*.raku,*.rakudoc,*.rakumod,*.rakutest,*.t6 setf raku
endif

if !has_key(s:disabled_packages, 'ragel')
  au BufNewFile,BufRead *.rl setf ragel
endif

if !has_key(s:disabled_packages, 'racket')
  au BufNewFile,BufRead *.rkt,*.rktd,*.rktl,*.scrbl setf racket
endif

if !has_key(s:disabled_packages, 'r-lang')
  au BufNewFile,BufRead *.S,*.r,*.rsx,*.s,{.,}Rprofile,expr-dist setf r
  au BufNewFile,BufRead *.rd setf rhelp
endif

if !has_key(s:disabled_packages, 'qml')
  au BufNewFile,BufRead *.qbs,*.qml setf qml
endif

if !has_key(s:disabled_packages, 'qmake')
  au BufNewFile,BufRead *.pri,*.pro setf qmake
endif

if !has_key(s:disabled_packages, 'requirements')
  au BufNewFile,BufRead *.pip,*require.{txt,in},*requirements.{txt,in},constraints.{txt,in} setf requirements
endif

if !has_key(s:disabled_packages, 'python')
  au BufNewFile,BufRead *.cgi,*.fcgi,*.gyp,*.gypi,*.lmi,*.ptl,*.py,*.py3,*.pyde,*.pyi,*.pyp,*.pyt,*.pyw,*.rpy,*.smk,*.spec,*.tac,*.wsgi,*.xpy,{.,}gclient,{.,}pythonrc,{.,}pythonstartup,DEPS,SConscript,SConstruct,Snakefile,wscript setf python
endif

if !has_key(s:disabled_packages, 'purescript')
  au BufNewFile,BufRead *.purs setf purescript
endif

if !has_key(s:disabled_packages, 'puppet')
  au BufNewFile,BufRead *.pp,Modulefile setf puppet
  au BufNewFile,BufRead *.epp setf embeddedpuppet
endif

if !has_key(s:disabled_packages, 'pug')
  au BufNewFile,BufRead *.jade,*.pug setf pug
endif

if !has_key(s:disabled_packages, 'protobuf')
  au BufNewFile,BufRead *.proto setf proto
endif

if !has_key(s:disabled_packages, 'powershell')
  au BufNewFile,BufRead *.ps1,*.psd1,*.psm1,*.pssc setf ps1
  au BufNewFile,BufRead *.ps1xml setf ps1xml
endif

if !has_key(s:disabled_packages, 'pony')
  au BufNewFile,BufRead *.pony setf pony
endif

if !has_key(s:disabled_packages, 'plantuml')
  au BufNewFile,BufRead *.iuml,*.plantuml,*.pu,*.puml,*.uml setf plantuml
endif

if !has_key(s:disabled_packages, 'blade')
  au BufNewFile,BufRead *.blade,*.blade.php setf blade
endif

if !has_key(s:disabled_packages, 'php')
  au BufNewFile,BufRead *.aw,*.ctp,*.fcgi,*.inc,*.php,*.php3,*.php4,*.php5,*.php9,*.phps,*.phpt,*.phtml,{.,}php,{.,}php_cs,{.,}php_cs.dist,Phakefile setf php
endif

if !has_key(s:disabled_packages, 'cql')
  au BufNewFile,BufRead *.cql setf cql
endif

if !has_key(s:disabled_packages, 'pgsql')
  au BufNewFile,BufRead *.pgsql let b:sql_type_override='pgsql' | set ft=sql
endif

if !has_key(s:disabled_packages, 'perl')
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

if !has_key(s:disabled_packages, 'rc')
  au BufNewFile,BufRead *.rc,*.rch setf rc
endif

if !has_key(s:disabled_packages, 'opencl')
  au BufNewFile,BufRead *.cl,*.opencl setf opencl
endif

if !has_key(s:disabled_packages, 'octave')
  au BufNewFile,BufRead,BufWritePost *.m call polyglot#detect#M()
  au BufNewFile,BufRead *.oct setf octave
endif

if !has_key(s:disabled_packages, 'ocaml')
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

if !has_key(s:disabled_packages, 'objc')
  au BufNewFile,BufRead,BufWritePost *.m call polyglot#detect#M()
  au BufNewFile,BufRead,BufWritePost *.h call polyglot#detect#H()
endif

if !has_key(s:disabled_packages, 'nix')
  au BufNewFile,BufRead *.nix setf nix
endif

if !has_key(s:disabled_packages, 'nim')
  au BufNewFile,BufRead *.nim,*.nim.cfg,*.nimble,*.nimrod,*.nims,nim.cfg setf nim
endif

if !has_key(s:disabled_packages, 'nginx')
  au BufNewFile,BufRead *.nginx,*.nginxconf,*.vhost,*/nginx/*.conf,*nginx.conf,nginx*.conf,nginx.conf setf nginx
  au BufNewFile,BufRead */usr/local/nginx/conf/* call s:StarSetf('nginx')
  au BufNewFile,BufRead */etc/nginx/* call s:StarSetf('nginx')
endif

if !has_key(s:disabled_packages, 'murphi')
  au BufNewFile,BufRead,BufWritePost *.m call polyglot#detect#M()
endif

if !has_key(s:disabled_packages, 'moonscript')
  au BufNewFile,BufRead *.moon setf moon
endif

if !has_key(s:disabled_packages, 'meson')
  au BufNewFile,BufRead meson.build,meson_options.txt setf meson
  au BufNewFile,BufRead *.wrap setf dosini
endif

if !has_key(s:disabled_packages, 'mdx')
  au BufNewFile,BufRead *.mdx setf markdown.mdx
endif

if !has_key(s:disabled_packages, 'mathematica')
  au BufNewFile,BufRead,BufWritePost *.m call polyglot#detect#M()
  au BufNewFile,BufRead *.cdf,*.ma,*.mathematica,*.mma,*.mt,*.nb,*.nbp,*.wl,*.wls,*.wlt setf mma
endif

if !has_key(s:disabled_packages, 'mako')
  au BufNewFile,BufRead *.mako,*.mao setf mako
  au BufReadPre *.*.mao execute "do BufRead filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufNewFile *.*.mao execute "do BufNewFile filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufReadPre *.*.mako execute "do BufRead filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufNewFile *.*.mako execute "do BufNewFile filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
endif

if !has_key(s:disabled_packages, 'm4')
  au BufNewFile,BufRead *.at,*.m4 setf m4
endif

if !has_key(s:disabled_packages, 'lua')
  au BufNewFile,BufRead *.fcgi,*.lua,*.nse,*.p8,*.pd_lua,*.rbxs,*.rockspec,*.wlua,{.,}luacheckrc setf lua
endif

if !has_key(s:disabled_packages, 'log')
  au BufNewFile,BufRead *.LOG,*.log,*_LOG,*_log setf log
endif

if !has_key(s:disabled_packages, 'llvm')
  au BufNewFile,BufRead *.ll setf llvm
  au BufNewFile,BufRead *.td setf tablegen
endif

if !has_key(s:disabled_packages, 'livescript')
  au BufNewFile,BufRead *._ls,*.ls,Slakefile setf livescript
endif

if !has_key(s:disabled_packages, 'lilypond')
  au BufNewFile,BufRead *.ily,*.ly setf lilypond
endif

if !has_key(s:disabled_packages, 'less')
  au BufNewFile,BufRead *.less setf less
endif

if !has_key(s:disabled_packages, 'ledger')
  au BufNewFile,BufRead *.journal,*.ldg,*.ledger setf ledger
endif

if !has_key(s:disabled_packages, 'kotlin')
  au BufNewFile,BufRead *.kt,*.ktm,*.kts setf kotlin
endif

if !has_key(s:disabled_packages, 'julia')
  au BufNewFile,BufRead *.jl setf julia
endif

if !has_key(s:disabled_packages, 'jst')
  au BufNewFile,BufRead *.ect,*.ejs,*.jst setf jst
endif

if !has_key(s:disabled_packages, 'jsonnet')
  au BufNewFile,BufRead *.jsonnet,*.libsonnet setf jsonnet
endif

if !has_key(s:disabled_packages, 'json')
  au BufNewFile,BufRead *.JSON-tmLanguage,*.avsc,*.geojson,*.gltf,*.har,*.ice,*.json,*.jsonl,*.jsonp,*.mcmeta,*.template,*.tfstate,*.tfstate.backup,*.topojson,*.webapp,*.webmanifest,*.yy,*.yyp,{.,}arcconfig,{.,}htmlhintrc,{.,}tern-config,{.,}tern-project,{.,}watchmanconfig,Pipfile.lock,composer.lock,mcmod.info setf json
endif

if !has_key(s:disabled_packages, 'json5')
  au BufNewFile,BufRead *.json5 setf json5
endif

if !has_key(s:disabled_packages, 'jq')
  au BufNewFile,BufRead *.jq,{.,}jqrc setf jq
  au BufNewFile,BufRead .jqrc* call s:StarSetf('jq')
endif

if !has_key(s:disabled_packages, 'htmldjango')
  au BufNewFile,BufRead *.j2,*.jinja,*.jinja2,*.njk setf htmldjango
endif

if !has_key(s:disabled_packages, 'jenkins')
  au BufNewFile,BufRead *.Jenkinsfile,*.jenkinsfile,Jenkinsfile setf Jenkinsfile
  au BufNewFile,BufRead Jenkinsfile* call s:StarSetf('Jenkinsfile')
endif

if !has_key(s:disabled_packages, 'ion')
  au BufNewFile,BufRead *.ion,~/.config/ion/initrc setf ion
endif

if !has_key(s:disabled_packages, 'idris2')
  au BufNewFile,BufRead,BufWritePost *.idr call polyglot#detect#Idr()
  au BufNewFile,BufRead *.ipkg,idris-response setf idris2
  au BufNewFile,BufRead,BufWritePost *.lidr call polyglot#detect#Lidr()
endif

if !has_key(s:disabled_packages, 'idris')
  au BufNewFile,BufRead,BufWritePost *.lidr call polyglot#detect#Lidr()
  au BufNewFile,BufRead,BufWritePost *.idr call polyglot#detect#Idr()
  au BufNewFile,BufRead idris-response setf idris
endif

if !has_key(s:disabled_packages, 'icalendar')
  au BufNewFile,BufRead *.ics setf icalendar
endif

if !has_key(s:disabled_packages, 'i3')
  au BufNewFile,BufRead *.i3.config,*.i3config,{.,}i3.config,{.,}i3config,i3.config,i3config setf i3config
endif

if !has_key(s:disabled_packages, 'hive')
  au BufNewFile,BufRead *.hql,*.q,*.ql setf hive
endif

if !has_key(s:disabled_packages, 'hcl')
  au BufNewFile,BufRead *.hcl,*.nomad,*.workflow,Appfile setf hcl
endif

if !has_key(s:disabled_packages, 'haxe')
  au BufNewFile,BufRead *.hx,*.hxsl setf haxe
endif

if !has_key(s:disabled_packages, 'haskell')
  au BufNewFile,BufRead *.bpk,*.hs,*.hs-boot,*.hsc,*.hsig setf haskell
endif

if !has_key(s:disabled_packages, 'haproxy')
  au BufNewFile,BufRead haproxy*.conf* call s:StarSetf('haproxy')
  au BufNewFile,BufRead haproxy*.cfg* call s:StarSetf('haproxy')
endif

if !has_key(s:disabled_packages, 'handlebars')
  au BufNewFile,BufRead *.hjs,*.hogan,*.hulk,*.mustache setf html.mustache
  au BufNewFile,BufRead *.handlebars,*.hb,*.hbs,*.hdbs setf html.handlebars
endif

if !has_key(s:disabled_packages, 'haml')
  au BufNewFile,BufRead *.haml,*.haml.deface,*.hamlbars,*.hamlc setf haml
endif

if !has_key(s:disabled_packages, 'grub')
  au BufNewFile,BufRead */boot/grub/grub.conf,*/boot/grub/menu.lst,*/etc/grub.conf setf grub
endif

if !has_key(s:disabled_packages, 'groovy')
  au BufNewFile,BufRead *.gradle,*.groovy,*.grt,*.gtpl,*.gvy,Jenkinsfile setf groovy
endif

if !has_key(s:disabled_packages, 'graphql')
  au BufNewFile,BufRead *.gql,*.graphql,*.graphqls setf graphql
endif

if !has_key(s:disabled_packages, 'jsx')
  au BufNewFile,BufRead *.jsx setf javascriptreact
endif

if !has_key(s:disabled_packages, 'javascript')
  au BufNewFile,BufRead *._js,*.bones,*.cjs,*.es,*.es6,*.frag,*.gs,*.jake,*.javascript,*.js,*.jsb,*.jscad,*.jsfl,*.jsm,*.jss,*.mjs,*.njs,*.pac,*.sjs,*.ssjs,*.xsjs,*.xsjslib,Jakefile setf javascript
  au BufNewFile,BufRead *.flow setf flow
endif

if !has_key(s:disabled_packages, 'go')
  au BufNewFile,BufRead *.go setf go
  au BufNewFile,BufRead go.mod setf gomod
  au BufNewFile,BufRead *.tmpl setf gohtmltmpl
endif

if !has_key(s:disabled_packages, 'gnuplot')
  au BufNewFile,BufRead *.gnu,*.gnuplot,*.gp,*.gpi,*.p,*.plot,*.plt setf gnuplot
endif

if !has_key(s:disabled_packages, 'gmpl')
  au BufNewFile,BufRead *.mod setf gmpl
endif

if !has_key(s:disabled_packages, 'glsl')
  au BufNewFile,BufRead,BufWritePost *.fs call polyglot#detect#Fs()
  au BufNewFile,BufRead *.comp,*.fp,*.frag,*.frg,*.fsh,*.fshader,*.geo,*.geom,*.glsl,*.glslf,*.glslv,*.gs,*.gshader,*.shader,*.tesc,*.tese,*.vert,*.vrx,*.vsh,*.vshader setf glsl
endif

if !has_key(s:disabled_packages, 'git')
  au BufNewFile,BufRead *.gitconfig,*.git/config,*.git/modules/*/config,*/.config/git/config,*/git/config,{.,}gitconfig,{.,}gitmodules setf gitconfig
  au BufNewFile,BufRead */{.,}gitconfig.d/* call s:StarSetf('gitconfig')
  au BufNewFile,BufRead git-rebase-todo setf gitrebase
  au BufNewFile,BufRead .gitsendemail.* call s:StarSetf('gitsendemail')
  au BufNewFile,BufRead COMMIT_EDITMSG,MERGE_MSG,TAG_EDITMSG setf gitcommit
endif

if !has_key(s:disabled_packages, 'gdscript')
  au BufNewFile,BufRead *.gd setf gdscript3
endif

if !has_key(s:disabled_packages, 'fsharp')
  au BufNewFile,BufRead,BufWritePost *.fs call polyglot#detect#Fs()
  au BufNewFile,BufRead *.fsi,*.fsx setf fsharp
endif

if !has_key(s:disabled_packages, 'forth')
  au BufNewFile,BufRead,BufWritePost *.fs call polyglot#detect#Fs()
  au BufNewFile,BufRead *.ft,*.fth setf forth
endif

if !has_key(s:disabled_packages, 'flatbuffers')
  au BufNewFile,BufRead *.fbs setf fbs
endif

if !has_key(s:disabled_packages, 'fish')
  au BufNewFile,BufRead *.fish setf fish
endif

if !has_key(s:disabled_packages, 'ferm')
  au BufNewFile,BufRead *.ferm,ferm.conf setf ferm
endif

if !has_key(s:disabled_packages, 'fennel')
  au BufNewFile,BufRead *.fnl setf fennel
endif

if !has_key(s:disabled_packages, 'erlang')
  au BufNewFile,BufRead *.app,*.app.src,*.erl,*.es,*.escript,*.hrl,*.xrl,*.yaws,*.yrl,Emakefile,rebar.config,rebar.config.lock,rebar.lock setf erlang
endif

if !has_key(s:disabled_packages, 'emblem')
  au BufNewFile,BufRead *.em,*.emblem setf emblem
endif

if !has_key(s:disabled_packages, 'emberscript')
  au BufNewFile,BufRead *.em,*.emberscript setf ember-script
endif

if !has_key(s:disabled_packages, 'elm')
  au BufNewFile,BufRead *.elm setf elm
endif

if !has_key(s:disabled_packages, 'elixir')
  au BufNewFile,BufRead *.ex,*.exs,mix.lock setf elixir
  au BufNewFile,BufRead *.eex,*.leex setf eelixir
endif

if !has_key(s:disabled_packages, 'docker-compose')
  au BufNewFile,BufRead docker-compose*.yaml,docker-compose*.yml setf yaml.docker-compose
endif

if !has_key(s:disabled_packages, 'yaml')
  au BufNewFile,BufRead *.mir,*.reek,*.rviz,*.sublime-syntax,*.syntax,*.yaml,*.yaml-tmlanguage,*.yaml.sed,*.yml,*.yml.mysql,{.,}clang-format,{.,}clang-tidy,{.,}gemrc,fish_history,fish_read_history,glide.lock,yarn.lock setf yaml
endif

if !has_key(s:disabled_packages, 'mysql')
  au BufNewFile,BufRead *.mysql setf mysql
endif

if !has_key(s:disabled_packages, 'sed')
  au BufNewFile,BufRead *.sed setf sed
endif

if !has_key(s:disabled_packages, 'dlang')
  au BufNewFile,BufRead *.d,*.di setf d
  au BufNewFile,BufRead *.lst setf dcov
  au BufNewFile,BufRead *.dd setf dd
  au BufNewFile,BufRead *.ddoc setf ddoc
  au BufNewFile,BufRead *.sdl setf dsdl
endif

if !has_key(s:disabled_packages, 'dhall')
  au BufNewFile,BufRead *.dhall setf dhall
endif

if !has_key(s:disabled_packages, 'dart')
  au BufNewFile,BufRead *.dart,*.drt setf dart
endif

if !has_key(s:disabled_packages, 'cue')
  au BufNewFile,BufRead *.cue setf cuesheet
endif

if !has_key(s:disabled_packages, 'cucumber')
  au BufNewFile,BufRead *.feature,*.story setf cucumber
endif

if !has_key(s:disabled_packages, 'crystal')
  au BufNewFile,BufRead *.cr,Projectfile setf crystal
  au BufNewFile,BufRead *.ecr setf ecrystal
endif

if !has_key(s:disabled_packages, 'cryptol')
  au BufNewFile,BufRead *.cry,*.cyl,*.lcry,*.lcyl setf cryptol
endif

if !has_key(s:disabled_packages, 'coffee-script')
  au BufNewFile,BufRead *._coffee,*.cake,*.cjsx,*.coffee,*.coffeekup,*.iced,Cakefile setf coffee
  au BufNewFile,BufRead *.coffee.md,*.litcoffee setf litcoffee
endif

if !has_key(s:disabled_packages, 'markdown')
  au BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mdwn,*.mkd,*.mkdn,*.mkdown,*.ronn,*.workbook,contents.lr setf markdown
endif

if !has_key(s:disabled_packages, 'cmake')
  au BufNewFile,BufRead *.cmake,*.cmake.in,CMakeLists.txt setf cmake
endif

if !has_key(s:disabled_packages, 'clojure')
  au BufNewFile,BufRead *.boot,*.cl2,*.clj,*.cljc,*.cljs,*.cljs.hl,*.cljscm,*.cljx,*.edn,*.hic,build.boot,profile.boot,riemann.config setf clojure
endif

if !has_key(s:disabled_packages, 'carp')
  au BufNewFile,BufRead *.carp setf carp
endif

if !has_key(s:disabled_packages, 'caddyfile')
  au BufNewFile,BufRead Caddyfile setf caddyfile
endif

if !has_key(s:disabled_packages, 'awk')
  au BufNewFile,BufRead *.awk,*.gawk setf awk
endif

if !has_key(s:disabled_packages, 'ave')
  au BufNewFile,BufRead *.ave setf ave
endif

if !has_key(s:disabled_packages, 'autoit')
  au BufNewFile,BufRead *.au3 setf autoit
endif

if !has_key(s:disabled_packages, 'atlas')
  au BufNewFile,BufRead *.as,*.atl setf atlas
endif

if !has_key(s:disabled_packages, 'aspperl')
  au BufNewFile,BufRead,BufWritePost *.asp call polyglot#detect#Asp()
endif

if !has_key(s:disabled_packages, 'aspvbs')
  au BufNewFile,BufRead,BufWritePost *.asp call polyglot#detect#Asp()
  au BufNewFile,BufRead,BufWritePost *.asa call polyglot#detect#Asa()
endif

if !has_key(s:disabled_packages, 'asn')
  au BufNewFile,BufRead *.asn,*.asn1 setf asn
endif

if !has_key(s:disabled_packages, 'automake')
  au BufNewFile,BufRead GNUmakefile.am,[mM]akefile.am setf automake
endif

if !has_key(s:disabled_packages, 'elf')
  au BufNewFile,BufRead *.am setf elf
endif

if !has_key(s:disabled_packages, 'make')
  au BufNewFile,BufRead *.dsp,*.mak,*.mk,*[mM]akefile setf make
endif

if !has_key(s:disabled_packages, 'autohotkey')
  au BufNewFile,BufRead *.ahk,*.ahkl setf autohotkey
endif

if !has_key(s:disabled_packages, 'asciidoc')
  au BufNewFile,BufRead *.adoc,*.asc,*.asciidoc setf asciidoc
endif

if !has_key(s:disabled_packages, 'art')
  au BufNewFile,BufRead *.art setf art
endif

if !has_key(s:disabled_packages, 'arduino')
  au BufNewFile,BufRead *.ino,*.pde setf arduino
endif

if !has_key(s:disabled_packages, 'c/c++')
  au BufNewFile,BufRead,BufWritePost *.h call polyglot#detect#H()
  au BufNewFile,BufRead *.c++,*.cc,*.cp,*.cpp,*.cxx,*.h++,*.hh,*.hpp,*.hxx,*.inc,*.inl,*.ipp,*.moc,*.tcc,*.tlh,*.tpp setf cpp
  au BufNewFile,BufRead,BufWritePost *.h call polyglot#detect#H()
  au BufNewFile,BufRead *.c,*.cats,*.idc,*.qc,*enlightenment/*.cfg setf c
endif

if !has_key(s:disabled_packages, 'arch')
  au BufNewFile,BufRead {.,}arch-inventory,=tagging-method setf arch
endif

if !has_key(s:disabled_packages, 'aptconf')
  au BufNewFile,BufRead */.aptitude/config,*/etc/apt/apt.conf.d/*.conf,apt.conf setf aptconf
  au BufNewFile,BufRead */etc/apt/apt.conf.d/[^.]* call s:StarSetf('aptconf')
endif

if !has_key(s:disabled_packages, 'applescript')
  au BufNewFile,BufRead *.applescript,*.scpt setf applescript
endif

if !has_key(s:disabled_packages, 'apiblueprint')
  au BufNewFile,BufRead *.apib setf apiblueprint
endif

if !has_key(s:disabled_packages, 'apache')
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

if !has_key(s:disabled_packages, 'ant')
  au BufNewFile,BufRead build.xml setf ant
endif

if !has_key(s:disabled_packages, 'xml')
  au BufNewFile,BufRead *.adml,*.admx,*.ant,*.axml,*.builds,*.ccproj,*.ccxml,*.cdxml,*.clixml,*.cproject,*.cscfg,*.csdef,*.csl,*.csproj,*.csproj.user,*.ct,*.depproj,*.dita,*.ditamap,*.ditaval,*.dll.config,*.dotsettings,*.filters,*.fsproj,*.fxml,*.glade,*.gml,*.gmx,*.grxml,*.gst,*.iml,*.ivy,*.jelly,*.jsproj,*.kml,*.launch,*.mdpolicy,*.mjml,*.mm,*.mod,*.mxml,*.natvis,*.ncl,*.ndproj,*.nproj,*.nuspec,*.odd,*.osm,*.pkgproj,*.pluginspec,*.proj,*.props,*.psc1,*.pt,*.rdf,*.resx,*.rss,*.sch,*.scxml,*.sfproj,*.shproj,*.srdf,*.storyboard,*.sublime-snippet,*.targets,*.tml,*.tpm,*.ui,*.urdf,*.ux,*.vbproj,*.vcxproj,*.vsixmanifest,*.vssettings,*.vstemplate,*.vxml,*.wixproj,*.workflow,*.wpl,*.wsdl,*.wsf,*.wxi,*.wxl,*.wxs,*.x3d,*.xacro,*.xaml,*.xib,*.xlf,*.xliff,*.xmi,*.xml,*.xml.dist,*.xproj,*.xsd,*.xspec,*.xul,*.zcml,*/etc/blkid.tab,*/etc/blkid.tab.old,*/etc/xdg/menus/*.menu,*fglrxrc,{.,}classpath,{.,}cproject,{.,}project,App.config,NuGet.config,Settings.StyleCop,Web.Debug.config,Web.Release.config,Web.config,packages.config setf xml
endif

if !has_key(s:disabled_packages, 'csv')
  au BufNewFile,BufRead *.csv,*.tab,*.tsv setf csv
endif

if !has_key(s:disabled_packages, 'ampl')
  " AMPL
  au BufNewFile,BufRead *.run setf ampl
endif

if !has_key(s:disabled_packages, 'aml')
  au BufNewFile,BufRead *.aml setf aml
endif

if !has_key(s:disabled_packages, 'alsaconf')
  au BufNewFile,BufRead */etc/asound.conf,*/usr/share/alsa/alsa.conf,{.,}asoundrc setf alsaconf
endif

if !has_key(s:disabled_packages, 'conf')
  au BufNewFile,BufRead *.conf,auto.master,config setf conf
endif

if !has_key(s:disabled_packages, 'master')
  au BufNewFile,BufRead *.mas,*.master setf master
endif

if !has_key(s:disabled_packages, 'aidl')
  " AIDL
  au BufNewFile,BufRead *.aidl setf aidl
endif

if !has_key(s:disabled_packages, 'ahdl')
  " AHDL
  au BufNewFile,BufRead *.tdf setf ahdl
endif

if !has_key(s:disabled_packages, 'ada')
  " Ada (83, 9X, 95)
  au BufNewFile,BufRead *.ada,*.ada_m,*.adb,*.adc,*.ads,*.gpr setf ada
endif

if !has_key(s:disabled_packages, 'acpiasl')
  au BufNewFile,BufRead *.asl,*.dsl setf asl
endif

if !has_key(s:disabled_packages, 'acedb')
  " AceDB
  au BufNewFile,BufRead *.wrm setf acedb
endif

if !has_key(s:disabled_packages, 'abel')
  " ABEL
  au BufNewFile,BufRead *.abl setf abel
endif

if !has_key(s:disabled_packages, 'abc')
  " ABC music notation
  au BufNewFile,BufRead *.abc setf abc
endif

if !has_key(s:disabled_packages, 'abaqus')
  au BufNewFile,BufRead,BufWritePost *.inp call polyglot#detect#Inp()
endif

if !has_key(s:disabled_packages, 'abap')
  " ABAB/4
  au BufNewFile,BufRead *.abap setf abap
endif

if !has_key(s:disabled_packages, 'aap')
  " A-A-P recipe
  au BufNewFile,BufRead *.aap setf aap
endif

if !has_key(s:disabled_packages, 'a65')
  " XA65 MOS6510 cross assembler
  au BufNewFile,BufRead *.a65 setf a65
endif

if !has_key(s:disabled_packages, 'a2ps')
  au BufNewFile,BufRead */etc/a2ps.cfg,*/etc/a2ps/*.cfg,{.,}a2psrc,a2psrc setf a2ps
endif

if !has_key(s:disabled_packages, 'cfg')
  au BufNewFile,BufRead *.cfg,*.hgrc,*hgrc setf cfg
endif

if !has_key(s:disabled_packages, '8th')
  " 8th (Firth-derivative)
  au BufNewFile,BufRead *.8th setf 8th
endif


" DO NOT EDIT CODE ABOVE, IT IS GENERATED WITH MAKEFILE

au! BufNewFile,BufRead,StdinReadPost * if expand("<afile>:e") == "" |
  \ call polyglot#shebang#Detect() | endif

au BufEnter * if &ft == "" && expand("<afile>:e") == ""  |
  \ call s:Observe('shebang#Detect') | endif

augroup END


if !has_key(s:disabled_packages, 'autoindent')
  " Code below re-implements sleuth for vim-polyglot
  let g:loaded_sleuth = 1

  function! s:guess(lines) abort
    let options = {}
    let ccomment = 0
    let podcomment = 0
    let triplequote = 0
    let backtick = 0
    let xmlcomment = 0
    let heredoc = ''
    let minindent = 10
    let spaces_minus_tabs = 0
    let i = 0

    for line in a:lines
      let i += 1

      if !len(line) || line =~# '^\S+$'
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

      let spaces_minus_tabs += line[0] == "\t" ? 1 : -1

      if line[0] == "\t"
        setlocal noexpandtab
        let &l:shiftwidth=&tabstop
        let b:sleuth_culprit .= ':' . i
        return 1
      elseif line[0] == " "
        let indent = len(matchstr(line, '^ *'))
        if indent < minindent && index([2, 3, 4, 6, 8], indent) >= 0
          let minindent = indent
        endif
      endif
    endfor

    if minindent < 10
      setlocal expandtab
      let &l:shiftwidth=minindent
      if &tabstop == 8
        let &l:tabstop=minindent
      endif
      let b:sleuth_culprit .= ':' . i
      return 1
    endif

    return 0
  endfunction

  function! s:detect_indent() abort
    if &buftype ==# 'help'
      return
    endif

    if &expandtab
      " Make tabstop to be synchronized with shiftwidth by default
      " Some plugins are using &shiftwidth directly or accessing &tabstop
      if &tabstop != 8 || &shiftwidth == 0
        let &shiftwidth = &tabstop
      else
        let &tabstop = &shiftwidth
      endif
    endif

    let b:sleuth_culprit = expand("<afile>:p")
    for line_length in g:polyglot_autoindent_guess_lines
      if s:guess(getline(1, line_length))
        return
      endif
    endfor
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

    unlet b:sleuth_culprit
  endfunction

  set smarttab

  function! SleuthIndicator() abort
    let sw = &shiftwidth ? &shiftwidth : &tabstop
    if &expandtab
      return 'sw='.sw
    elseif &tabstop == sw
      return 'ts='.&tabstop
    else
      return 'sw='.sw.',ts='.&tabstop
    endif
  endfunction

  augroup polyglot-sleuth
    au!
    au BufEnter * call s:detect_indent()
    au User Flags call Hoist('buffer', 5, 'SleuthIndicator')
  augroup END

  command! -bar -bang Sleuth call s:detect_indent()
endif

func! s:verify()
  if exists("g:polyglot_disabled_not_set")
    if exists("g:polyglot_disabled")
      echohl WarningMsg
      echo "vim-polyglot: g:polyglot_disabled should be defined before loading vim-polyglot"
      echohl None
    endif

    unlet g:polyglot_disabled_not_set
  endif
endfunc

au VimEnter * call s:verify()

" Save polyglot_disabled without postfixes
if exists('g:polyglot_disabled')
  let g:polyglot_disabled = s:new_polyglot_disabled
endif

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
" detected filetypes.
if exists("did_load_filetypes") && exists("g:polyglot_disabled")
  unlet did_load_filetypes
  runtime! extras/filetype.vim
endif

" Restore 'cpoptions'
let &cpo = s:cpo_save
unlet s:cpo_save
