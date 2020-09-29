" Vim support file to detect file types
"
" Maintainer:	Adam Stankiewicz <sheerun@sher.pl>
" URL: https://github.com/sheerun/vim-polyglot

" Listen very carefully, I will say this only once
if exists("did_load_polyglot")
  finish
endif
let did_load_polyglot = 1

" Line continuation is used here, remove 'C' from 'cpoptions'
let s:cpo_save = &cpo
set cpo&vim

" Disable all native vim ftdetect
if exists('g:polyglot_test')
  autocmd!
endif

func! s:Observe(fn)
  let b:polyglot_observe = a:fn
  augroup polyglot-observer
    au! CursorHold,CursorHoldI,BufWritePost <buffer>
      \ execute('if polyglot#' . b:polyglot_observe . '() | au! polyglot-observer | endif')
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

" DO NOT EDIT CODE BELOW, IT IS GENERATED WITH MAKEFILE

if !has_key(s:disabled_packages, 'sql')
  au BufNewFile,BufRead *.bdy,*.ddl,*.fnc,*.pck,*.pkb,*.pks,*.plb,*.pls,*.plsql,*.prc,*.spc,*.sql,*.tpb,*.tps,*.trg,*.tyb,*.tyc,*.typ,*.vw setf sql
endif

if !has_key(s:disabled_packages, 'gitignore')
  au BufNewFile,BufRead *.git/info/exclude,*/.config/git/ignore,{.,}gitignore setf gitignore
endif

if !has_key(s:disabled_packages, 'tads')
  au! BufNewFile,BufRead *.t call polyglot#detect#T()
endif

if !has_key(s:disabled_packages, 'prolog')
  au! BufNewFile,BufRead *.pl call polyglot#detect#Pl()
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

if !has_key(s:disabled_packages, 'visual-basic')
  au! BufNewFile,BufRead *.bas call polyglot#detect#Bas()
  au BufNewFile,BufRead *.cls,*.ctl,*.dsm,*.frm,*.frx,*.sba,*.vba,*.vbs setf vb
endif

if !has_key(s:disabled_packages, 'basic')
  au BufNewFile,BufRead *.basic setf basic
endif

if !has_key(s:disabled_packages, 'trasys')
  au! BufNewFile,BufRead *.inp call polyglot#detect#Inp()
endif

if !has_key(s:disabled_packages, 'zig')
  au BufNewFile,BufRead *.zig,*.zir setf zig
  au BufNewFile,BufRead *.zir setf zir
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
  au BufNewFile,BufRead *.v setf v
endif

if !has_key(s:disabled_packages, 'unison')
  au BufNewFile,BufRead *.u,*.uu setf unison
endif

if !has_key(s:disabled_packages, 'typescript')
  au BufNewFile,BufRead *.tsx setf typescriptreact
  au BufNewFile,BufRead *.ts setf typescript
endif

if !has_key(s:disabled_packages, 'twig')
  au BufNewFile,BufRead *.xml.twig setf xml.twig
  au BufNewFile,BufRead *.twig setf html.twig
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

if !has_key(s:disabled_packages, 'svg-indent')
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

if !has_key(s:disabled_packages, 'zinit')
endif

if !has_key(s:disabled_packages, 'sh')
  au BufNewFile,BufRead *.zsh,{.,}zfbfmarks,{.,}zlogin,{.,}zlogout,{.,}zprofile,{.,}zshenv,{.,}zshrc setf zsh
  au BufNewFile,BufRead {.,}zsh* call s:StarSetf('zsh')
  au BufNewFile,BufRead {.,}zlog* call s:StarSetf('zsh')
  au BufNewFile,BufRead {.,}zcompdump* call s:StarSetf('zsh')
  au BufNewFile,BufRead *.bash,*.bats,*.cgi,*.command,*.env,*.fcgi,*.ksh,*.sh,*.sh.in,*.tmux,*.tool,*/etc/udev/cdsymlinks.conf,{.,}bash_aliases,{.,}bash_history,{.,}bash_logout,{.,}bash_profile,{.,}bashrc,{.,}cshrc,{.,}env,{.,}env.example,{.,}flaskenv,{.,}login,{.,}profile,9fs,PKGBUILD,bash_aliases,bash_logout,bash_profile,bashrc,cshrc,gradlew,login,man,profile,zlogin,zlogout,zprofile,zshenv,zshrc setf sh
