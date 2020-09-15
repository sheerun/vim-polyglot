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
  if expand("<amatch>") !~ g:ft_ignore_pat
    exe 'setf ' . a:ft
  endif
endfunc

augroup filetypedetect

" filetypes

if !has_key(s:disabled_packages, '8th')
  au! BufRead,BufNewFile *.8th
endif

if !has_key(s:disabled_packages, 'haproxy')
  au! BufRead,BufNewFile *.cfg
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

if !has_key(s:disabled_packages, 'xml')
  au! BufRead,BufNewFile *.csproj,*.ui,*.wsdl,*.wsf,*.xlf,*.xliff,*.xmi,*.xsd,*.xul
endif

if !has_key(s:disabled_packages, 'applescript')
  au! BufRead,BufNewFile *.scpt
endif

if !has_key(s:disabled_packages, 'c/c++')
  au! BufRead,BufNewFile *.cpp,*.c++,*.cc,*.cxx,*.hh,*.hpp,*.hxx,*.inl,*.ipp,*.tcc,*.tpp,*.moc,*.tlh,*.qc
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
  au! BufRead,BufNewFile *.ini,*.properties
endif

if !has_key(s:disabled_packages, '8th')
  au BufNewFile,BufRead *.8th call s:Setf('8th')
endif

if !has_key(s:disabled_packages, 'haproxy')
  au BufNewFile,BufRead *.cfg call s:Setf('haproxy')
  au BufNewFile,BufRead haproxy*.c* call s:StarSetf('haproxy')
  au BufNewFile,BufRead haproxy.cfg call s:Setf('haproxy')
endif

if !has_key(s:disabled_packages, 'a2ps')
  au BufNewFile,BufRead */etc/a2ps.cfg call s:Setf('a2ps')
  au BufNewFile,BufRead */etc/a2ps/*.cfg call s:Setf('a2ps')
  au BufNewFile,BufRead {.,}a2psrc call s:Setf('a2ps')
  au BufNewFile,BufRead a2psrc call s:Setf('a2ps')
endif

if !has_key(s:disabled_packages, 'a65')
  au BufNewFile,BufRead *.a65 call s:Setf('a65')
endif

if !has_key(s:disabled_packages, 'aap')
  au BufNewFile,BufRead *.aap call s:Setf('aap')
endif

if !has_key(s:disabled_packages, 'abap')
  au BufNewFile,BufRead *.abap call s:Setf('abap')
endif

if !has_key(s:disabled_packages, 'abaqus')
  au! BufNewFile,BufRead *.inp call polyglot#DetectInpFiletype()
endif

if !has_key(s:disabled_packages, 'abc')
  au BufNewFile,BufRead *.abc call s:Setf('abc')
endif

if !has_key(s:disabled_packages, 'abel')
  au BufNewFile,BufRead *.abl call s:Setf('abel')
endif

if !has_key(s:disabled_packages, 'acedb')
  au BufNewFile,BufRead *.wrm call s:Setf('acedb')
endif

if !has_key(s:disabled_packages, 'acpiasl')
  au BufNewFile,BufRead *.asl call s:Setf('asl')
  au BufNewFile,BufRead *.dsl call s:Setf('asl')
endif

if !has_key(s:disabled_packages, 'ada')
  au BufNewFile,BufRead *.ada call s:Setf('ada')
  au BufNewFile,BufRead *.ada_m call s:Setf('ada')
  au BufNewFile,BufRead *.adb call s:Setf('ada')
  au BufNewFile,BufRead *.adc call s:Setf('ada')
  au BufNewFile,BufRead *.ads call s:Setf('ada')
  au BufNewFile,BufRead *.gpr call s:Setf('ada')
endif

if !has_key(s:disabled_packages, 'ahdl')
  au BufNewFile,BufRead *.tdf call s:Setf('ahdl')
endif

if !has_key(s:disabled_packages, 'aidl')
  au BufNewFile,BufRead *.aidl call s:Setf('aidl')
endif

if !has_key(s:disabled_packages, 'alsaconf')
  au BufNewFile,BufRead */etc/asound.conf call s:Setf('alsaconf')
  au BufNewFile,BufRead */usr/share/alsa/alsa.conf call s:Setf('alsaconf')
  au BufNewFile,BufRead {.,}asoundrc call s:Setf('alsaconf')
endif

if !has_key(s:disabled_packages, 'aml')
  au BufNewFile,BufRead *.aml call s:Setf('aml')
endif

if !has_key(s:disabled_packages, 'ampl')
  au BufNewFile,BufRead *.run call s:Setf('ampl')
endif

if !has_key(s:disabled_packages, 'xml')
  au BufNewFile,BufRead *.adml call s:Setf('xml')
  au BufNewFile,BufRead *.admx call s:Setf('xml')
  au BufNewFile,BufRead *.ant call s:Setf('xml')
  au BufNewFile,BufRead *.axml call s:Setf('xml')
  au BufNewFile,BufRead *.builds call s:Setf('xml')
  au BufNewFile,BufRead *.ccproj call s:Setf('xml')
  au BufNewFile,BufRead *.ccxml call s:Setf('xml')
  au BufNewFile,BufRead *.cdxml call s:Setf('xml')
  au BufNewFile,BufRead *.clixml call s:Setf('xml')
  au BufNewFile,BufRead *.cproject call s:Setf('xml')
  au BufNewFile,BufRead *.cscfg call s:Setf('xml')
  au BufNewFile,BufRead *.csdef call s:Setf('xml')
  au BufNewFile,BufRead *.csl call s:Setf('xml')
  au BufNewFile,BufRead *.csproj call s:Setf('xml')
  au BufNewFile,BufRead *.ct call s:Setf('xml')
  au BufNewFile,BufRead *.depproj call s:Setf('xml')
  au BufNewFile,BufRead *.dita call s:Setf('xml')
  au BufNewFile,BufRead *.ditamap call s:Setf('xml')
  au BufNewFile,BufRead *.ditaval call s:Setf('xml')
  au BufNewFile,BufRead *.dll.config call s:Setf('xml')
  au BufNewFile,BufRead *.dotsettings call s:Setf('xml')
  au BufNewFile,BufRead *.filters call s:Setf('xml')
  au BufNewFile,BufRead *.fsproj call s:Setf('xml')
  au BufNewFile,BufRead *.fxml call s:Setf('xml')
  au BufNewFile,BufRead *.glade call s:Setf('xml')
  au BufNewFile,BufRead *.gml call s:Setf('xml')
  au BufNewFile,BufRead *.gmx call s:Setf('xml')
  au BufNewFile,BufRead *.grxml call s:Setf('xml')
  au BufNewFile,BufRead *.gst call s:Setf('xml')
  au BufNewFile,BufRead *.iml call s:Setf('xml')
  au BufNewFile,BufRead *.ivy call s:Setf('xml')
  au BufNewFile,BufRead *.jelly call s:Setf('xml')
  au BufNewFile,BufRead *.jsproj call s:Setf('xml')
  au BufNewFile,BufRead *.kml call s:Setf('xml')
  au BufNewFile,BufRead *.launch call s:Setf('xml')
  au BufNewFile,BufRead *.mdpolicy call s:Setf('xml')
  au BufNewFile,BufRead *.mjml call s:Setf('xml')
  au BufNewFile,BufRead *.mm call s:Setf('xml')
  au BufNewFile,BufRead *.mod call s:Setf('xml')
  au BufNewFile,BufRead *.mxml call s:Setf('xml')
  au BufNewFile,BufRead *.natvis call s:Setf('xml')
  au BufNewFile,BufRead *.ncl call s:Setf('xml')
  au BufNewFile,BufRead *.ndproj call s:Setf('xml')
  au BufNewFile,BufRead *.nproj call s:Setf('xml')
  au BufNewFile,BufRead *.nuspec call s:Setf('xml')
  au BufNewFile,BufRead *.odd call s:Setf('xml')
  au BufNewFile,BufRead *.osm call s:Setf('xml')
  au BufNewFile,BufRead *.pkgproj call s:Setf('xml')
  au BufNewFile,BufRead *.pluginspec call s:Setf('xml')
  au BufNewFile,BufRead *.proj call s:Setf('xml')
  au BufNewFile,BufRead *.props call s:Setf('xml')
  au BufNewFile,BufRead *.ps1xml call s:Setf('xml')
  au BufNewFile,BufRead *.psc1 call s:Setf('xml')
  au BufNewFile,BufRead *.pt call s:Setf('xml')
  au BufNewFile,BufRead *.rdf call s:Setf('xml')
  au BufNewFile,BufRead *.resx call s:Setf('xml')
  au BufNewFile,BufRead *.rss call s:Setf('xml')
  au BufNewFile,BufRead *.sch call s:Setf('xml')
  au BufNewFile,BufRead *.scxml call s:Setf('xml')
  au BufNewFile,BufRead *.sfproj call s:Setf('xml')
  au BufNewFile,BufRead *.shproj call s:Setf('xml')
  au BufNewFile,BufRead *.srdf call s:Setf('xml')
  au BufNewFile,BufRead *.storyboard call s:Setf('xml')
  au BufNewFile,BufRead *.sublime-snippet call s:Setf('xml')
  au BufNewFile,BufRead *.targets call s:Setf('xml')
  au BufNewFile,BufRead *.tml call s:Setf('xml')
  au BufNewFile,BufRead *.ui call s:Setf('xml')
  au BufNewFile,BufRead *.urdf call s:Setf('xml')
  au BufNewFile,BufRead *.ux call s:Setf('xml')
  au BufNewFile,BufRead *.vbproj call s:Setf('xml')
  au BufNewFile,BufRead *.vcxproj call s:Setf('xml')
  au BufNewFile,BufRead *.vsixmanifest call s:Setf('xml')
  au BufNewFile,BufRead *.vssettings call s:Setf('xml')
  au BufNewFile,BufRead *.vstemplate call s:Setf('xml')
  au BufNewFile,BufRead *.vxml call s:Setf('xml')
  au BufNewFile,BufRead *.wixproj call s:Setf('xml')
  au BufNewFile,BufRead *.workflow call s:Setf('xml')
  au BufNewFile,BufRead *.wsdl call s:Setf('xml')
  au BufNewFile,BufRead *.wsf call s:Setf('xml')
  au BufNewFile,BufRead *.wxi call s:Setf('xml')
  au BufNewFile,BufRead *.wxl call s:Setf('xml')
  au BufNewFile,BufRead *.wxs call s:Setf('xml')
  au BufNewFile,BufRead *.x3d call s:Setf('xml')
  au BufNewFile,BufRead *.xacro call s:Setf('xml')
  au BufNewFile,BufRead *.xaml call s:Setf('xml')
  au BufNewFile,BufRead *.xib call s:Setf('xml')
  au BufNewFile,BufRead *.xlf call s:Setf('xml')
  au BufNewFile,BufRead *.xliff call s:Setf('xml')
  au BufNewFile,BufRead *.xmi call s:Setf('xml')
  au BufNewFile,BufRead *.xml call s:Setf('xml')
  au BufNewFile,BufRead *.xml.dist call s:Setf('xml')
  au BufNewFile,BufRead *.xproj call s:Setf('xml')
  au BufNewFile,BufRead *.xsd call s:Setf('xml')
  au BufNewFile,BufRead *.xspec call s:Setf('xml')
  au BufNewFile,BufRead *.xul call s:Setf('xml')
  au BufNewFile,BufRead *.zcml call s:Setf('xml')
  au BufNewFile,BufRead {.,}classpath call s:Setf('xml')
  au BufNewFile,BufRead {.,}cproject call s:Setf('xml')
  au BufNewFile,BufRead {.,}project call s:Setf('xml')
  au BufNewFile,BufRead App.config call s:Setf('xml')
  au BufNewFile,BufRead NuGet.config call s:Setf('xml')
  au BufNewFile,BufRead Settings.StyleCop call s:Setf('xml')
  au BufNewFile,BufRead Web.Debug.config call s:Setf('xml')
  au BufNewFile,BufRead Web.Release.config call s:Setf('xml')
  au BufNewFile,BufRead Web.config call s:Setf('xml')
  au BufNewFile,BufRead packages.config call s:Setf('xml')
