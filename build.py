#!/usr/bin/env python3

import yaml
import urllib.request as request

url = 'https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml'
data = yaml.safe_load(request.urlopen(url))

lines = []

def language(name,
             filetype=None,
             polyglot=None,
             extensions=None,
             filenames=None,
             syntax=None,
             outer_filetype=None,
             custom_set=None,
             compound=False,
             extra_extensions=[],
             extra_filenames=[],
             ignored_extensions=[]
):
    language = data.get(name, {})
    filetype_name = filetype or name.lower().replace(" ", "")
    polyglot_name = polyglot or filetype_name
    lines.append(f"if index(g:polyglot_disabled, '{polyglot_name}') == -1")
    if syntax != None:
        syntax = " syntax=" + syntax
    else:
        syntax = ""
    if extensions == None:
        extensions = language.get("extensions", [])
    if filenames == None:
        filenames = language.get("filenames", [])
    if custom_set == None:
        custom_set = f"set ft={filetype_name}{syntax}"
    for ext in sorted(list(set(extensions + extra_extensions) - set(ignored_extensions))):
        if outer_filetype != None:
          lines.append(f"  au BufNewFile *.*{ext} execute \"do BufNewFile filetypedetect \" . expand(\"<afile>:r\") | {outer_filetype}")
          lines.append(f"  au BufReadPre *.*{ext} execute \"do BufRead filetypedetect \" . expand(\"<afile>:r\") | {outer_filetype}")
        lines.append(f"  au BufNewFile,BufRead *{ext} {custom_set}")
    for fn in sorted(filenames + extra_filenames):
        if fn[0] == ".":
            fn = "{.,}" + fn[1:]
        lines.append(f"  au BufNewFile,BufRead {fn} {custom_set}")
    lines.append("endif")
    lines.append("")


lines.append("""" don't spam the user when Vim is started in Vi compatibility mode
let s:cpo_save = &cpo
set cpo&vim

if !exists('g:polyglot_disabled')
  let g:polyglot_disabled = []
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
""")

