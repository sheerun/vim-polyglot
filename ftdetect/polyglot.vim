" don't spam the user when Vim is started in Vi compatibility mode
let s:cpo_save = &cpo
set cpo&vim

" Disable all native vim ftdetect
if exists('g:polyglot_test')
  autocmd!
endif

let s:disabled_packages = {}

if exists('g:polyglot_disabled')
  for pkg in g:polyglot_disabled
    let s:disabled_packages[pkg] = 1
  endfor
else
  let g:polyglot_disabled_not_set = 1
endif

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
  if expand("<amatch>") !~ g:ft_ignore_pat && &filetype !~# '\<'.a:ft.'\>'
    let &filetype = a:ft
  endif
endfunc

augroup filetypedetect

au! filetypedetect BufRead,BufNewFile,StdinReadPost *

" filetypes

if !has_key(s:disabled_packages, '8th')
  au! BufRead,BufNewFile *.8th
endif

if !has_key(s:disabled_packages, 'haproxy')
  au! BufRead,BufNewFile *.cfg
endif

if !has_key(s:disabled_packages, 'a2ps')
  au! BufRead,BufNewFile */etc/a2ps.cfg,*/etc/a2ps/*.cfg,a2psrc,.a2psrc
endif

if !has_key(s:disabled_packages, 'a65')
  au! BufRead,BufNewFile *.a65
endif

if !has_key(s:disabled_packages, 'aap')
  au! BufRead,BufNewFile *.aap
endif

if !has_key(s:disabled_packages, 'abap')
  au! BufRead,BufNewFile *.abap
endif

if !has_key(s:disabled_packages, 'abc')
  au! BufRead,BufNewFile *.abc
endif

if !has_key(s:disabled_packages, 'abel')
  au! BufRead,BufNewFile *.abl
endif

if !has_key(s:disabled_packages, 'acedb')
  au! BufRead,BufNewFile *.wrm
endif

if !has_key(s:disabled_packages, 'acpiasl')
  au! BufRead,BufNewFile *.dsl
endif

if !has_key(s:disabled_packages, 'ada')
  au! BufRead,BufNewFile *.adb,*.ads,*.ada,*.adc,*.gpr,*.ada_m
endif

if !has_key(s:disabled_packages, 'ahdl')
  au! BufRead,BufNewFile *.tdf
endif

if !has_key(s:disabled_packages, 'aidl')
  au! BufRead,BufNewFile *.aidl
endif

if !has_key(s:disabled_packages, 'alsaconf')
  au! BufRead,BufNewFile .asoundrc,*/usr/share/alsa/alsa.conf,*/etc/asound.conf
endif

if !has_key(s:disabled_packages, 'aml')
  au! BufRead,BufNewFile *.aml
endif

if !has_key(s:disabled_packages, 'ampl')
  au! BufRead,BufNewFile *.run
endif

if !has_key(s:disabled_packages, 'xml')
  au! BufRead,BufNewFile *.csproj,*.ui,*.wsdl,*.wsf,*.xlf,*.xliff,*.xmi,*.xsd,*.xul
endif

if !has_key(s:disabled_packages, 'ant')
  au! BufRead,BufNewFile build.xml
endif

if !has_key(s:disabled_packages, 'apache')
  au! BufRead,BufNewFile .htaccess,*/etc/httpd/*.conf,*/etc/apache2/sites-*/*.com,access.conf*,apache.conf*,apache2.conf*,httpd.conf*,srm.conf*,*/etc/apache2/*.conf*,*/etc/apache2/conf.*/*,*/etc/apache2/mods-*/*,*/etc/apache2/sites-*/*,*/etc/httpd/conf.d/*.conf*
endif

if !has_key(s:disabled_packages, 'applescript')
  au! BufRead,BufNewFile *.scpt
endif

if !has_key(s:disabled_packages, 'aptconf')
  au! BufRead,BufNewFile apt.conf,*/.aptitude/config
endif

if !has_key(s:disabled_packages, 'arch')
  au! BufRead,BufNewFile .arch-inventory,=tagging-method
endif

if !has_key(s:disabled_packages, 'c/c++')
  au! BufRead,BufNewFile *.cpp,*.c++,*.cc,*.cxx,*.hh,*.hpp,*.hxx,*.inl,*.ipp,*.tcc,*.tpp,*.moc,*.tlh,*.qc,*enlightenment/*.cfg
endif

if !has_key(s:disabled_packages, 'arduino')
  au! BufRead,BufNewFile *.pde,*.ino
endif

if !has_key(s:disabled_packages, 'art')
  au! BufRead,BufNewFile *.art
endif

if !has_key(s:disabled_packages, 'asciidoc')
  au! BufRead,BufNewFile *.asciidoc,*.adoc
endif

if !has_key(s:disabled_packages, 'autohotkey')
  au! BufRead,BufNewFile *.ahk
endif

if !has_key(s:disabled_packages, 'elf')
  au! BufRead,BufNewFile *.am
endif

if !has_key(s:disabled_packages, 'automake')
  au! BufRead,BufNewFile GNUmakefile.am
endif

if !has_key(s:disabled_packages, 'asn')
  au! BufRead,BufNewFile *.asn,*.asn1
endif

if !has_key(s:disabled_packages, 'atlas')
  au! BufRead,BufNewFile *.atl,*.as
endif

if !has_key(s:disabled_packages, 'autoit')
  au! BufRead,BufNewFile *.au3
endif

if !has_key(s:disabled_packages, 'ave')
  au! BufRead,BufNewFile *.ave
endif

if !has_key(s:disabled_packages, 'awk')
  au! BufRead,BufNewFile *.awk,*.gawk
endif

if !has_key(s:disabled_packages, 'clojure')
  au! BufRead,BufNewFile *.clj,*.cljc,*.cljs,*.cljx
endif

if !has_key(s:disabled_packages, 'cmake')
  au! BufRead,BufNewFile *.cmake,*.cmake.in,CMakeLists.txt
endif

if !has_key(s:disabled_packages, 'cucumber')
  au! BufRead,BufNewFile *.feature
endif

if !has_key(s:disabled_packages, 'dart')
  au! BufRead,BufNewFile *.dart,*.drt
endif

if !has_key(s:disabled_packages, 'dlang')
  au! BufRead,BufNewFile *.sdl
endif

if !has_key(s:disabled_packages, 'dockerfile')
  au! BufRead,BufNewFile *.Dockerfile,Dockerfile
endif

if !has_key(s:disabled_packages, 'elm')
  au! BufRead,BufNewFile *.elm
endif

if !has_key(s:disabled_packages, 'erlang')
  au! BufRead,BufNewFile *.erl,*.es,*.hrl,*.yaws
endif

if !has_key(s:disabled_packages, 'forth')
  au! BufRead,BufNewFile *.fs,*.ft,*.fth
endif

if !has_key(s:disabled_packages, 'glsl')
  au! BufRead,BufNewFile *.fs,*.gs,*.comp
endif

if !has_key(s:disabled_packages, 'fsharp')
  au! BufRead,BufNewFile *.fs
endif

if !has_key(s:disabled_packages, 'git')
  au! BufRead,BufNewFile .gitconfig,.gitmodules,*.git/config,*/.config/git/config,*.git/modules/*/config,git-rebase-todo
endif

if !has_key(s:disabled_packages, 'gnuplot')
  au! BufRead,BufNewFile *.gp,*.gpi
endif

if !has_key(s:disabled_packages, 'go')
  au! BufRead,BufNewFile *.go,*.tmpl
endif

if !has_key(s:disabled_packages, 'javascript')
  au! BufRead,BufNewFile *.js,*.cjs,*.es,*.gs,*.mjs,*.pac
endif

if !has_key(s:disabled_packages, 'jsx')
  au! BufRead,BufNewFile *.jsx
endif

if !has_key(s:disabled_packages, 'groovy')
  au! BufRead,BufNewFile *.groovy,*.gradle
endif

if !has_key(s:disabled_packages, 'grub')
  au! BufRead,BufNewFile */boot/grub/menu.lst,*/boot/grub/grub.conf,*/etc/grub.conf
endif

if !has_key(s:disabled_packages, 'haml')
  au! BufRead,BufNewFile *.haml
endif

if !has_key(s:disabled_packages, 'handlebars')
  au! BufRead,BufNewFile *.hb
endif

if !has_key(s:disabled_packages, 'haskell')
  au! BufRead,BufNewFile *.hs,*.hs-boot,*.hsc
endif

if !has_key(s:disabled_packages, 'html5')
  au! BufRead,BufNewFile *.st,*.xht,*.xhtml
endif

if !has_key(s:disabled_packages, 'json')
  au! BufRead,BufNewFile *.json,*.ice,*.webmanifest,*.yy,*.jsonp,Pipfile.lock
endif

if !has_key(s:disabled_packages, 'kotlin')
  au! BufRead,BufNewFile *.kt,*.ktm,*.kts
endif

if !has_key(s:disabled_packages, 'less')
  au! BufRead,BufNewFile *.less
endif

if !has_key(s:disabled_packages, 'llvm')
  au! BufRead,BufNewFile *.ll
endif

if !has_key(s:disabled_packages, 'lua')
  au! BufRead,BufNewFile *.lua,*.nse,*.rockspec
endif

if !has_key(s:disabled_packages, 'm4')
  au! BufRead,BufNewFile *.m4,*.at
endif

if !has_key(s:disabled_packages, 'mathematica')
  au! BufRead,BufNewFile *.cdf,*.nb
endif

if !has_key(s:disabled_packages, 'markdown')
  au! BufRead,BufNewFile *.md,*.markdown,*.mdown,*.mdwn,*.mkd,*.mkdn
endif

if !has_key(s:disabled_packages, 'meson')
  au! BufRead,BufNewFile meson.build,meson_options.txt
endif

if !has_key(s:disabled_packages, 'ocaml')
  au! BufRead,BufNewFile *.ml,*.mli,*.mll,*.mly,.ocamlinit
endif

if !has_key(s:disabled_packages, 'opencl')
  au! BufRead,BufNewFile *.cl
endif

if !has_key(s:disabled_packages, 'perl')
  au! BufRead,BufNewFile *.al,*.plx,*.psgi,*.t,*.pod,*.mason,*.mhtml,*.comp,*.xs
endif

if !has_key(s:disabled_packages, 'php')
  au! BufRead,BufNewFile *.php,*.ctp
endif

if !has_key(s:disabled_packages, 'protobuf')
  au! BufRead,BufNewFile *.proto
endif

if !has_key(s:disabled_packages, 'python')
  au! BufRead,BufNewFile *.py,*.pyi,*.pyw,*.spec,SConstruct
endif

if !has_key(s:disabled_packages, 'r-lang')
  au! BufRead,BufNewFile *.s,*.S,*.rd
endif

if !has_key(s:disabled_packages, 'racket')
  au! BufRead,BufNewFile *.rkt
endif

if !has_key(s:disabled_packages, 'raku')
  au! BufRead,BufNewFile *.p6,*.pl6,*.pm6,*.t,*.raku,*.rakumod,*.pod6
endif

if !has_key(s:disabled_packages, 'raml')
  au! BufRead,BufNewFile *.raml
endif

if !has_key(s:disabled_packages, 'rst')
  au! BufRead,BufNewFile *.rst
