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

" filetypes

if !has_key(s:disabled_packages, '8th')
  au! BufRead,BufNewFile *.8th
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

if !has_key(s:disabled_packages, 'aml')
  au! BufRead,BufNewFile *.aml
endif

if !has_key(s:disabled_packages, 'ampl')
  au! BufRead,BufNewFile *.run
endif

if !has_key(s:disabled_packages, 'applescript')
  au! BufRead,BufNewFile *.scpt
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

if !has_key(s:disabled_packages, 'c/c++')
  au! BufRead,BufNewFile *.cpp,*.c++,*.cc,*.cxx,*.hh,*.hpp,*.hxx,*.inl,*.ipp,*.tcc,*.tpp,*.moc,*.tlh,*.qc
endif

if !has_key(s:disabled_packages, 'clojure')
  au! BufRead,BufNewFile *.clj,*.cljc,*.cljs,*.cljx
endif

if !has_key(s:disabled_packages, 'cmake')
  au! BufRead,BufNewFile *.cmake,*.cmake.in
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
  au! BufRead,BufNewFile *.Dockerfile
endif

if !has_key(s:disabled_packages, 'elf')
  au! BufRead,BufNewFile *.am
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

if !has_key(s:disabled_packages, 'fsharp')
  au! BufRead,BufNewFile *.fs
endif

if !has_key(s:disabled_packages, 'glsl')
  au! BufRead,BufNewFile *.fs,*.gs,*.comp
endif

if !has_key(s:disabled_packages, 'gnuplot')
  au! BufRead,BufNewFile *.gp,*.gpi
endif

if !has_key(s:disabled_packages, 'go')
  au! BufRead,BufNewFile *.go,*.tmpl
endif

if !has_key(s:disabled_packages, 'groovy')
  au! BufRead,BufNewFile *.groovy,*.gradle
endif

if !has_key(s:disabled_packages, 'haml')
  au! BufRead,BufNewFile *.haml
endif

if !has_key(s:disabled_packages, 'handlebars')
  au! BufRead,BufNewFile *.hb
endif

if !has_key(s:disabled_packages, 'haproxy')
  au! BufRead,BufNewFile *.cfg
endif

if !has_key(s:disabled_packages, 'haskell')
  au! BufRead,BufNewFile *.hs,*.hs-boot,*.hsc
endif

if !has_key(s:disabled_packages, 'html5')
  au! BufRead,BufNewFile *.st,*.xht,*.xhtml
endif

if !has_key(s:disabled_packages, 'jsx')
  au! BufRead,BufNewFile *.jsx
endif

if !has_key(s:disabled_packages, 'javascript')
  au! BufRead,BufNewFile *.js,*.cjs,*.es,*.gs,*.mjs,*.pac
endif

if !has_key(s:disabled_packages, 'json')
  au! BufRead,BufNewFile *.json,*.ice,*.webmanifest,*.yy,*.jsonp
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

if !has_key(s:disabled_packages, 'ocaml')
  au! BufRead,BufNewFile *.ml,*.mli,*.mll,*.mly
endif

if !has_key(s:disabled_packages, 'opencl')
  au! BufRead,BufNewFile *.cl
endif

if !has_key(s:disabled_packages, 'perl')
  au! BufRead,BufNewFile *.al,*.plx,*.psgi,*.t
endif

if !has_key(s:disabled_packages, 'php')
  au! BufRead,BufNewFile *.php,*.ctp
endif

if !has_key(s:disabled_packages, 'protobuf')
  au! BufRead,BufNewFile *.proto
endif

if !has_key(s:disabled_packages, 'python')
  au! BufRead,BufNewFile *.py,*.pyi,*.pyw,*.spec
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
  au! BufRead,BufNewFile *.rb,*.builder,*.gemspec,*.rake,*.rbw,*.ru,*.spec,*.rxml,*.rjs,*.rant,*.erb,*.rhtml
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
  au! BufRead,BufNewFile *.zsh
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

if !has_key(s:disabled_packages, 'xml')
  au! BufRead,BufNewFile *.csproj,*.ui,*.wsdl,*.wsf,*.xlf,*.xliff,*.xmi,*.xsd,*.xul
endif

if !has_key(s:disabled_packages, 'xsl')
  au! BufRead,BufNewFile *.xslt,*.xsl
endif

if !has_key(s:disabled_packages, 'yaml')
  au! BufRead,BufNewFile *.yml,*.yaml
endif

if !has_key(s:disabled_packages, 'visual-basic')
  au! BufRead,BufNewFile *.vba,*.vbs,*.dsm,*.ctl,*.sba
endif

if !has_key(s:disabled_packages, 'dosini')
  au! BufRead,BufNewFile *.ini,*.cfg,*.properties
endif

if !has_key(s:disabled_packages, '8th')
  au BufNewFile,BufRead *.8th setf 8th
endif

if !has_key(s:disabled_packages, 'a2ps')
  au BufNewFile,BufRead */etc/a2ps.cfg setf a2ps
  au BufNewFile,BufRead */etc/a2ps/*.cfg setf a2ps
  au BufNewFile,BufRead {.,}a2psrc setf a2ps
  au BufNewFile,BufRead a2psrc setf a2ps
endif

if !has_key(s:disabled_packages, 'a65')
  au BufNewFile,BufRead *.a65 setf a65
endif

if !has_key(s:disabled_packages, 'aap')
  au BufNewFile,BufRead *.aap setf aap
endif

if !has_key(s:disabled_packages, 'abap')
  au BufNewFile,BufRead *.abap setf abap
endif

if !has_key(s:disabled_packages, 'abaqus')
  au! BufNewFile,BufRead *.inp call polyglot#DetectInpFiletype()
endif

if !has_key(s:disabled_packages, 'abc')
  au BufNewFile,BufRead *.abc setf abc
endif

if !has_key(s:disabled_packages, 'abel')
  au BufNewFile,BufRead *.abl setf abel
endif

if !has_key(s:disabled_packages, 'acedb')
  au BufNewFile,BufRead *.wrm setf acedb
endif

if !has_key(s:disabled_packages, 'acpiasl')
  au BufNewFile,BufRead *.asl setf asl
  au BufNewFile,BufRead *.dsl setf asl
endif

if !has_key(s:disabled_packages, 'ada')
  au BufNewFile,BufRead *.ada setf ada
  au BufNewFile,BufRead *.ada_m setf ada
  au BufNewFile,BufRead *.adb setf ada
  au BufNewFile,BufRead *.adc setf ada
  au BufNewFile,BufRead *.ads setf ada
  au BufNewFile,BufRead *.gpr setf ada
endif

if !has_key(s:disabled_packages, 'ahdl')
  au BufNewFile,BufRead *.tdf setf ahdl
endif

if !has_key(s:disabled_packages, 'aidl')
  au BufNewFile,BufRead *.aidl setf aidl
endif

if !has_key(s:disabled_packages, 'alsaconf')
  au BufNewFile,BufRead */etc/asound.conf setf alsaconf
  au BufNewFile,BufRead */usr/share/alsa/alsa.conf setf alsaconf
  au BufNewFile,BufRead {.,}asoundrc setf alsaconf
endif

if !has_key(s:disabled_packages, 'aml')
  au BufNewFile,BufRead *.aml setf aml
endif

if !has_key(s:disabled_packages, 'ampl')
  au BufNewFile,BufRead *.run setf ampl
endif

if !has_key(s:disabled_packages, 'ant')
  au BufNewFile,BufRead build.xml setf ant
endif

if !has_key(s:disabled_packages, 'apache')
  au BufNewFile,BufRead */etc/apache2/*.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead */etc/apache2/conf.*/* call s:StarSetf('apache')
  au BufNewFile,BufRead */etc/apache2/mods-*/* call s:StarSetf('apache')
  au BufNewFile,BufRead */etc/apache2/sites-*/* call s:StarSetf('apache')
  au BufNewFile,BufRead */etc/apache2/sites-*/*.com setf apache
  au BufNewFile,BufRead */etc/httpd/*.conf setf apache
  au BufNewFile,BufRead */etc/httpd/conf.d/*.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead {.,}htaccess setf apache
  au BufNewFile,BufRead access.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead apache.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead apache2.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead httpd.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead srm.conf* call s:StarSetf('apache')
endif

if !has_key(s:disabled_packages, 'apiblueprint')
  au BufNewFile,BufRead *.apib setf apiblueprint
endif

if !has_key(s:disabled_packages, 'applescript')
  au BufNewFile,BufRead *.applescript setf applescript
  au BufNewFile,BufRead *.scpt setf applescript
endif

if !has_key(s:disabled_packages, 'aptconf')
  au BufNewFile,BufRead */.aptitude/config setf aptconf
  au BufNewFile,BufRead */etc/apt/apt.conf.d/*.conf setf aptconf
  au BufNewFile,BufRead */etc/apt/apt.conf.d/[^.]* call s:StarSetf('aptconf')
  au BufNewFile,BufRead apt.conf setf aptconf
endif

if !has_key(s:disabled_packages, 'arch')
  au BufNewFile,BufRead {.,}arch-inventory setf arch
  au BufNewFile,BufRead =tagging-method setf arch
