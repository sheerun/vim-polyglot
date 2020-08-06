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
             extra_extensions=[],
             extra_filenames=[]
):
    language = data.get(name, {})
    filetype_name = filetype or name.lower().replace(" ", "")
    polyglot_name = polyglot or filetype_name
    lines.append(f"if index(g:polyglot_disabled, '{polyglot_name}') == -1")
    for ext in (extensions or language.get("extensions", [])) + extra_extensions:
        lines.append(f"  au BufNewFile,BufRead *{ext} set ft={filetype_name}")
    for fn in (filenames or language.get("filenames", [])) + extra_filenames:
        lines.append(f"  au BufNewFile,BufRead {fn} set ft={filetype_name}")
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
language("CoffeeScript", filetype="coffee")
language("Clojure")

f = open("ftdetect/polyglot_auto.vim", "w")
f.write("\n".join(lines))
f.close()