endif

if !has_key(s:disabled_packages, 'ant')
  au BufNewFile,BufRead build.xml call s:Setf('ant')
endif

if !has_key(s:disabled_packages, 'apache')
  au BufNewFile,BufRead */etc/apache2/*.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead */etc/apache2/conf.*/* call s:StarSetf('apache')
  au BufNewFile,BufRead */etc/apache2/mods-*/* call s:StarSetf('apache')
  au BufNewFile,BufRead */etc/apache2/sites-*/* call s:StarSetf('apache')
  au BufNewFile,BufRead */etc/apache2/sites-*/*.com call s:Setf('apache')
  au BufNewFile,BufRead */etc/httpd/*.conf call s:Setf('apache')
  au BufNewFile,BufRead */etc/httpd/conf.d/*.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead {.,}htaccess call s:Setf('apache')
  au BufNewFile,BufRead access.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead apache.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead apache2.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead httpd.conf* call s:StarSetf('apache')
  au BufNewFile,BufRead srm.conf* call s:StarSetf('apache')
endif

if !has_key(s:disabled_packages, 'apiblueprint')
  au BufNewFile,BufRead *.apib call s:Setf('apiblueprint')
endif

if !has_key(s:disabled_packages, 'applescript')
  au BufNewFile,BufRead *.applescript call s:Setf('applescript')
  au BufNewFile,BufRead *.scpt call s:Setf('applescript')
endif

if !has_key(s:disabled_packages, 'aptconf')
  au BufNewFile,BufRead */.aptitude/config call s:Setf('aptconf')
  au BufNewFile,BufRead */etc/apt/apt.conf.d/*.conf call s:Setf('aptconf')
  au BufNewFile,BufRead */etc/apt/apt.conf.d/[^.]* call s:StarSetf('aptconf')
  au BufNewFile,BufRead apt.conf call s:Setf('aptconf')
endif

if !has_key(s:disabled_packages, 'arch')
  au BufNewFile,BufRead {.,}arch-inventory call s:Setf('arch')
  au BufNewFile,BufRead =tagging-method call s:Setf('arch')
endif