endif

if !has_key(s:disabled_packages, 'arduino')
  au BufNewFile,BufRead *.ino setf arduino
  au BufNewFile,BufRead *.pde setf arduino
endif

if !has_key(s:disabled_packages, 'art')
  au BufNewFile,BufRead *.art setf art
endif

if !has_key(s:disabled_packages, 'asciidoc')
  au BufNewFile,BufRead *.adoc setf asciidoc
  au BufNewFile,BufRead *.asc setf asciidoc
  au BufNewFile,BufRead *.asciidoc setf asciidoc
endif

if !has_key(s:disabled_packages, 'autohotkey')
  au BufNewFile,BufRead *.ahk setf autohotkey
  au BufNewFile,BufRead *.ahkl setf autohotkey
endif

if !has_key(s:disabled_packages, 'automake')
  au BufNewFile,BufRead GNUmakefile.am setf automake
  au BufNewFile,BufRead [Mm]akefile.am setf automake
endif

if !has_key(s:disabled_packages, 'asn')
  au BufNewFile,BufRead *.asn setf asn
  au BufNewFile,BufRead *.asn1 setf asn
endif

if !has_key(s:disabled_packages, 'aspvbs')
  au! BufNewFile,BufRead *.asa call polyglot#DetectAsaFiletype()
  au! BufNewFile,BufRead *.asp call polyglot#DetectAspFiletype()
endif

if !has_key(s:disabled_packages, 'aspperl')
  au! BufNewFile,BufRead *.asp call polyglot#DetectAspFiletype()
endif

if !has_key(s:disabled_packages, 'atlas')
  au BufNewFile,BufRead *.as setf atlas
  au BufNewFile,BufRead *.atl setf atlas
endif

if !has_key(s:disabled_packages, 'autoit')
  au BufNewFile,BufRead *.au3 setf autoit
endif

if !has_key(s:disabled_packages, 'ave')
  au BufNewFile,BufRead *.ave setf ave
endif

if !has_key(s:disabled_packages, 'awk')
  au BufNewFile,BufRead *.awk setf awk
  au BufNewFile,BufRead *.gawk setf awk
endif

if !has_key(s:disabled_packages, 'reason')
  au BufNewFile,BufRead *.rei setf reason
  au! BufNewFile,BufRead *.re call polyglot#DetectReFiletype()
endif

if !has_key(s:disabled_packages, 'c/c++')
  au BufNewFile,BufRead *.c++ setf cpp
  au BufNewFile,BufRead *.cc setf cpp
  au BufNewFile,BufRead *.cp setf cpp
  au BufNewFile,BufRead *.cpp setf cpp
  au BufNewFile,BufRead *.cxx setf cpp
  au BufNewFile,BufRead *.h++ setf cpp
  au BufNewFile,BufRead *.hh setf cpp
  au BufNewFile,BufRead *.hpp setf cpp
  au BufNewFile,BufRead *.hxx setf cpp
  au BufNewFile,BufRead *.inc setf cpp
  au BufNewFile,BufRead *.inl setf cpp
  au BufNewFile,BufRead *.ipp setf cpp
  au BufNewFile,BufRead *.moc setf cpp
  au BufNewFile,BufRead *.tcc setf cpp
  au BufNewFile,BufRead *.tlh setf cpp
  au BufNewFile,BufRead *.tpp setf cpp
  au BufNewFile,BufRead *.c setf c
  au BufNewFile,BufRead *.cats setf c
  au BufNewFile,BufRead *.idc setf c
  au BufNewFile,BufRead *.qc setf c
  au BufNewFile,BufRead *enlightenment/*.cfg setf c
  au! BufNewFile,BufRead *.h call polyglot#DetectHFiletype()
endif

if !has_key(s:disabled_packages, 'caddyfile')
  au BufNewFile,BufRead Caddyfile setf caddyfile
endif

if !has_key(s:disabled_packages, 'carp')
  au BufNewFile,BufRead *.carp setf carp
endif

if !has_key(s:disabled_packages, 'clojure')
  au BufNewFile,BufRead *.boot setf clojure
  au BufNewFile,BufRead *.cl2 setf clojure
  au BufNewFile,BufRead *.clj setf clojure
  au BufNewFile,BufRead *.cljc setf clojure
  au BufNewFile,BufRead *.cljs setf clojure
  au BufNewFile,BufRead *.cljs.hl setf clojure
  au BufNewFile,BufRead *.cljscm setf clojure
  au BufNewFile,BufRead *.cljx setf clojure
  au BufNewFile,BufRead *.edn setf clojure
  au BufNewFile,BufRead *.hic setf clojure
  au BufNewFile,BufRead build.boot setf clojure
  au BufNewFile,BufRead profile.boot setf clojure
  au BufNewFile,BufRead riemann.config setf clojure
endif

if !has_key(s:disabled_packages, 'cmake')
  au BufNewFile,BufRead *.cmake setf cmake
  au BufNewFile,BufRead *.cmake.in setf cmake
  au BufNewFile,BufRead CMakeLists.txt setf cmake
endif

if !has_key(s:disabled_packages, 'coffee-script')
  au BufNewFile,BufRead *._coffee setf coffee
  au BufNewFile,BufRead *.cake setf coffee
  au BufNewFile,BufRead *.cjsx setf coffee
  au BufNewFile,BufRead *.coffee setf coffee
  au BufNewFile,BufRead *.coffeekup setf coffee
  au BufNewFile,BufRead *.iced setf coffee
  au BufNewFile,BufRead Cakefile setf coffee
  au BufNewFile,BufRead *.coffee.md setf litcoffee
  au BufNewFile,BufRead *.litcoffee setf litcoffee
endif

if !has_key(s:disabled_packages, 'cryptol')
  au BufNewFile,BufRead *.cry setf cryptol
  au BufNewFile,BufRead *.cyl setf cryptol
  au BufNewFile,BufRead *.lcry setf cryptol
  au BufNewFile,BufRead *.lcyl setf cryptol
endif

if !has_key(s:disabled_packages, 'crystal')
  au BufNewFile,BufRead *.cr setf crystal
  au BufNewFile,BufRead Projectfile setf crystal
  au BufNewFile,BufRead *.ecr setf ecrystal
endif

if !has_key(s:disabled_packages, 'csv')
  au BufNewFile,BufRead *.csv setf csv
  au BufNewFile,BufRead *.tab setf csv
  au BufNewFile,BufRead *.tsv setf csv
endif

if !has_key(s:disabled_packages, 'cucumber')
  au BufNewFile,BufRead *.feature setf cucumber
  au BufNewFile,BufRead *.story setf cucumber
endif

if !has_key(s:disabled_packages, 'cue')
  au BufNewFile,BufRead *.cue setf cuesheet
endif

if !has_key(s:disabled_packages, 'dart')
  au BufNewFile,BufRead *.dart setf dart
  au BufNewFile,BufRead *.drt setf dart
endif

if !has_key(s:disabled_packages, 'dhall')
  au BufNewFile,BufRead *.dhall setf dhall
endif

if !has_key(s:disabled_packages, 'grub')
  au BufNewFile,BufRead */boot/grub/grub.conf setf grub
  au BufNewFile,BufRead */boot/grub/menu.lst setf grub
  au BufNewFile,BufRead */etc/grub.conf setf grub
endif

if !has_key(s:disabled_packages, 'dlang')
  au BufNewFile,BufRead *.d setf d
  au BufNewFile,BufRead *.di setf d
  au BufNewFile,BufRead *.lst setf dcov
  au BufNewFile,BufRead *.dd setf dd
  au BufNewFile,BufRead *.ddoc setf ddoc
  au BufNewFile,BufRead *.sdl setf dsdl
endif

if !has_key(s:disabled_packages, 'dockerfile')
  au BufNewFile,BufRead *.Dockerfile setf Dockerfile
  au BufNewFile,BufRead *.dock setf Dockerfile
  au BufNewFile,BufRead *.dockerfile setf Dockerfile
  au BufNewFile,BufRead Dockerfile setf Dockerfile
  au BufNewFile,BufRead Dockerfile* call s:StarSetf('Dockerfile')
  au BufNewFile,BufRead dockerfile setf Dockerfile
  au BufNewFile,BufRead docker-compose*.yaml setf yaml.docker-compose
  au BufNewFile,BufRead docker-compose*.yml setf yaml.docker-compose
endif

if !has_key(s:disabled_packages, 'elf')
  au BufNewFile,BufRead *.am setf elf
endif

if !has_key(s:disabled_packages, 'elixir')
  au BufNewFile,BufRead *.ex setf elixir
  au BufNewFile,BufRead *.exs setf elixir
  au BufNewFile,BufRead mix.lock setf elixir
  au BufNewFile,BufRead *.eex setf eelixir
  au BufNewFile,BufRead *.leex setf eelixir
endif

if !has_key(s:disabled_packages, 'elm')
  au BufNewFile,BufRead *.elm setf elm
endif

if !has_key(s:disabled_packages, 'emberscript')
  au BufNewFile,BufRead *.em setf ember-script
  au BufNewFile,BufRead *.emberscript setf ember-script
endif