endif

if !has_key(s:disabled_packages, 'scss')
  au BufNewFile,BufRead *.scss setf scss
endif

if !has_key(s:disabled_packages, 'sbt')
  au BufNewFile,BufRead *.sbt setf sbt.scala
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

if !has_key(s:disabled_packages, 'yard')
endif

if !has_key(s:disabled_packages, 'rspec')
  au BufNewFile,BufRead *_spec.rb set ft=ruby syntax=rspec
endif

if !has_key(s:disabled_packages, 'ruby')
  au BufNewFile,BufRead *.erb,*.erb.deface,*.rhtml setf eruby
  au BufNewFile,BufRead *.axlsx,*.builder,*.cap,*.eye,*.fcgi,*.gemspec,*.god,*.jbuilder,*.mspec,*.opal,*.pluginspec,*.podspec,*.rabl,*.rake,*.rant,*.rb,*.rbi,*.rbuild,*.rbw,*.rbx,*.rjs,*.ru,*.ruby,*.rxml,*.spec,*.thor,*.watchr,{.,}Brewfile,{.,}Guardfile,{.,}autotest,{.,}irbrc,{.,}pryrc,{.,}simplecov,Appraisals,Berksfile,Buildfile,Capfile,Cheffile,Dangerfile,Deliverfile,Fastfile,Gemfile,Gemfile.lock,Guardfile,Jarfile,KitchenSink,Mavenfile,Podfile,Puppetfile,Rakefile,Rantfile,Routefile,Snapfile,Thorfile,Vagrantfile,buildfile,vagrantfile setf ruby
  au BufNewFile,BufRead [Rr]akefile* call s:StarSetf('ruby')
endif

if !has_key(s:disabled_packages, 'rst')
  au BufNewFile,BufRead *.rest,*.rest.txt,*.rst,*.rst.txt setf rst
endif

if !has_key(s:disabled_packages, 'reason')
  au! BufNewFile,BufRead *.re call polyglot#detect#Re()
  au BufNewFile,BufRead *.rei setf reason
endif

if !has_key(s:disabled_packages, 'razor')
  au BufNewFile,BufRead *.cshtml,*.razor setf razor
endif

if !has_key(s:disabled_packages, 'raml')
  au BufNewFile,BufRead *.raml setf raml
endif

if !has_key(s:disabled_packages, 'raku')
  au! BufNewFile,BufRead *.t call polyglot#detect#T()
  au! BufNewFile,BufRead *.pm call polyglot#detect#Pm()
  au! BufNewFile,BufRead *.pl call polyglot#detect#Pl()
  au BufNewFile,BufRead *.6pl,*.6pm,*.nqp,*.p6,*.p6l,*.p6m,*.pl6,*.pm6,*.pod6,*.raku,*.rakudoc,*.rakumod,*.rakutest,*.t6 setf raku
endif

if !has_key(s:disabled_packages, 'ragel')
  au BufNewFile,BufRead *.rl setf ragel
endif

if !has_key(s:disabled_packages, 'racket')
  au BufNewFile,BufRead *.rkt,*.rktd,*.rktl,*.scrbl setf racket
endif

if !has_key(s:disabled_packages, 'r-lang')
  au BufNewFile,BufRead *.rd setf rhelp
  au BufNewFile,BufRead *.S,*.r,*.rsx,*.s,{.,}Rprofile,expr-dist setf r
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

if !has_key(s:disabled_packages, 'python-compiler')
endif

if !has_key(s:disabled_packages, 'python-indent')
endif

if !has_key(s:disabled_packages, 'python')
  au BufNewFile,BufRead *.cgi,*.fcgi,*.gyp,*.gypi,*.lmi,*.ptl,*.py,*.py3,*.pyde,*.pyi,*.pyp,*.pyt,*.pyw,*.rpy,*.smk,*.spec,*.tac,*.wsgi,*.xpy,{.,}gclient,{.,}pythonrc,{.,}pythonstartup,DEPS,SConscript,SConstruct,Snakefile,wscript setf python