if !has_key(s:disabled_packages, 'c/c++')
  au BufNewFile,BufRead *.c++ call s:Setf('cpp')
  au BufNewFile,BufRead *.cc call s:Setf('cpp')
  au BufNewFile,BufRead *.cp call s:Setf('cpp')
  au BufNewFile,BufRead *.cpp call s:Setf('cpp')
  au BufNewFile,BufRead *.cxx call s:Setf('cpp')
  au BufNewFile,BufRead *.h++ call s:Setf('cpp')
  au BufNewFile,BufRead *.hh call s:Setf('cpp')
  au BufNewFile,BufRead *.hpp call s:Setf('cpp')
  au BufNewFile,BufRead *.hxx call s:Setf('cpp')
  au BufNewFile,BufRead *.inc call s:Setf('cpp')
  au BufNewFile,BufRead *.inl call s:Setf('cpp')
  au BufNewFile,BufRead *.ipp call s:Setf('cpp')
  au BufNewFile,BufRead *.moc call s:Setf('cpp')
  au BufNewFile,BufRead *.tcc call s:Setf('cpp')
  au BufNewFile,BufRead *.tlh call s:Setf('cpp')
  au BufNewFile,BufRead *.tpp call s:Setf('cpp')
  au BufNewFile,BufRead *.c call s:Setf('c')
  au BufNewFile,BufRead *.cats call s:Setf('c')
  au BufNewFile,BufRead *.idc call s:Setf('c')
  au BufNewFile,BufRead *.qc call s:Setf('c')
  au BufNewFile,BufRead *enlightenment/*.cfg call s:Setf('c')
  au! BufNewFile,BufRead *.h call polyglot#DetectHFiletype()
endif

if !has_key(s:disabled_packages, 'arduino')
  au BufNewFile,BufRead *.ino call s:Setf('arduino')
  au BufNewFile,BufRead *.pde call s:Setf('arduino')
endif

if !has_key(s:disabled_packages, 'art')
  au BufNewFile,BufRead *.art call s:Setf('art')
endif

if !has_key(s:disabled_packages, 'asciidoc')
  au BufNewFile,BufRead *.adoc call s:Setf('asciidoc')
  au BufNewFile,BufRead *.asc call s:Setf('asciidoc')
  au BufNewFile,BufRead *.asciidoc call s:Setf('asciidoc')
endif

if !has_key(s:disabled_packages, 'autohotkey')
  au BufNewFile,BufRead *.ahk call s:Setf('autohotkey')
  au BufNewFile,BufRead *.ahkl call s:Setf('autohotkey')
endif

if !has_key(s:disabled_packages, 'elf')
  au BufNewFile,BufRead *.am call s:Setf('elf')
endif

if !has_key(s:disabled_packages, 'automake')
  au BufNewFile,BufRead GNUmakefile.am call s:Setf('automake')
  au BufNewFile,BufRead [Mm]akefile.am call s:Setf('automake')
endif

if !has_key(s:disabled_packages, 'asn')
  au BufNewFile,BufRead *.asn call s:Setf('asn')
  au BufNewFile,BufRead *.asn1 call s:Setf('asn')
endif

if !has_key(s:disabled_packages, 'aspvbs')
  au! BufNewFile,BufRead *.asa call polyglot#DetectAsaFiletype()
  au! BufNewFile,BufRead *.asp call polyglot#DetectAspFiletype()
endif

if !has_key(s:disabled_packages, 'aspperl')
  au! BufNewFile,BufRead *.asp call polyglot#DetectAspFiletype()
endif

if !has_key(s:disabled_packages, 'atlas')
  au BufNewFile,BufRead *.as call s:Setf('atlas')
  au BufNewFile,BufRead *.atl call s:Setf('atlas')
endif

if !has_key(s:disabled_packages, 'autoit')
  au BufNewFile,BufRead *.au3 call s:Setf('autoit')
endif

if !has_key(s:disabled_packages, 'ave')
  au BufNewFile,BufRead *.ave call s:Setf('ave')
endif

if !has_key(s:disabled_packages, 'awk')
  au BufNewFile,BufRead *.awk call s:Setf('awk')
  au BufNewFile,BufRead *.gawk call s:Setf('awk')
endif

if !has_key(s:disabled_packages, 'caddyfile')
  au BufNewFile,BufRead Caddyfile call s:Setf('caddyfile')
endif

if !has_key(s:disabled_packages, 'carp')
  au BufNewFile,BufRead *.carp call s:Setf('carp')
endif

if !has_key(s:disabled_packages, 'clojure')
  au BufNewFile,BufRead *.boot call s:Setf('clojure')
  au BufNewFile,BufRead *.cl2 call s:Setf('clojure')
  au BufNewFile,BufRead *.clj call s:Setf('clojure')
  au BufNewFile,BufRead *.cljc call s:Setf('clojure')
  au BufNewFile,BufRead *.cljs call s:Setf('clojure')
  au BufNewFile,BufRead *.cljs.hl call s:Setf('clojure')
  au BufNewFile,BufRead *.cljscm call s:Setf('clojure')
  au BufNewFile,BufRead *.cljx call s:Setf('clojure')
  au BufNewFile,BufRead *.edn call s:Setf('clojure')
  au BufNewFile,BufRead *.hic call s:Setf('clojure')
  au BufNewFile,BufRead build.boot call s:Setf('clojure')
  au BufNewFile,BufRead profile.boot call s:Setf('clojure')
  au BufNewFile,BufRead riemann.config call s:Setf('clojure')
endif

if !has_key(s:disabled_packages, 'cmake')
  au BufNewFile,BufRead *.cmake call s:Setf('cmake')
  au BufNewFile,BufRead *.cmake.in call s:Setf('cmake')
  au BufNewFile,BufRead CMakeLists.txt call s:Setf('cmake')
endif

if !has_key(s:disabled_packages, 'coffee-script')
  au BufNewFile,BufRead *._coffee call s:Setf('coffee')
  au BufNewFile,BufRead *.cake call s:Setf('coffee')
  au BufNewFile,BufRead *.cjsx call s:Setf('coffee')
  au BufNewFile,BufRead *.coffee call s:Setf('coffee')
  au BufNewFile,BufRead *.coffeekup call s:Setf('coffee')
  au BufNewFile,BufRead *.iced call s:Setf('coffee')
  au BufNewFile,BufRead Cakefile call s:Setf('coffee')
  au BufNewFile,BufRead *.coffee.md call s:Setf('litcoffee')
  au BufNewFile,BufRead *.litcoffee call s:Setf('litcoffee')
endif

if !has_key(s:disabled_packages, 'cryptol')
  au BufNewFile,BufRead *.cry call s:Setf('cryptol')
  au BufNewFile,BufRead *.cyl call s:Setf('cryptol')
  au BufNewFile,BufRead *.lcry call s:Setf('cryptol')
  au BufNewFile,BufRead *.lcyl call s:Setf('cryptol')
endif

if !has_key(s:disabled_packages, 'crystal')
  au BufNewFile,BufRead *.cr call s:Setf('crystal')
  au BufNewFile,BufRead Projectfile call s:Setf('crystal')
  au BufNewFile,BufRead *.ecr call s:Setf('ecrystal')
endif

if !has_key(s:disabled_packages, 'csv')
  au BufNewFile,BufRead *.csv call s:Setf('csv')
  au BufNewFile,BufRead *.tab call s:Setf('csv')
  au BufNewFile,BufRead *.tsv call s:Setf('csv')
endif

if !has_key(s:disabled_packages, 'cucumber')
  au BufNewFile,BufRead *.feature call s:Setf('cucumber')
  au BufNewFile,BufRead *.story call s:Setf('cucumber')
endif

if !has_key(s:disabled_packages, 'cue')
  au BufNewFile,BufRead *.cue call s:Setf('cuesheet')
endif

if !has_key(s:disabled_packages, 'dart')
  au BufNewFile,BufRead *.dart call s:Setf('dart')
  au BufNewFile,BufRead *.drt call s:Setf('dart')
endif

if !has_key(s:disabled_packages, 'dhall')
  au BufNewFile,BufRead *.dhall call s:Setf('dhall')
endif

if !has_key(s:disabled_packages, 'dlang')
  au BufNewFile,BufRead *.d call s:Setf('d')
  au BufNewFile,BufRead *.di call s:Setf('d')
  au BufNewFile,BufRead *.lst call s:Setf('dcov')
  au BufNewFile,BufRead *.dd call s:Setf('dd')
  au BufNewFile,BufRead *.ddoc call s:Setf('ddoc')
  au BufNewFile,BufRead *.sdl call s:Setf('dsdl')
endif

if !has_key(s:disabled_packages, 'dockerfile')
  au BufNewFile,BufRead *.Dockerfile call s:Setf('Dockerfile')
  au BufNewFile,BufRead *.dock call s:Setf('Dockerfile')
  au BufNewFile,BufRead *.dockerfile call s:Setf('Dockerfile')
  au BufNewFile,BufRead Dockerfile call s:Setf('Dockerfile')
  au BufNewFile,BufRead Dockerfile* call s:StarSetf('Dockerfile')
  au BufNewFile,BufRead dockerfile call s:Setf('Dockerfile')
  au BufNewFile,BufRead docker-compose*.yaml call s:Setf('yaml.docker-compose')
  au BufNewFile,BufRead docker-compose*.yml call s:Setf('yaml.docker-compose')
endif

if !has_key(s:disabled_packages, 'elixir')
  au BufNewFile,BufRead *.ex call s:Setf('elixir')
  au BufNewFile,BufRead *.exs call s:Setf('elixir')
  au BufNewFile,BufRead mix.lock call s:Setf('elixir')
  au BufNewFile,BufRead *.eex call s:Setf('eelixir')
  au BufNewFile,BufRead *.leex call s:Setf('eelixir')
endif

if !has_key(s:disabled_packages, 'elm')
  au BufNewFile,BufRead *.elm call s:Setf('elm')
endif

if !has_key(s:disabled_packages, 'emberscript')
  au BufNewFile,BufRead *.em call s:Setf('ember-script')
  au BufNewFile,BufRead *.emberscript call s:Setf('ember-script')
endif

if !has_key(s:disabled_packages, 'emblem')
  au BufNewFile,BufRead *.em call s:Setf('emblem')
  au BufNewFile,BufRead *.emblem call s:Setf('emblem')
endif

if !has_key(s:disabled_packages, 'erlang')
  au BufNewFile,BufRead *.app call s:Setf('erlang')
  au BufNewFile,BufRead *.app.src call s:Setf('erlang')
  au BufNewFile,BufRead *.erl call s:Setf('erlang')
  au BufNewFile,BufRead *.es call s:Setf('erlang')
  au BufNewFile,BufRead *.escript call s:Setf('erlang')
  au BufNewFile,BufRead *.hrl call s:Setf('erlang')
  au BufNewFile,BufRead *.xrl call s:Setf('erlang')
  au BufNewFile,BufRead *.yaws call s:Setf('erlang')
  au BufNewFile,BufRead *.yrl call s:Setf('erlang')
  au BufNewFile,BufRead Emakefile call s:Setf('erlang')
  au BufNewFile,BufRead rebar.config call s:Setf('erlang')
  au BufNewFile,BufRead rebar.config.lock call s:Setf('erlang')
  au BufNewFile,BufRead rebar.lock call s:Setf('erlang')
endif

if !has_key(s:disabled_packages, 'fennel')
  au BufNewFile,BufRead *.fnl call s:Setf('fennel')
endif

if !has_key(s:disabled_packages, 'ferm')
  au BufNewFile,BufRead *.ferm call s:Setf('ferm')
  au BufNewFile,BufRead ferm.conf call s:Setf('ferm')
endif

if !has_key(s:disabled_packages, 'fish')
  au BufNewFile,BufRead *.fish call s:Setf('fish')
endif

if !has_key(s:disabled_packages, 'flatbuffers')
  au BufNewFile,BufRead *.fbs call s:Setf('fbs')
endif

if !has_key(s:disabled_packages, 'forth')
  au BufNewFile,BufRead *.ft call s:Setf('forth')
  au BufNewFile,BufRead *.fth call s:Setf('forth')
  au! BufNewFile,BufRead *.fs call polyglot#DetectFsFiletype()
endif

if !has_key(s:disabled_packages, 'glsl')
  au BufNewFile,BufRead *.comp call s:Setf('glsl')
  au BufNewFile,BufRead *.fp call s:Setf('glsl')
  au BufNewFile,BufRead *.frag call s:Setf('glsl')
  au BufNewFile,BufRead *.frg call s:Setf('glsl')
  au BufNewFile,BufRead *.fsh call s:Setf('glsl')
  au BufNewFile,BufRead *.fshader call s:Setf('glsl')
  au BufNewFile,BufRead *.geo call s:Setf('glsl')
  au BufNewFile,BufRead *.geom call s:Setf('glsl')
  au BufNewFile,BufRead *.glsl call s:Setf('glsl')
  au BufNewFile,BufRead *.glslf call s:Setf('glsl')
  au BufNewFile,BufRead *.glslv call s:Setf('glsl')
  au BufNewFile,BufRead *.gs call s:Setf('glsl')
  au BufNewFile,BufRead *.gshader call s:Setf('glsl')
  au BufNewFile,BufRead *.shader call s:Setf('glsl')
  au BufNewFile,BufRead *.tesc call s:Setf('glsl')
  au BufNewFile,BufRead *.tese call s:Setf('glsl')
  au BufNewFile,BufRead *.vert call s:Setf('glsl')
  au BufNewFile,BufRead *.vrx call s:Setf('glsl')
  au BufNewFile,BufRead *.vsh call s:Setf('glsl')
  au BufNewFile,BufRead *.vshader call s:Setf('glsl')
  au! BufNewFile,BufRead *.fs call polyglot#DetectFsFiletype()
endif

if !has_key(s:disabled_packages, 'fsharp')
  au BufNewFile,BufRead *.fsi call s:Setf('fsharp')
  au BufNewFile,BufRead *.fsx call s:Setf('fsharp')
  au! BufNewFile,BufRead *.fs call polyglot#DetectFsFiletype()
endif

if !has_key(s:disabled_packages, 'gdscript')
  au BufNewFile,BufRead *.gd call s:Setf('gdscript3')
endif

if !has_key(s:disabled_packages, 'git')
  au BufNewFile,BufRead *.gitconfig call s:Setf('gitconfig')
  au BufNewFile,BufRead *.git/config call s:Setf('gitconfig')
  au BufNewFile,BufRead *.git/modules/*/config call s:Setf('gitconfig')
  au BufNewFile,BufRead */.config/git/config call s:Setf('gitconfig')
  au BufNewFile,BufRead */git/config call s:Setf('gitconfig')
  au BufNewFile,BufRead */{.,}gitconfig.d/* call s:StarSetf('gitconfig')
  au BufNewFile,BufRead {.,}gitconfig call s:Setf('gitconfig')
  au BufNewFile,BufRead {.,}gitmodules call s:Setf('gitconfig')
  au BufNewFile,BufRead git-rebase-todo call s:Setf('gitrebase')
  au BufNewFile,BufRead {.,}gitsendemail.* call s:StarSetf('gitsendemail')
  au BufNewFile,BufRead COMMIT_EDITMSG,MERGE_MSG,TAG_EDITMSG call s:Setf('gitcommit')
endif

if !has_key(s:disabled_packages, 'gmpl')
  au BufNewFile,BufRead *.mod call s:Setf('gmpl')
endif

if !has_key(s:disabled_packages, 'gnuplot')
  au BufNewFile,BufRead *.gnu call s:Setf('gnuplot')
  au BufNewFile,BufRead *.gnuplot call s:Setf('gnuplot')
  au BufNewFile,BufRead *.gp call s:Setf('gnuplot')
  au BufNewFile,BufRead *.gpi call s:Setf('gnuplot')
  au BufNewFile,BufRead *.p call s:Setf('gnuplot')
  au BufNewFile,BufRead *.plot call s:Setf('gnuplot')
  au BufNewFile,BufRead *.plt call s:Setf('gnuplot')
endif

if !has_key(s:disabled_packages, 'go')
  au BufNewFile,BufRead *.go call s:Setf('go')
  au BufNewFile,BufRead go.mod call s:Setf('gomod')
  au BufNewFile,BufRead *.tmpl call s:Setf('gohtmltmpl')
endif

if !has_key(s:disabled_packages, 'javascript')
  au BufNewFile,BufRead *._js call s:Setf('javascript')
  au BufNewFile,BufRead *.bones call s:Setf('javascript')
  au BufNewFile,BufRead *.cjs call s:Setf('javascript')
  au BufNewFile,BufRead *.es call s:Setf('javascript')
  au BufNewFile,BufRead *.es6 call s:Setf('javascript')
  au BufNewFile,BufRead *.frag call s:Setf('javascript')
  au BufNewFile,BufRead *.gs call s:Setf('javascript')
  au BufNewFile,BufRead *.jake call s:Setf('javascript')
  au BufNewFile,BufRead *.js call s:Setf('javascript')
  au BufNewFile,BufRead *.jsb call s:Setf('javascript')
  au BufNewFile,BufRead *.jscad call s:Setf('javascript')
  au BufNewFile,BufRead *.jsfl call s:Setf('javascript')
  au BufNewFile,BufRead *.jsm call s:Setf('javascript')
  au BufNewFile,BufRead *.jss call s:Setf('javascript')
  au BufNewFile,BufRead *.mjs call s:Setf('javascript')
  au BufNewFile,BufRead *.njs call s:Setf('javascript')
  au BufNewFile,BufRead *.pac call s:Setf('javascript')
  au BufNewFile,BufRead *.sjs call s:Setf('javascript')
  au BufNewFile,BufRead *.ssjs call s:Setf('javascript')
  au BufNewFile,BufRead *.xsjs call s:Setf('javascript')
  au BufNewFile,BufRead *.xsjslib call s:Setf('javascript')
  au BufNewFile,BufRead Jakefile call s:Setf('javascript')
  au BufNewFile,BufRead *.flow call s:Setf('flow')
endif

if !has_key(s:disabled_packages, 'jsx')
  au BufNewFile,BufRead *.jsx call s:Setf('javascriptreact')
endif

if !has_key(s:disabled_packages, 'graphql')
  au BufNewFile,BufRead *.gql call s:Setf('graphql')
  au BufNewFile,BufRead *.graphql call s:Setf('graphql')
  au BufNewFile,BufRead *.graphqls call s:Setf('graphql')
endif

if !has_key(s:disabled_packages, 'groovy')
  au BufNewFile,BufRead *.gradle call s:Setf('groovy')
  au BufNewFile,BufRead *.groovy call s:Setf('groovy')
  au BufNewFile,BufRead *.grt call s:Setf('groovy')
  au BufNewFile,BufRead *.gtpl call s:Setf('groovy')
  au BufNewFile,BufRead *.gvy call s:Setf('groovy')
  au BufNewFile,BufRead Jenkinsfile call s:Setf('groovy')
endif

if !has_key(s:disabled_packages, 'grub')
  au BufNewFile,BufRead */boot/grub/grub.conf call s:Setf('grub')
  au BufNewFile,BufRead */boot/grub/menu.lst call s:Setf('grub')
  au BufNewFile,BufRead */etc/grub.conf call s:Setf('grub')