if !has_key(s:disabled_packages, 'emblem')
  au BufNewFile,BufRead *.em setf emblem
  au BufNewFile,BufRead *.emblem setf emblem
endif

if !has_key(s:disabled_packages, 'erlang')
  au BufNewFile,BufRead *.app setf erlang
  au BufNewFile,BufRead *.app.src setf erlang
  au BufNewFile,BufRead *.erl setf erlang
  au BufNewFile,BufRead *.es setf erlang
  au BufNewFile,BufRead *.escript setf erlang
  au BufNewFile,BufRead *.hrl setf erlang
  au BufNewFile,BufRead *.xrl setf erlang
  au BufNewFile,BufRead *.yaws setf erlang
  au BufNewFile,BufRead *.yrl setf erlang
  au BufNewFile,BufRead Emakefile setf erlang
  au BufNewFile,BufRead rebar.config setf erlang
  au BufNewFile,BufRead rebar.config.lock setf erlang
  au BufNewFile,BufRead rebar.lock setf erlang
endif

if !has_key(s:disabled_packages, 'fennel')
  au BufNewFile,BufRead *.fnl setf fennel
endif

if !has_key(s:disabled_packages, 'ferm')
  au BufNewFile,BufRead *.ferm setf ferm
  au BufNewFile,BufRead ferm.conf setf ferm
endif

if !has_key(s:disabled_packages, 'fish')
  au BufNewFile,BufRead *.fish setf fish
endif

if !has_key(s:disabled_packages, 'flatbuffers')
  au BufNewFile,BufRead *.fbs setf fbs
endif

if !has_key(s:disabled_packages, 'forth')
  au BufNewFile,BufRead *.ft setf forth
  au BufNewFile,BufRead *.fth setf forth
  au! BufNewFile,BufRead *.fs call polyglot#DetectFsFiletype()
endif

if !has_key(s:disabled_packages, 'fsharp')
  au BufNewFile,BufRead *.fsi setf fsharp
  au BufNewFile,BufRead *.fsx setf fsharp
  au! BufNewFile,BufRead *.fs call polyglot#DetectFsFiletype()
endif

if !has_key(s:disabled_packages, 'gdscript')
  au BufNewFile,BufRead *.gd setf gdscript3
endif