endif

if !has_key(s:disabled_packages, 'ruby')
  au! BufRead,BufNewFile *.rb,*.builder,*.gemspec,*.rake,*.rbw,*.ru,*.spec,*.rxml,*.rjs,*.rant,.irbrc,Gemfile,Rakefile,Rantfile,*.erb,*.rhtml
endif

if !has_key(s:disabled_packages, 'rust')
  au! BufRead,BufNewFile *.rs
endif

if !has_key(s:disabled_packages, 'scala')
  au! BufRead,BufNewFile *.scala
endif

if !has_key(s:disabled_packages, 'sbt')
  au! BufRead,BufNewFile *.sbt
endif

if !has_key(s:disabled_packages, 'scss')
  au! BufRead,BufNewFile *.scss
endif

if !has_key(s:disabled_packages, 'sh')
  au! BufRead,BufNewFile *.zsh,.zshrc,.zshenv,.zlogin,.zprofile,.zlogout
endif

if !has_key(s:disabled_packages, 'smt2')
  au! BufRead,BufNewFile *.smt
endif

if !has_key(s:disabled_packages, 'svg')
  au! BufRead,BufNewFile *.svg
endif

if !has_key(s:disabled_packages, 'swift')
  au! BufRead,BufNewFile *.swift
endif

if !has_key(s:disabled_packages, 'terraform')
  au! BufRead,BufNewFile *.tf
endif

if !has_key(s:disabled_packages, 'toml')
  au! BufRead,BufNewFile Pipfile
endif

if !has_key(s:disabled_packages, 'twig')
  au! BufRead,BufNewFile *.twig
endif

if !has_key(s:disabled_packages, 'typescript')
  au! BufRead,BufNewFile *.ts,*.tsx
endif

if !has_key(s:disabled_packages, 'v')
  au! BufRead,BufNewFile *.v
endif

if !has_key(s:disabled_packages, 'vbnet')
  au! BufRead,BufNewFile *.vb
endif

if !has_key(s:disabled_packages, 'vmasm')
  au! BufRead,BufNewFile *.mar
endif

if !has_key(s:disabled_packages, 'vue')
  au! BufRead,BufNewFile *.vue
endif

if !has_key(s:disabled_packages, 'xsl')
  au! BufRead,BufNewFile *.xslt,*.xsl
endif

if !has_key(s:disabled_packages, 'yaml')
  au! BufRead,BufNewFile *.yml,*.yaml
endif

if !has_key(s:disabled_packages, 'help')
  au! BufRead,BufNewFile $VIMRUNTIME/doc/*.txt
endif

if !has_key(s:disabled_packages, 'visual-basic')
  au! BufRead,BufNewFile *.vba,*.vbs,*.dsm,*.ctl,*.sba
endif

if !has_key(s:disabled_packages, 'dosini')
  au! BufRead,BufNewFile *.ini,*.properties,.editorconfig,.npmrc,*/etc/pacman.conf,php.ini-*,*/etc/yum.conf,*/etc/yum.repos.d/*
endif

if !has_key(s:disabled_packages, 'bzl')
  au! BufRead,BufNewFile *.bzl,BUILD,WORKSPACE
endif

if !has_key(s:disabled_packages, 'tads')
  au! BufRead,BufNewFile *.t
endif

if !has_key(s:disabled_packages, '8th')
  au BufNewFile,BufRead *.8th set ft=8th
endif

if !has_key(s:disabled_packages, 'haproxy')
  au BufNewFile,BufRead *.cfg set ft=haproxy
  au BufNewFile,BufRead haproxy*.c* call s:StarSetf('haproxy')
  au BufNewFile,BufRead haproxy.cfg set ft=haproxy
endif

if !has_key(s:disabled_packages, 'a2ps')
  au BufNewFile,BufRead */etc/a2ps.cfg set ft=a2ps
  au BufNewFile,BufRead */etc/a2ps/*.cfg set ft=a2ps
  au BufNewFile,BufRead {.,}a2psrc set ft=a2ps
  au BufNewFile,BufRead a2psrc set ft=a2ps
endif

if !has_key(s:disabled_packages, 'a65')
  au BufNewFile,BufRead *.a65 set ft=a65
endif

if !has_key(s:disabled_packages, 'aap')
  au BufNewFile,BufRead *.aap set ft=aap
endif

if !has_key(s:disabled_packages, 'abap')
  au BufNewFile,BufRead *.abap set ft=abap
endif

if !has_key(s:disabled_packages, 'abaqus')
  au! BufNewFile,BufRead *.inp call polyglot#DetectInpFiletype()
endif

if !has_key(s:disabled_packages, 'abc')
  au BufNewFile,BufRead *.abc set ft=abc
endif

if !has_key(s:disabled_packages, 'abel')
  au BufNewFile,BufRead *.abl set ft=abel
endif

if !has_key(s:disabled_packages, 'acedb')
  au BufNewFile,BufRead *.wrm set ft=acedb
endif

if !has_key(s:disabled_packages, 'acpiasl')
  au BufNewFile,BufRead *.asl set ft=asl
  au BufNewFile,BufRead *.dsl set ft=asl
endif

if !has_key(s:disabled_packages, 'ada')
  au BufNewFile,BufRead *.ada set ft=ada
  au BufNewFile,BufRead *.ada_m set ft=ada
  au BufNewFile,BufRead *.adb set ft=ada
  au BufNewFile,BufRead *.adc set ft=ada
  au BufNewFile,BufRead *.ads set ft=ada
  au BufNewFile,BufRead *.gpr set ft=ada
endif

if !has_key(s:disabled_packages, 'ahdl')
  au BufNewFile,BufRead *.tdf set ft=ahdl
endif

if !has_key(s:disabled_packages, 'aidl')
  au BufNewFile,BufRead *.aidl set ft=aidl
endif

if !has_key(s:disabled_packages, 'alsaconf')
  au BufNewFile,BufRead */etc/asound.conf set ft=alsaconf
  au BufNewFile,BufRead */usr/share/alsa/alsa.conf set ft=alsaconf
  au BufNewFile,BufRead {.,}asoundrc set ft=alsaconf
endif

if !has_key(s:disabled_packages, 'aml')
  au BufNewFile,BufRead *.aml set ft=aml
endif

if !has_key(s:disabled_packages, 'ampl')
  au BufNewFile,BufRead *.run set ft=ampl
endif

if !has_key(s:disabled_packages, 'xml')
  au BufNewFile,BufRead *.adml set ft=xml
  au BufNewFile,BufRead *.admx set ft=xml
  au BufNewFile,BufRead *.ant set ft=xml
  au BufNewFile,BufRead *.axml set ft=xml
  au BufNewFile,BufRead *.builds set ft=xml
  au BufNewFile,BufRead *.ccproj set ft=xml
  au BufNewFile,BufRead *.ccxml set ft=xml
  au BufNewFile,BufRead *.cdxml set ft=xml
  au BufNewFile,BufRead *.clixml set ft=xml
  au BufNewFile,BufRead *.cproject set ft=xml
  au BufNewFile,BufRead *.cscfg set ft=xml
  au BufNewFile,BufRead *.csdef set ft=xml
  au BufNewFile,BufRead *.csl set ft=xml
  au BufNewFile,BufRead *.csproj set ft=xml
  au BufNewFile,BufRead *.ct set ft=xml
  au BufNewFile,BufRead *.depproj set ft=xml
  au BufNewFile,BufRead *.dita set ft=xml
  au BufNewFile,BufRead *.ditamap set ft=xml
  au BufNewFile,BufRead *.ditaval set ft=xml
  au BufNewFile,BufRead *.dll.config set ft=xml
  au BufNewFile,BufRead *.dotsettings set ft=xml
  au BufNewFile,BufRead *.filters set ft=xml
  au BufNewFile,BufRead *.fsproj set ft=xml
  au BufNewFile,BufRead *.fxml set ft=xml
  au BufNewFile,BufRead *.glade set ft=xml
  au BufNewFile,BufRead *.gml set ft=xml
  au BufNewFile,BufRead *.gmx set ft=xml
  au BufNewFile,BufRead *.grxml set ft=xml
  au BufNewFile,BufRead *.gst set ft=xml
  au BufNewFile,BufRead *.iml set ft=xml
  au BufNewFile,BufRead *.ivy set ft=xml
  au BufNewFile,BufRead *.jelly set ft=xml
  au BufNewFile,BufRead *.jsproj set ft=xml
  au BufNewFile,BufRead *.kml set ft=xml
  au BufNewFile,BufRead *.launch set ft=xml
  au BufNewFile,BufRead *.mdpolicy set ft=xml
  au BufNewFile,BufRead *.mjml set ft=xml
  au BufNewFile,BufRead *.mm set ft=xml
  au BufNewFile,BufRead *.mod set ft=xml
  au BufNewFile,BufRead *.mxml set ft=xml
  au BufNewFile,BufRead *.natvis set ft=xml
  au BufNewFile,BufRead *.ncl set ft=xml
  au BufNewFile,BufRead *.ndproj set ft=xml
  au BufNewFile,BufRead *.nproj set ft=xml
  au BufNewFile,BufRead *.nuspec set ft=xml
  au BufNewFile,BufRead *.odd set ft=xml
  au BufNewFile,BufRead *.osm set ft=xml
  au BufNewFile,BufRead *.pkgproj set ft=xml
  au BufNewFile,BufRead *.pluginspec set ft=xml
  au BufNewFile,BufRead *.proj set ft=xml
  au BufNewFile,BufRead *.props set ft=xml
  au BufNewFile,BufRead *.ps1xml set ft=xml
  au BufNewFile,BufRead *.psc1 set ft=xml
  au BufNewFile,BufRead *.pt set ft=xml
  au BufNewFile,BufRead *.rdf set ft=xml
  au BufNewFile,BufRead *.resx set ft=xml
  au BufNewFile,BufRead *.rss set ft=xml
  au BufNewFile,BufRead *.sch set ft=xml
  au BufNewFile,BufRead *.scxml set ft=xml
  au BufNewFile,BufRead *.sfproj set ft=xml
  au BufNewFile,BufRead *.shproj set ft=xml
  au BufNewFile,BufRead *.srdf set ft=xml
  au BufNewFile,BufRead *.storyboard set ft=xml
  au BufNewFile,BufRead *.sublime-snippet set ft=xml
  au BufNewFile,BufRead *.targets set ft=xml
  au BufNewFile,BufRead *.tml set ft=xml
  au BufNewFile,BufRead *.ui set ft=xml
  au BufNewFile,BufRead *.urdf set ft=xml
  au BufNewFile,BufRead *.ux set ft=xml
  au BufNewFile,BufRead *.vbproj set ft=xml
  au BufNewFile,BufRead *.vcxproj set ft=xml
  au BufNewFile,BufRead *.vsixmanifest set ft=xml
  au BufNewFile,BufRead *.vssettings set ft=xml
  au BufNewFile,BufRead *.vstemplate set ft=xml
  au BufNewFile,BufRead *.vxml set ft=xml
  au BufNewFile,BufRead *.wixproj set ft=xml
  au BufNewFile,BufRead *.workflow set ft=xml
  au BufNewFile,BufRead *.wsdl set ft=xml
  au BufNewFile,BufRead *.wsf set ft=xml
  au BufNewFile,BufRead *.wxi set ft=xml
  au BufNewFile,BufRead *.wxl set ft=xml
  au BufNewFile,BufRead *.wxs set ft=xml
  au BufNewFile,BufRead *.x3d set ft=xml
  au BufNewFile,BufRead *.xacro set ft=xml
  au BufNewFile,BufRead *.xaml set ft=xml
  au BufNewFile,BufRead *.xib set ft=xml
  au BufNewFile,BufRead *.xlf set ft=xml
  au BufNewFile,BufRead *.xliff set ft=xml
  au BufNewFile,BufRead *.xmi set ft=xml
  au BufNewFile,BufRead *.xml set ft=xml
  au BufNewFile,BufRead *.xml.dist set ft=xml
  au BufNewFile,BufRead *.xproj set ft=xml
  au BufNewFile,BufRead *.xsd set ft=xml
  au BufNewFile,BufRead *.xspec set ft=xml
  au BufNewFile,BufRead *.xul set ft=xml
  au BufNewFile,BufRead *.zcml set ft=xml
  au BufNewFile,BufRead {.,}classpath set ft=xml
  au BufNewFile,BufRead {.,}cproject set ft=xml
  au BufNewFile,BufRead {.,}project set ft=xml
  au BufNewFile,BufRead App.config set ft=xml
  au BufNewFile,BufRead NuGet.config set ft=xml
  au BufNewFile,BufRead Settings.StyleCop set ft=xml
  au BufNewFile,BufRead Web.Debug.config set ft=xml
  au BufNewFile,BufRead Web.Release.config set ft=xml
  au BufNewFile,BufRead Web.config set ft=xml
  au BufNewFile,BufRead packages.config set ft=xml