endif

if !has_key(s:disabled_packages, 'haml')
  au BufNewFile,BufRead *.haml call s:Setf('haml')
  au BufNewFile,BufRead *.haml.deface call s:Setf('haml')
  au BufNewFile,BufRead *.hamlbars call s:Setf('haml')
  au BufNewFile,BufRead *.hamlc call s:Setf('haml')
endif

if !has_key(s:disabled_packages, 'handlebars')
  au BufNewFile,BufRead *.handlebars call s:Setf('mustache')
  au BufNewFile,BufRead *.hb call s:Setf('mustache')
  au BufNewFile,BufRead *.hbs call s:Setf('mustache')
  au BufNewFile,BufRead *.hdbs call s:Setf('mustache')
  au BufNewFile,BufRead *.hjs call s:Setf('mustache')
  au BufNewFile,BufRead *.hogan call s:Setf('mustache')
  au BufNewFile,BufRead *.hulk call s:Setf('mustache')
  au BufNewFile,BufRead *.mustache call s:Setf('mustache')
  au BufNewFile,BufRead *.njk call s:Setf('mustache')
endif

if !has_key(s:disabled_packages, 'haskell')
  au BufNewFile,BufRead *.bpk call s:Setf('haskell')
  au BufNewFile,BufRead *.hs call s:Setf('haskell')
  au BufNewFile,BufRead *.hs-boot call s:Setf('haskell')
  au BufNewFile,BufRead *.hsc call s:Setf('haskell')
  au BufNewFile,BufRead *.hsig call s:Setf('haskell')
endif

if !has_key(s:disabled_packages, 'haxe')
  au BufNewFile,BufRead *.hx call s:Setf('haxe')
  au BufNewFile,BufRead *.hxsl call s:Setf('haxe')
endif

if !has_key(s:disabled_packages, 'hcl')
  au BufNewFile,BufRead *.hcl call s:Setf('hcl')
  au BufNewFile,BufRead *.nomad call s:Setf('hcl')
  au BufNewFile,BufRead *.workflow call s:Setf('hcl')
  au BufNewFile,BufRead Appfile call s:Setf('hcl')
endif

if !has_key(s:disabled_packages, 'hive')
  au BufNewFile,BufRead *.hql call s:Setf('hive')
  au BufNewFile,BufRead *.q call s:Setf('hive')
  au BufNewFile,BufRead *.ql call s:Setf('hive')
endif

if !has_key(s:disabled_packages, 'html5')
  au BufNewFile,BufRead *.htm call s:Setf('html')
  au BufNewFile,BufRead *.html call s:Setf('html')
  au BufNewFile,BufRead *.html.hl call s:Setf('html')
  au BufNewFile,BufRead *.inc call s:Setf('html')
  au BufNewFile,BufRead *.st call s:Setf('html')
  au BufNewFile,BufRead *.xht call s:Setf('html')
  au BufNewFile,BufRead *.xhtml call s:Setf('html')
endif

if !has_key(s:disabled_packages, 'i3')
  au BufNewFile,BufRead *.i3.config call s:Setf('i3config')
  au BufNewFile,BufRead *.i3config call s:Setf('i3config')
  au BufNewFile,BufRead {.,}i3.config call s:Setf('i3config')
  au BufNewFile,BufRead {.,}i3config call s:Setf('i3config')
  au BufNewFile,BufRead i3.config call s:Setf('i3config')
  au BufNewFile,BufRead i3config call s:Setf('i3config')
endif

if !has_key(s:disabled_packages, 'icalendar')
  au BufNewFile,BufRead *.ics call s:Setf('icalendar')
endif

if !has_key(s:disabled_packages, 'idris')
  au BufNewFile,BufRead idris-response call s:Setf('idris')
  au! BufNewFile,BufRead *.idr call polyglot#DetectIdrFiletype()
  au! BufNewFile,BufRead *.lidr call polyglot#DetectLidrFiletype()
endif

if !has_key(s:disabled_packages, 'idris2')
  au BufNewFile,BufRead *.ipkg call s:Setf('idris2')
  au BufNewFile,BufRead idris-response call s:Setf('idris2')
  au! BufNewFile,BufRead *.idr call polyglot#DetectIdrFiletype()
  au! BufNewFile,BufRead *.lidr call polyglot#DetectLidrFiletype()
endif

if !has_key(s:disabled_packages, 'ion')
  au BufNewFile,BufRead *.ion call s:Setf('ion')
  au BufNewFile,BufRead ~/.config/ion/initrc call s:Setf('ion')
endif

if !has_key(s:disabled_packages, 'jenkins')
  au BufNewFile,BufRead *.Jenkinsfile call s:Setf('Jenkinsfile')
  au BufNewFile,BufRead *.jenkinsfile call s:Setf('Jenkinsfile')
  au BufNewFile,BufRead Jenkinsfile call s:Setf('Jenkinsfile')
  au BufNewFile,BufRead Jenkinsfile* call s:StarSetf('Jenkinsfile')
endif

if !has_key(s:disabled_packages, 'jinja')
  au BufNewFile,BufRead *.j2 call s:Setf('jinja.html')
  au BufNewFile,BufRead *.jinja call s:Setf('jinja.html')
  au BufNewFile,BufRead *.jinja2 call s:Setf('jinja.html')
endif

if !has_key(s:disabled_packages, 'jq')
  au BufNewFile,BufRead *.jq call s:Setf('jq')
  au BufNewFile,BufRead {.,}jqrc call s:Setf('jq')
  au BufNewFile,BufRead {.,}jqrc* call s:StarSetf('jq')
endif

if !has_key(s:disabled_packages, 'json5')
  au BufNewFile,BufRead *.json5 call s:Setf('json5')
endif

if !has_key(s:disabled_packages, 'json')
  au BufNewFile,BufRead *.JSON-tmLanguage call s:Setf('json')
  au BufNewFile,BufRead *.avsc call s:Setf('json')
  au BufNewFile,BufRead *.geojson call s:Setf('json')
  au BufNewFile,BufRead *.gltf call s:Setf('json')
  au BufNewFile,BufRead *.har call s:Setf('json')
  au BufNewFile,BufRead *.ice call s:Setf('json')
  au BufNewFile,BufRead *.json call s:Setf('json')
  au BufNewFile,BufRead *.jsonl call s:Setf('json')
  au BufNewFile,BufRead *.jsonp call s:Setf('json')
  au BufNewFile,BufRead *.mcmeta call s:Setf('json')
  au BufNewFile,BufRead *.template call s:Setf('json')
  au BufNewFile,BufRead *.tfstate call s:Setf('json')
  au BufNewFile,BufRead *.tfstate.backup call s:Setf('json')
  au BufNewFile,BufRead *.topojson call s:Setf('json')
  au BufNewFile,BufRead *.webapp call s:Setf('json')
  au BufNewFile,BufRead *.webmanifest call s:Setf('json')
  au BufNewFile,BufRead *.yy call s:Setf('json')
  au BufNewFile,BufRead *.yyp call s:Setf('json')
  au BufNewFile,BufRead {.,}arcconfig call s:Setf('json')
  au BufNewFile,BufRead {.,}htmlhintrc call s:Setf('json')
  au BufNewFile,BufRead {.,}tern-config call s:Setf('json')
  au BufNewFile,BufRead {.,}tern-project call s:Setf('json')
  au BufNewFile,BufRead {.,}watchmanconfig call s:Setf('json')
  au BufNewFile,BufRead Pipfile.lock call s:Setf('json')
  au BufNewFile,BufRead composer.lock call s:Setf('json')
  au BufNewFile,BufRead mcmod.info call s:Setf('json')