if !has_key(s:disabled_packages, 'git')
  au BufNewFile,BufRead *.gitconfig setf gitconfig
  au BufNewFile,BufRead *.git/config setf gitconfig
  au BufNewFile,BufRead *.git/modules/*/config setf gitconfig
  au BufNewFile,BufRead */.config/git/config setf gitconfig
  au BufNewFile,BufRead */git/config setf gitconfig
  au BufNewFile,BufRead */{.,}gitconfig.d/* call s:StarSetf('gitconfig')
  au BufNewFile,BufRead {.,}gitconfig setf gitconfig
  au BufNewFile,BufRead {.,}gitmodules setf gitconfig
  au BufNewFile,BufRead git-rebase-todo setf gitrebase
  au BufNewFile,BufRead {.,}gitsendemail.* call s:StarSetf('gitsendemail')
  au BufNewFile,BufRead COMMIT_EDITMSG,MERGE_MSG,TAG_EDITMSG setf gitcommit
endif

if !has_key(s:disabled_packages, 'glsl')
  au BufNewFile,BufRead *.comp setf glsl
  au BufNewFile,BufRead *.fp setf glsl
  au BufNewFile,BufRead *.frag setf glsl
  au BufNewFile,BufRead *.frg setf glsl
  au BufNewFile,BufRead *.fsh setf glsl
  au BufNewFile,BufRead *.fshader setf glsl
  au BufNewFile,BufRead *.geo setf glsl
  au BufNewFile,BufRead *.geom setf glsl
  au BufNewFile,BufRead *.glsl setf glsl
  au BufNewFile,BufRead *.glslf setf glsl
  au BufNewFile,BufRead *.glslv setf glsl
  au BufNewFile,BufRead *.gs setf glsl
  au BufNewFile,BufRead *.gshader setf glsl
  au BufNewFile,BufRead *.shader setf glsl
  au BufNewFile,BufRead *.tesc setf glsl
  au BufNewFile,BufRead *.tese setf glsl
  au BufNewFile,BufRead *.vert setf glsl
  au BufNewFile,BufRead *.vrx setf glsl
  au BufNewFile,BufRead *.vsh setf glsl
  au BufNewFile,BufRead *.vshader setf glsl
  au! BufNewFile,BufRead *.fs call polyglot#DetectFsFiletype()
endif

if !has_key(s:disabled_packages, 'gmpl')
  au BufNewFile,BufRead *.mod setf gmpl
endif

if !has_key(s:disabled_packages, 'gnuplot')
  au BufNewFile,BufRead *.gnu setf gnuplot
  au BufNewFile,BufRead *.gnuplot setf gnuplot
  au BufNewFile,BufRead *.gp setf gnuplot
  au BufNewFile,BufRead *.gpi setf gnuplot
  au BufNewFile,BufRead *.p setf gnuplot
  au BufNewFile,BufRead *.plot setf gnuplot
  au BufNewFile,BufRead *.plt setf gnuplot
endif

if !has_key(s:disabled_packages, 'go')
  au BufNewFile,BufRead *.go setf go
  au BufNewFile,BufRead go.mod setf gomod
  au BufNewFile,BufRead *.tmpl setf gohtmltmpl
endif

if !has_key(s:disabled_packages, 'graphql')
  au BufNewFile,BufRead *.gql setf graphql
  au BufNewFile,BufRead *.graphql setf graphql
  au BufNewFile,BufRead *.graphqls setf graphql
endif

if !has_key(s:disabled_packages, 'groovy')
  au BufNewFile,BufRead *.gradle setf groovy
  au BufNewFile,BufRead *.groovy setf groovy
  au BufNewFile,BufRead *.grt setf groovy
  au BufNewFile,BufRead *.gtpl setf groovy
  au BufNewFile,BufRead *.gvy setf groovy
  au BufNewFile,BufRead Jenkinsfile setf groovy
endif

if !has_key(s:disabled_packages, 'haml')
  au BufNewFile,BufRead *.haml setf haml
  au BufNewFile,BufRead *.haml.deface setf haml
  au BufNewFile,BufRead *.hamlbars setf haml
  au BufNewFile,BufRead *.hamlc setf haml
endif

if !has_key(s:disabled_packages, 'handlebars')
  au BufNewFile,BufRead *.handlebars setf mustache
  au BufNewFile,BufRead *.hb setf mustache
  au BufNewFile,BufRead *.hbs setf mustache
  au BufNewFile,BufRead *.hdbs setf mustache
  au BufNewFile,BufRead *.hjs setf mustache
  au BufNewFile,BufRead *.hogan setf mustache
  au BufNewFile,BufRead *.hulk setf mustache
  au BufNewFile,BufRead *.mustache setf mustache
  au BufNewFile,BufRead *.njk setf mustache
endif

if !has_key(s:disabled_packages, 'haproxy')
  au BufNewFile,BufRead *.cfg setf haproxy
  au BufNewFile,BufRead haproxy*.c* call s:StarSetf('haproxy')
  au BufNewFile,BufRead haproxy.cfg setf haproxy
endif

if !has_key(s:disabled_packages, 'haskell')
  au BufNewFile,BufRead *.bpk setf haskell
  au BufNewFile,BufRead *.hs setf haskell
  au BufNewFile,BufRead *.hs-boot setf haskell
  au BufNewFile,BufRead *.hsc setf haskell
  au BufNewFile,BufRead *.hsig setf haskell
endif

if !has_key(s:disabled_packages, 'haxe')
  au BufNewFile,BufRead *.hx setf haxe
  au BufNewFile,BufRead *.hxsl setf haxe
endif

if !has_key(s:disabled_packages, 'hcl')
  au BufNewFile,BufRead *.hcl setf hcl
  au BufNewFile,BufRead *.nomad setf hcl
  au BufNewFile,BufRead *.workflow setf hcl
  au BufNewFile,BufRead Appfile setf hcl
endif

if !has_key(s:disabled_packages, 'hive')
  au BufNewFile,BufRead *.hql setf hive
  au BufNewFile,BufRead *.q setf hive
  au BufNewFile,BufRead *.ql setf hive
endif

if !has_key(s:disabled_packages, 'html5')
  au BufNewFile,BufRead *.htm setf html
  au BufNewFile,BufRead *.html setf html
  au BufNewFile,BufRead *.html.hl setf html
  au BufNewFile,BufRead *.inc setf html
  au BufNewFile,BufRead *.st setf html
  au BufNewFile,BufRead *.xht setf html
  au BufNewFile,BufRead *.xhtml setf html
endif

if !has_key(s:disabled_packages, 'i3')
  au BufNewFile,BufRead *.i3.config setf i3config
  au BufNewFile,BufRead *.i3config setf i3config
  au BufNewFile,BufRead {.,}i3.config setf i3config
  au BufNewFile,BufRead {.,}i3config setf i3config
  au BufNewFile,BufRead i3.config setf i3config
  au BufNewFile,BufRead i3config setf i3config
endif

if !has_key(s:disabled_packages, 'icalendar')
  au BufNewFile,BufRead *.ics setf icalendar
endif

if !has_key(s:disabled_packages, 'idris')
  au BufNewFile,BufRead idris-response setf idris
  au! BufNewFile,BufRead *.idr call polyglot#DetectIdrFiletype()
  au! BufNewFile,BufRead *.lidr call polyglot#DetectLidrFiletype()
endif

if !has_key(s:disabled_packages, 'idris2')
  au BufNewFile,BufRead *.ipkg setf idris2
  au BufNewFile,BufRead idris-response setf idris2
  au! BufNewFile,BufRead *.idr call polyglot#DetectIdrFiletype()
  au! BufNewFile,BufRead *.lidr call polyglot#DetectLidrFiletype()
endif

if !has_key(s:disabled_packages, 'ion')
  au BufNewFile,BufRead *.ion setf ion
  au BufNewFile,BufRead ~/.config/ion/initrc setf ion
endif

if !has_key(s:disabled_packages, 'jsx')
  au BufNewFile,BufRead *.jsx setf javascriptreact
endif

if !has_key(s:disabled_packages, 'javascript')
  au BufNewFile,BufRead *._js setf javascript
  au BufNewFile,BufRead *.bones setf javascript
  au BufNewFile,BufRead *.cjs setf javascript
  au BufNewFile,BufRead *.es setf javascript
  au BufNewFile,BufRead *.es6 setf javascript
  au BufNewFile,BufRead *.frag setf javascript
  au BufNewFile,BufRead *.gs setf javascript
  au BufNewFile,BufRead *.jake setf javascript
  au BufNewFile,BufRead *.js setf javascript
  au BufNewFile,BufRead *.jsb setf javascript
  au BufNewFile,BufRead *.jscad setf javascript
  au BufNewFile,BufRead *.jsfl setf javascript
  au BufNewFile,BufRead *.jsm setf javascript
  au BufNewFile,BufRead *.jss setf javascript
  au BufNewFile,BufRead *.mjs setf javascript
  au BufNewFile,BufRead *.njs setf javascript
  au BufNewFile,BufRead *.pac setf javascript
  au BufNewFile,BufRead *.sjs setf javascript
  au BufNewFile,BufRead *.ssjs setf javascript
  au BufNewFile,BufRead *.xsjs setf javascript
  au BufNewFile,BufRead *.xsjslib setf javascript
  au BufNewFile,BufRead Jakefile setf javascript
  au BufNewFile,BufRead *.flow setf flow
endif

if !has_key(s:disabled_packages, 'jenkins')
  au BufNewFile,BufRead *.Jenkinsfile setf Jenkinsfile
  au BufNewFile,BufRead *.jenkinsfile setf Jenkinsfile
  au BufNewFile,BufRead Jenkinsfile setf Jenkinsfile
  au BufNewFile,BufRead Jenkinsfile* call s:StarSetf('Jenkinsfile')
endif

if !has_key(s:disabled_packages, 'jinja')
  au BufNewFile,BufRead *.j2 setf jinja.html
  au BufNewFile,BufRead *.jinja setf jinja.html
  au BufNewFile,BufRead *.jinja2 setf jinja.html
endif

if !has_key(s:disabled_packages, 'jq')
  au BufNewFile,BufRead *.jq setf jq
  au BufNewFile,BufRead {.,}jqrc setf jq
  au BufNewFile,BufRead {.,}jqrc* call s:StarSetf('jq')
endif

if !has_key(s:disabled_packages, 'json5')
  au BufNewFile,BufRead *.json5 setf json5
endif

if !has_key(s:disabled_packages, 'json')
  au BufNewFile,BufRead *.JSON-tmLanguage setf json
  au BufNewFile,BufRead *.avsc setf json
  au BufNewFile,BufRead *.geojson setf json
  au BufNewFile,BufRead *.gltf setf json
  au BufNewFile,BufRead *.har setf json
  au BufNewFile,BufRead *.ice setf json
  au BufNewFile,BufRead *.json setf json
  au BufNewFile,BufRead *.jsonl setf json
  au BufNewFile,BufRead *.jsonp setf json
  au BufNewFile,BufRead *.mcmeta setf json
  au BufNewFile,BufRead *.template setf json
  au BufNewFile,BufRead *.tfstate setf json
  au BufNewFile,BufRead *.tfstate.backup setf json
  au BufNewFile,BufRead *.topojson setf json
  au BufNewFile,BufRead *.webapp setf json
  au BufNewFile,BufRead *.webmanifest setf json
  au BufNewFile,BufRead *.yy setf json
  au BufNewFile,BufRead *.yyp setf json
  au BufNewFile,BufRead {.,}arcconfig setf json
  au BufNewFile,BufRead {.,}htmlhintrc setf json
  au BufNewFile,BufRead {.,}tern-config setf json
  au BufNewFile,BufRead {.,}tern-project setf json
  au BufNewFile,BufRead {.,}watchmanconfig setf json
  au BufNewFile,BufRead Pipfile.lock setf json
  au BufNewFile,BufRead composer.lock setf json
  au BufNewFile,BufRead mcmod.info setf json
endif

if !has_key(s:disabled_packages, 'jsonnet')
  au BufNewFile,BufRead *.jsonnet setf jsonnet
  au BufNewFile,BufRead *.libsonnet setf jsonnet
endif

if !has_key(s:disabled_packages, 'jst')
  au BufNewFile,BufRead *.ect setf jst
  au BufNewFile,BufRead *.ejs setf jst
  au BufNewFile,BufRead *.jst setf jst
endif

if !has_key(s:disabled_packages, 'julia')
  au BufNewFile,BufRead *.jl setf julia
endif

if !has_key(s:disabled_packages, 'kotlin')
  au BufNewFile,BufRead *.kt setf kotlin
  au BufNewFile,BufRead *.ktm setf kotlin
  au BufNewFile,BufRead *.kts setf kotlin
endif

if !has_key(s:disabled_packages, 'ledger')
  au BufNewFile,BufRead *.journal setf ledger
  au BufNewFile,BufRead *.ldg setf ledger
  au BufNewFile,BufRead *.ledger setf ledger
endif

if !has_key(s:disabled_packages, 'less')
  au BufNewFile,BufRead *.less setf less
endif

if !has_key(s:disabled_packages, 'lilypond')
  au BufNewFile,BufRead *.ily setf lilypond
  au BufNewFile,BufRead *.ly setf lilypond
endif

if !has_key(s:disabled_packages, 'livescript')
  au BufNewFile,BufRead *._ls setf livescript
  au BufNewFile,BufRead *.ls setf livescript
  au BufNewFile,BufRead Slakefile setf livescript
endif

if !has_key(s:disabled_packages, 'llvm')
  au BufNewFile,BufRead *.ll setf llvm
  au BufNewFile,BufRead *.td setf tablegen
endif

if !has_key(s:disabled_packages, 'log')
  au BufNewFile,BufRead *.LOG setf log
  au BufNewFile,BufRead *.log setf log
  au BufNewFile,BufRead *_LOG setf log
  au BufNewFile,BufRead *_log setf log
endif

if !has_key(s:disabled_packages, 'lua')
  au BufNewFile,BufRead *.fcgi setf lua
  au BufNewFile,BufRead *.lua setf lua
  au BufNewFile,BufRead *.nse setf lua
  au BufNewFile,BufRead *.p8 setf lua
  au BufNewFile,BufRead *.pd_lua setf lua
  au BufNewFile,BufRead *.rbxs setf lua
  au BufNewFile,BufRead *.rockspec setf lua
  au BufNewFile,BufRead *.wlua setf lua
  au BufNewFile,BufRead {.,}luacheckrc setf lua
endif

if !has_key(s:disabled_packages, 'm4')
  au BufNewFile,BufRead *.at setf m4
  au BufNewFile,BufRead *.m4 setf m4
endif

if !has_key(s:disabled_packages, 'mako')
  au BufNewFile *.*.mako execute "do BufNewFile filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufReadPre *.*.mako execute "do BufRead filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufNewFile,BufRead *.mako setf mako
  au BufNewFile *.*.mao execute "do BufNewFile filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufReadPre *.*.mao execute "do BufRead filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufNewFile,BufRead *.mao setf mako
endif

if !has_key(s:disabled_packages, 'octave')
  au BufNewFile,BufRead *.oct setf octave
  au! BufNewFile,BufRead *.m call polyglot#DetectMFiletype()
endif

if !has_key(s:disabled_packages, 'mathematica')
  au BufNewFile,BufRead *.cdf setf mma
  au BufNewFile,BufRead *.ma setf mma
  au BufNewFile,BufRead *.mathematica setf mma
  au BufNewFile,BufRead *.mma setf mma
  au BufNewFile,BufRead *.mt setf mma
  au BufNewFile,BufRead *.nb setf mma
  au BufNewFile,BufRead *.nbp setf mma
  au BufNewFile,BufRead *.wl setf mma
  au BufNewFile,BufRead *.wls setf mma
  au BufNewFile,BufRead *.wlt setf mma
  au! BufNewFile,BufRead *.m call polyglot#DetectMFiletype()
endif

if !has_key(s:disabled_packages, 'markdown')
  au BufNewFile,BufRead *.markdown setf markdown
  au BufNewFile,BufRead *.md setf markdown
  au BufNewFile,BufRead *.mdown setf markdown
  au BufNewFile,BufRead *.mdwn setf markdown
  au BufNewFile,BufRead *.mkd setf markdown
  au BufNewFile,BufRead *.mkdn setf markdown
  au BufNewFile,BufRead *.mkdown setf markdown
  au BufNewFile,BufRead *.ronn setf markdown
  au BufNewFile,BufRead *.workbook setf markdown
  au BufNewFile,BufRead contents.lr setf markdown
endif

if !has_key(s:disabled_packages, 'mdx')
  au BufNewFile,BufRead *.mdx setf markdown.mdx
endif

if !has_key(s:disabled_packages, 'meson')
  au BufNewFile,BufRead meson.build setf meson
  au BufNewFile,BufRead meson_options.txt setf meson
  au BufNewFile,BufRead *.wrap setf dosini
endif

if !has_key(s:disabled_packages, 'moonscript')
  au BufNewFile,BufRead *.moon setf moon
endif

if !has_key(s:disabled_packages, 'murphi')
  au! BufNewFile,BufRead *.m call polyglot#DetectMFiletype()
endif

if !has_key(s:disabled_packages, 'nginx')
  au BufNewFile,BufRead *.nginx setf nginx
  au BufNewFile,BufRead *.nginxconf setf nginx
  au BufNewFile,BufRead *.vhost setf nginx
  au BufNewFile,BufRead */etc/nginx/* call s:StarSetf('nginx')
  au BufNewFile,BufRead */nginx/*.conf setf nginx
  au BufNewFile,BufRead */usr/local/nginx/conf/* call s:StarSetf('nginx')
  au BufNewFile,BufRead *nginx.conf setf nginx
  au BufNewFile,BufRead nginx*.conf setf nginx
  au BufNewFile,BufRead nginx.conf setf nginx
endif

if !has_key(s:disabled_packages, 'nim')
  au BufNewFile,BufRead *.nim setf nim
  au BufNewFile,BufRead *.nim.cfg setf nim
  au BufNewFile,BufRead *.nimble setf nim
  au BufNewFile,BufRead *.nimrod setf nim
  au BufNewFile,BufRead *.nims setf nim
  au BufNewFile,BufRead nim.cfg setf nim
endif

if !has_key(s:disabled_packages, 'nix')
  au BufNewFile,BufRead *.nix setf nix
endif

if !has_key(s:disabled_packages, 'objc')
  au! BufNewFile,BufRead *.h call polyglot#DetectHFiletype()
  au! BufNewFile,BufRead *.m call polyglot#DetectMFiletype()
endif

if !has_key(s:disabled_packages, 'ocaml')
  au BufNewFile,BufRead *.eliom setf ocaml
  au BufNewFile,BufRead *.eliomi setf ocaml
  au BufNewFile,BufRead *.ml setf ocaml
  au BufNewFile,BufRead *.ml.cppo setf ocaml
  au BufNewFile,BufRead *.ml4 setf ocaml
  au BufNewFile,BufRead *.mli setf ocaml
  au BufNewFile,BufRead *.mli.cppo setf ocaml
  au BufNewFile,BufRead *.mlip setf ocaml
  au BufNewFile,BufRead *.mll setf ocaml
  au BufNewFile,BufRead *.mlp setf ocaml
  au BufNewFile,BufRead *.mlt setf ocaml
  au BufNewFile,BufRead *.mly setf ocaml
  au BufNewFile,BufRead {.,}ocamlinit setf ocaml
  au BufNewFile,BufRead *.om setf omake
  au BufNewFile,BufRead OMakefile setf omake
  au BufNewFile,BufRead OMakeroot setf omake
  au BufNewFile,BufRead OMakeroot.in setf omake
  au BufNewFile,BufRead *.opam setf opam
  au BufNewFile,BufRead *.opam.template setf opam
  au BufNewFile,BufRead opam setf opam
  au BufNewFile,BufRead _oasis setf oasis
  au BufNewFile,BufRead dune setf dune
  au BufNewFile,BufRead dune-project setf dune
  au BufNewFile,BufRead dune-workspace setf dune
  au BufNewFile,BufRead jbuild setf dune
  au BufNewFile,BufRead _tags setf ocamlbuild_tags
  au BufNewFile,BufRead *.ocp setf ocpbuild
  au BufNewFile,BufRead *.root setf ocpbuildroot
  au BufNewFile,BufRead *.sexp setf sexplib
endif

if !has_key(s:disabled_packages, 'opencl')
  au BufNewFile,BufRead *.cl setf opencl
  au BufNewFile,BufRead *.opencl setf opencl
endif

if !has_key(s:disabled_packages, 'perl')
  au BufNewFile,BufRead *.al setf perl
  au BufNewFile,BufRead *.cgi setf perl
  au BufNewFile,BufRead *.fcgi setf perl
  au BufNewFile,BufRead *.perl setf perl
  au BufNewFile,BufRead *.ph setf perl
  au BufNewFile,BufRead *.pl setf perl
  au BufNewFile,BufRead *.plx setf perl
  au BufNewFile,BufRead *.pm setf perl
  au BufNewFile,BufRead *.psgi setf perl
  au BufNewFile,BufRead *.t setf perl
  au BufNewFile,BufRead Makefile.PL setf perl
  au BufNewFile,BufRead Rexfile setf perl
  au BufNewFile,BufRead ack setf perl
  au BufNewFile,BufRead cpanfile setf perl
endif

if !has_key(s:disabled_packages, 'pgsql')
  au BufNewFile,BufRead *.pgsql let b:sql_type_override='pgsql' | set ft=sql
endif

if !has_key(s:disabled_packages, 'cql')
  au BufNewFile,BufRead *.cql setf cql
endif

if !has_key(s:disabled_packages, 'blade')
  au BufNewFile,BufRead *.blade setf blade
  au BufNewFile,BufRead *.blade.php setf blade
endif

if !has_key(s:disabled_packages, 'php')
  au BufNewFile,BufRead *.aw setf php
  au BufNewFile,BufRead *.ctp setf php
  au BufNewFile,BufRead *.fcgi setf php
  au BufNewFile,BufRead *.inc setf php
  au BufNewFile,BufRead *.php setf php
  au BufNewFile,BufRead *.php3 setf php
  au BufNewFile,BufRead *.php4 setf php
  au BufNewFile,BufRead *.php5 setf php
  au BufNewFile,BufRead *.phps setf php
  au BufNewFile,BufRead *.phpt setf php
  au BufNewFile,BufRead {.,}php setf php
  au BufNewFile,BufRead {.,}php_cs setf php
  au BufNewFile,BufRead {.,}php_cs.dist setf php
  au BufNewFile,BufRead Phakefile setf php
endif

if !has_key(s:disabled_packages, 'plantuml')
  au BufNewFile,BufRead *.iuml setf plantuml
  au BufNewFile,BufRead *.plantuml setf plantuml
  au BufNewFile,BufRead *.pu setf plantuml
  au BufNewFile,BufRead *.puml setf plantuml
  au BufNewFile,BufRead *.uml setf plantuml
endif

if !has_key(s:disabled_packages, 'pony')
  au BufNewFile,BufRead *.pony setf pony
endif

if !has_key(s:disabled_packages, 'powershell')
  au BufNewFile,BufRead *.ps1 setf ps1
  au BufNewFile,BufRead *.psd1 setf ps1
  au BufNewFile,BufRead *.psm1 setf ps1
  au BufNewFile,BufRead *.pssc setf ps1
  au BufNewFile,BufRead *.ps1xml setf ps1xml
endif

if !has_key(s:disabled_packages, 'protobuf')
  au BufNewFile,BufRead *.proto setf proto
endif

if !has_key(s:disabled_packages, 'pug')
  au BufNewFile,BufRead *.jade setf pug
  au BufNewFile,BufRead *.pug setf pug
endif

if !has_key(s:disabled_packages, 'puppet')
  au BufNewFile,BufRead *.pp setf puppet
  au BufNewFile,BufRead Modulefile setf puppet
  au BufNewFile,BufRead *.epp setf embeddedpuppet
endif

if !has_key(s:disabled_packages, 'purescript')
  au BufNewFile,BufRead *.purs setf purescript
endif

if !has_key(s:disabled_packages, 'python')
  au BufNewFile,BufRead *.cgi setf python
  au BufNewFile,BufRead *.fcgi setf python
  au BufNewFile,BufRead *.gyp setf python
  au BufNewFile,BufRead *.gypi setf python
  au BufNewFile,BufRead *.lmi setf python
  au BufNewFile,BufRead *.py setf python
  au BufNewFile,BufRead *.py3 setf python
  au BufNewFile,BufRead *.pyde setf python
  au BufNewFile,BufRead *.pyi setf python
  au BufNewFile,BufRead *.pyp setf python
  au BufNewFile,BufRead *.pyt setf python
  au BufNewFile,BufRead *.pyw setf python
  au BufNewFile,BufRead *.rpy setf python
  au BufNewFile,BufRead *.smk setf python
  au BufNewFile,BufRead *.spec setf python
  au BufNewFile,BufRead *.tac setf python
  au BufNewFile,BufRead *.wsgi setf python
  au BufNewFile,BufRead *.xpy setf python
  au BufNewFile,BufRead {.,}gclient setf python
  au BufNewFile,BufRead DEPS setf python
  au BufNewFile,BufRead SConscript setf python
  au BufNewFile,BufRead SConstruct setf python
  au BufNewFile,BufRead Snakefile setf python
  au BufNewFile,BufRead wscript setf python
endif

if !has_key(s:disabled_packages, 'requirements')
  au BufNewFile,BufRead *.pip setf requirements
  au BufNewFile,BufRead *require.{txt,in} setf requirements
  au BufNewFile,BufRead *requirements.{txt,in} setf requirements
  au BufNewFile,BufRead constraints.{txt,in} setf requirements
endif

if !has_key(s:disabled_packages, 'qmake')
  au BufNewFile,BufRead *.pri setf qmake
  au BufNewFile,BufRead *.pro setf qmake
endif

if !has_key(s:disabled_packages, 'qml')
  au BufNewFile,BufRead *.qbs setf qml
  au BufNewFile,BufRead *.qml setf qml
endif

if !has_key(s:disabled_packages, 'r-lang')
  au BufNewFile,BufRead *.S setf r
  au BufNewFile,BufRead *.r setf r
  au BufNewFile,BufRead *.rsx setf r
  au BufNewFile,BufRead *.s setf r
  au BufNewFile,BufRead {.,}Rprofile setf r
  au BufNewFile,BufRead expr-dist setf r
  au BufNewFile,BufRead *.rd setf rhelp
endif

if !has_key(s:disabled_packages, 'racket')
  au BufNewFile,BufRead *.rkt setf racket
  au BufNewFile,BufRead *.rktd setf racket
  au BufNewFile,BufRead *.rktl setf racket
  au BufNewFile,BufRead *.scrbl setf racket
endif

if !has_key(s:disabled_packages, 'ragel')
  au BufNewFile,BufRead *.rl setf ragel
endif

if !has_key(s:disabled_packages, 'raku')
  au BufNewFile,BufRead *.6pl setf raku
  au BufNewFile,BufRead *.6pm setf raku
  au BufNewFile,BufRead *.nqp setf raku
  au BufNewFile,BufRead *.p6 setf raku
  au BufNewFile,BufRead *.p6l setf raku
  au BufNewFile,BufRead *.p6m setf raku
  au BufNewFile,BufRead *.pl setf raku
  au BufNewFile,BufRead *.pl6 setf raku
  au BufNewFile,BufRead *.pm setf raku
  au BufNewFile,BufRead *.pm6 setf raku
  au BufNewFile,BufRead *.pod6 setf raku
  au BufNewFile,BufRead *.raku setf raku
  au BufNewFile,BufRead *.rakudoc setf raku
  au BufNewFile,BufRead *.rakumod setf raku
  au BufNewFile,BufRead *.rakutest setf raku
  au BufNewFile,BufRead *.t setf raku
  au BufNewFile,BufRead *.t6 setf raku
endif

if !has_key(s:disabled_packages, 'raml')
  au BufNewFile,BufRead *.raml setf raml
endif

if !has_key(s:disabled_packages, 'razor')
  au BufNewFile,BufRead *.cshtml setf razor
  au BufNewFile,BufRead *.razor setf razor
endif

if !has_key(s:disabled_packages, 'rst')
  au BufNewFile,BufRead *.rest setf rst
  au BufNewFile,BufRead *.rest.txt setf rst
  au BufNewFile,BufRead *.rst setf rst
  au BufNewFile,BufRead *.rst.txt setf rst
endif

if !has_key(s:disabled_packages, 'ruby')
  au BufNewFile,BufRead *.axlsx setf ruby
  au BufNewFile,BufRead *.builder setf ruby
  au BufNewFile,BufRead *.cap setf ruby
  au BufNewFile,BufRead *.eye setf ruby
  au BufNewFile,BufRead *.fcgi setf ruby
  au BufNewFile,BufRead *.gemspec setf ruby
  au BufNewFile,BufRead *.god setf ruby
  au BufNewFile,BufRead *.jbuilder setf ruby
  au BufNewFile,BufRead *.mspec setf ruby
  au BufNewFile,BufRead *.opal setf ruby
  au BufNewFile,BufRead *.pluginspec setf ruby
  au BufNewFile,BufRead *.podspec setf ruby
  au BufNewFile,BufRead *.rabl setf ruby
  au BufNewFile,BufRead *.rake setf ruby
  au BufNewFile,BufRead *.rant setf ruby
  au BufNewFile,BufRead *.rb setf ruby
  au BufNewFile,BufRead *.rbi setf ruby
  au BufNewFile,BufRead *.rbuild setf ruby
  au BufNewFile,BufRead *.rbw setf ruby
  au BufNewFile,BufRead *.rbx setf ruby
  au BufNewFile,BufRead *.rjs setf ruby
  au BufNewFile,BufRead *.ru setf ruby
  au BufNewFile,BufRead *.ruby setf ruby
  au BufNewFile,BufRead *.rxml setf ruby
  au BufNewFile,BufRead *.spec setf ruby
  au BufNewFile,BufRead *.thor setf ruby
  au BufNewFile,BufRead *.watchr setf ruby
  au BufNewFile,BufRead {.,}Brewfile setf ruby
  au BufNewFile,BufRead {.,}Guardfile setf ruby
  au BufNewFile,BufRead {.,}autotest setf ruby
  au BufNewFile,BufRead {.,}irbrc setf ruby
  au BufNewFile,BufRead {.,}pryrc setf ruby
  au BufNewFile,BufRead {.,}simplecov setf ruby
  au BufNewFile,BufRead Appraisals setf ruby
  au BufNewFile,BufRead Berksfile setf ruby
  au BufNewFile,BufRead Buildfile setf ruby
  au BufNewFile,BufRead Capfile setf ruby
  au BufNewFile,BufRead Cheffile setf ruby
  au BufNewFile,BufRead Dangerfile setf ruby
  au BufNewFile,BufRead Deliverfile setf ruby
  au BufNewFile,BufRead Fastfile setf ruby
  au BufNewFile,BufRead Gemfile setf ruby
  au BufNewFile,BufRead Gemfile.lock setf ruby
  au BufNewFile,BufRead Guardfile setf ruby
  au BufNewFile,BufRead Jarfile setf ruby
  au BufNewFile,BufRead KitchenSink setf ruby
  au BufNewFile,BufRead Mavenfile setf ruby
  au BufNewFile,BufRead Podfile setf ruby
  au BufNewFile,BufRead Puppetfile setf ruby
  au BufNewFile,BufRead Rakefile setf ruby
  au BufNewFile,BufRead Rantfile setf ruby
  au BufNewFile,BufRead Routefile setf ruby
  au BufNewFile,BufRead Snapfile setf ruby
  au BufNewFile,BufRead Thorfile setf ruby
  au BufNewFile,BufRead Vagrantfile setf ruby
  au BufNewFile,BufRead [Rr]akefile* call s:StarSetf('ruby')
  au BufNewFile,BufRead buildfile setf ruby
  au BufNewFile,BufRead vagrantfile setf ruby
  au BufNewFile,BufRead *.erb setf eruby
  au BufNewFile,BufRead *.erb.deface setf eruby
  au BufNewFile,BufRead *.rhtml setf eruby
endif

if !has_key(s:disabled_packages, 'rspec')
  au BufNewFile,BufRead *_spec.rb if !did_filetype() | set ft=ruby syntax=rspec | endif
endif

if !has_key(s:disabled_packages, 'brewfile')
  au BufNewFile,BufRead Brewfile setf brewfile
endif

if !has_key(s:disabled_packages, 'rust')
  au BufNewFile,BufRead *.rs setf rust
  au BufNewFile,BufRead *.rs.in setf rust
endif

if !has_key(s:disabled_packages, 'scala')
  au BufNewFile,BufRead *.kojo setf scala
  au BufNewFile,BufRead *.sc setf scala
  au BufNewFile,BufRead *.scala setf scala
endif

if !has_key(s:disabled_packages, 'sbt')
  au BufNewFile,BufRead *.sbt setf sbt.scala
endif

if !has_key(s:disabled_packages, 'scss')
  au BufNewFile,BufRead *.scss setf scss
endif

if !has_key(s:disabled_packages, 'sh')
  au BufNewFile,BufRead *.bash setf sh
  au BufNewFile,BufRead *.bats setf sh
  au BufNewFile,BufRead *.cgi setf sh
  au BufNewFile,BufRead *.command setf sh
  au BufNewFile,BufRead *.env setf sh
  au BufNewFile,BufRead *.fcgi setf sh
  au BufNewFile,BufRead *.ksh setf sh
  au BufNewFile,BufRead *.sh setf sh
  au BufNewFile,BufRead *.sh.in setf sh
  au BufNewFile,BufRead *.tmux setf sh
  au BufNewFile,BufRead *.tool setf sh
  au BufNewFile,BufRead {.,}bash_aliases setf sh
  au BufNewFile,BufRead {.,}bash_history setf sh
  au BufNewFile,BufRead {.,}bash_logout setf sh
  au BufNewFile,BufRead {.,}bash_profile setf sh
  au BufNewFile,BufRead {.,}bashrc setf sh
  au BufNewFile,BufRead {.,}cshrc setf sh
  au BufNewFile,BufRead {.,}env setf sh
  au BufNewFile,BufRead {.,}env.example setf sh
  au BufNewFile,BufRead {.,}flaskenv setf sh
  au BufNewFile,BufRead {.,}login setf sh
  au BufNewFile,BufRead {.,}profile setf sh
  au BufNewFile,BufRead 9fs setf sh
  au BufNewFile,BufRead PKGBUILD setf sh
  au BufNewFile,BufRead bash_aliases setf sh
  au BufNewFile,BufRead bash_logout setf sh
  au BufNewFile,BufRead bash_profile setf sh
  au BufNewFile,BufRead bashrc setf sh
  au BufNewFile,BufRead cshrc setf sh
  au BufNewFile,BufRead gradlew setf sh
  au BufNewFile,BufRead login setf sh
  au BufNewFile,BufRead man setf sh
  au BufNewFile,BufRead profile setf sh
  au BufNewFile,BufRead *.zsh setf zsh
  au BufNewFile,BufRead {.,}zlogin setf zsh
  au BufNewFile,BufRead {.,}zlogout setf zsh
  au BufNewFile,BufRead {.,}zprofile setf zsh
  au BufNewFile,BufRead {.,}zshenv setf zsh
  au BufNewFile,BufRead {.,}zshrc setf zsh
endif

if !has_key(s:disabled_packages, 'slim')
  au BufNewFile,BufRead *.slim setf slim
endif

if !has_key(s:disabled_packages, 'slime')
  au BufNewFile,BufRead *.slime setf slime
endif

if !has_key(s:disabled_packages, 'smt2')
  au BufNewFile,BufRead *.smt setf smt2
  au BufNewFile,BufRead *.smt2 setf smt2
endif

if !has_key(s:disabled_packages, 'solidity')
  au BufNewFile,BufRead *.sol setf solidity
endif

if !has_key(s:disabled_packages, 'stylus')
  au BufNewFile,BufRead *.styl setf stylus
  au BufNewFile,BufRead *.stylus setf stylus
endif

if !has_key(s:disabled_packages, 'svelte')
  au BufNewFile,BufRead *.svelte setf svelte
endif

if !has_key(s:disabled_packages, 'svg')
  au BufNewFile,BufRead *.svg setf svg
endif

if !has_key(s:disabled_packages, 'swift')
  au BufNewFile,BufRead *.swift setf swift
endif

if !has_key(s:disabled_packages, 'sxhkd')
  au BufNewFile,BufRead *.sxhkdrc setf sxhkdrc
  au BufNewFile,BufRead sxhkdrc setf sxhkdrc
endif

if !has_key(s:disabled_packages, 'systemd')
  au BufNewFile,BufRead *.automount setf systemd
  au BufNewFile,BufRead *.mount setf systemd
  au BufNewFile,BufRead *.path setf systemd
  au BufNewFile,BufRead *.service setf systemd
  au BufNewFile,BufRead *.socket setf systemd
  au BufNewFile,BufRead *.swap setf systemd
  au BufNewFile,BufRead *.target setf systemd
  au BufNewFile,BufRead *.timer setf systemd
endif

if !has_key(s:disabled_packages, 'terraform')
  au BufNewFile,BufRead *.hcl setf terraform
  au BufNewFile,BufRead *.nomad setf terraform
  au BufNewFile,BufRead *.tf setf terraform
  au BufNewFile,BufRead *.tfvars setf terraform
  au BufNewFile,BufRead *.workflow setf terraform
endif

if !has_key(s:disabled_packages, 'textile')
  au BufNewFile,BufRead *.textile setf textile
endif

if !has_key(s:disabled_packages, 'thrift')
  au BufNewFile,BufRead *.thrift setf thrift
endif

if !has_key(s:disabled_packages, 'tmux')
  au BufNewFile,BufRead {.,}tmux.conf setf tmux
endif

if !has_key(s:disabled_packages, 'toml')
  au BufNewFile,BufRead *.toml setf toml
  au BufNewFile,BufRead */.cargo/config setf toml
  au BufNewFile,BufRead */.cargo/credentials setf toml
  au BufNewFile,BufRead Cargo.lock setf toml
  au BufNewFile,BufRead Gopkg.lock setf toml
  au BufNewFile,BufRead Pipfile setf toml
  au BufNewFile,BufRead poetry.lock setf toml