endif

if !has_key(s:disabled_packages, 'ant')
  au BufNewFile,BufRead build.xml set ft=ant
endif

if !has_key(s:disabled_packages, 'apache')
  au BufNewFile,BufRead */etc/apache2/*.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead */etc/apache2/conf.*/* call s:StarSetf('apache')
  au BufNewFile,BufRead */etc/apache2/mods-*/* call s:StarSetf('apache')
  au BufNewFile,BufRead */etc/apache2/sites-*/* call s:StarSetf('apache')
  au BufNewFile,BufRead */etc/apache2/sites-*/*.com set ft=apache
  au BufNewFile,BufRead */etc/httpd/*.conf set ft=apache
  au BufNewFile,BufRead */etc/httpd/conf.d/*.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead {.,}htaccess set ft=apache
  au BufNewFile,BufRead access.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead apache.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead apache2.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead httpd.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead srm.conf* call s:StarSetf('apache')
endif

if !has_key(s:disabled_packages, 'apiblueprint')
  au BufNewFile,BufRead *.apib set ft=apiblueprint
endif

if !has_key(s:disabled_packages, 'applescript')
  au BufNewFile,BufRead *.applescript set ft=applescript
  au BufNewFile,BufRead *.scpt set ft=applescript
endif

if !has_key(s:disabled_packages, 'aptconf')
  au BufNewFile,BufRead */.aptitude/config set ft=aptconf
  au BufNewFile,BufRead */etc/apt/apt.conf.d/*.conf set ft=aptconf
  au BufNewFile,BufRead */etc/apt/apt.conf.d/[^.]* call s:StarSetf('aptconf')
  au BufNewFile,BufRead apt.conf set ft=aptconf
endif

if !has_key(s:disabled_packages, 'arch')
  au BufNewFile,BufRead {.,}arch-inventory set ft=arch
  au BufNewFile,BufRead =tagging-method set ft=arch
endif