endif

if !has_key(s:disabled_packages, 'jsonnet')
  au BufNewFile,BufRead *.jsonnet call s:Setf('jsonnet')
  au BufNewFile,BufRead *.libsonnet call s:Setf('jsonnet')
endif

if !has_key(s:disabled_packages, 'jst')
  au BufNewFile,BufRead *.ect call s:Setf('jst')
  au BufNewFile,BufRead *.ejs call s:Setf('jst')
  au BufNewFile,BufRead *.jst call s:Setf('jst')
endif

if !has_key(s:disabled_packages, 'julia')
  au BufNewFile,BufRead *.jl call s:Setf('julia')
endif

if !has_key(s:disabled_packages, 'kotlin')
  au BufNewFile,BufRead *.kt call s:Setf('kotlin')
  au BufNewFile,BufRead *.ktm call s:Setf('kotlin')
  au BufNewFile,BufRead *.kts call s:Setf('kotlin')
endif

if !has_key(s:disabled_packages, 'ledger')
  au BufNewFile,BufRead *.journal call s:Setf('ledger')
  au BufNewFile,BufRead *.ldg call s:Setf('ledger')
  au BufNewFile,BufRead *.ledger call s:Setf('ledger')
endif

if !has_key(s:disabled_packages, 'less')
  au BufNewFile,BufRead *.less call s:Setf('less')
endif

if !has_key(s:disabled_packages, 'lilypond')
  au BufNewFile,BufRead *.ily call s:Setf('lilypond')
  au BufNewFile,BufRead *.ly call s:Setf('lilypond')
endif

if !has_key(s:disabled_packages, 'livescript')
  au BufNewFile,BufRead *._ls call s:Setf('livescript')
  au BufNewFile,BufRead *.ls call s:Setf('livescript')
  au BufNewFile,BufRead Slakefile call s:Setf('livescript')
endif

if !has_key(s:disabled_packages, 'llvm')
  au BufNewFile,BufRead *.ll call s:Setf('llvm')
  au BufNewFile,BufRead *.td call s:Setf('tablegen')
endif

if !has_key(s:disabled_packages, 'log')
  au BufNewFile,BufRead *.LOG call s:Setf('log')
  au BufNewFile,BufRead *.log call s:Setf('log')
  au BufNewFile,BufRead *_LOG call s:Setf('log')
  au BufNewFile,BufRead *_log call s:Setf('log')
endif

if !has_key(s:disabled_packages, 'lua')
  au BufNewFile,BufRead *.fcgi call s:Setf('lua')
  au BufNewFile,BufRead *.lua call s:Setf('lua')
  au BufNewFile,BufRead *.nse call s:Setf('lua')
  au BufNewFile,BufRead *.p8 call s:Setf('lua')
  au BufNewFile,BufRead *.pd_lua call s:Setf('lua')
  au BufNewFile,BufRead *.rbxs call s:Setf('lua')
  au BufNewFile,BufRead *.rockspec call s:Setf('lua')
  au BufNewFile,BufRead *.wlua call s:Setf('lua')
  au BufNewFile,BufRead {.,}luacheckrc call s:Setf('lua')
endif

if !has_key(s:disabled_packages, 'm4')
  au BufNewFile,BufRead *.at call s:Setf('m4')
  au BufNewFile,BufRead *.m4 call s:Setf('m4')
endif

if !has_key(s:disabled_packages, 'mako')
  au BufNewFile *.*.mako execute "do BufNewFile filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufReadPre *.*.mako execute "do BufRead filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufNewFile,BufRead *.mako call s:Setf('mako')
  au BufNewFile *.*.mao execute "do BufNewFile filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufReadPre *.*.mao execute "do BufRead filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufNewFile,BufRead *.mao call s:Setf('mako')
endif

if !has_key(s:disabled_packages, 'mathematica')
  au BufNewFile,BufRead *.cdf call s:Setf('mma')
  au BufNewFile,BufRead *.ma call s:Setf('mma')
  au BufNewFile,BufRead *.mathematica call s:Setf('mma')
  au BufNewFile,BufRead *.mma call s:Setf('mma')
  au BufNewFile,BufRead *.mt call s:Setf('mma')
  au BufNewFile,BufRead *.nb call s:Setf('mma')
  au BufNewFile,BufRead *.nbp call s:Setf('mma')
  au BufNewFile,BufRead *.wl call s:Setf('mma')
  au BufNewFile,BufRead *.wls call s:Setf('mma')
  au BufNewFile,BufRead *.wlt call s:Setf('mma')
  au! BufNewFile,BufRead *.m call polyglot#DetectMFiletype()
endif

if !has_key(s:disabled_packages, 'markdown')
  au BufNewFile,BufRead *.markdown call s:Setf('markdown')
  au BufNewFile,BufRead *.md call s:Setf('markdown')
  au BufNewFile,BufRead *.mdown call s:Setf('markdown')
  au BufNewFile,BufRead *.mdwn call s:Setf('markdown')
  au BufNewFile,BufRead *.mkd call s:Setf('markdown')
  au BufNewFile,BufRead *.mkdn call s:Setf('markdown')
  au BufNewFile,BufRead *.mkdown call s:Setf('markdown')
  au BufNewFile,BufRead *.ronn call s:Setf('markdown')
  au BufNewFile,BufRead *.workbook call s:Setf('markdown')
  au BufNewFile,BufRead contents.lr call s:Setf('markdown')
endif

if !has_key(s:disabled_packages, 'mdx')
  au BufNewFile,BufRead *.mdx call s:Setf('markdown.mdx')
endif

if !has_key(s:disabled_packages, 'meson')
  au BufNewFile,BufRead meson.build call s:Setf('meson')
  au BufNewFile,BufRead meson_options.txt call s:Setf('meson')
  au BufNewFile,BufRead *.wrap call s:Setf('dosini')
endif

if !has_key(s:disabled_packages, 'moonscript')
  au BufNewFile,BufRead *.moon call s:Setf('moon')
endif

if !has_key(s:disabled_packages, 'murphi')
  au! BufNewFile,BufRead *.m call polyglot#DetectMFiletype()
endif