endif

if !has_key(s:disabled_packages, 'tptp')
  au BufNewFile,BufRead *.ax setf tptp
  au BufNewFile,BufRead *.p setf tptp
  au BufNewFile,BufRead *.tptp setf tptp
endif

if !has_key(s:disabled_packages, 'twig')
  au BufNewFile,BufRead *.twig setf html.twig
  au BufNewFile,BufRead *.xml.twig setf xml.twig
endif

if !has_key(s:disabled_packages, 'typescript')
  au BufNewFile,BufRead *.ts setf typescript
  au BufNewFile,BufRead *.tsx setf typescriptreact
endif

if !has_key(s:disabled_packages, 'unison')
  au BufNewFile,BufRead *.u setf unison
  au BufNewFile,BufRead *.uu setf unison
endif

if !has_key(s:disabled_packages, 'v')
  au BufNewFile,BufRead *.v setf v
endif

if !has_key(s:disabled_packages, 'vala')
  au BufNewFile,BufRead *.vala setf vala
  au BufNewFile,BufRead *.valadoc setf vala
  au BufNewFile,BufRead *.vapi setf vala
endif

if !has_key(s:disabled_packages, 'vbnet')
  au BufNewFile,BufRead *.vb setf vbnet
  au BufNewFile,BufRead *.vbhtml setf vbnet