language("ASL", polyglot="acpiasl", extensions=[".asl", ".dsl"])
language("API Blueprint")
language("AppleScript")
language("Processing", filetype="arduino", extra_extensions=[".ino"])
language("AsciiDoc")
language("Blade")
language("Caddyfile", extensions=["Caddyfile"])
language("Carp", extensions=[".carp"])
language("CoffeeScript", polyglot="coffee-script", filetype="coffee", extra_extensions=[".coffeekup", '.ck'])
language("Literate CoffeeScript", polyglot="coffee-script", filetype="litcoffee", extra_extensions=[".coffee.md"])
language("Clojure")
language("CQL", extensions=[".cql"])
language("Cryptol", extensions=[".cry", ".cyl", ".lcry", ".lcyl"])
language("Crystal", extra_filenames=["Projectfile"])
language("HTML+ECR", polyglot="crystal", filetype="ecrystal")
language("CSV", extra_extensions=[".tsv", ".dat", ".tab"])
language("Gherkin", filetype="cucumber", extra_extensions=[".story"])
language("Cue", filetype="cuesheet", extensions=[".cue"], polyglot="cue")
language("Dart")
language("Dhall")
language("D", polyglot="dlang")
language("D", polyglot="dlang", filetype="dcov", extensions=[".lst"])
language("D", polyglot="dlang", filetype="dd", extensions=[".dd"])
language("D", polyglot="dlang", filetype="ddoc", extensions=[".ddoc"])
language("D", polyglot="dlang", filetype="dsdl", extensions=[".sdl"])
language("Dockerfile", extra_extensions=[".dock", ".Dockerfile"], extra_filenames=["dockerfile", "Dockerfile*"], filetype="Dockerfile", polyglot="dockerfile")
language("Dockerfile", extensions=[], filenames=["docker-compose*.yaml", "docker-compose*.yml"], filetype="yaml.docker-compose", polyglot="dockerfile")
language("Elixir")
language("HTML+EEX", polyglot="elixir", filetype="elixir", extra_extensions=[".leex"])
language("Elm")
language("EmberScript", filetype="ember-script", polyglot="emberscript")
language("Emblem", extensions=[".emblem"], filetype="emblem")
language("Erlang", extra_extensions=[".app", ".yaws"])
language("Ferm", extensions=[".ferm"], filenames=["ferm.conf"], filetype="ferm")
language("fish")
language("YAML", extra_filenames=["fish_history", "fish_read_history"])
language("Flatbuffers", extensions=[".fbs"], filetype="fbs", polyglot="flatbuffers")
language("GDScript", filetype="gdscript3", polyglot="gdscript")
language("GLSL", extra_extensions=[".comp"])
language("F#", polyglot="fsharp", filetype="fsharp")
language("Git Config", polyglot="git", filetype="gitconfig", extra_filenames=["*.git/config", "*/.config/git/config", "*.git/modules/**/config", "gitconfig"])
language("Git Rebase", polyglot="git", filetype="gitrebase", filenames=["git-rebase-todo"])
language("Git Send Email", polyglot="git", filetype="gitsendemail", filenames=[".gitsendemail.*"])
language("Git Commit", polyglot="git", filetype="gitcommit", filenames=["COMMIT_EDIT_MSG", "TAG_EDIT_MSG", "MERGE_MSG", "MSG"])
language("Gnu MathProg", polyglot="gmpl", filetype="gmpl", extensions=[".mod"])
language("Go")
language("Go Mod", filetype="gomod", filenames=["go.mod"], polyglot="go")
language("Go Template", filetype="gohtmltmpl", extensions=[".tmpl"], polyglot="go")
language("Assembly", filetype="asm", polyglot="assembly")
language("GraphQL")
language("Gradle", filetype="groovy", polyglot="gradle")
language("Haml", extra_extensions=[".hamlc", ".hamlbars"])
language("Handlebars", filetype="mustache", polyglot="handlebars", extra_extensions=[".hulk", ".hjs", ".mustache", ".njk"])
language("HTML+Django", polyglot="jinja", filetype="jinja.html", ignored_extensions=[".mustache", ".njk"], extra_extensions=[".j2"])
language("HAProxy")
language("Haskell", extra_extensions=[".bpk", ".hsig"])
language("Haxe")
language("HCL", extra_extensions=[".nomad"], extra_filenames=["Appfile"])
language("Helm", extra_filenames=["*/templates/*.yaml", "*/templates/*.tpl"])
language("HiveQL", polyglot="hive", filetype="hive")
language("I3", extensions=[".i3.config"], filenames=["i3.config"], filetype="i3config", polyglot="i3")
language("HiveQL", polyglot="hive", filetype="hive")
language("iCalendar", polyglot="icalendar", filetype="icalendar", extensions=[".ics"])
language("Idris", extra_filenames=["idris-response"])
language("Ion", extensions=[".ion"], filenames=["~/.config/ion/initrc"])
language("JavaScript")
language("Flow", polyglot="javascript", filetype="flow", extensions=[".flow"])
language("Jenkinsfile", polyglot="jenkins", extensions=[".jenkinsfile", ".Jenkinsfile"], filenames=["Jenkinsfile*"], filetype="Jenkinsfile")
language("JSON5")
language("JSON", extra_extensions=[".jsonp", ".template"])
language("EJS", filetype="jst", extra_extensions=[".jst", ".djs", ".hamljs", ".ect"])
language("JSX", filetype="javascriptreact", polyglot="jsx")
language("Julia")
language("Kotlin")
language("Ledger", extensions=[".ldg", ".ledger", ".journal"])
language("Less")
language("LilyPond")
language("LiveScript")
language("LLVM")
language("Tablegen", polyglot="llvm", extensions=[".td"], filetype="tablegen")
language("Mako", outer_filetype="let b:mako_outer_lang = &filetype")
language("Log", extensions=[".log"], filenames=["*_log"])
language("Markdown", ignored_extensions=[".mdx"])
language("Mdx", extensions=[".mdx"], polyglot="mdx", filetype="markdown.mdx")
language("Mathematica", filetype="mma")
language("Meson")
language("Dosini", extensions=[".wrap"], filetype="dosini", polyglot="meson")
language("MoonScript", filetype="moon", polyglot="moon")
language("Nginx", extra_extensions=[".nginx"], extra_filenames=["*/etc/nginx/*", "*/usr/local/nginx/conf/*", "*/nginx/*.conf", "nginx*.conf",  "*nginx.conf"])
language("Nim")
language("Nix")
language("OCaml", extra_extensions=[".mlt", ".mlp", ".mlip", ".mli.cppo", ".ml.cppo"])
language("OMake", extensions=[".om"], filenames=["OMakefile", "OMakeroot", "Omakeroot.in"], polyglot="ocaml", filetype="omake")
language("OPam", extensions=[".opam", ".opam.template"], filenames=["opam"], filetype="opam", polyglot="ocaml")
language("Oasis", filenames=["_oasis"], polyglot="ocaml", filetype="oasis")
language("OpenCL")
language("Perl")
language("PLpgSQL", filetype="sql", ignored_extensions=[".sql"], custom_set="let b:sql_type_override='pgsql' | set ft=sql", polyglot="pgsql")
language("PlantUML", extra_extensions=[".uml", ".pu"])
language("Pony")
language("PowerShell", extra_extensions=[".pssc"])
language("Ps1XML", extensions=[".ps1xml"], polyglot="powershell", filetype="ps1xml")
language("Protocol Buffer", polyglot="protobuf", filetype="proto")
language("Pug")
language("Puppet")
language("Embedded Puppet", polyglot="puppet", filetype="embeddedpuppet", extensions=[".epp"])
language("PureScript")
language("QMake")
language("QML")
language("Racket")
language("Raku", extra_extensions=[".rakudoc", ".rakutest", ".raku", ".rakumod", ".pod6", ".t6"])
language("RAML")
language("HTML+Razor", filetype="razor", polyglot="razor")
language("Reason")
language("Merlin", filetype="merlin", polyglot="razor", filenames=[".merlin"])
language("Ruby", extra_extensions=[".rxml", ".rjs", ".rant", ".axlsx", ".cap", ".opal"], extra_filenames=["Rantfile", ".autotest", "Cheffile", "KitchenSink", "Routefile"])
language("HTML+ERB", polyglot="ruby", filetype="eruby", extra_extensions=[".rhtml"])
# Needs to be after ruby
language("RSpec", filenames=["*_spec.rb"], polyglot="rspec", filetype="ruby", syntax="rspec")
language("Rust")
language("Scala", ignored_extensions=[".sbt"])
language("Scala SBT", filetype="sbt.scala", extensions=[".sbt"], polyglot="scala")
language("SCSS")
language("Slim")
language("Slime", extensions=[".slime"])
language("SMT", filetype="smt2")
language("Solidity", extra_extensions=[".sol"])
language("Stylus", extra_extensions=[".stylus"])
language("Svelte")
language("Swift")
language("Sxhkd", extensions=[".sxhkdrc"], filetype="sxhkdrc", polyglot="sxhkd")
language("Systemd", extensions=[".automount", ".mount", ".path", ".service", ".socket", ".swap", ".target", ".timer"])
language("HCL", filetype="terraform", polyglot="terraform")
language("Textile")
language("Thrift")
language("Tmux", filenames=[".tmux.conf"])
language("TOML", extra_filenames=["Pipfile", "*/.cargo/config", "*/.cargo/credentials"])
language("TPTP", extensions=[".p", ".tptp", ".ax"])
language("Twig", ignored_extensions=[".xml.twig"], filetype="html.twig", polyglot="twig")
language("Twig XML", extensions=[".xml.twig"], filetype="xml.twig", polyglot="twig")
language("TypeScript")
language("TSX", filetype="typescriptreact", polyglot="typescript")
language("XML", extra_extensions=[".cdxml"], ignored_extensions=[".ts", ".tsx"])
language("V")
language("Vala", extra_extensions=[".valadoc"])
language("Visual Basic .NET", filetype="vbnet", polyglot="vbnet")
language("VCL")
language("Vifm", extensions=[".vifm"], filenames=["vifmrc", "*vifm/colors/*"])
language("Vifm Rename", filetype="vifm-rename", filenames=["vifm.rename*"], polyglot="vifm")
language("Velocity", extensions=[".vm"], filetype="velocity")
language("Vue", extra_extensions=[".wpy"])
language("XDC", extensions=[".xdc"])
language("Zig", extra_extensions=[".zir"])
language("Zir", extensions=[".zir"], polyglot="zig", filetype="zir")
language("Jsonnet")
language("Fennel", extensions=[".fnl"])
language("mcfunction")
language("JSONiq", extra_filenames=[".jqrc"], filetype="jq", polyglot="jq")
language("Requirements", extensions=[".pip"], filenames=["*requirements.{txt,in}", "*require.{txt,in}", "constraints.{txt,in}"])

lines.append('" restore Vi compatibility settings')
lines.append('let &cpo = s:cpo_save')
lines.append('unlet s:cpo_save')

f = open("ftdetect/polyglot.vim", "w")
f.write("\n".join(lines))
f.close()