endif

if !has_key(s:disabled_packages, 'purescript')
  au BufNewFile,BufRead *.purs setf purescript
endif

if !has_key(s:disabled_packages, 'puppet')
  au BufNewFile,BufRead *.epp setf embeddedpuppet
  au BufNewFile,BufRead *.pp,Modulefile setf puppet
endif

if !has_key(s:disabled_packages, 'pug')
  au BufNewFile,BufRead *.jade,*.pug setf pug
endif

if !has_key(s:disabled_packages, 'protobuf')
  au BufNewFile,BufRead *.proto setf proto
endif

if !has_key(s:disabled_packages, 'powershell')
  au BufNewFile,BufRead *.ps1xml setf ps1xml
  au BufNewFile,BufRead *.ps1,*.psd1,*.psm1,*.pssc setf ps1
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
  au BufNewFile,BufRead *.aw,*.ctp,*.fcgi,*.inc,*.php,*.php3,*.php4,*.php5,*.phps,*.phpt,*.phtml,{.,}php,{.,}php_cs,{.,}php_cs.dist,Phakefile setf php
endif

if !has_key(s:disabled_packages, 'cql')
  au BufNewFile,BufRead *.cql setf cql
endif

if !has_key(s:disabled_packages, 'pgsql')
  au BufNewFile,BufRead *.pgsql let b:sql_type_override='pgsql' | set ft=sql
endif

if !has_key(s:disabled_packages, 'perl')
  au! BufNewFile,BufRead *.tt2 call polyglot#detect#Tt2()
  au! BufNewFile,BufRead *.t call polyglot#detect#T()
  au! BufNewFile,BufRead *.pm call polyglot#detect#Pm()
  au! BufNewFile,BufRead *.pl call polyglot#detect#Pl()
  au BufNewFile,BufRead *.xs setf xs
  au BufNewFile,BufRead *.comp,*.mason,*.mhtml setf mason
  au BufNewFile,BufRead *.pod setf pod
  au BufNewFile,BufRead *.al,*.cgi,*.fcgi,*.perl,*.ph,*.plx,*.psgi,{.,}gitolite.rc,Makefile.PL,Rexfile,ack,cpanfile,example.gitolite.rc setf perl
endif

if !has_key(s:disabled_packages, 'opencl')
  au BufNewFile,BufRead *.cl,*.opencl setf opencl
endif

if !has_key(s:disabled_packages, 'octave')
  au! BufNewFile,BufRead *.m call polyglot#detect#M()
  au BufNewFile,BufRead *.oct setf octave
endif

if !has_key(s:disabled_packages, 'ocaml')
  au BufNewFile,BufRead *.sexp setf sexplib
  au BufNewFile,BufRead *.root setf ocpbuildroot
  au BufNewFile,BufRead *.ocp setf ocpbuild
  au BufNewFile,BufRead _tags setf ocamlbuild_tags
  au BufNewFile,BufRead dune,dune-project,dune-workspace,jbuild setf dune
  au BufNewFile,BufRead _oasis setf oasis
  au BufNewFile,BufRead *.opam,*.opam.template,opam setf opam
  au BufNewFile,BufRead *.om,OMakefile,OMakeroot,OMakeroot.in setf omake
  au BufNewFile,BufRead *.eliom,*.eliomi,*.ml,*.ml.cppo,*.ml4,*.mli,*.mli.cppo,*.mlip,*.mll,*.mlp,*.mlt,*.mly,{.,}ocamlinit setf ocaml
endif

if !has_key(s:disabled_packages, 'objc')
  au! BufNewFile,BufRead *.m call polyglot#detect#M()
  au! BufNewFile,BufRead *.h call polyglot#detect#H()
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
  au! BufNewFile,BufRead *.m call polyglot#detect#M()
endif

if !has_key(s:disabled_packages, 'moonscript')
  au BufNewFile,BufRead *.moon setf moon