if !has_key(s:disabled_packages, 'c/c++')
  au BufNewFile,BufRead *.c++ set ft=cpp
  au BufNewFile,BufRead *.cc set ft=cpp
  au BufNewFile,BufRead *.cp set ft=cpp
  au BufNewFile,BufRead *.cpp set ft=cpp
  au BufNewFile,BufRead *.cxx set ft=cpp
  au BufNewFile,BufRead *.h++ set ft=cpp
  au BufNewFile,BufRead *.hh set ft=cpp
  au BufNewFile,BufRead *.hpp set ft=cpp
  au BufNewFile,BufRead *.hxx set ft=cpp
  au BufNewFile,BufRead *.inc set ft=cpp
  au BufNewFile,BufRead *.inl set ft=cpp
  au BufNewFile,BufRead *.ipp set ft=cpp
  au BufNewFile,BufRead *.moc set ft=cpp
  au BufNewFile,BufRead *.tcc set ft=cpp
  au BufNewFile,BufRead *.tlh set ft=cpp
  au BufNewFile,BufRead *.tpp set ft=cpp
  au BufNewFile,BufRead *.c set ft=c
  au BufNewFile,BufRead *.cats set ft=c
  au BufNewFile,BufRead *.idc set ft=c
  au BufNewFile,BufRead *.qc set ft=c
  au BufNewFile,BufRead *enlightenment/*.cfg set ft=c
  au! BufNewFile,BufRead *.h call polyglot#DetectHFiletype()
endif

if !has_key(s:disabled_packages, 'arduino')
  au BufNewFile,BufRead *.ino set ft=arduino
  au BufNewFile,BufRead *.pde set ft=arduino
endif

if !has_key(s:disabled_packages, 'art')
  au BufNewFile,BufRead *.art set ft=art
endif

if !has_key(s:disabled_packages, 'asciidoc')
  au BufNewFile,BufRead *.adoc set ft=asciidoc
  au BufNewFile,BufRead *.asc set ft=asciidoc
  au BufNewFile,BufRead *.asciidoc set ft=asciidoc
endif

if !has_key(s:disabled_packages, 'autohotkey')
  au BufNewFile,BufRead *.ahk set ft=autohotkey
  au BufNewFile,BufRead *.ahkl set ft=autohotkey
endif

if !has_key(s:disabled_packages, 'elf')
  au BufNewFile,BufRead *.am set ft=elf
endif

if !has_key(s:disabled_packages, 'automake')
  au BufNewFile,BufRead GNUmakefile.am set ft=automake
  au BufNewFile,BufRead [Mm]akefile.am set ft=automake
endif

if !has_key(s:disabled_packages, 'asn')
  au BufNewFile,BufRead *.asn set ft=asn
  au BufNewFile,BufRead *.asn1 set ft=asn
endif

if !has_key(s:disabled_packages, 'aspvbs')
  au! BufNewFile,BufRead *.asa call polyglot#DetectAsaFiletype()
  au! BufNewFile,BufRead *.asp call polyglot#DetectAspFiletype()
endif

if !has_key(s:disabled_packages, 'aspperl')
  au! BufNewFile,BufRead *.asp call polyglot#DetectAspFiletype()
endif

if !has_key(s:disabled_packages, 'atlas')
  au BufNewFile,BufRead *.as set ft=atlas
  au BufNewFile,BufRead *.atl set ft=atlas
endif

if !has_key(s:disabled_packages, 'autoit')
  au BufNewFile,BufRead *.au3 set ft=autoit
endif

if !has_key(s:disabled_packages, 'ave')
  au BufNewFile,BufRead *.ave set ft=ave
endif

if !has_key(s:disabled_packages, 'awk')
  au BufNewFile,BufRead *.awk set ft=awk
  au BufNewFile,BufRead *.gawk set ft=awk
endif

if !has_key(s:disabled_packages, 'caddyfile')
  au BufNewFile,BufRead Caddyfile set ft=caddyfile
endif

if !has_key(s:disabled_packages, 'carp')
  au BufNewFile,BufRead *.carp set ft=carp
endif

if !has_key(s:disabled_packages, 'clojure')
  au BufNewFile,BufRead *.boot set ft=clojure
  au BufNewFile,BufRead *.cl2 set ft=clojure
  au BufNewFile,BufRead *.clj set ft=clojure
  au BufNewFile,BufRead *.cljc set ft=clojure
  au BufNewFile,BufRead *.cljs set ft=clojure
  au BufNewFile,BufRead *.cljs.hl set ft=clojure
  au BufNewFile,BufRead *.cljscm set ft=clojure
  au BufNewFile,BufRead *.cljx set ft=clojure
  au BufNewFile,BufRead *.edn set ft=clojure
  au BufNewFile,BufRead *.hic set ft=clojure
  au BufNewFile,BufRead build.boot set ft=clojure
  au BufNewFile,BufRead profile.boot set ft=clojure
  au BufNewFile,BufRead riemann.config set ft=clojure
endif

if !has_key(s:disabled_packages, 'cmake')
  au BufNewFile,BufRead *.cmake set ft=cmake
  au BufNewFile,BufRead *.cmake.in set ft=cmake
  au BufNewFile,BufRead CMakeLists.txt set ft=cmake
endif

if !has_key(s:disabled_packages, 'coffee-script')
  au BufNewFile,BufRead *._coffee set ft=coffee
  au BufNewFile,BufRead *.cake set ft=coffee
  au BufNewFile,BufRead *.cjsx set ft=coffee
  au BufNewFile,BufRead *.coffee set ft=coffee
  au BufNewFile,BufRead *.coffeekup set ft=coffee
  au BufNewFile,BufRead *.iced set ft=coffee
  au BufNewFile,BufRead Cakefile set ft=coffee
  au BufNewFile,BufRead *.coffee.md set ft=litcoffee
  au BufNewFile,BufRead *.litcoffee set ft=litcoffee
endif

if !has_key(s:disabled_packages, 'cryptol')
  au BufNewFile,BufRead *.cry set ft=cryptol
  au BufNewFile,BufRead *.cyl set ft=cryptol
  au BufNewFile,BufRead *.lcry set ft=cryptol
  au BufNewFile,BufRead *.lcyl set ft=cryptol
endif

if !has_key(s:disabled_packages, 'crystal')
  au BufNewFile,BufRead *.cr set ft=crystal
  au BufNewFile,BufRead Projectfile set ft=crystal
  au BufNewFile,BufRead *.ecr set ft=ecrystal
endif

if !has_key(s:disabled_packages, 'csv')
  au BufNewFile,BufRead *.csv set ft=csv
  au BufNewFile,BufRead *.tab set ft=csv
  au BufNewFile,BufRead *.tsv set ft=csv
endif

if !has_key(s:disabled_packages, 'cucumber')
  au BufNewFile,BufRead *.feature set ft=cucumber
  au BufNewFile,BufRead *.story set ft=cucumber
endif

if !has_key(s:disabled_packages, 'cue')
  au BufNewFile,BufRead *.cue set ft=cuesheet
endif

if !has_key(s:disabled_packages, 'dart')
  au BufNewFile,BufRead *.dart set ft=dart
  au BufNewFile,BufRead *.drt set ft=dart
endif

if !has_key(s:disabled_packages, 'dhall')
  au BufNewFile,BufRead *.dhall set ft=dhall
endif

if !has_key(s:disabled_packages, 'dlang')
  au BufNewFile,BufRead *.d set ft=d
  au BufNewFile,BufRead *.di set ft=d
  au BufNewFile,BufRead *.lst set ft=dcov
  au BufNewFile,BufRead *.dd set ft=dd
  au BufNewFile,BufRead *.ddoc set ft=ddoc
  au BufNewFile,BufRead *.sdl set ft=dsdl
endif

if !has_key(s:disabled_packages, 'dockerfile')
  au BufNewFile,BufRead *.Dockerfile set ft=Dockerfile
  au BufNewFile,BufRead *.dock set ft=Dockerfile
  au BufNewFile,BufRead *.dockerfile set ft=Dockerfile
  au BufNewFile,BufRead Dockerfile set ft=Dockerfile
  au BufNewFile,BufRead Dockerfile* call s:StarSetf('Dockerfile')
  au BufNewFile,BufRead dockerfile set ft=Dockerfile
  au BufNewFile,BufRead docker-compose*.yaml set ft=yaml.docker-compose
  au BufNewFile,BufRead docker-compose*.yml set ft=yaml.docker-compose
endif

if !has_key(s:disabled_packages, 'elixir')
  au BufNewFile,BufRead *.ex set ft=elixir
  au BufNewFile,BufRead *.exs set ft=elixir
  au BufNewFile,BufRead mix.lock set ft=elixir
  au BufNewFile,BufRead *.eex set ft=eelixir
  au BufNewFile,BufRead *.leex set ft=eelixir
endif

if !has_key(s:disabled_packages, 'elm')
  au BufNewFile,BufRead *.elm set ft=elm
endif

if !has_key(s:disabled_packages, 'emberscript')
  au BufNewFile,BufRead *.em set ft=ember-script
  au BufNewFile,BufRead *.emberscript set ft=ember-script
endif

if !has_key(s:disabled_packages, 'emblem')
  au BufNewFile,BufRead *.em set ft=emblem
  au BufNewFile,BufRead *.emblem set ft=emblem
endif

if !has_key(s:disabled_packages, 'erlang')
  au BufNewFile,BufRead *.app set ft=erlang
  au BufNewFile,BufRead *.app.src set ft=erlang
  au BufNewFile,BufRead *.erl set ft=erlang
  au BufNewFile,BufRead *.es set ft=erlang
  au BufNewFile,BufRead *.escript set ft=erlang
  au BufNewFile,BufRead *.hrl set ft=erlang
  au BufNewFile,BufRead *.xrl set ft=erlang
  au BufNewFile,BufRead *.yaws set ft=erlang
  au BufNewFile,BufRead *.yrl set ft=erlang
  au BufNewFile,BufRead Emakefile set ft=erlang
  au BufNewFile,BufRead rebar.config set ft=erlang
  au BufNewFile,BufRead rebar.config.lock set ft=erlang
  au BufNewFile,BufRead rebar.lock set ft=erlang
endif

if !has_key(s:disabled_packages, 'fennel')
  au BufNewFile,BufRead *.fnl set ft=fennel
endif

if !has_key(s:disabled_packages, 'ferm')
  au BufNewFile,BufRead *.ferm set ft=ferm
  au BufNewFile,BufRead ferm.conf set ft=ferm
endif

if !has_key(s:disabled_packages, 'fish')
  au BufNewFile,BufRead *.fish set ft=fish
endif

if !has_key(s:disabled_packages, 'flatbuffers')
  au BufNewFile,BufRead *.fbs set ft=fbs
endif

if !has_key(s:disabled_packages, 'forth')
  au BufNewFile,BufRead *.ft set ft=forth
  au BufNewFile,BufRead *.fth set ft=forth
  au! BufNewFile,BufRead *.fs call polyglot#DetectFsFiletype()
endif

if !has_key(s:disabled_packages, 'glsl')
  au BufNewFile,BufRead *.comp set ft=glsl
  au BufNewFile,BufRead *.fp set ft=glsl
  au BufNewFile,BufRead *.frag set ft=glsl
  au BufNewFile,BufRead *.frg set ft=glsl
  au BufNewFile,BufRead *.fsh set ft=glsl
  au BufNewFile,BufRead *.fshader set ft=glsl
  au BufNewFile,BufRead *.geo set ft=glsl
  au BufNewFile,BufRead *.geom set ft=glsl
  au BufNewFile,BufRead *.glsl set ft=glsl
  au BufNewFile,BufRead *.glslf set ft=glsl
  au BufNewFile,BufRead *.glslv set ft=glsl
  au BufNewFile,BufRead *.gs set ft=glsl
  au BufNewFile,BufRead *.gshader set ft=glsl
  au BufNewFile,BufRead *.shader set ft=glsl
  au BufNewFile,BufRead *.tesc set ft=glsl
  au BufNewFile,BufRead *.tese set ft=glsl
  au BufNewFile,BufRead *.vert set ft=glsl
  au BufNewFile,BufRead *.vrx set ft=glsl
  au BufNewFile,BufRead *.vsh set ft=glsl
  au BufNewFile,BufRead *.vshader set ft=glsl
  au! BufNewFile,BufRead *.fs call polyglot#DetectFsFiletype()
endif

if !has_key(s:disabled_packages, 'fsharp')
  au BufNewFile,BufRead *.fsi set ft=fsharp
  au BufNewFile,BufRead *.fsx set ft=fsharp
  au! BufNewFile,BufRead *.fs call polyglot#DetectFsFiletype()
endif

if !has_key(s:disabled_packages, 'gdscript')
  au BufNewFile,BufRead *.gd set ft=gdscript3
endif

if !has_key(s:disabled_packages, 'git')
  au BufNewFile,BufRead *.gitconfig set ft=gitconfig
  au BufNewFile,BufRead *.git/config set ft=gitconfig
  au BufNewFile,BufRead *.git/modules/*/config set ft=gitconfig
  au BufNewFile,BufRead */.config/git/config set ft=gitconfig
  au BufNewFile,BufRead */git/config set ft=gitconfig
  au BufNewFile,BufRead */{.,}gitconfig.d/* call s:StarSetf('gitconfig')
  au BufNewFile,BufRead {.,}gitconfig set ft=gitconfig
  au BufNewFile,BufRead {.,}gitmodules set ft=gitconfig
  au BufNewFile,BufRead git-rebase-todo set ft=gitrebase
  au BufNewFile,BufRead {.,}gitsendemail.* call s:StarSetf('gitsendemail')
  au BufNewFile,BufRead COMMIT_EDITMSG,MERGE_MSG,TAG_EDITMSG set ft=gitcommit
endif

if !has_key(s:disabled_packages, 'gmpl')
  au BufNewFile,BufRead *.mod set ft=gmpl
endif

if !has_key(s:disabled_packages, 'gnuplot')
  au BufNewFile,BufRead *.gnu set ft=gnuplot
  au BufNewFile,BufRead *.gnuplot set ft=gnuplot
  au BufNewFile,BufRead *.gp set ft=gnuplot
  au BufNewFile,BufRead *.gpi set ft=gnuplot
  au BufNewFile,BufRead *.p set ft=gnuplot
  au BufNewFile,BufRead *.plot set ft=gnuplot
  au BufNewFile,BufRead *.plt set ft=gnuplot
endif

if !has_key(s:disabled_packages, 'go')
  au BufNewFile,BufRead *.go set ft=go
  au BufNewFile,BufRead go.mod set ft=gomod
  au BufNewFile,BufRead *.tmpl set ft=gohtmltmpl
endif

if !has_key(s:disabled_packages, 'javascript')
  au BufNewFile,BufRead *._js set ft=javascript
  au BufNewFile,BufRead *.bones set ft=javascript
  au BufNewFile,BufRead *.cjs set ft=javascript
  au BufNewFile,BufRead *.es set ft=javascript
  au BufNewFile,BufRead *.es6 set ft=javascript
  au BufNewFile,BufRead *.frag set ft=javascript
  au BufNewFile,BufRead *.gs set ft=javascript
  au BufNewFile,BufRead *.jake set ft=javascript
  au BufNewFile,BufRead *.js set ft=javascript
  au BufNewFile,BufRead *.jsb set ft=javascript
  au BufNewFile,BufRead *.jscad set ft=javascript
  au BufNewFile,BufRead *.jsfl set ft=javascript
  au BufNewFile,BufRead *.jsm set ft=javascript
  au BufNewFile,BufRead *.jss set ft=javascript
  au BufNewFile,BufRead *.mjs set ft=javascript
  au BufNewFile,BufRead *.njs set ft=javascript
  au BufNewFile,BufRead *.pac set ft=javascript
  au BufNewFile,BufRead *.sjs set ft=javascript
  au BufNewFile,BufRead *.ssjs set ft=javascript
  au BufNewFile,BufRead *.xsjs set ft=javascript
  au BufNewFile,BufRead *.xsjslib set ft=javascript
  au BufNewFile,BufRead Jakefile set ft=javascript
  au BufNewFile,BufRead *.flow set ft=flow
endif

if !has_key(s:disabled_packages, 'jsx')
  au BufNewFile,BufRead *.jsx set ft=javascriptreact
endif

if !has_key(s:disabled_packages, 'graphql')
  au BufNewFile,BufRead *.gql set ft=graphql
  au BufNewFile,BufRead *.graphql set ft=graphql
  au BufNewFile,BufRead *.graphqls set ft=graphql
endif

if !has_key(s:disabled_packages, 'groovy')
  au BufNewFile,BufRead *.gradle set ft=groovy
  au BufNewFile,BufRead *.groovy set ft=groovy
  au BufNewFile,BufRead *.grt set ft=groovy
  au BufNewFile,BufRead *.gtpl set ft=groovy
  au BufNewFile,BufRead *.gvy set ft=groovy
  au BufNewFile,BufRead Jenkinsfile set ft=groovy
endif

if !has_key(s:disabled_packages, 'grub')
  au BufNewFile,BufRead */boot/grub/grub.conf set ft=grub
  au BufNewFile,BufRead */boot/grub/menu.lst set ft=grub
  au BufNewFile,BufRead */etc/grub.conf set ft=grub
endif

if !has_key(s:disabled_packages, 'haml')
  au BufNewFile,BufRead *.haml set ft=haml
  au BufNewFile,BufRead *.haml.deface set ft=haml
  au BufNewFile,BufRead *.hamlbars set ft=haml
  au BufNewFile,BufRead *.hamlc set ft=haml
endif

if !has_key(s:disabled_packages, 'handlebars')
  au BufNewFile,BufRead *.handlebars set ft=mustache
  au BufNewFile,BufRead *.hb set ft=mustache
  au BufNewFile,BufRead *.hbs set ft=mustache
  au BufNewFile,BufRead *.hdbs set ft=mustache
  au BufNewFile,BufRead *.hjs set ft=mustache
  au BufNewFile,BufRead *.hogan set ft=mustache
  au BufNewFile,BufRead *.hulk set ft=mustache
  au BufNewFile,BufRead *.mustache set ft=mustache
  au BufNewFile,BufRead *.njk set ft=mustache
endif

if !has_key(s:disabled_packages, 'haskell')
  au BufNewFile,BufRead *.bpk set ft=haskell
  au BufNewFile,BufRead *.hs set ft=haskell
  au BufNewFile,BufRead *.hs-boot set ft=haskell
  au BufNewFile,BufRead *.hsc set ft=haskell
  au BufNewFile,BufRead *.hsig set ft=haskell
endif

if !has_key(s:disabled_packages, 'haxe')
  au BufNewFile,BufRead *.hx set ft=haxe
  au BufNewFile,BufRead *.hxsl set ft=haxe