endif

if !has_key(s:disabled_packages, 'vcl')
  au BufNewFile,BufRead *.vcl setf vcl
endif

if !has_key(s:disabled_packages, 'velocity')
  au BufNewFile,BufRead *.vm setf velocity
endif

if !has_key(s:disabled_packages, 'vmasm')
  au BufNewFile,BufRead *.mar setf vmasm
endif

if !has_key(s:disabled_packages, 'vue')
  au BufNewFile,BufRead *.vue setf vue
  au BufNewFile,BufRead *.wpy setf vue
endif

if !has_key(s:disabled_packages, 'xdc')
  au BufNewFile,BufRead *.xdc setf xdc
endif

if !has_key(s:disabled_packages, 'xml')
  au BufNewFile,BufRead *.adml setf xml
  au BufNewFile,BufRead *.admx setf xml
  au BufNewFile,BufRead *.ant setf xml
  au BufNewFile,BufRead *.axml setf xml
  au BufNewFile,BufRead *.builds setf xml
  au BufNewFile,BufRead *.ccproj setf xml
  au BufNewFile,BufRead *.ccxml setf xml
  au BufNewFile,BufRead *.cdxml setf xml
  au BufNewFile,BufRead *.clixml setf xml
  au BufNewFile,BufRead *.cproject setf xml
  au BufNewFile,BufRead *.cscfg setf xml
  au BufNewFile,BufRead *.csdef setf xml
  au BufNewFile,BufRead *.csl setf xml
  au BufNewFile,BufRead *.csproj setf xml
  au BufNewFile,BufRead *.ct setf xml
  au BufNewFile,BufRead *.depproj setf xml
  au BufNewFile,BufRead *.dita setf xml
  au BufNewFile,BufRead *.ditamap setf xml
  au BufNewFile,BufRead *.ditaval setf xml
  au BufNewFile,BufRead *.dll.config setf xml
  au BufNewFile,BufRead *.dotsettings setf xml
  au BufNewFile,BufRead *.filters setf xml
  au BufNewFile,BufRead *.fsproj setf xml
  au BufNewFile,BufRead *.fxml setf xml
  au BufNewFile,BufRead *.glade setf xml
  au BufNewFile,BufRead *.gml setf xml
  au BufNewFile,BufRead *.gmx setf xml
  au BufNewFile,BufRead *.grxml setf xml
  au BufNewFile,BufRead *.gst setf xml
  au BufNewFile,BufRead *.iml setf xml
  au BufNewFile,BufRead *.ivy setf xml
  au BufNewFile,BufRead *.jelly setf xml
  au BufNewFile,BufRead *.jsproj setf xml
  au BufNewFile,BufRead *.kml setf xml
  au BufNewFile,BufRead *.launch setf xml
  au BufNewFile,BufRead *.mdpolicy setf xml
  au BufNewFile,BufRead *.mjml setf xml
  au BufNewFile,BufRead *.mm setf xml
  au BufNewFile,BufRead *.mod setf xml
  au BufNewFile,BufRead *.mxml setf xml
  au BufNewFile,BufRead *.natvis setf xml
  au BufNewFile,BufRead *.ncl setf xml
  au BufNewFile,BufRead *.ndproj setf xml
  au BufNewFile,BufRead *.nproj setf xml
  au BufNewFile,BufRead *.nuspec setf xml
  au BufNewFile,BufRead *.odd setf xml
  au BufNewFile,BufRead *.osm setf xml
  au BufNewFile,BufRead *.pkgproj setf xml
  au BufNewFile,BufRead *.pluginspec setf xml
  au BufNewFile,BufRead *.proj setf xml
  au BufNewFile,BufRead *.props setf xml
  au BufNewFile,BufRead *.ps1xml setf xml
  au BufNewFile,BufRead *.psc1 setf xml
  au BufNewFile,BufRead *.pt setf xml
  au BufNewFile,BufRead *.rdf setf xml
  au BufNewFile,BufRead *.resx setf xml
  au BufNewFile,BufRead *.rss setf xml
  au BufNewFile,BufRead *.sch setf xml
  au BufNewFile,BufRead *.scxml setf xml
  au BufNewFile,BufRead *.sfproj setf xml
  au BufNewFile,BufRead *.shproj setf xml
  au BufNewFile,BufRead *.srdf setf xml
  au BufNewFile,BufRead *.storyboard setf xml
  au BufNewFile,BufRead *.sublime-snippet setf xml
  au BufNewFile,BufRead *.targets setf xml
  au BufNewFile,BufRead *.tml setf xml
  au BufNewFile,BufRead *.ui setf xml
  au BufNewFile,BufRead *.urdf setf xml
  au BufNewFile,BufRead *.ux setf xml
  au BufNewFile,BufRead *.vbproj setf xml
  au BufNewFile,BufRead *.vcxproj setf xml
  au BufNewFile,BufRead *.vsixmanifest setf xml
  au BufNewFile,BufRead *.vssettings setf xml
  au BufNewFile,BufRead *.vstemplate setf xml
  au BufNewFile,BufRead *.vxml setf xml
  au BufNewFile,BufRead *.wixproj setf xml
  au BufNewFile,BufRead *.workflow setf xml
  au BufNewFile,BufRead *.wsdl setf xml
  au BufNewFile,BufRead *.wsf setf xml
  au BufNewFile,BufRead *.wxi setf xml
  au BufNewFile,BufRead *.wxl setf xml
  au BufNewFile,BufRead *.wxs setf xml
  au BufNewFile,BufRead *.x3d setf xml
  au BufNewFile,BufRead *.xacro setf xml
  au BufNewFile,BufRead *.xaml setf xml
  au BufNewFile,BufRead *.xib setf xml
  au BufNewFile,BufRead *.xlf setf xml
  au BufNewFile,BufRead *.xliff setf xml
  au BufNewFile,BufRead *.xmi setf xml
  au BufNewFile,BufRead *.xml setf xml
  au BufNewFile,BufRead *.xml.dist setf xml
  au BufNewFile,BufRead *.xproj setf xml
  au BufNewFile,BufRead *.xsd setf xml
  au BufNewFile,BufRead *.xspec setf xml
  au BufNewFile,BufRead *.xul setf xml
  au BufNewFile,BufRead *.zcml setf xml
  au BufNewFile,BufRead {.,}classpath setf xml
  au BufNewFile,BufRead {.,}cproject setf xml
  au BufNewFile,BufRead {.,}project setf xml
  au BufNewFile,BufRead App.config setf xml
  au BufNewFile,BufRead NuGet.config setf xml
  au BufNewFile,BufRead Settings.StyleCop setf xml
  au BufNewFile,BufRead Web.Debug.config setf xml
  au BufNewFile,BufRead Web.Release.config setf xml
  au BufNewFile,BufRead Web.config setf xml
  au BufNewFile,BufRead packages.config setf xml