endif

if !has_key(s:disabled_packages, 'meson')
  au BufNewFile,BufRead *.wrap setf dosini
  au BufNewFile,BufRead meson.build,meson_options.txt setf meson
endif

if !has_key(s:disabled_packages, 'mdx')
  au BufNewFile,BufRead *.mdx setf markdown.mdx
endif

if !has_key(s:disabled_packages, 'markdown')
  au BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mdwn,*.mkd,*.mkdn,*.mkdown,*.ronn,*.workbook,contents.lr setf markdown
endif

if !has_key(s:disabled_packages, 'mathematica')
  au! BufNewFile,BufRead *.m call polyglot#detect#M()
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
  au BufNewFile,BufRead *.td setf tablegen
  au BufNewFile,BufRead *.ll setf llvm
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
  au BufNewFile,BufRead {.,}jqrc* call s:StarSetf('jq')
endif

if !has_key(s:disabled_packages, 'htmldjango')
  au BufNewFile,BufRead *.j2,*.jinja,*.jinja2,*.njk setf htmldjango
endif

if !has_key(s:disabled_packages, 'jenkins')
  au BufNewFile,BufRead *.Jenkinsfile,*.jenkinsfile,Jenkinsfile setf Jenkinsfile
  au BufNewFile,BufRead Jenkinsfile* call s:StarSetf('Jenkinsfile')
endif

if !has_key(s:disabled_packages, 'javascript-sql')
endif

if !has_key(s:disabled_packages, 'ion')
  au BufNewFile,BufRead *.ion,~/.config/ion/initrc setf ion
endif

if !has_key(s:disabled_packages, 'idris2')
  au! BufNewFile,BufRead *.lidr call polyglot#detect#Lidr()
  au! BufNewFile,BufRead *.idr call polyglot#detect#Idr()
  au BufNewFile,BufRead *.ipkg,idris-response setf idris2
endif

if !has_key(s:disabled_packages, 'idris')
  au! BufNewFile,BufRead *.lidr call polyglot#detect#Lidr()
  au! BufNewFile,BufRead *.idr call polyglot#detect#Idr()
  au BufNewFile,BufRead idris-response setf idris
endif

if !has_key(s:disabled_packages, 'icalendar')
  au BufNewFile,BufRead *.ics setf icalendar
endif

if !has_key(s:disabled_packages, 'i3')
  au BufNewFile,BufRead *.i3.config,*.i3config,{.,}i3.config,{.,}i3config,i3.config,i3config setf i3config
endif

if !has_key(s:disabled_packages, 'html5')
  au! BufNewFile,BufRead *.html call polyglot#detect#Html()
  au BufNewFile,BufRead *.htm,*.html.hl,*.inc,*.st,*.xht,*.xhtml setf html
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

if !has_key(s:disabled_packages, 'handlebars')
  au BufNewFile,BufRead *.handlebars,*.hb,*.hbs,*.hdbs setf html.handlebars
  au BufNewFile,BufRead *.hjs,*.hogan,*.hulk,*.mustache setf html.mustache
endif

if !has_key(s:disabled_packages, 'haml')
  au BufNewFile,BufRead *.haml,*.haml.deface,*.hamlbars,*.hamlc setf haml
endif

if !has_key(s:disabled_packages, 'grub')
  au BufNewFile,BufRead */boot/grub/grub.conf,*/boot/grub/menu.lst,*/etc/grub.conf setf grub
endif

if !has_key(s:disabled_packages, 'gradle')
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
  au BufNewFile,BufRead *.flow setf flow
  au BufNewFile,BufRead *._js,*.bones,*.cjs,*.es,*.es6,*.frag,*.gs,*.jake,*.javascript,*.js,*.jsb,*.jscad,*.jsfl,*.jsm,*.jss,*.mjs,*.njs,*.pac,*.sjs,*.ssjs,*.xsjs,*.xsjslib,Jakefile setf javascript
endif

if !has_key(s:disabled_packages, 'go')
  au BufNewFile,BufRead *.tmpl setf gohtmltmpl
  au BufNewFile,BufRead go.mod setf gomod
  au BufNewFile,BufRead *.go setf go