endif

if !has_key(s:disabled_packages, 'hcl')
  au BufNewFile,BufRead *.hcl set ft=hcl
  au BufNewFile,BufRead *.nomad set ft=hcl
  au BufNewFile,BufRead *.workflow set ft=hcl
  au BufNewFile,BufRead Appfile set ft=hcl
endif

if !has_key(s:disabled_packages, 'hive')
  au BufNewFile,BufRead *.hql set ft=hive
  au BufNewFile,BufRead *.q set ft=hive
  au BufNewFile,BufRead *.ql set ft=hive
endif

if !has_key(s:disabled_packages, 'html5')
  au BufNewFile,BufRead *.htm set ft=html
  au BufNewFile,BufRead *.html.hl set ft=html
  au BufNewFile,BufRead *.inc set ft=html
  au BufNewFile,BufRead *.st set ft=html
  au BufNewFile,BufRead *.xht set ft=html
  au BufNewFile,BufRead *.xhtml set ft=html
  au! BufNewFile,BufRead *.html call polyglot#DetectHtmlFiletype()
endif

if !has_key(s:disabled_packages, 'i3')
  au BufNewFile,BufRead *.i3.config set ft=i3config
  au BufNewFile,BufRead *.i3config set ft=i3config
  au BufNewFile,BufRead {.,}i3.config set ft=i3config
  au BufNewFile,BufRead {.,}i3config set ft=i3config
  au BufNewFile,BufRead i3.config set ft=i3config
  au BufNewFile,BufRead i3config set ft=i3config
endif

if !has_key(s:disabled_packages, 'icalendar')
  au BufNewFile,BufRead *.ics set ft=icalendar
endif

if !has_key(s:disabled_packages, 'idris')
  au BufNewFile,BufRead idris-response set ft=idris
  au! BufNewFile,BufRead *.idr call polyglot#DetectIdrFiletype()
  au! BufNewFile,BufRead *.lidr call polyglot#DetectLidrFiletype()
endif

if !has_key(s:disabled_packages, 'idris2')
  au BufNewFile,BufRead *.ipkg set ft=idris2
  au BufNewFile,BufRead idris-response set ft=idris2
  au! BufNewFile,BufRead *.idr call polyglot#DetectIdrFiletype()
  au! BufNewFile,BufRead *.lidr call polyglot#DetectLidrFiletype()
endif

if !has_key(s:disabled_packages, 'ion')
  au BufNewFile,BufRead *.ion set ft=ion
  au BufNewFile,BufRead ~/.config/ion/initrc set ft=ion
endif

if !has_key(s:disabled_packages, 'jenkins')
  au BufNewFile,BufRead *.Jenkinsfile set ft=Jenkinsfile
  au BufNewFile,BufRead *.jenkinsfile set ft=Jenkinsfile
  au BufNewFile,BufRead Jenkinsfile set ft=Jenkinsfile
  au BufNewFile,BufRead Jenkinsfile* call s:StarSetf('Jenkinsfile')
endif

if !has_key(s:disabled_packages, 'jinja')
  au BufNewFile,BufRead *.j2 set ft=jinja.html
  au BufNewFile,BufRead *.jinja set ft=jinja.html
  au BufNewFile,BufRead *.jinja2 set ft=jinja.html
endif

if !has_key(s:disabled_packages, 'jq')
  au BufNewFile,BufRead *.jq set ft=jq
  au BufNewFile,BufRead {.,}jqrc set ft=jq
  au BufNewFile,BufRead {.,}jqrc* call s:StarSetf('jq')
endif

if !has_key(s:disabled_packages, 'json5')
  au BufNewFile,BufRead *.json5 set ft=json5
endif

if !has_key(s:disabled_packages, 'json')
  au BufNewFile,BufRead *.JSON-tmLanguage set ft=json
  au BufNewFile,BufRead *.avsc set ft=json
  au BufNewFile,BufRead *.geojson set ft=json
  au BufNewFile,BufRead *.gltf set ft=json
  au BufNewFile,BufRead *.har set ft=json
  au BufNewFile,BufRead *.ice set ft=json
  au BufNewFile,BufRead *.json set ft=json
  au BufNewFile,BufRead *.jsonl set ft=json
  au BufNewFile,BufRead *.jsonp set ft=json
  au BufNewFile,BufRead *.mcmeta set ft=json
  au BufNewFile,BufRead *.template set ft=json
  au BufNewFile,BufRead *.tfstate set ft=json
  au BufNewFile,BufRead *.tfstate.backup set ft=json
  au BufNewFile,BufRead *.topojson set ft=json
  au BufNewFile,BufRead *.webapp set ft=json
  au BufNewFile,BufRead *.webmanifest set ft=json
  au BufNewFile,BufRead *.yy set ft=json
  au BufNewFile,BufRead *.yyp set ft=json
  au BufNewFile,BufRead {.,}arcconfig set ft=json
  au BufNewFile,BufRead {.,}htmlhintrc set ft=json
  au BufNewFile,BufRead {.,}tern-config set ft=json
  au BufNewFile,BufRead {.,}tern-project set ft=json
  au BufNewFile,BufRead {.,}watchmanconfig set ft=json
  au BufNewFile,BufRead Pipfile.lock set ft=json
  au BufNewFile,BufRead composer.lock set ft=json
  au BufNewFile,BufRead mcmod.info set ft=json
endif

if !has_key(s:disabled_packages, 'jsonnet')
  au BufNewFile,BufRead *.jsonnet set ft=jsonnet
  au BufNewFile,BufRead *.libsonnet set ft=jsonnet
endif

if !has_key(s:disabled_packages, 'jst')
  au BufNewFile,BufRead *.ect set ft=jst
  au BufNewFile,BufRead *.ejs set ft=jst
  au BufNewFile,BufRead *.jst set ft=jst
endif

if !has_key(s:disabled_packages, 'julia')
  au BufNewFile,BufRead *.jl set ft=julia
endif

if !has_key(s:disabled_packages, 'kotlin')
  au BufNewFile,BufRead *.kt set ft=kotlin
  au BufNewFile,BufRead *.ktm set ft=kotlin
  au BufNewFile,BufRead *.kts set ft=kotlin
endif

if !has_key(s:disabled_packages, 'ledger')
  au BufNewFile,BufRead *.journal set ft=ledger
  au BufNewFile,BufRead *.ldg set ft=ledger
  au BufNewFile,BufRead *.ledger set ft=ledger
endif

if !has_key(s:disabled_packages, 'less')
  au BufNewFile,BufRead *.less set ft=less
endif

if !has_key(s:disabled_packages, 'lilypond')
  au BufNewFile,BufRead *.ily set ft=lilypond
  au BufNewFile,BufRead *.ly set ft=lilypond
endif

if !has_key(s:disabled_packages, 'livescript')
  au BufNewFile,BufRead *._ls set ft=livescript
  au BufNewFile,BufRead *.ls set ft=livescript
  au BufNewFile,BufRead Slakefile set ft=livescript
endif

if !has_key(s:disabled_packages, 'llvm')
  au BufNewFile,BufRead *.ll set ft=llvm
  au BufNewFile,BufRead *.td set ft=tablegen
endif

if !has_key(s:disabled_packages, 'log')
  au BufNewFile,BufRead *.LOG set ft=log
  au BufNewFile,BufRead *.log set ft=log
  au BufNewFile,BufRead *_LOG set ft=log
  au BufNewFile,BufRead *_log set ft=log
endif

if !has_key(s:disabled_packages, 'lua')
  au BufNewFile,BufRead *.fcgi set ft=lua
  au BufNewFile,BufRead *.lua set ft=lua
  au BufNewFile,BufRead *.nse set ft=lua
  au BufNewFile,BufRead *.p8 set ft=lua
  au BufNewFile,BufRead *.pd_lua set ft=lua
  au BufNewFile,BufRead *.rbxs set ft=lua
  au BufNewFile,BufRead *.rockspec set ft=lua
  au BufNewFile,BufRead *.wlua set ft=lua
  au BufNewFile,BufRead {.,}luacheckrc set ft=lua
endif

if !has_key(s:disabled_packages, 'm4')
  au BufNewFile,BufRead *.at set ft=m4
  au BufNewFile,BufRead *.m4 set ft=m4
endif

if !has_key(s:disabled_packages, 'mako')
  au BufNewFile *.*.mako execute "do BufNewFile filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufReadPre *.*.mako execute "do BufRead filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufNewFile,BufRead *.mako set ft=mako
  au BufNewFile *.*.mao execute "do BufNewFile filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufReadPre *.*.mao execute "do BufRead filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufNewFile,BufRead *.mao set ft=mako
endif

if !has_key(s:disabled_packages, 'mathematica')
  au BufNewFile,BufRead *.cdf set ft=mma
  au BufNewFile,BufRead *.ma set ft=mma
  au BufNewFile,BufRead *.mathematica set ft=mma
  au BufNewFile,BufRead *.mma set ft=mma
  au BufNewFile,BufRead *.mt set ft=mma
  au BufNewFile,BufRead *.nb set ft=mma
  au BufNewFile,BufRead *.nbp set ft=mma
  au BufNewFile,BufRead *.wl set ft=mma
  au BufNewFile,BufRead *.wls set ft=mma
  au BufNewFile,BufRead *.wlt set ft=mma
  au! BufNewFile,BufRead *.m call polyglot#DetectMFiletype()
endif

if !has_key(s:disabled_packages, 'markdown')
  au BufNewFile,BufRead *.markdown set ft=markdown
  au BufNewFile,BufRead *.md set ft=markdown
  au BufNewFile,BufRead *.mdown set ft=markdown
  au BufNewFile,BufRead *.mdwn set ft=markdown
  au BufNewFile,BufRead *.mkd set ft=markdown
  au BufNewFile,BufRead *.mkdn set ft=markdown
  au BufNewFile,BufRead *.mkdown set ft=markdown
  au BufNewFile,BufRead *.ronn set ft=markdown
  au BufNewFile,BufRead *.workbook set ft=markdown
  au BufNewFile,BufRead contents.lr set ft=markdown
endif

if !has_key(s:disabled_packages, 'mdx')
  au BufNewFile,BufRead *.mdx set ft=markdown.mdx
endif

if !has_key(s:disabled_packages, 'meson')
  au BufNewFile,BufRead meson.build set ft=meson
  au BufNewFile,BufRead meson_options.txt set ft=meson
  au BufNewFile,BufRead *.wrap set ft=dosini
endif

if !has_key(s:disabled_packages, 'moonscript')
  au BufNewFile,BufRead *.moon set ft=moon
endif

if !has_key(s:disabled_packages, 'murphi')
  au! BufNewFile,BufRead *.m call polyglot#DetectMFiletype()
endif