if !has_key(s:disabled_packages, 'nginx')
  au BufNewFile,BufRead *.nginx call s:Setf('nginx')
  au BufNewFile,BufRead *.nginxconf call s:Setf('nginx')
  au BufNewFile,BufRead *.vhost call s:Setf('nginx')
  au BufNewFile,BufRead */etc/nginx/* call s:StarSetf('nginx')
  au BufNewFile,BufRead */nginx/*.conf call s:Setf('nginx')
  au BufNewFile,BufRead */usr/local/nginx/conf/* call s:StarSetf('nginx')
  au BufNewFile,BufRead *nginx.conf call s:Setf('nginx')
  au BufNewFile,BufRead nginx*.conf call s:Setf('nginx')
  au BufNewFile,BufRead nginx.conf call s:Setf('nginx')
endif

if !has_key(s:disabled_packages, 'nim')
  au BufNewFile,BufRead *.nim call s:Setf('nim')
  au BufNewFile,BufRead *.nim.cfg call s:Setf('nim')
  au BufNewFile,BufRead *.nimble call s:Setf('nim')
  au BufNewFile,BufRead *.nimrod call s:Setf('nim')
  au BufNewFile,BufRead *.nims call s:Setf('nim')
  au BufNewFile,BufRead nim.cfg call s:Setf('nim')
endif

if !has_key(s:disabled_packages, 'nix')
  au BufNewFile,BufRead *.nix call s:Setf('nix')
endif

if !has_key(s:disabled_packages, 'objc')
  au! BufNewFile,BufRead *.h call polyglot#DetectHFiletype()
  au! BufNewFile,BufRead *.m call polyglot#DetectMFiletype()
endif

if !has_key(s:disabled_packages, 'ocaml')
  au BufNewFile,BufRead *.eliom call s:Setf('ocaml')
  au BufNewFile,BufRead *.eliomi call s:Setf('ocaml')
  au BufNewFile,BufRead *.ml call s:Setf('ocaml')
  au BufNewFile,BufRead *.ml.cppo call s:Setf('ocaml')
  au BufNewFile,BufRead *.ml4 call s:Setf('ocaml')
  au BufNewFile,BufRead *.mli call s:Setf('ocaml')
  au BufNewFile,BufRead *.mli.cppo call s:Setf('ocaml')
  au BufNewFile,BufRead *.mlip call s:Setf('ocaml')
  au BufNewFile,BufRead *.mll call s:Setf('ocaml')
  au BufNewFile,BufRead *.mlp call s:Setf('ocaml')
  au BufNewFile,BufRead *.mlt call s:Setf('ocaml')
  au BufNewFile,BufRead *.mly call s:Setf('ocaml')
  au BufNewFile,BufRead {.,}ocamlinit call s:Setf('ocaml')
  au BufNewFile,BufRead *.om call s:Setf('omake')
  au BufNewFile,BufRead OMakefile call s:Setf('omake')
  au BufNewFile,BufRead OMakeroot call s:Setf('omake')
  au BufNewFile,BufRead OMakeroot.in call s:Setf('omake')
  au BufNewFile,BufRead *.opam call s:Setf('opam')
  au BufNewFile,BufRead *.opam.template call s:Setf('opam')
  au BufNewFile,BufRead opam call s:Setf('opam')
  au BufNewFile,BufRead _oasis call s:Setf('oasis')
  au BufNewFile,BufRead dune call s:Setf('dune')
  au BufNewFile,BufRead dune-project call s:Setf('dune')
  au BufNewFile,BufRead dune-workspace call s:Setf('dune')
  au BufNewFile,BufRead jbuild call s:Setf('dune')
  au BufNewFile,BufRead _tags call s:Setf('ocamlbuild_tags')
  au BufNewFile,BufRead *.ocp call s:Setf('ocpbuild')
  au BufNewFile,BufRead *.root call s:Setf('ocpbuildroot')
  au BufNewFile,BufRead *.sexp call s:Setf('sexplib')
endif

if !has_key(s:disabled_packages, 'octave')
  au BufNewFile,BufRead *.oct call s:Setf('octave')
  au! BufNewFile,BufRead *.m call polyglot#DetectMFiletype()
endif

if !has_key(s:disabled_packages, 'opencl')
  au BufNewFile,BufRead *.cl call s:Setf('opencl')
  au BufNewFile,BufRead *.opencl call s:Setf('opencl')
endif

if !has_key(s:disabled_packages, 'perl')
  au BufNewFile,BufRead *.al call s:Setf('perl')
  au BufNewFile,BufRead *.cgi call s:Setf('perl')
  au BufNewFile,BufRead *.fcgi call s:Setf('perl')
  au BufNewFile,BufRead *.perl call s:Setf('perl')
  au BufNewFile,BufRead *.ph call s:Setf('perl')
  au BufNewFile,BufRead *.pl call s:Setf('perl')
  au BufNewFile,BufRead *.plx call s:Setf('perl')
  au BufNewFile,BufRead *.pm call s:Setf('perl')
  au BufNewFile,BufRead *.psgi call s:Setf('perl')
  au BufNewFile,BufRead *.t call s:Setf('perl')
  au BufNewFile,BufRead Makefile.PL call s:Setf('perl')
  au BufNewFile,BufRead Rexfile call s:Setf('perl')
  au BufNewFile,BufRead ack call s:Setf('perl')
  au BufNewFile,BufRead cpanfile call s:Setf('perl')
endif

if !has_key(s:disabled_packages, 'pgsql')
  au BufNewFile,BufRead *.pgsql let b:sql_type_override='pgsql' | set ft=sql
endif

if !has_key(s:disabled_packages, 'cql')
  au BufNewFile,BufRead *.cql call s:Setf('cql')
endif

if !has_key(s:disabled_packages, 'php')
  au BufNewFile,BufRead *.aw call s:Setf('php')
  au BufNewFile,BufRead *.ctp call s:Setf('php')
  au BufNewFile,BufRead *.fcgi call s:Setf('php')
  au BufNewFile,BufRead *.inc call s:Setf('php')
  au BufNewFile,BufRead *.php call s:Setf('php')
  au BufNewFile,BufRead *.php3 call s:Setf('php')
  au BufNewFile,BufRead *.php4 call s:Setf('php')
  au BufNewFile,BufRead *.php5 call s:Setf('php')
  au BufNewFile,BufRead *.phps call s:Setf('php')
  au BufNewFile,BufRead *.phpt call s:Setf('php')
  au BufNewFile,BufRead {.,}php call s:Setf('php')
  au BufNewFile,BufRead {.,}php_cs call s:Setf('php')
  au BufNewFile,BufRead {.,}php_cs.dist call s:Setf('php')
  au BufNewFile,BufRead Phakefile call s:Setf('php')
endif

if !has_key(s:disabled_packages, 'blade')
  au BufNewFile,BufRead *.blade call s:Setf('blade')
  au BufNewFile,BufRead *.blade.php call s:Setf('blade')
endif

if !has_key(s:disabled_packages, 'plantuml')
  au BufNewFile,BufRead *.iuml call s:Setf('plantuml')
  au BufNewFile,BufRead *.plantuml call s:Setf('plantuml')
  au BufNewFile,BufRead *.pu call s:Setf('plantuml')
  au BufNewFile,BufRead *.puml call s:Setf('plantuml')
  au BufNewFile,BufRead *.uml call s:Setf('plantuml')
endif

if !has_key(s:disabled_packages, 'pony')
  au BufNewFile,BufRead *.pony call s:Setf('pony')
endif

if !has_key(s:disabled_packages, 'powershell')
  au BufNewFile,BufRead *.ps1 call s:Setf('ps1')
  au BufNewFile,BufRead *.psd1 call s:Setf('ps1')
  au BufNewFile,BufRead *.psm1 call s:Setf('ps1')
  au BufNewFile,BufRead *.pssc call s:Setf('ps1')
  au BufNewFile,BufRead *.ps1xml call s:Setf('ps1xml')
endif

if !has_key(s:disabled_packages, 'protobuf')
  au BufNewFile,BufRead *.proto call s:Setf('proto')
endif

if !has_key(s:disabled_packages, 'pug')
  au BufNewFile,BufRead *.jade call s:Setf('pug')
  au BufNewFile,BufRead *.pug call s:Setf('pug')
endif

if !has_key(s:disabled_packages, 'puppet')
  au BufNewFile,BufRead *.pp call s:Setf('puppet')
  au BufNewFile,BufRead Modulefile call s:Setf('puppet')
  au BufNewFile,BufRead *.epp call s:Setf('embeddedpuppet')
endif

if !has_key(s:disabled_packages, 'purescript')
  au BufNewFile,BufRead *.purs call s:Setf('purescript')
endif

if !has_key(s:disabled_packages, 'python')
  au BufNewFile,BufRead *.cgi call s:Setf('python')
  au BufNewFile,BufRead *.fcgi call s:Setf('python')
  au BufNewFile,BufRead *.gyp call s:Setf('python')
  au BufNewFile,BufRead *.gypi call s:Setf('python')
  au BufNewFile,BufRead *.lmi call s:Setf('python')
  au BufNewFile,BufRead *.py call s:Setf('python')
  au BufNewFile,BufRead *.py3 call s:Setf('python')
  au BufNewFile,BufRead *.pyde call s:Setf('python')
  au BufNewFile,BufRead *.pyi call s:Setf('python')
  au BufNewFile,BufRead *.pyp call s:Setf('python')
  au BufNewFile,BufRead *.pyt call s:Setf('python')
  au BufNewFile,BufRead *.pyw call s:Setf('python')
  au BufNewFile,BufRead *.rpy call s:Setf('python')
  au BufNewFile,BufRead *.smk call s:Setf('python')
  au BufNewFile,BufRead *.spec call s:Setf('python')
  au BufNewFile,BufRead *.tac call s:Setf('python')
  au BufNewFile,BufRead *.wsgi call s:Setf('python')
  au BufNewFile,BufRead *.xpy call s:Setf('python')
  au BufNewFile,BufRead {.,}gclient call s:Setf('python')
  au BufNewFile,BufRead DEPS call s:Setf('python')
  au BufNewFile,BufRead SConscript call s:Setf('python')
  au BufNewFile,BufRead SConstruct call s:Setf('python')
  au BufNewFile,BufRead Snakefile call s:Setf('python')
  au BufNewFile,BufRead wscript call s:Setf('python')
endif

if !has_key(s:disabled_packages, 'requirements')
  au BufNewFile,BufRead *.pip call s:Setf('requirements')
  au BufNewFile,BufRead *require.{txt,in} call s:Setf('requirements')
  au BufNewFile,BufRead *requirements.{txt,in} call s:Setf('requirements')
  au BufNewFile,BufRead constraints.{txt,in} call s:Setf('requirements')
endif

if !has_key(s:disabled_packages, 'qmake')
  au BufNewFile,BufRead *.pri call s:Setf('qmake')
  au BufNewFile,BufRead *.pro call s:Setf('qmake')
endif

if !has_key(s:disabled_packages, 'qml')
  au BufNewFile,BufRead *.qbs call s:Setf('qml')
  au BufNewFile,BufRead *.qml call s:Setf('qml')
endif

if !has_key(s:disabled_packages, 'r-lang')
  au BufNewFile,BufRead *.S call s:Setf('r')
  au BufNewFile,BufRead *.r call s:Setf('r')
  au BufNewFile,BufRead *.rsx call s:Setf('r')
  au BufNewFile,BufRead *.s call s:Setf('r')
  au BufNewFile,BufRead {.,}Rprofile call s:Setf('r')
  au BufNewFile,BufRead expr-dist call s:Setf('r')
  au BufNewFile,BufRead *.rd call s:Setf('rhelp')
endif

if !has_key(s:disabled_packages, 'racket')
  au BufNewFile,BufRead *.rkt call s:Setf('racket')
  au BufNewFile,BufRead *.rktd call s:Setf('racket')
  au BufNewFile,BufRead *.rktl call s:Setf('racket')
  au BufNewFile,BufRead *.scrbl call s:Setf('racket')
endif

if !has_key(s:disabled_packages, 'ragel')
  au BufNewFile,BufRead *.rl call s:Setf('ragel')
endif

if !has_key(s:disabled_packages, 'raku')
  au BufNewFile,BufRead *.6pl call s:Setf('raku')
  au BufNewFile,BufRead *.6pm call s:Setf('raku')
  au BufNewFile,BufRead *.nqp call s:Setf('raku')
  au BufNewFile,BufRead *.p6 call s:Setf('raku')
  au BufNewFile,BufRead *.p6l call s:Setf('raku')
  au BufNewFile,BufRead *.p6m call s:Setf('raku')
  au BufNewFile,BufRead *.pl call s:Setf('raku')
  au BufNewFile,BufRead *.pl6 call s:Setf('raku')
  au BufNewFile,BufRead *.pm call s:Setf('raku')
  au BufNewFile,BufRead *.pm6 call s:Setf('raku')
  au BufNewFile,BufRead *.pod6 call s:Setf('raku')
  au BufNewFile,BufRead *.raku call s:Setf('raku')
  au BufNewFile,BufRead *.rakudoc call s:Setf('raku')
  au BufNewFile,BufRead *.rakumod call s:Setf('raku')
  au BufNewFile,BufRead *.rakutest call s:Setf('raku')
  au BufNewFile,BufRead *.t call s:Setf('raku')
  au BufNewFile,BufRead *.t6 call s:Setf('raku')
endif

if !has_key(s:disabled_packages, 'raml')
  au BufNewFile,BufRead *.raml call s:Setf('raml')
endif

if !has_key(s:disabled_packages, 'razor')
  au BufNewFile,BufRead *.cshtml call s:Setf('razor')
  au BufNewFile,BufRead *.razor call s:Setf('razor')
endif

if !has_key(s:disabled_packages, 'reason')
  au BufNewFile,BufRead *.rei call s:Setf('reason')
  au! BufNewFile,BufRead *.re call polyglot#DetectReFiletype()
endif

if !has_key(s:disabled_packages, 'rst')
  au BufNewFile,BufRead *.rest call s:Setf('rst')
  au BufNewFile,BufRead *.rest.txt call s:Setf('rst')
  au BufNewFile,BufRead *.rst call s:Setf('rst')
  au BufNewFile,BufRead *.rst.txt call s:Setf('rst')
endif

if !has_key(s:disabled_packages, 'ruby')
  au BufNewFile,BufRead *.axlsx call s:Setf('ruby')
  au BufNewFile,BufRead *.builder call s:Setf('ruby')
  au BufNewFile,BufRead *.cap call s:Setf('ruby')
  au BufNewFile,BufRead *.eye call s:Setf('ruby')
  au BufNewFile,BufRead *.fcgi call s:Setf('ruby')
  au BufNewFile,BufRead *.gemspec call s:Setf('ruby')
  au BufNewFile,BufRead *.god call s:Setf('ruby')
  au BufNewFile,BufRead *.jbuilder call s:Setf('ruby')
  au BufNewFile,BufRead *.mspec call s:Setf('ruby')
  au BufNewFile,BufRead *.opal call s:Setf('ruby')
  au BufNewFile,BufRead *.pluginspec call s:Setf('ruby')
  au BufNewFile,BufRead *.podspec call s:Setf('ruby')
  au BufNewFile,BufRead *.rabl call s:Setf('ruby')
  au BufNewFile,BufRead *.rake call s:Setf('ruby')
  au BufNewFile,BufRead *.rant call s:Setf('ruby')
  au BufNewFile,BufRead *.rb call s:Setf('ruby')
  au BufNewFile,BufRead *.rbi call s:Setf('ruby')
  au BufNewFile,BufRead *.rbuild call s:Setf('ruby')
  au BufNewFile,BufRead *.rbw call s:Setf('ruby')
  au BufNewFile,BufRead *.rbx call s:Setf('ruby')
  au BufNewFile,BufRead *.rjs call s:Setf('ruby')
  au BufNewFile,BufRead *.ru call s:Setf('ruby')
  au BufNewFile,BufRead *.ruby call s:Setf('ruby')
  au BufNewFile,BufRead *.rxml call s:Setf('ruby')
  au BufNewFile,BufRead *.spec call s:Setf('ruby')
  au BufNewFile,BufRead *.thor call s:Setf('ruby')
  au BufNewFile,BufRead *.watchr call s:Setf('ruby')
  au BufNewFile,BufRead {.,}Brewfile call s:Setf('ruby')
  au BufNewFile,BufRead {.,}Guardfile call s:Setf('ruby')
  au BufNewFile,BufRead {.,}autotest call s:Setf('ruby')
  au BufNewFile,BufRead {.,}irbrc call s:Setf('ruby')
  au BufNewFile,BufRead {.,}pryrc call s:Setf('ruby')
  au BufNewFile,BufRead {.,}simplecov call s:Setf('ruby')
  au BufNewFile,BufRead Appraisals call s:Setf('ruby')
  au BufNewFile,BufRead Berksfile call s:Setf('ruby')
  au BufNewFile,BufRead Buildfile call s:Setf('ruby')
  au BufNewFile,BufRead Capfile call s:Setf('ruby')
  au BufNewFile,BufRead Cheffile call s:Setf('ruby')
  au BufNewFile,BufRead Dangerfile call s:Setf('ruby')
  au BufNewFile,BufRead Deliverfile call s:Setf('ruby')
  au BufNewFile,BufRead Fastfile call s:Setf('ruby')
  au BufNewFile,BufRead Gemfile call s:Setf('ruby')
  au BufNewFile,BufRead Gemfile.lock call s:Setf('ruby')
  au BufNewFile,BufRead Guardfile call s:Setf('ruby')
  au BufNewFile,BufRead Jarfile call s:Setf('ruby')
  au BufNewFile,BufRead KitchenSink call s:Setf('ruby')
  au BufNewFile,BufRead Mavenfile call s:Setf('ruby')
  au BufNewFile,BufRead Podfile call s:Setf('ruby')
  au BufNewFile,BufRead Puppetfile call s:Setf('ruby')
  au BufNewFile,BufRead Rakefile call s:Setf('ruby')
  au BufNewFile,BufRead Rantfile call s:Setf('ruby')
  au BufNewFile,BufRead Routefile call s:Setf('ruby')
  au BufNewFile,BufRead Snapfile call s:Setf('ruby')
  au BufNewFile,BufRead Thorfile call s:Setf('ruby')
  au BufNewFile,BufRead Vagrantfile call s:Setf('ruby')
  au BufNewFile,BufRead [Rr]akefile* call s:StarSetf('ruby')
  au BufNewFile,BufRead buildfile call s:Setf('ruby')
  au BufNewFile,BufRead vagrantfile call s:Setf('ruby')
  au BufNewFile,BufRead *.erb call s:Setf('eruby')
  au BufNewFile,BufRead *.erb.deface call s:Setf('eruby')
  au BufNewFile,BufRead *.rhtml call s:Setf('eruby')
endif

if !has_key(s:disabled_packages, 'rspec')
  au BufNewFile,BufRead *_spec.rb if !did_filetype() | set ft=ruby syntax=rspec | endif
endif

if !has_key(s:disabled_packages, 'brewfile')
  au BufNewFile,BufRead Brewfile call s:Setf('brewfile')
endif

if !has_key(s:disabled_packages, 'rust')
  au BufNewFile,BufRead *.rs call s:Setf('rust')
  au BufNewFile,BufRead *.rs.in call s:Setf('rust')
endif

if !has_key(s:disabled_packages, 'scala')
  au BufNewFile,BufRead *.kojo call s:Setf('scala')
  au BufNewFile,BufRead *.sc call s:Setf('scala')
  au BufNewFile,BufRead *.scala call s:Setf('scala')
endif

if !has_key(s:disabled_packages, 'sbt')
  au BufNewFile,BufRead *.sbt call s:Setf('sbt.scala')
endif

if !has_key(s:disabled_packages, 'scss')
  au BufNewFile,BufRead *.scss call s:Setf('scss')
endif

if !has_key(s:disabled_packages, 'sh')
  au BufNewFile,BufRead *.bash call s:Setf('sh')
  au BufNewFile,BufRead *.bats call s:Setf('sh')
  au BufNewFile,BufRead *.cgi call s:Setf('sh')
  au BufNewFile,BufRead *.command call s:Setf('sh')
  au BufNewFile,BufRead *.env call s:Setf('sh')
  au BufNewFile,BufRead *.fcgi call s:Setf('sh')
  au BufNewFile,BufRead *.ksh call s:Setf('sh')
  au BufNewFile,BufRead *.sh call s:Setf('sh')
  au BufNewFile,BufRead *.sh.in call s:Setf('sh')
  au BufNewFile,BufRead *.tmux call s:Setf('sh')
  au BufNewFile,BufRead *.tool call s:Setf('sh')
  au BufNewFile,BufRead {.,}bash_aliases call s:Setf('sh')
  au BufNewFile,BufRead {.,}bash_history call s:Setf('sh')
  au BufNewFile,BufRead {.,}bash_logout call s:Setf('sh')
  au BufNewFile,BufRead {.,}bash_profile call s:Setf('sh')
  au BufNewFile,BufRead {.,}bashrc call s:Setf('sh')
  au BufNewFile,BufRead {.,}cshrc call s:Setf('sh')
  au BufNewFile,BufRead {.,}env call s:Setf('sh')
  au BufNewFile,BufRead {.,}env.example call s:Setf('sh')
  au BufNewFile,BufRead {.,}flaskenv call s:Setf('sh')
  au BufNewFile,BufRead {.,}login call s:Setf('sh')
  au BufNewFile,BufRead {.,}profile call s:Setf('sh')
  au BufNewFile,BufRead 9fs call s:Setf('sh')
  au BufNewFile,BufRead PKGBUILD call s:Setf('sh')
  au BufNewFile,BufRead bash_aliases call s:Setf('sh')
  au BufNewFile,BufRead bash_logout call s:Setf('sh')
  au BufNewFile,BufRead bash_profile call s:Setf('sh')
  au BufNewFile,BufRead bashrc call s:Setf('sh')
  au BufNewFile,BufRead cshrc call s:Setf('sh')
  au BufNewFile,BufRead gradlew call s:Setf('sh')
  au BufNewFile,BufRead login call s:Setf('sh')
  au BufNewFile,BufRead man call s:Setf('sh')
  au BufNewFile,BufRead profile call s:Setf('sh')
  au BufNewFile,BufRead *.zsh call s:Setf('zsh')
  au BufNewFile,BufRead {.,}zlogin call s:Setf('zsh')
  au BufNewFile,BufRead {.,}zlogout call s:Setf('zsh')
  au BufNewFile,BufRead {.,}zprofile call s:Setf('zsh')
  au BufNewFile,BufRead {.,}zshenv call s:Setf('zsh')
  au BufNewFile,BufRead {.,}zshrc call s:Setf('zsh')
endif

if !has_key(s:disabled_packages, 'slim')
  au BufNewFile,BufRead *.slim call s:Setf('slim')
endif

if !has_key(s:disabled_packages, 'slime')
  au BufNewFile,BufRead *.slime call s:Setf('slime')
endif

if !has_key(s:disabled_packages, 'smt2')
  au BufNewFile,BufRead *.smt call s:Setf('smt2')
  au BufNewFile,BufRead *.smt2 call s:Setf('smt2')
endif

if !has_key(s:disabled_packages, 'solidity')
  au BufNewFile,BufRead *.sol call s:Setf('solidity')
endif

if !has_key(s:disabled_packages, 'stylus')
  au BufNewFile,BufRead *.styl call s:Setf('stylus')
  au BufNewFile,BufRead *.stylus call s:Setf('stylus')
endif

if !has_key(s:disabled_packages, 'svelte')
  au BufNewFile,BufRead *.svelte call s:Setf('svelte')
endif

if !has_key(s:disabled_packages, 'svg')
  au BufNewFile,BufRead *.svg call s:Setf('svg')
endif

if !has_key(s:disabled_packages, 'swift')
  au BufNewFile,BufRead *.swift call s:Setf('swift')
endif

if !has_key(s:disabled_packages, 'sxhkd')
  au BufNewFile,BufRead *.sxhkdrc call s:Setf('sxhkdrc')
  au BufNewFile,BufRead sxhkdrc call s:Setf('sxhkdrc')
endif

if !has_key(s:disabled_packages, 'systemd')
  au BufNewFile,BufRead *.automount call s:Setf('systemd')
  au BufNewFile,BufRead *.mount call s:Setf('systemd')
  au BufNewFile,BufRead *.path call s:Setf('systemd')
  au BufNewFile,BufRead *.service call s:Setf('systemd')
  au BufNewFile,BufRead *.socket call s:Setf('systemd')
  au BufNewFile,BufRead *.swap call s:Setf('systemd')
  au BufNewFile,BufRead *.target call s:Setf('systemd')
  au BufNewFile,BufRead *.timer call s:Setf('systemd')
endif

if !has_key(s:disabled_packages, 'terraform')
  au BufNewFile,BufRead *.hcl call s:Setf('terraform')
  au BufNewFile,BufRead *.nomad call s:Setf('terraform')
  au BufNewFile,BufRead *.tf call s:Setf('terraform')
  au BufNewFile,BufRead *.tfvars call s:Setf('terraform')
  au BufNewFile,BufRead *.workflow call s:Setf('terraform')
endif

if !has_key(s:disabled_packages, 'textile')
  au BufNewFile,BufRead *.textile call s:Setf('textile')
endif

if !has_key(s:disabled_packages, 'thrift')
  au BufNewFile,BufRead *.thrift call s:Setf('thrift')
endif

if !has_key(s:disabled_packages, 'tmux')
  au BufNewFile,BufRead {.,}tmux.conf call s:Setf('tmux')
endif

if !has_key(s:disabled_packages, 'toml')
  au BufNewFile,BufRead *.toml call s:Setf('toml')
  au BufNewFile,BufRead */.cargo/config call s:Setf('toml')
  au BufNewFile,BufRead */.cargo/credentials call s:Setf('toml')
  au BufNewFile,BufRead Cargo.lock call s:Setf('toml')
  au BufNewFile,BufRead Gopkg.lock call s:Setf('toml')
  au BufNewFile,BufRead Pipfile call s:Setf('toml')
  au BufNewFile,BufRead poetry.lock call s:Setf('toml')