endif

if !has_key(s:disabled_packages, 'gnuplot')
  au BufNewFile,BufRead *.gnu,*.gnuplot,*.gp,*.gpi,*.p,*.plot,*.plt setf gnuplot
endif

if !has_key(s:disabled_packages, 'gmpl')
  au BufNewFile,BufRead *.mod setf gmpl
endif

if !has_key(s:disabled_packages, 'glsl')
  au! BufNewFile,BufRead *.fs call polyglot#detect#Fs()
  au BufNewFile,BufRead *.comp,*.fp,*.frag,*.frg,*.fsh,*.fshader,*.geo,*.geom,*.glsl,*.glslf,*.glslv,*.gs,*.gshader,*.shader,*.tesc,*.tese,*.vert,*.vrx,*.vsh,*.vshader setf glsl
endif

if !has_key(s:disabled_packages, 'git')
  au BufNewFile,BufRead COMMIT_EDITMSG,MERGE_MSG,TAG_EDITMSG setf gitcommit
  au BufNewFile,BufRead {.,}gitsendemail.* call s:StarSetf('gitsendemail')
  au BufNewFile,BufRead git-rebase-todo setf gitrebase
  au BufNewFile,BufRead *.gitconfig,*.git/config,*.git/modules/*/config,*/.config/git/config,*/git/config,{.,}gitconfig,{.,}gitmodules setf gitconfig
  au BufNewFile,BufRead */{.,}gitconfig.d/* call s:StarSetf('gitconfig')
endif

if !has_key(s:disabled_packages, 'gdscript')
  au BufNewFile,BufRead *.gd setf gdscript3
endif

if !has_key(s:disabled_packages, 'fsharp')
  au! BufNewFile,BufRead *.fs call polyglot#detect#Fs()
  au BufNewFile,BufRead *.fsi,*.fsx setf fsharp
endif

if !has_key(s:disabled_packages, 'forth')
  au! BufNewFile,BufRead *.fs call polyglot#detect#Fs()
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
  au BufNewFile,BufRead *.eex,*.leex setf eelixir
  au BufNewFile,BufRead *.ex,*.exs,mix.lock setf elixir
endif

if !has_key(s:disabled_packages, 'dockerfile')
  au BufNewFile,BufRead docker-compose*.yaml,docker-compose*.yml setf yaml.docker-compose
  au BufNewFile,BufRead *.Dockerfile,*.dock,*.dockerfile,Dockerfile,dockerfile setf Dockerfile
  au BufNewFile,BufRead Dockerfile* call s:StarSetf('Dockerfile')
endif

if !has_key(s:disabled_packages, 'yaml')
  au BufNewFile,BufRead *.mir,*.reek,*.rviz,*.sublime-syntax,*.syntax,*.yaml,*.yaml-tmlanguage,*.yaml.sed,*.yml,*.yml.mysql,{.,}clang-format,{.,}clang-tidy,{.,}gemrc,fish_history,fish_read_history,glide.lock,yarn.lock setf yaml
endif

if !has_key(s:disabled_packages, 'dlang')
  au BufNewFile,BufRead *.sdl setf dsdl
  au BufNewFile,BufRead *.ddoc setf ddoc
  au BufNewFile,BufRead *.dd setf dd
  au BufNewFile,BufRead *.lst setf dcov
  au BufNewFile,BufRead *.d,*.di setf d
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
  au BufNewFile,BufRead *.ecr setf ecrystal
  au BufNewFile,BufRead *.cr,Projectfile setf crystal
endif

if !has_key(s:disabled_packages, 'cryptol')
  au BufNewFile,BufRead *.cry,*.cyl,*.lcry,*.lcyl setf cryptol
endif

if !has_key(s:disabled_packages, 'cjsx')
endif

if !has_key(s:disabled_packages, 'coffee-script')
  au BufNewFile,BufRead *.coffee.md,*.litcoffee setf litcoffee
  au BufNewFile,BufRead *._coffee,*.cake,*.cjsx,*.coffee,*.coffeekup,*.iced,Cakefile setf coffee
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

if !has_key(s:disabled_packages, 'cpp-modern')
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
  au! BufNewFile,BufRead *.asp call polyglot#detect#Asp()
endif

if !has_key(s:disabled_packages, 'aspvbs')
  au! BufNewFile,BufRead *.asp call polyglot#detect#Asp()
  au! BufNewFile,BufRead *.asa call polyglot#detect#Asa()
endif

if !has_key(s:disabled_packages, 'asn')
  au BufNewFile,BufRead *.asn,*.asn1 setf asn
endif

if !has_key(s:disabled_packages, 'automake')
  au BufNewFile,BufRead GNUmakefile.am,[Mm]akefile.am setf automake
endif

if !has_key(s:disabled_packages, 'elf')
  au BufNewFile,BufRead *.am setf elf
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
  au! BufNewFile,BufRead *.h call polyglot#detect#H()
  au BufNewFile,BufRead *.c,*.cats,*.idc,*.qc,*enlightenment/*.cfg setf c
  au BufNewFile,BufRead *.c++,*.cc,*.cp,*.cpp,*.cxx,*.h++,*.hh,*.hpp,*.hxx,*.inc,*.inl,*.ipp,*.moc,*.tcc,*.tlh,*.tpp setf cpp
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
  au BufNewFile,BufRead *.run setf ampl
endif

if !has_key(s:disabled_packages, 'aml')
  au BufNewFile,BufRead *.aml setf aml
endif

if !has_key(s:disabled_packages, 'alsaconf')
  au BufNewFile,BufRead */etc/asound.conf,*/usr/share/alsa/alsa.conf,{.,}asoundrc setf alsaconf