if !has_key(s:disabled_packages, 'nginx')
  au BufNewFile,BufRead *.nginx set ft=nginx
  au BufNewFile,BufRead *.nginxconf set ft=nginx
  au BufNewFile,BufRead *.vhost set ft=nginx
  au BufNewFile,BufRead */etc/nginx/* call s:StarSetf('nginx')
  au BufNewFile,BufRead */nginx/*.conf set ft=nginx
  au BufNewFile,BufRead */usr/local/nginx/conf/* call s:StarSetf('nginx')
  au BufNewFile,BufRead *nginx.conf set ft=nginx
  au BufNewFile,BufRead nginx*.conf set ft=nginx
  au BufNewFile,BufRead nginx.conf set ft=nginx
endif

if !has_key(s:disabled_packages, 'nim')
  au BufNewFile,BufRead *.nim set ft=nim
  au BufNewFile,BufRead *.nim.cfg set ft=nim
  au BufNewFile,BufRead *.nimble set ft=nim
  au BufNewFile,BufRead *.nimrod set ft=nim
  au BufNewFile,BufRead *.nims set ft=nim
  au BufNewFile,BufRead nim.cfg set ft=nim
endif

if !has_key(s:disabled_packages, 'nix')
  au BufNewFile,BufRead *.nix set ft=nix
endif

if !has_key(s:disabled_packages, 'objc')
  au! BufNewFile,BufRead *.h call polyglot#DetectHFiletype()
  au! BufNewFile,BufRead *.m call polyglot#DetectMFiletype()
endif

if !has_key(s:disabled_packages, 'ocaml')
  au BufNewFile,BufRead *.eliom set ft=ocaml
  au BufNewFile,BufRead *.eliomi set ft=ocaml
  au BufNewFile,BufRead *.ml set ft=ocaml
  au BufNewFile,BufRead *.ml.cppo set ft=ocaml
  au BufNewFile,BufRead *.ml4 set ft=ocaml
  au BufNewFile,BufRead *.mli set ft=ocaml
  au BufNewFile,BufRead *.mli.cppo set ft=ocaml
  au BufNewFile,BufRead *.mlip set ft=ocaml
  au BufNewFile,BufRead *.mll set ft=ocaml
  au BufNewFile,BufRead *.mlp set ft=ocaml
  au BufNewFile,BufRead *.mlt set ft=ocaml
  au BufNewFile,BufRead *.mly set ft=ocaml
  au BufNewFile,BufRead {.,}ocamlinit set ft=ocaml
  au BufNewFile,BufRead *.om set ft=omake
  au BufNewFile,BufRead OMakefile set ft=omake
  au BufNewFile,BufRead OMakeroot set ft=omake
  au BufNewFile,BufRead OMakeroot.in set ft=omake
  au BufNewFile,BufRead *.opam set ft=opam
  au BufNewFile,BufRead *.opam.template set ft=opam
  au BufNewFile,BufRead opam set ft=opam
  au BufNewFile,BufRead _oasis set ft=oasis
  au BufNewFile,BufRead dune set ft=dune
  au BufNewFile,BufRead dune-project set ft=dune
  au BufNewFile,BufRead dune-workspace set ft=dune
  au BufNewFile,BufRead jbuild set ft=dune
  au BufNewFile,BufRead _tags set ft=ocamlbuild_tags
  au BufNewFile,BufRead *.ocp set ft=ocpbuild
  au BufNewFile,BufRead *.root set ft=ocpbuildroot
  au BufNewFile,BufRead *.sexp set ft=sexplib
endif

if !has_key(s:disabled_packages, 'octave')
  au BufNewFile,BufRead *.oct set ft=octave
  au! BufNewFile,BufRead *.m call polyglot#DetectMFiletype()
endif

if !has_key(s:disabled_packages, 'opencl')
  au BufNewFile,BufRead *.cl set ft=opencl
  au BufNewFile,BufRead *.opencl set ft=opencl
endif

if !has_key(s:disabled_packages, 'perl')
  au BufNewFile,BufRead *.al set ft=perl
  au BufNewFile,BufRead *.cgi set ft=perl
  au BufNewFile,BufRead *.fcgi set ft=perl
  au BufNewFile,BufRead *.perl set ft=perl
  au BufNewFile,BufRead *.ph set ft=perl
  au BufNewFile,BufRead *.plx set ft=perl
  au BufNewFile,BufRead *.psgi set ft=perl
  au BufNewFile,BufRead Makefile.PL set ft=perl
  au BufNewFile,BufRead Rexfile set ft=perl
  au BufNewFile,BufRead ack set ft=perl
  au BufNewFile,BufRead cpanfile set ft=perl
  au BufNewFile,BufRead *.pod set ft=pod
  au BufNewFile,BufRead *.comp set ft=mason
  au BufNewFile,BufRead *.mason set ft=mason
  au BufNewFile,BufRead *.mhtml set ft=mason
  au BufNewFile,BufRead *.xs set ft=xs
  au! BufNewFile,BufRead *.pl call polyglot#DetectPlFiletype()
  au! BufNewFile,BufRead *.pm call polyglot#DetectPmFiletype()
  au! BufNewFile,BufRead *.t call polyglot#DetectTFiletype()
  au! BufNewFile,BufRead *.tt2 call polyglot#DetectTt2Filetype()
endif

if !has_key(s:disabled_packages, 'pgsql')
  au BufNewFile,BufRead *.pgsql let b:sql_type_override='pgsql' | set ft=sql
endif

if !has_key(s:disabled_packages, 'cql')
  au BufNewFile,BufRead *.cql set ft=cql
endif

if !has_key(s:disabled_packages, 'php')
  au BufNewFile,BufRead *.aw set ft=php
  au BufNewFile,BufRead *.ctp set ft=php
  au BufNewFile,BufRead *.fcgi set ft=php
  au BufNewFile,BufRead *.inc set ft=php
  au BufNewFile,BufRead *.php set ft=php
  au BufNewFile,BufRead *.php3 set ft=php
  au BufNewFile,BufRead *.php4 set ft=php
  au BufNewFile,BufRead *.php5 set ft=php
  au BufNewFile,BufRead *.phps set ft=php
  au BufNewFile,BufRead *.phpt set ft=php
  au BufNewFile,BufRead {.,}php set ft=php
  au BufNewFile,BufRead {.,}php_cs set ft=php
  au BufNewFile,BufRead {.,}php_cs.dist set ft=php
  au BufNewFile,BufRead Phakefile set ft=php
endif

if !has_key(s:disabled_packages, 'blade')
  au BufNewFile,BufRead *.blade set ft=blade
  au BufNewFile,BufRead *.blade.php set ft=blade
endif

if !has_key(s:disabled_packages, 'plantuml')
  au BufNewFile,BufRead *.iuml set ft=plantuml
  au BufNewFile,BufRead *.plantuml set ft=plantuml
  au BufNewFile,BufRead *.pu set ft=plantuml
  au BufNewFile,BufRead *.puml set ft=plantuml
  au BufNewFile,BufRead *.uml set ft=plantuml
endif

if !has_key(s:disabled_packages, 'pony')
  au BufNewFile,BufRead *.pony set ft=pony
endif

if !has_key(s:disabled_packages, 'powershell')
  au BufNewFile,BufRead *.ps1 set ft=ps1
  au BufNewFile,BufRead *.psd1 set ft=ps1
  au BufNewFile,BufRead *.psm1 set ft=ps1
  au BufNewFile,BufRead *.pssc set ft=ps1
  au BufNewFile,BufRead *.ps1xml set ft=ps1xml
endif

if !has_key(s:disabled_packages, 'protobuf')
  au BufNewFile,BufRead *.proto set ft=proto
endif

if !has_key(s:disabled_packages, 'pug')
  au BufNewFile,BufRead *.jade set ft=pug
  au BufNewFile,BufRead *.pug set ft=pug
endif

if !has_key(s:disabled_packages, 'puppet')
  au BufNewFile,BufRead *.pp set ft=puppet
  au BufNewFile,BufRead Modulefile set ft=puppet
  au BufNewFile,BufRead *.epp set ft=embeddedpuppet
endif

if !has_key(s:disabled_packages, 'purescript')
  au BufNewFile,BufRead *.purs set ft=purescript
endif

if !has_key(s:disabled_packages, 'python')
  au BufNewFile,BufRead *.cgi set ft=python
  au BufNewFile,BufRead *.fcgi set ft=python
  au BufNewFile,BufRead *.gyp set ft=python
  au BufNewFile,BufRead *.gypi set ft=python
  au BufNewFile,BufRead *.lmi set ft=python
  au BufNewFile,BufRead *.py set ft=python
  au BufNewFile,BufRead *.py3 set ft=python
  au BufNewFile,BufRead *.pyde set ft=python
  au BufNewFile,BufRead *.pyi set ft=python
  au BufNewFile,BufRead *.pyp set ft=python
  au BufNewFile,BufRead *.pyt set ft=python
  au BufNewFile,BufRead *.pyw set ft=python
  au BufNewFile,BufRead *.rpy set ft=python
  au BufNewFile,BufRead *.smk set ft=python
  au BufNewFile,BufRead *.spec set ft=python
  au BufNewFile,BufRead *.tac set ft=python
  au BufNewFile,BufRead *.wsgi set ft=python
  au BufNewFile,BufRead *.xpy set ft=python
  au BufNewFile,BufRead {.,}gclient set ft=python
  au BufNewFile,BufRead DEPS set ft=python
  au BufNewFile,BufRead SConscript set ft=python
  au BufNewFile,BufRead SConstruct set ft=python
  au BufNewFile,BufRead Snakefile set ft=python
  au BufNewFile,BufRead wscript set ft=python
endif

if !has_key(s:disabled_packages, 'requirements')
  au BufNewFile,BufRead *.pip set ft=requirements
  au BufNewFile,BufRead *require.{txt,in} set ft=requirements
  au BufNewFile,BufRead *requirements.{txt,in} set ft=requirements
  au BufNewFile,BufRead constraints.{txt,in} set ft=requirements
endif

if !has_key(s:disabled_packages, 'qmake')
  au BufNewFile,BufRead *.pri set ft=qmake
  au BufNewFile,BufRead *.pro set ft=qmake
endif

if !has_key(s:disabled_packages, 'qml')
  au BufNewFile,BufRead *.qbs set ft=qml
  au BufNewFile,BufRead *.qml set ft=qml
endif

if !has_key(s:disabled_packages, 'r-lang')
  au BufNewFile,BufRead *.S set ft=r
  au BufNewFile,BufRead *.r set ft=r
  au BufNewFile,BufRead *.rsx set ft=r
  au BufNewFile,BufRead *.s set ft=r
  au BufNewFile,BufRead {.,}Rprofile set ft=r
  au BufNewFile,BufRead expr-dist set ft=r
  au BufNewFile,BufRead *.rd set ft=rhelp
endif

if !has_key(s:disabled_packages, 'racket')
  au BufNewFile,BufRead *.rkt set ft=racket
  au BufNewFile,BufRead *.rktd set ft=racket
  au BufNewFile,BufRead *.rktl set ft=racket
  au BufNewFile,BufRead *.scrbl set ft=racket
endif

if !has_key(s:disabled_packages, 'ragel')
  au BufNewFile,BufRead *.rl set ft=ragel
endif

if !has_key(s:disabled_packages, 'raku')
  au BufNewFile,BufRead *.6pl set ft=raku
  au BufNewFile,BufRead *.6pm set ft=raku
  au BufNewFile,BufRead *.nqp set ft=raku
  au BufNewFile,BufRead *.p6 set ft=raku
  au BufNewFile,BufRead *.p6l set ft=raku
  au BufNewFile,BufRead *.p6m set ft=raku
  au BufNewFile,BufRead *.pl6 set ft=raku
  au BufNewFile,BufRead *.pm6 set ft=raku
  au BufNewFile,BufRead *.pod6 set ft=raku
  au BufNewFile,BufRead *.raku set ft=raku
  au BufNewFile,BufRead *.rakudoc set ft=raku
  au BufNewFile,BufRead *.rakumod set ft=raku
  au BufNewFile,BufRead *.rakutest set ft=raku
  au BufNewFile,BufRead *.t6 set ft=raku
  au! BufNewFile,BufRead *.pl call polyglot#DetectPlFiletype()
  au! BufNewFile,BufRead *.pm call polyglot#DetectPmFiletype()
  au! BufNewFile,BufRead *.t call polyglot#DetectTFiletype()
endif

if !has_key(s:disabled_packages, 'raml')
  au BufNewFile,BufRead *.raml set ft=raml
endif

if !has_key(s:disabled_packages, 'razor')
  au BufNewFile,BufRead *.cshtml set ft=razor
  au BufNewFile,BufRead *.razor set ft=razor
endif

if !has_key(s:disabled_packages, 'reason')
  au BufNewFile,BufRead *.rei set ft=reason
  au! BufNewFile,BufRead *.re call polyglot#DetectReFiletype()
endif

if !has_key(s:disabled_packages, 'rst')
  au BufNewFile,BufRead *.rest set ft=rst
  au BufNewFile,BufRead *.rest.txt set ft=rst
  au BufNewFile,BufRead *.rst set ft=rst
  au BufNewFile,BufRead *.rst.txt set ft=rst
endif

if !has_key(s:disabled_packages, 'ruby')
  au BufNewFile,BufRead *.axlsx set ft=ruby
  au BufNewFile,BufRead *.builder set ft=ruby
  au BufNewFile,BufRead *.cap set ft=ruby
  au BufNewFile,BufRead *.eye set ft=ruby
  au BufNewFile,BufRead *.fcgi set ft=ruby
  au BufNewFile,BufRead *.gemspec set ft=ruby
  au BufNewFile,BufRead *.god set ft=ruby
  au BufNewFile,BufRead *.jbuilder set ft=ruby
  au BufNewFile,BufRead *.mspec set ft=ruby
  au BufNewFile,BufRead *.opal set ft=ruby
  au BufNewFile,BufRead *.pluginspec set ft=ruby
  au BufNewFile,BufRead *.podspec set ft=ruby
  au BufNewFile,BufRead *.rabl set ft=ruby
  au BufNewFile,BufRead *.rake set ft=ruby
  au BufNewFile,BufRead *.rant set ft=ruby
  au BufNewFile,BufRead *.rb set ft=ruby
  au BufNewFile,BufRead *.rbi set ft=ruby
  au BufNewFile,BufRead *.rbuild set ft=ruby
  au BufNewFile,BufRead *.rbw set ft=ruby
  au BufNewFile,BufRead *.rbx set ft=ruby
  au BufNewFile,BufRead *.rjs set ft=ruby
  au BufNewFile,BufRead *.ru set ft=ruby
  au BufNewFile,BufRead *.ruby set ft=ruby
  au BufNewFile,BufRead *.rxml set ft=ruby
  au BufNewFile,BufRead *.spec set ft=ruby
  au BufNewFile,BufRead *.thor set ft=ruby
  au BufNewFile,BufRead *.watchr set ft=ruby
  au BufNewFile,BufRead {.,}Brewfile set ft=ruby
  au BufNewFile,BufRead {.,}Guardfile set ft=ruby
  au BufNewFile,BufRead {.,}autotest set ft=ruby
  au BufNewFile,BufRead {.,}irbrc set ft=ruby
  au BufNewFile,BufRead {.,}pryrc set ft=ruby
  au BufNewFile,BufRead {.,}simplecov set ft=ruby
  au BufNewFile,BufRead Appraisals set ft=ruby
  au BufNewFile,BufRead Berksfile set ft=ruby
  au BufNewFile,BufRead Buildfile set ft=ruby
  au BufNewFile,BufRead Capfile set ft=ruby
  au BufNewFile,BufRead Cheffile set ft=ruby
  au BufNewFile,BufRead Dangerfile set ft=ruby
  au BufNewFile,BufRead Deliverfile set ft=ruby
  au BufNewFile,BufRead Fastfile set ft=ruby
  au BufNewFile,BufRead Gemfile set ft=ruby
  au BufNewFile,BufRead Gemfile.lock set ft=ruby
  au BufNewFile,BufRead Guardfile set ft=ruby
  au BufNewFile,BufRead Jarfile set ft=ruby
  au BufNewFile,BufRead KitchenSink set ft=ruby
  au BufNewFile,BufRead Mavenfile set ft=ruby
  au BufNewFile,BufRead Podfile set ft=ruby
  au BufNewFile,BufRead Puppetfile set ft=ruby
  au BufNewFile,BufRead Rakefile set ft=ruby
  au BufNewFile,BufRead Rantfile set ft=ruby
  au BufNewFile,BufRead Routefile set ft=ruby
  au BufNewFile,BufRead Snapfile set ft=ruby
  au BufNewFile,BufRead Thorfile set ft=ruby
  au BufNewFile,BufRead Vagrantfile set ft=ruby
  au BufNewFile,BufRead [Rr]akefile* call s:StarSetf('ruby')
  au BufNewFile,BufRead buildfile set ft=ruby
  au BufNewFile,BufRead vagrantfile set ft=ruby
  au BufNewFile,BufRead *.erb set ft=eruby
  au BufNewFile,BufRead *.erb.deface set ft=eruby
  au BufNewFile,BufRead *.rhtml set ft=eruby
endif

if !has_key(s:disabled_packages, 'rspec')
  au BufNewFile,BufRead *_spec.rb set ft=ruby syntax=rspec
endif

if !has_key(s:disabled_packages, 'brewfile')
  au BufNewFile,BufRead Brewfile set ft=brewfile
endif

if !has_key(s:disabled_packages, 'rust')
  au BufNewFile,BufRead *.rs set ft=rust
  au BufNewFile,BufRead *.rs.in set ft=rust
endif

if !has_key(s:disabled_packages, 'scala')
  au BufNewFile,BufRead *.kojo set ft=scala
  au BufNewFile,BufRead *.sc set ft=scala
  au BufNewFile,BufRead *.scala set ft=scala
endif

if !has_key(s:disabled_packages, 'sbt')
  au BufNewFile,BufRead *.sbt set ft=sbt.scala
endif

if !has_key(s:disabled_packages, 'scss')
  au BufNewFile,BufRead *.scss set ft=scss
endif

if !has_key(s:disabled_packages, 'sh')
  au BufNewFile,BufRead *.bash set ft=sh
  au BufNewFile,BufRead *.bats set ft=sh
  au BufNewFile,BufRead *.cgi set ft=sh
  au BufNewFile,BufRead *.command set ft=sh
  au BufNewFile,BufRead *.env set ft=sh
  au BufNewFile,BufRead *.fcgi set ft=sh
  au BufNewFile,BufRead *.ksh set ft=sh
  au BufNewFile,BufRead *.sh set ft=sh
  au BufNewFile,BufRead *.sh.in set ft=sh
  au BufNewFile,BufRead *.tmux set ft=sh
  au BufNewFile,BufRead *.tool set ft=sh
  au BufNewFile,BufRead {.,}bash_aliases set ft=sh
  au BufNewFile,BufRead {.,}bash_history set ft=sh
  au BufNewFile,BufRead {.,}bash_logout set ft=sh
  au BufNewFile,BufRead {.,}bash_profile set ft=sh
  au BufNewFile,BufRead {.,}bashrc set ft=sh
  au BufNewFile,BufRead {.,}cshrc set ft=sh
  au BufNewFile,BufRead {.,}env set ft=sh
  au BufNewFile,BufRead {.,}env.example set ft=sh
  au BufNewFile,BufRead {.,}flaskenv set ft=sh
  au BufNewFile,BufRead {.,}login set ft=sh
  au BufNewFile,BufRead {.,}profile set ft=sh
  au BufNewFile,BufRead 9fs set ft=sh
  au BufNewFile,BufRead PKGBUILD set ft=sh
  au BufNewFile,BufRead bash_aliases set ft=sh
  au BufNewFile,BufRead bash_logout set ft=sh
  au BufNewFile,BufRead bash_profile set ft=sh
  au BufNewFile,BufRead bashrc set ft=sh
  au BufNewFile,BufRead cshrc set ft=sh
  au BufNewFile,BufRead gradlew set ft=sh
  au BufNewFile,BufRead login set ft=sh
  au BufNewFile,BufRead man set ft=sh
  au BufNewFile,BufRead profile set ft=sh
  au BufNewFile,BufRead *.zsh set ft=zsh
  au BufNewFile,BufRead {.,}zlogin set ft=zsh
  au BufNewFile,BufRead {.,}zlogout set ft=zsh
  au BufNewFile,BufRead {.,}zprofile set ft=zsh
  au BufNewFile,BufRead {.,}zshenv set ft=zsh
  au BufNewFile,BufRead {.,}zshrc set ft=zsh
endif

if !has_key(s:disabled_packages, 'slim')
  au BufNewFile,BufRead *.slim set ft=slim
endif

if !has_key(s:disabled_packages, 'slime')
  au BufNewFile,BufRead *.slime set ft=slime
endif

if !has_key(s:disabled_packages, 'smt2')
  au BufNewFile,BufRead *.smt set ft=smt2
  au BufNewFile,BufRead *.smt2 set ft=smt2
endif

if !has_key(s:disabled_packages, 'solidity')
  au BufNewFile,BufRead *.sol set ft=solidity
endif

if !has_key(s:disabled_packages, 'stylus')
  au BufNewFile,BufRead *.styl set ft=stylus
  au BufNewFile,BufRead *.stylus set ft=stylus
endif

if !has_key(s:disabled_packages, 'svelte')
  au BufNewFile,BufRead *.svelte set ft=svelte
endif

if !has_key(s:disabled_packages, 'svg')
  au BufNewFile,BufRead *.svg set ft=svg
endif

if !has_key(s:disabled_packages, 'swift')
  au BufNewFile,BufRead *.swift set ft=swift
endif

if !has_key(s:disabled_packages, 'sxhkd')
  au BufNewFile,BufRead *.sxhkdrc set ft=sxhkdrc
  au BufNewFile,BufRead sxhkdrc set ft=sxhkdrc
endif

if !has_key(s:disabled_packages, 'systemd')
  au BufNewFile,BufRead *.automount set ft=systemd
  au BufNewFile,BufRead *.mount set ft=systemd
  au BufNewFile,BufRead *.path set ft=systemd
  au BufNewFile,BufRead *.service set ft=systemd
  au BufNewFile,BufRead *.socket set ft=systemd
  au BufNewFile,BufRead *.swap set ft=systemd
  au BufNewFile,BufRead *.target set ft=systemd
  au BufNewFile,BufRead *.timer set ft=systemd
endif

if !has_key(s:disabled_packages, 'terraform')
  au BufNewFile,BufRead *.hcl set ft=terraform
  au BufNewFile,BufRead *.nomad set ft=terraform
  au BufNewFile,BufRead *.tf set ft=terraform
  au BufNewFile,BufRead *.tfvars set ft=terraform
  au BufNewFile,BufRead *.workflow set ft=terraform
endif

if !has_key(s:disabled_packages, 'textile')
  au BufNewFile,BufRead *.textile set ft=textile
endif

if !has_key(s:disabled_packages, 'thrift')
  au BufNewFile,BufRead *.thrift set ft=thrift
endif

if !has_key(s:disabled_packages, 'tmux')
  au BufNewFile,BufRead {.,}tmux.conf set ft=tmux
endif

if !has_key(s:disabled_packages, 'toml')
  au BufNewFile,BufRead *.toml set ft=toml
  au BufNewFile,BufRead */.cargo/config set ft=toml
  au BufNewFile,BufRead */.cargo/credentials set ft=toml
  au BufNewFile,BufRead Cargo.lock set ft=toml
  au BufNewFile,BufRead Gopkg.lock set ft=toml
  au BufNewFile,BufRead Pipfile set ft=toml
  au BufNewFile,BufRead poetry.lock set ft=toml