endif

if !has_key(s:disabled_packages, 'xsl')
  au BufNewFile,BufRead *.xsl setf xsl
  au BufNewFile,BufRead *.xslt setf xsl
endif

if !has_key(s:disabled_packages, 'ansible')
  au BufNewFile,BufRead group_vars/* call s:StarSetf('yaml.ansible')
  au BufNewFile,BufRead handlers.*.y{a,}ml setf yaml.ansible
  au BufNewFile,BufRead host_vars/* call s:StarSetf('yaml.ansible')
  au BufNewFile,BufRead local.y{a,}ml setf yaml.ansible
  au BufNewFile,BufRead main.y{a,}ml setf yaml.ansible
  au BufNewFile,BufRead playbook.y{a,}ml setf yaml.ansible
  au BufNewFile,BufRead requirements.y{a,}ml setf yaml.ansible
  au BufNewFile,BufRead roles.*.y{a,}ml setf yaml.ansible
  au BufNewFile,BufRead site.y{a,}ml setf yaml.ansible
  au BufNewFile,BufRead tasks.*.y{a,}ml setf yaml.ansible
endif

if !has_key(s:disabled_packages, 'yaml')
  au BufNewFile,BufRead *.mir setf yaml
  au BufNewFile,BufRead *.reek setf yaml
  au BufNewFile,BufRead *.rviz setf yaml
  au BufNewFile,BufRead *.sublime-syntax setf yaml
  au BufNewFile,BufRead *.syntax setf yaml
  au BufNewFile,BufRead *.yaml setf yaml
  au BufNewFile,BufRead *.yaml-tmlanguage setf yaml
  au BufNewFile,BufRead *.yaml.sed setf yaml
  au BufNewFile,BufRead *.yml setf yaml
  au BufNewFile,BufRead *.yml.mysql setf yaml
  au BufNewFile,BufRead {.,}clang-format setf yaml
  au BufNewFile,BufRead {.,}clang-tidy setf yaml
  au BufNewFile,BufRead {.,}gemrc setf yaml
  au BufNewFile,BufRead fish_history setf yaml
  au BufNewFile,BufRead fish_read_history setf yaml
  au BufNewFile,BufRead glide.lock setf yaml
  au BufNewFile,BufRead yarn.lock setf yaml
endif

if !has_key(s:disabled_packages, 'helm')
  au BufNewFile,BufRead */templates/*.tpl setf helm
  au BufNewFile,BufRead */templates/*.yaml setf helm
endif

if !has_key(s:disabled_packages, 'help')
  au BufNewFile,BufRead $VIMRUNTIME/doc/*.txt setf help
endif

if !has_key(s:disabled_packages, 'zephir')
  au BufNewFile,BufRead *.zep setf zephir
endif

if !has_key(s:disabled_packages, 'zig')
  au BufNewFile,BufRead *.zir setf zir
  au BufNewFile,BufRead *.zig setf zig
  au BufNewFile,BufRead *.zir setf zig
endif

if !has_key(s:disabled_packages, 'trasys')
  au! BufNewFile,BufRead *.inp call polyglot#DetectInpFiletype()
endif

if !has_key(s:disabled_packages, 'basic')
  au BufNewFile,BufRead *.basic setf basic
endif

if !has_key(s:disabled_packages, 'visual-basic')
  au BufNewFile,BufRead *.cls setf vb
  au BufNewFile,BufRead *.ctl setf vb
  au BufNewFile,BufRead *.dsm setf vb
  au BufNewFile,BufRead *.frm setf vb
  au BufNewFile,BufRead *.frx setf vb
  au BufNewFile,BufRead *.sba setf vb
  au BufNewFile,BufRead *.vba setf vb
  au BufNewFile,BufRead *.vbs setf vb
  au! BufNewFile,BufRead *.bas call polyglot#DetectBasFiletype()
endif

if !has_key(s:disabled_packages, 'dosini')
  au BufNewFile,BufRead *.cfg setf dosini
  au BufNewFile,BufRead *.dof setf dosini
  au BufNewFile,BufRead *.ini setf dosini
  au BufNewFile,BufRead *.lektorproject setf dosini
  au BufNewFile,BufRead *.prefs setf dosini
  au BufNewFile,BufRead *.pro setf dosini
  au BufNewFile,BufRead *.properties setf dosini
  au BufNewFile,BufRead */etc/pacman.conf setf dosini
  au BufNewFile,BufRead */etc/yum.conf setf dosini
  au BufNewFile,BufRead */etc/yum.repos.d/* call s:StarSetf('dosini')
  au BufNewFile,BufRead {.,}editorconfig setf dosini
  au BufNewFile,BufRead {.,}npmrc setf dosini
  au BufNewFile,BufRead buildozer.spec setf dosini
  au BufNewFile,BufRead php.ini-* call s:StarSetf('dosini')
endif

if !has_key(s:disabled_packages, 'odin')
  au BufNewFile,BufRead *.odin setf odin
endif


" end filetypes

au BufNewFile,BufRead,StdinReadPost * 
  \ if !did_filetype() && expand("<afile>") !~ g:ft_ignore_pat 
  \ | call polyglot#Heuristics() | endif

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
      \ if polyglot#Heuristics() | au! polyglot-observer CursorHold,CursorHoldI | endif
  augroup END
endfunc

au BufEnter * if &ft == "" && expand("<afile>") !~ g:ft_ignore_pat
      \ | call s:observe_filetype() | endif

" restore Vi compatibility settings
let &cpo = s:cpo_save
unlet s:cpo_save