endif

if !has_key(s:disabled_packages, 'tptp')
  au BufNewFile,BufRead *.ax call s:Setf('tptp')
  au BufNewFile,BufRead *.p call s:Setf('tptp')
  au BufNewFile,BufRead *.tptp call s:Setf('tptp')
endif

if !has_key(s:disabled_packages, 'twig')
  au BufNewFile,BufRead *.twig call s:Setf('html.twig')
  au BufNewFile,BufRead *.xml.twig call s:Setf('xml.twig')
endif

if !has_key(s:disabled_packages, 'typescript')
  au BufNewFile,BufRead *.ts call s:Setf('typescript')
  au BufNewFile,BufRead *.tsx call s:Setf('typescriptreact')
endif

if !has_key(s:disabled_packages, 'unison')
  au BufNewFile,BufRead *.u call s:Setf('unison')
  au BufNewFile,BufRead *.uu call s:Setf('unison')
endif

if !has_key(s:disabled_packages, 'v')
  au BufNewFile,BufRead *.v call s:Setf('v')
endif

if !has_key(s:disabled_packages, 'vala')
  au BufNewFile,BufRead *.vala call s:Setf('vala')
  au BufNewFile,BufRead *.valadoc call s:Setf('vala')
  au BufNewFile,BufRead *.vapi call s:Setf('vala')
