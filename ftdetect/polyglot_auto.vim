if index(g:polyglot_disabled, 'acpiasl') == -1
  au BufNewFile,BufRead *.asl set ft=asl
  au BufNewFile,BufRead *.dsl set ft=asl
endif

if index(g:polyglot_disabled, 'apiblueprint') == -1
  au BufNewFile,BufRead *.apib set ft=apiblueprint
endif

if index(g:polyglot_disabled, 'applescript') == -1
  au BufNewFile,BufRead *.applescript set ft=applescript
  au BufNewFile,BufRead *.scpt set ft=applescript
endif

if index(g:polyglot_disabled, 'arduino') == -1
  au BufNewFile,BufRead *.pde set ft=arduino
  au BufNewFile,BufRead *.ino set ft=arduino
endif

if index(g:polyglot_disabled, 'asciidoc') == -1
  au BufNewFile,BufRead *.asciidoc set ft=asciidoc
  au BufNewFile,BufRead *.adoc set ft=asciidoc
  au BufNewFile,BufRead *.asc set ft=asciidoc
endif

if index(g:polyglot_disabled, 'blade') == -1
  au BufNewFile,BufRead *.blade set ft=blade
  au BufNewFile,BufRead *.blade.php set ft=blade
endif

if index(g:polyglot_disabled, 'caddyfile') == -1
  au BufNewFile,BufRead *Caddyfile set ft=caddyfile
endif

if index(g:polyglot_disabled, 'carp') == -1
  au BufNewFile,BufRead *.carp set ft=carp
endif

if index(g:polyglot_disabled, 'coffee') == -1
  au BufNewFile,BufRead *.coffee set ft=coffee
  au BufNewFile,BufRead *._coffee set ft=coffee
  au BufNewFile,BufRead *.cake set ft=coffee
  au BufNewFile,BufRead *.cjsx set ft=coffee
  au BufNewFile,BufRead *.iced set ft=coffee
  au BufNewFile,BufRead Cakefile set ft=coffee
endif

if index(g:polyglot_disabled, 'clojure') == -1
  au BufNewFile,BufRead *.clj set ft=clojure
  au BufNewFile,BufRead *.boot set ft=clojure
  au BufNewFile,BufRead *.cl2 set ft=clojure
  au BufNewFile,BufRead *.cljc set ft=clojure
  au BufNewFile,BufRead *.cljs set ft=clojure
  au BufNewFile,BufRead *.cljs.hl set ft=clojure
  au BufNewFile,BufRead *.cljscm set ft=clojure
  au BufNewFile,BufRead *.cljx set ft=clojure
  au BufNewFile,BufRead *.hic set ft=clojure
  au BufNewFile,BufRead riemann.config set ft=clojure
endif