endif

if !has_key(s:disabled_packages, 'tptp')
  au BufNewFile,BufRead *.ax set ft=tptp
  au BufNewFile,BufRead *.p set ft=tptp
  au BufNewFile,BufRead *.tptp set ft=tptp
endif

if !has_key(s:disabled_packages, 'twig')
  au BufNewFile,BufRead *.twig set ft=html.twig
  au BufNewFile,BufRead *.xml.twig set ft=xml.twig
endif

if !has_key(s:disabled_packages, 'typescript')
  au BufNewFile,BufRead *.ts set ft=typescript
  au BufNewFile,BufRead *.tsx set ft=typescriptreact
endif

if !has_key(s:disabled_packages, 'unison')
  au BufNewFile,BufRead *.u set ft=unison
  au BufNewFile,BufRead *.uu set ft=unison
endif

if !has_key(s:disabled_packages, 'v')
  au BufNewFile,BufRead *.v set ft=v
endif

if !has_key(s:disabled_packages, 'vala')
  au BufNewFile,BufRead *.vala set ft=vala
  au BufNewFile,BufRead *.valadoc set ft=vala
  au BufNewFile,BufRead *.vapi set ft=vala
endif

if !has_key(s:disabled_packages, 'vbnet')
  au BufNewFile,BufRead *.vb set ft=vbnet
  au BufNewFile,BufRead *.vbhtml set ft=vbnet
