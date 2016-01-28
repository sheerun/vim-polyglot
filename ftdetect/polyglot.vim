if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ansible') == -1
  
function! DetectAnsible()
  let filepath = expand("%:p")
  let filename = expand("%:t")
  if filepath =~ '\v/(tasks|roles)/.*\.ya?ml$' || filepath =~ '\v/(group|host)_vars/' || filename =~ '\v(playbook|site)\.ya?ml$'
    set ft=ansible
  endif
  unlet filepath
  unlet filename
endfunction
:au BufNewFile,BufRead *.yml,*yaml,*/{group,host}_vars/*  call DetectAnsible()
:au BufNewFile,BufRead *.j2 set ft=ansible_template
:au BufNewFile,BufRead hosts set ft=ansible_hosts
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'arduino') == -1
  
au BufRead,BufNewFile *.ino,*.pde set filetype=arduino
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'blade') == -1
  
autocmd BufNewFile,BufRead *.blade.php set filetype=blade
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cjsx') == -1
  
augroup CJSX
  au!
  autocmd BufNewFile,BufRead *.csx,*.cjsx set filetype=coffee
augroup END
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'clojure') == -1
  
autocmd BufNewFile,BufRead *.clj,*.cljs,*.edn,*.cljx,*.cljc setlocal filetype=clojure
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'coffee-script') == -1
  
autocmd BufNewFile,BufRead *.coffee set filetype=coffee
autocmd BufNewFile,BufRead *Cakefile set filetype=coffee
autocmd BufNewFile,BufRead *.coffeekup,*.ck set filetype=coffee
autocmd BufNewFile,BufRead *._coffee set filetype=coffee
function! s:DetectCoffee()
    if getline(1) =~ '^#!.*\<coffee\>'
        set filetype=coffee
    endif
endfunction
autocmd BufNewFile,BufRead * call s:DetectCoffee()
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cql') == -1
  
if has("autocmd")
  au  BufNewFile,BufRead *.cql set filetype=cql
endif
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cucumber') == -1
  
autocmd BufNewFile,BufReadPost *.feature,*.story set filetype=cucumber
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dart') == -1
  
autocmd BufRead,BufNewFile *.dart set filetype=dart
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dockerfile') == -1
  
au BufNewFile,BufRead Dockerfile set filetype=dockerfile
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elixir') == -1
  
au BufRead,BufNewFile *.ex,*.exs call s:setf('elixir')
au BufRead,BufNewFile *.eex call s:setf('eelixir')
au FileType elixir,eelixir setl sw=2 sts=2 et iskeyword+=!,?
au BufNewFile,BufRead * call s:DetectElixir()
function! s:setf(filetype) abort
  let &filetype = a:filetype
endfunction
function! s:DetectElixir()
  if getline(1) =~ '^#!.*\<elixir\>'
    call s:setf('elixir')
  endif
endfunction
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elm') == -1
  
au BufNewFile,BufRead *.elm		set filetype=elm
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'emberscript') == -1
  
autocmd BufNewFile,BufRead *.em set filetype=ember-script
autocmd FileType ember-script set tabstop=2|set shiftwidth=2|set expandtab
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'emblem') == -1
  
autocmd BufNewFile,BufRead *.emblem set filetype=emblem
autocmd FileType emblem set tabstop=2|set shiftwidth=2|set expandtab
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'erlang') == -1
  
au BufNewFile,BufRead *.erl,*.hrl,rebar.config,*.app,*.app.src,*.yaws,*.xrl set ft=erlang
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'git') == -1
  
autocmd BufNewFile,BufRead *.git/{,modules/**/,worktrees/*/}{COMMIT_EDIT,TAG_EDIT,MERGE_,}MSG set ft=gitcommit
autocmd BufNewFile,BufRead *.git/config,.gitconfig,gitconfig,.gitmodules set ft=gitconfig
autocmd BufNewFile,BufRead */.config/git/config                          set ft=gitconfig
autocmd BufNewFile,BufRead *.git/modules/**/config                       set ft=gitconfig
autocmd BufNewFile,BufRead git-rebase-todo                               set ft=gitrebase
autocmd BufNewFile,BufRead .gitsendemail.*                               set ft=gitsendemail
autocmd BufNewFile,BufRead *.git/**
      \ if getline(1) =~ '^\x\{40\}\>\|^ref: ' |
      \   set ft=git |
      \ endif
autocmd BufNewFile,BufRead,StdinReadPost *
      \ if getline(1) =~ '^\(commit\|tree\|object\) \x\{40\}\>\|^tag \S\+$' |
      \   set ft=git |
      \ endif
autocmd BufNewFile,BufRead *
      \ if getline(1) =~ '^From \x\{40\} Mon Sep 17 00:00:00 2001$' |
      \   set filetype=gitsendemail |
      \ endif
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'glsl') == -1
  
autocmd! BufNewFile,BufRead *.glsl,*.geom,*.vert,*.frag,*.gsh,*.vsh,*.fsh,*.vs,*.fs,*.gs,*.tcs,*.tes set filetype=glsl
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'go') == -1
  
let s:current_fileformats = ''
let s:current_fileencodings = ''
function! s:gofiletype_pre(type)
    let s:current_fileformats = &g:fileformats
    let s:current_fileencodings = &g:fileencodings
    set fileencodings=utf-8 fileformats=unix
    let &l:filetype = a:type
endfunction
function! s:gofiletype_post()
    let &g:fileformats = s:current_fileformats
    let &g:fileencodings = s:current_fileencodings
endfunction
au BufNewFile *.go setfiletype go | setlocal fileencoding=utf-8 fileformat=unix
au BufRead *.go call s:gofiletype_pre("go")
au BufReadPost *.go call s:gofiletype_post()
au BufNewFile *.s setfiletype asm | setlocal fileencoding=utf-8 fileformat=unix
au BufRead *.s call s:gofiletype_pre("asm")
au BufReadPost *.s call s:gofiletype_post()
au BufRead,BufNewFile *.tmpl set filetype=gohtmltmpl
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haml') == -1
  
autocmd BufNewFile,BufRead *.haml,*.hamlbars,*.hamlc setf haml
autocmd BufNewFile,BufRead *.sass setf sass
autocmd BufNewFile,BufRead *.scss setf scss
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haskell') == -1
  
au BufRead,BufNewFile *.hsc set filetype=haskell
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haxe') == -1
  
autocmd BufNewFile,BufRead *.hx setf haxe
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jade') == -1
  
autocmd BufNewFile,BufReadPost *.jade set filetype=jade
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jasmine') == -1
  
autocmd BufNewFile,BufRead *Spec.js,*_spec.js set filetype=jasmine.javascript syntax=jasmine
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jsx') == -1
  
if !exists('g:jsx_ext_required')
  let g:jsx_ext_required = 1
endif
if !exists('g:jsx_pragma_required')
  let g:jsx_pragma_required = 0
endif
if g:jsx_pragma_required
  " Look for the @jsx pragma.  It must be included in a docblock comment before
  " anything else in the file (except whitespace).
  let s:jsx_pragma_pattern = '\%^\_s*\/\*\*\%(\_.\%(\*\/\)\@!\)*@jsx\_.\{-}\*\/'
  let b:jsx_pragma_found = search(s:jsx_pragma_pattern, 'npw')
endif
fu! <SID>EnableJSX()
  if g:jsx_pragma_required && !b:jsx_pragma_found | return 0 | endif
  if g:jsx_ext_required && !exists('b:jsx_ext_found') | return 0 | endif
  return 1
endfu
autocmd BufNewFile,BufRead *.jsx let b:jsx_ext_found = 1
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd BufNewFile,BufRead *.js
  \ if <SID>EnableJSX() | set filetype=javascript.jsx | endif
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jinja') == -1
  
fun! s:SelectHTML()
  let n = 1
  while n < 50 && n <= line("$")
    " check for jinja
    if getline(n) =~ '{{.*}}\|{%-\?\s*\(end.*\|extends\|block\|macro\|set\|if\|for\|include\|trans\)\>'
      set ft=jinja
      return
    endif
    let n = n + 1
  endwhile
endfun
autocmd BufNewFile,BufRead *.html,*.htm,*.nunjucks,*.nunjs  call s:SelectHTML()
autocmd BufNewFile,BufRead *.jinja2,*.j2,*.jinja set ft=jinja
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'json') == -1
  
autocmd BufNewFile,BufRead *.json set filetype=json
autocmd BufNewFile,BufRead *.jsonp set filetype=json
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jst') == -1
  
au BufNewFile,BufRead *.ejs set filetype=jst
au BufNewFile,BufRead *.jst set filetype=jst
au BufNewFile,BufRead *.djs set filetype=jst
au BufNewFile,BufRead *.hamljs set filetype=jst
au BufNewFile,BufRead *.ect set filetype=jst
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'julia') == -1
  
au BufRead,BufNewFile *.jl		let b:undo_ftplugin = "setlocal comments< define< formatoptions< iskeyword< lisp<"
au BufRead,BufNewFile *.jl		set filetype=julia
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'kotlin') == -1
  
autocmd BufNewFile,BufRead *.kt setfiletype kotlin
autocmd BufNewFile,BufRead *.kts setfiletype kotlin
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'less') == -1
  
autocmd BufNewFile,BufRead *.less setf less
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'liquid') == -1
  
au BufNewFile,BufRead *.liquid					set ft=liquid
au BufNewFile,BufRead */_layouts/*.html,*/_includes/*.html	set ft=liquid
au BufNewFile,BufRead *.html,*.xml,*.textile
      \ if getline(1) == '---' | set ft=liquid | endif
au BufNewFile,BufRead *.markdown,*.mkd,*.mkdn,*.md
      \ if getline(1) == '---' |
      \   let b:liquid_subtype = 'markdown' |
      \   set ft=liquid |
      \ endif
au BufNewFile,BufRead */templates/**.liquid,*/layout/**.liquid,*/snippets/**.liquid
      \ let b:liquid_subtype = 'html' |
      \ set ft=liquid |
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'markdown') == -1
  
autocmd BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn
      \ if &ft =~# '^\%(conf\|modula2\)$' |
      \   set ft=markdown |
      \ else |
      \   setf markdown |
      \ endif
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'perl') == -1
  
autocmd BufRead *.html
    \ if getline(1) =~ '^\(%\|<[%&].*>\)' |
    \     set filetype=mason |
    \ endif
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'handlebars') == -1
  
if has("autocmd")
  au  BufNewFile,BufRead *.mustache,*.hogan,*.hulk,*.hjs set filetype=html.mustache syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
  au  BufNewFile,BufRead *.handlebars,*.hbs set filetype=html.handlebars syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
endif
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
au BufRead,BufNewFile *.nginx set ft=nginx
au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile */usr/local/nginx/conf/* set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nim') == -1
  
au BufNewFile,BufRead *.nim set filetype=nim
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nix') == -1
  
autocmd BufNewFile,BufRead *.nix setfiletype nix
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'opencl') == -1
  
au! BufRead,BufNewFile *.cl set filetype=opencl
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'perl') == -1
  
function! s:DetectPerl6()
  let line_no = 1
  let eof     = line('$')
  let in_pod  = 0
  while line_no <= eof
    let line    = getline(line_no)
    let line_no = line_no + 1
    if line =~ '^=\w'
      let in_pod = 1
    elseif line =~ '^=\%(end\|cut\)'
      let in_pod = 0
    elseif !in_pod
      let line = substitute(line, '#.*', '', '')
      if line =~ '^\s*$'
        continue
      endif
      if line =~ '^\s*\%(use\s\+\)\=v6\%(\.\d\%(\.\d\)\=\)\=;'
        set filetype=perl6 " we matched a 'use v6' declaration
      elseif line =~ '^\s*\%(\%(my\|our\)\s\+\)\=\%(unit\s\+\)\=\(module\|class\|role\|enum\|grammar\)'
        set filetype=perl6 " we found a class, role, module, enum, or grammar declaration
      endif
      break " we either found what we needed, or we found a non-POD, non-comment,
            " non-Perl 6 indicating line, so bail out
    endif
  endwhile
endfunction
autocmd BufReadPost *.pl,*.pm,*.t call s:DetectPerl6()
autocmd BufNew,BufNewFile,BufRead *.nqp setf perl6
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'protobuf') == -1
  
autocmd BufNewFile,BufRead *.proto setfiletype proto
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'powershell') == -1
  
au BufNewFile,BufRead   *.ps1   set ft=ps1
au BufNewFile,BufRead   *.psd1  set ft=ps1
au BufNewFile,BufRead   *.psm1  set ft=ps1
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'powershell') == -1
  
au BufNewFile,BufRead   *.ps1xml   set ft=ps1xml
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'puppet') == -1
  
au! BufRead,BufNewFile *.pp setfiletype puppet
au! BufRead,BufNewFile Puppetfile setfiletype ruby
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'qml') == -1
  
autocmd BufRead,BufNewFile *.qml setfiletype qml
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ruby') == -1
  
function! s:setf(filetype) abort
  if &filetype !=# a:filetype
    let &filetype = a:filetype
  endif
endfunction
au BufNewFile,BufRead *.rb,*.rbw,*.gemspec	call s:setf('ruby')
au BufNewFile,BufRead *.builder,*.rxml,*.rjs,*.ruby call s:setf('ruby')
au BufNewFile,BufRead [rR]akefile,*.rake	call s:setf('ruby')
au BufNewFile,BufRead [rR]antfile,*.rant	call s:setf('ruby')
au BufNewFile,BufRead .irbrc,irbrc		call s:setf('ruby')
au BufNewFile,BufRead .pryrc			call s:setf('ruby')
au BufNewFile,BufRead *.ru			call s:setf('ruby')
au BufNewFile,BufRead Capfile,*.cap 		call s:setf('ruby')
au BufNewFile,BufRead Gemfile			call s:setf('ruby')
au BufNewFile,BufRead Guardfile,.Guardfile	call s:setf('ruby')
au BufNewFile,BufRead Cheffile			call s:setf('ruby')
au BufNewFile,BufRead Berksfile			call s:setf('ruby')
au BufNewFile,BufRead [vV]agrantfile		call s:setf('ruby')
au BufNewFile,BufRead .autotest			call s:setf('ruby')
au BufNewFile,BufRead *.erb,*.rhtml		call s:setf('eruby')
au BufNewFile,BufRead [tT]horfile,*.thor	call s:setf('ruby')
au BufNewFile,BufRead *.rabl			call s:setf('ruby')
au BufNewFile,BufRead *.jbuilder		call s:setf('ruby')
au BufNewFile,BufRead Puppetfile		call s:setf('ruby')
au BufNewFile,BufRead [Bb]uildfile		call s:setf('ruby')
au BufNewFile,BufRead Appraisals		call s:setf('ruby')
au BufNewFile,BufRead Podfile,*.podspec		call s:setf('ruby')
au BufNewFile,BufRead [rR]outefile		call s:setf('ruby')
au BufNewFile,BufRead .simplecov		set filetype=ruby
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'rust') == -1
  
au BufRead,BufNewFile *.rs set filetype=rust
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'sbt') == -1
  
au BufRead,BufNewFile *.sbt set filetype=sbt.scala
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'scala') == -1
  
fun! s:DetectScala()
    if getline(1) =~# '^#!\(/usr\)\?/bin/env\s\+scalas\?'
        set filetype=scala
    endif
endfun
au BufRead,BufNewFile *.scala set filetype=scala
au BufRead,BufNewFile * call s:DetectScala()
au BufRead,BufNewFile *.sbt setfiletype sbt.scala
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'slim') == -1
  
autocmd BufNewFile,BufRead *.slim set filetype=slim
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'solidity') == -1
  
au BufNewFile,BufRead *.sol setf solidity
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'stylus') == -1
  
autocmd BufNewFile,BufReadPost *.styl set filetype=stylus
autocmd BufNewFile,BufReadPost *.stylus set filetype=stylus
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'swift') == -1
  
autocmd BufNewFile,BufRead *.swift setfiletype swift
autocmd BufRead * call s:Swift()
function! s:Swift()
  if !empty(&filetype)
    return
  endif
  let line = getline(1)
  if line =~ "^#!.*swift"
    setfiletype swift
  endif
endfunction
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'systemd') == -1
  
au BufNewFile,BufRead *.automount set filetype=systemd
au BufNewFile,BufRead *.mount     set filetype=systemd
au BufNewFile,BufRead *.path      set filetype=systemd
au BufNewFile,BufRead *.service   set filetype=systemd
au BufNewFile,BufRead *.socket    set filetype=systemd
au BufNewFile,BufRead *.swap      set filetype=systemd
au BufNewFile,BufRead *.target    set filetype=systemd
au BufNewFile,BufRead *.timer     set filetype=systemd
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'textile') == -1
  
au BufRead,BufNewFile *.textile set filetype=textile
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'thrift') == -1
  
au BufNewFile,BufRead *.thrift setlocal filetype=thrift
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'tmux') == -1
  
autocmd BufNewFile,BufRead {.,}tmux.conf{.*,} setlocal filetype=tmux
autocmd BufNewFile,BufRead {.,}tmux.conf{.*,} setlocal commentstring=#\ %s
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'toml') == -1
  
autocmd BufNewFile,BufRead *.toml set filetype=toml
autocmd BufNewFile,BufRead Cargo.lock set filetype=toml
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1
  
autocmd BufNewFile,BufRead *.ts,*.tsx setlocal filetype=typescript
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vala') == -1
  
autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala,*.vapi setfiletype vala
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vcl') == -1
  
au BufRead,BufNewFile *.vcl set filetype=vcl
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vm') == -1
  
au BufRead,BufNewFile *.vm set ft=velocity syntax=velocity
endif
