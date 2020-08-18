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
             extra_extensions=[],
             extra_filenames=[],
             ignored_extensions=[]
):
    language = data.get(name, {})
    filetype_name = filetype or name.lower().replace(" ", "")
    polyglot_name = polyglot or filetype_name
    lines.append(f"if index(g:polyglot_disabled, '{polyglot_name}') == -1")
    if syntax != None:
        syntax = " syn=" + syntax
    else:
        syntax = ""
    if extensions == None:
        extensions = language.get("extensions", [])
    if filenames == None:
        filenames = language.get("filenames", [])
    for ext in sorted(list(set(extensions + extra_extensions) - set(ignored_extensions))):
        lines.append(f"  au BufNewFile,BufRead *{ext} set ft={filetype_name}{syntax}")
    for fn in filenames + extra_filenames:
        lines.append(f"  au BufNewFile,BufRead {fn} set ft={filetype_name}{syntax}")
    lines.append("endif")
    lines.append("")

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
language("F#", polyglot="fsharp", filetype="fsharp")
language("GDScript", filetype="gdscript3", polyglot="gdscript")
language("GLSL", extra_extensions=[".comp"])
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
language("HTML+Django", polyglot="jinja", filetype="jinja.html", ignored_extensions=[".mustache", ".njk"])
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

f = open("ftdetect/polyglot_auto.vim", "w")
f.write("\n".join(lines))
f.close()