endif

if !has_key(s:disabled_packages, 'vcl')
  au BufNewFile,BufRead *.vcl set ft=vcl
endif

if !has_key(s:disabled_packages, 'velocity')
  au BufNewFile,BufRead *.vm set ft=velocity
endif

if !has_key(s:disabled_packages, 'vmasm')
  au BufNewFile,BufRead *.mar set ft=vmasm
endif

if !has_key(s:disabled_packages, 'vue')
  au BufNewFile,BufRead *.vue set ft=vue
  au BufNewFile,BufRead *.wpy set ft=vue
endif

if !has_key(s:disabled_packages, 'xdc')
  au BufNewFile,BufRead *.xdc set ft=xdc
endif

if !has_key(s:disabled_packages, 'xsl')
  au BufNewFile,BufRead *.xsl set ft=xsl
  au BufNewFile,BufRead *.xslt set ft=xsl
endif

if !has_key(s:disabled_packages, 'yaml')
  au BufNewFile,BufRead *.mir set ft=yaml
  au BufNewFile,BufRead *.reek set ft=yaml
  au BufNewFile,BufRead *.rviz set ft=yaml
  au BufNewFile,BufRead *.sublime-syntax set ft=yaml
  au BufNewFile,BufRead *.syntax set ft=yaml
  au BufNewFile,BufRead *.yaml set ft=yaml
  au BufNewFile,BufRead *.yaml-tmlanguage set ft=yaml
  au BufNewFile,BufRead *.yaml.sed set ft=yaml
  au BufNewFile,BufRead *.yml set ft=yaml
  au BufNewFile,BufRead *.yml.mysql set ft=yaml
  au BufNewFile,BufRead {.,}clang-format set ft=yaml
  au BufNewFile,BufRead {.,}clang-tidy set ft=yaml
  au BufNewFile,BufRead {.,}gemrc set ft=yaml
  au BufNewFile,BufRead fish_history set ft=yaml
  au BufNewFile,BufRead fish_read_history set ft=yaml
  au BufNewFile,BufRead glide.lock set ft=yaml
  au BufNewFile,BufRead yarn.lock set ft=yaml
endif

if !has_key(s:disabled_packages, 'ansible')
  au BufNewFile,BufRead group_vars/* call s:StarSetf('yaml.ansible')
  au BufNewFile,BufRead handlers.*.y{a,}ml set ft=yaml.ansible
  au BufNewFile,BufRead host_vars/* call s:StarSetf('yaml.ansible')
  au BufNewFile,BufRead local.y{a,}ml set ft=yaml.ansible
  au BufNewFile,BufRead main.y{a,}ml set ft=yaml.ansible
  au BufNewFile,BufRead playbook.y{a,}ml set ft=yaml.ansible
  au BufNewFile,BufRead requirements.y{a,}ml set ft=yaml.ansible
  au BufNewFile,BufRead roles.*.y{a,}ml set ft=yaml.ansible
  au BufNewFile,BufRead site.y{a,}ml set ft=yaml.ansible
  au BufNewFile,BufRead tasks.*.y{a,}ml set ft=yaml.ansible
endif

if !has_key(s:disabled_packages, 'helm')
  au BufNewFile,BufRead */templates/*.tpl set ft=helm
  au BufNewFile,BufRead */templates/*.yaml set ft=helm
endif

if !has_key(s:disabled_packages, 'help')
  au BufNewFile,BufRead $VIMRUNTIME/doc/*.txt set ft=help
endif

if !has_key(s:disabled_packages, 'zephir')
  au BufNewFile,BufRead *.zep set ft=zephir
endif

if !has_key(s:disabled_packages, 'zig')
  au BufNewFile,BufRead *.zir set ft=zir
  au BufNewFile,BufRead *.zig set ft=zig
  au BufNewFile,BufRead *.zir set ft=zig
endif

if !has_key(s:disabled_packages, 'trasys')
  au! BufNewFile,BufRead *.inp call polyglot#DetectInpFiletype()
endif

if !has_key(s:disabled_packages, 'basic')
  au BufNewFile,BufRead *.basic set ft=basic
endif

if !has_key(s:disabled_packages, 'visual-basic')
  au BufNewFile,BufRead *.cls set ft=vb
  au BufNewFile,BufRead *.ctl set ft=vb
  au BufNewFile,BufRead *.dsm set ft=vb
  au BufNewFile,BufRead *.frm set ft=vb
  au BufNewFile,BufRead *.frx set ft=vb
  au BufNewFile,BufRead *.sba set ft=vb
  au BufNewFile,BufRead *.vba set ft=vb
  au BufNewFile,BufRead *.vbs set ft=vb
  au! BufNewFile,BufRead *.bas call polyglot#DetectBasFiletype()
endif

if !has_key(s:disabled_packages, 'dosini')
  au BufNewFile,BufRead *.dof set ft=dosini
  au BufNewFile,BufRead *.ini set ft=dosini
  au BufNewFile,BufRead *.lektorproject set ft=dosini
  au BufNewFile,BufRead *.prefs set ft=dosini
  au BufNewFile,BufRead *.pro set ft=dosini
  au BufNewFile,BufRead *.properties set ft=dosini
  au BufNewFile,BufRead */etc/pacman.conf set ft=dosini
  au BufNewFile,BufRead */etc/yum.conf set ft=dosini
  au BufNewFile,BufRead */etc/yum.repos.d/* call s:StarSetf('dosini')
  au BufNewFile,BufRead {.,}editorconfig set ft=dosini
  au BufNewFile,BufRead {.,}npmrc set ft=dosini
  au BufNewFile,BufRead buildozer.spec set ft=dosini
  au BufNewFile,BufRead php.ini-* call s:StarSetf('dosini')
endif

if !has_key(s:disabled_packages, 'odin')
  au BufNewFile,BufRead *.odin set ft=odin
endif

if !has_key(s:disabled_packages, 'bzl')
  au BufNewFile,BufRead *.bzl set ft=bzl
  au BufNewFile,BufRead BUCK set ft=bzl
  au BufNewFile,BufRead BUILD set ft=bzl
  au BufNewFile,BufRead BUILD.bazel set ft=bzl
  au BufNewFile,BufRead Tiltfile set ft=bzl
  au BufNewFile,BufRead WORKSPACE set ft=bzl
endif

if !has_key(s:disabled_packages, 'prolog')
  au BufNewFile,BufRead *.pro set ft=prolog
  au BufNewFile,BufRead *.prolog set ft=prolog
  au BufNewFile,BufRead *.yap set ft=prolog
  au! BufNewFile,BufRead *.pl call polyglot#DetectPlFiletype()
endif

if !has_key(s:disabled_packages, 'tads')
  au! BufNewFile,BufRead *.t call polyglot#DetectTFiletype()
endif


" end filetypes

func! s:PolyglotFallback() 
  if expand("<afile>") !~ g:ft_ignore_pat
    if getline(1) =~# "^#!"
      call polyglot#Shebang()
    endif
    if &filetype == ''
      runtime! scripts.vim
    endif
  endif
endfunc

au BufNewFile,BufRead,StdinReadPost * call s:PolyglotFallback()

augroup END

if !has_key(s:disabled_packages, 'autoindent')
  " Code below re-implements sleuth for vim-polyglot
  let g:loaded_sleuth = 1
  let g:loaded_foobar = 1

  " Makes shiftwidth to be synchronized with tabstop by default
  if &shiftwidth == &tabstop
    let &shiftwidth = 0
  endif

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

      if !len(line) || line =~# '^\W*$'
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
        let &shiftwidth=&tabstop
        let b:sleuth_culprit .= ':' . i
        return 1
      elseif line[0] == " "
        let indent = len(matchstr(line, '^ *'))
        if (indent % 2 == 0 || indent % 3 == 0) && indent < minindent
          let minindent = indent
        endif
      endif
    endfor

    if minindent < 10
      setlocal expandtab
      let &shiftwidth=minindent
      let b:sleuth_culprit .= ':' . i
      return 1
    endif

    return 0
  endfunction

  function! s:detect_indent() abort
    if &buftype ==# 'help'
      return
    endif

    let b:sleuth_culprit = expand("<afile>:p")
    if s:guess(getline(1, 32))
      return
    endif
    let pattern = sleuth#GlobForFiletype(&filetype)
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

  setglobal smarttab

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
    au FileType * call s:detect_indent()
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

func! s:observe_filetype()
  augroup polyglot-observer
    au! CursorHold,CursorHoldI <buffer>
      \ if polyglot#Shebang() | au! polyglot-observer CursorHold,CursorHoldI | endif
  augroup END
endfunc

au BufEnter * if &ft == "" && expand("<afile>") !~ g:ft_ignore_pat
      \ | call s:observe_filetype() | endif

" restore Vi compatibility settings
let &cpo = s:cpo_save
unlet s:cpo_save