endif

if !has_key(s:disabled_packages, 'aidl')
  au BufNewFile,BufRead *.aidl setf aidl
endif

if !has_key(s:disabled_packages, 'ahdl')
  au BufNewFile,BufRead *.tdf setf ahdl
endif

if !has_key(s:disabled_packages, 'ada')
  au BufNewFile,BufRead *.ada,*.ada_m,*.adb,*.adc,*.ads,*.gpr setf ada
endif

if !has_key(s:disabled_packages, 'acpiasl')
  au BufNewFile,BufRead *.asl,*.dsl setf asl
endif

if !has_key(s:disabled_packages, 'acedb')
  au BufNewFile,BufRead *.wrm setf acedb
endif

if !has_key(s:disabled_packages, 'abel')
  au BufNewFile,BufRead *.abl setf abel
endif

if !has_key(s:disabled_packages, 'abc')
  au BufNewFile,BufRead *.abc setf abc
endif

if !has_key(s:disabled_packages, 'abaqus')
  au! BufNewFile,BufRead *.inp call polyglot#detect#Inp()
endif

if !has_key(s:disabled_packages, 'abap')
  au BufNewFile,BufRead *.abap setf abap
endif

if !has_key(s:disabled_packages, 'aap')
  au BufNewFile,BufRead *.aap setf aap
endif

if !has_key(s:disabled_packages, 'a65')
  au BufNewFile,BufRead *.a65 setf a65
endif

if !has_key(s:disabled_packages, 'a2ps')
  au BufNewFile,BufRead */etc/a2ps.cfg,*/etc/a2ps/*.cfg,{.,}a2psrc,a2psrc setf a2ps
endif

if !has_key(s:disabled_packages, 'haproxy')
  au BufNewFile,BufRead *.cfg,haproxy.cfg setf haproxy
  au BufNewFile,BufRead haproxy*.conf* call s:StarSetf('haproxy')
endif

if !has_key(s:disabled_packages, 'conf')
  au BufNewFile,BufRead *.conf,auto.master,config setf conf
endif

if !has_key(s:disabled_packages, '8th')
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
        let &l:shiftwidth=&tabstop
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
      let &l:shiftwidth=minindent
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

" Save polyglot_disabled without postfixes
if exists('g:polyglot_disabled')
  let g:polyglot_disabled = s:new_polyglot_disabled
endif

" Restore 'cpoptions'
let &cpo = s:cpo_save
unlet s:cpo_save