endif

if !has_key(s:disabled_packages, 'vbnet')
  au BufNewFile,BufRead *.vb call s:Setf('vbnet')
  au BufNewFile,BufRead *.vbhtml call s:Setf('vbnet')
endif

if !has_key(s:disabled_packages, 'vcl')
  au BufNewFile,BufRead *.vcl call s:Setf('vcl')
endif

if !has_key(s:disabled_packages, 'velocity')
  au BufNewFile,BufRead *.vm call s:Setf('velocity')
endif

if !has_key(s:disabled_packages, 'vmasm')
  au BufNewFile,BufRead *.mar call s:Setf('vmasm')
endif

if !has_key(s:disabled_packages, 'vue')
  au BufNewFile,BufRead *.vue call s:Setf('vue')
  au BufNewFile,BufRead *.wpy call s:Setf('vue')
endif

if !has_key(s:disabled_packages, 'xdc')
  au BufNewFile,BufRead *.xdc call s:Setf('xdc')
endif

if !has_key(s:disabled_packages, 'xsl')
  au BufNewFile,BufRead *.xsl call s:Setf('xsl')
  au BufNewFile,BufRead *.xslt call s:Setf('xsl')
endif

if !has_key(s:disabled_packages, 'yaml')
  au BufNewFile,BufRead *.mir call s:Setf('yaml')
  au BufNewFile,BufRead *.reek call s:Setf('yaml')
  au BufNewFile,BufRead *.rviz call s:Setf('yaml')
  au BufNewFile,BufRead *.sublime-syntax call s:Setf('yaml')
  au BufNewFile,BufRead *.syntax call s:Setf('yaml')
  au BufNewFile,BufRead *.yaml call s:Setf('yaml')
  au BufNewFile,BufRead *.yaml-tmlanguage call s:Setf('yaml')
  au BufNewFile,BufRead *.yaml.sed call s:Setf('yaml')
  au BufNewFile,BufRead *.yml call s:Setf('yaml')
  au BufNewFile,BufRead *.yml.mysql call s:Setf('yaml')
  au BufNewFile,BufRead {.,}clang-format call s:Setf('yaml')
  au BufNewFile,BufRead {.,}clang-tidy call s:Setf('yaml')
  au BufNewFile,BufRead {.,}gemrc call s:Setf('yaml')
  au BufNewFile,BufRead fish_history call s:Setf('yaml')
  au BufNewFile,BufRead fish_read_history call s:Setf('yaml')
  au BufNewFile,BufRead glide.lock call s:Setf('yaml')
  au BufNewFile,BufRead yarn.lock call s:Setf('yaml')
endif

if !has_key(s:disabled_packages, 'ansible')
  au BufNewFile,BufRead group_vars/* call s:StarSetf('yaml.ansible')
  au BufNewFile,BufRead handlers.*.y{a,}ml call s:Setf('yaml.ansible')
  au BufNewFile,BufRead host_vars/* call s:StarSetf('yaml.ansible')
  au BufNewFile,BufRead local.y{a,}ml call s:Setf('yaml.ansible')
  au BufNewFile,BufRead main.y{a,}ml call s:Setf('yaml.ansible')
  au BufNewFile,BufRead playbook.y{a,}ml call s:Setf('yaml.ansible')
  au BufNewFile,BufRead requirements.y{a,}ml call s:Setf('yaml.ansible')
  au BufNewFile,BufRead roles.*.y{a,}ml call s:Setf('yaml.ansible')
  au BufNewFile,BufRead site.y{a,}ml call s:Setf('yaml.ansible')
  au BufNewFile,BufRead tasks.*.y{a,}ml call s:Setf('yaml.ansible')
endif

if !has_key(s:disabled_packages, 'helm')
  au BufNewFile,BufRead */templates/*.tpl call s:Setf('helm')
  au BufNewFile,BufRead */templates/*.yaml call s:Setf('helm')
endif

if !has_key(s:disabled_packages, 'help')
  au BufNewFile,BufRead $VIMRUNTIME/doc/*.txt call s:Setf('help')
endif

if !has_key(s:disabled_packages, 'zephir')
  au BufNewFile,BufRead *.zep call s:Setf('zephir')
endif

if !has_key(s:disabled_packages, 'zig')
  au BufNewFile,BufRead *.zir call s:Setf('zir')
  au BufNewFile,BufRead *.zig call s:Setf('zig')
  au BufNewFile,BufRead *.zir call s:Setf('zig')
endif

if !has_key(s:disabled_packages, 'trasys')
  au! BufNewFile,BufRead *.inp call polyglot#DetectInpFiletype()
endif

if !has_key(s:disabled_packages, 'basic')
  au BufNewFile,BufRead *.basic call s:Setf('basic')
endif

if !has_key(s:disabled_packages, 'visual-basic')
  au BufNewFile,BufRead *.cls call s:Setf('vb')
  au BufNewFile,BufRead *.ctl call s:Setf('vb')
  au BufNewFile,BufRead *.dsm call s:Setf('vb')
  au BufNewFile,BufRead *.frm call s:Setf('vb')
  au BufNewFile,BufRead *.frx call s:Setf('vb')
  au BufNewFile,BufRead *.sba call s:Setf('vb')
  au BufNewFile,BufRead *.vba call s:Setf('vb')
  au BufNewFile,BufRead *.vbs call s:Setf('vb')
  au! BufNewFile,BufRead *.bas call polyglot#DetectBasFiletype()
endif

if !has_key(s:disabled_packages, 'dosini')
  au BufNewFile,BufRead *.dof call s:Setf('dosini')
  au BufNewFile,BufRead *.ini call s:Setf('dosini')
  au BufNewFile,BufRead *.lektorproject call s:Setf('dosini')
  au BufNewFile,BufRead *.prefs call s:Setf('dosini')
  au BufNewFile,BufRead *.pro call s:Setf('dosini')
  au BufNewFile,BufRead *.properties call s:Setf('dosini')
  au BufNewFile,BufRead */etc/pacman.conf call s:Setf('dosini')
  au BufNewFile,BufRead */etc/yum.conf call s:Setf('dosini')
  au BufNewFile,BufRead */etc/yum.repos.d/* call s:StarSetf('dosini')
  au BufNewFile,BufRead {.,}editorconfig call s:Setf('dosini')
  au BufNewFile,BufRead {.,}npmrc call s:Setf('dosini')
  au BufNewFile,BufRead buildozer.spec call s:Setf('dosini')
  au BufNewFile,BufRead php.ini-* call s:StarSetf('dosini')
endif

if !has_key(s:disabled_packages, 'odin')
  au BufNewFile,BufRead *.odin call s:Setf('odin')
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
