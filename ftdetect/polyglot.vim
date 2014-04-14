au BufRead,BufNewFile *.ino,*.pde set filetype=arduino
autocmd BufNewFile,BufRead *.clj,*.cljs,*.edn setlocal filetype=clojure
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
au BufRead,BufNewFile *.csv,*.dat,*.tsv,*.tab set filetype=csv
autocmd BufNewFile,BufReadPost *.feature,*.story set filetype=cucumber
au BufNewFile,BufRead Dockerfile set filetype=dockerfile
au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
au FileType elixir setl sw=2 sts=2 et iskeyword+=!,?
autocmd BufNewFile,BufRead *.em set filetype=ember-script
autocmd FileType ember-script set tabstop=2|set shiftwidth=2|set expandtab
autocmd BufNewFile,BufRead *.git/{,modules/**/}{COMMIT_EDIT,TAG_EDIT,MERGE_,}MSG set ft=gitcommit
autocmd BufNewFile,BufRead *.git/config,.gitconfig,.gitmodules set ft=gitconfig
autocmd BufNewFile,BufRead */.config/git/config                set ft=gitconfig
autocmd BufNewFile,BufRead *.git/modules/**/config             set ft=gitconfig
autocmd BufNewFile,BufRead git-rebase-todo                     set ft=gitrebase
autocmd BufNewFile,BufRead .gitsendemail.*                     set ft=gitsendemail
autocmd BufNewFile,BufRead *.git/**
      \ if getline(1) =~ '^\x\{40\}\>\|^ref: ' |
      \   set ft=git |
      \ endif
autocmd BufNewFile,BufRead,StdinReadPost *
      \ if getline(1) =~ '^\(commit\|tree\|object\) \x\{40\}\>\|^tag \S\+$' |
      \   set ft=git |
      \ endif
let s:current_fileformats = ''
let s:current_fileencodings = ''
function! s:gofiletype_pre()
  let s:current_fileformats = &g:fileformats
  let s:current_fileencodings = &g:fileencodings
  set fileencodings=utf-8 fileformats=unix
  setlocal filetype=go
endfunction
function! s:gofiletype_post()
  let &g:fileformats = s:current_fileformats
  let &g:fileencodings = s:current_fileencodings
endfunction
au BufNewFile *.go setlocal filetype=go fileencoding=utf-8 fileformat=unix
au BufRead *.go call s:gofiletype_pre()
au BufReadPost *.go call s:gofiletype_post()
autocmd BufNewFile,BufRead *.haml,*.hamlbars,*.hamlc setf haml
autocmd BufNewFile,BufRead *.sass setf sass
autocmd BufNewFile,BufRead *.scss setf scss
autocmd BufNewFile,BufReadPost *.jade set filetype=jade
autocmd BufNewFile,BufRead *Spec.js,*_spec.js set filetype=jasmine.javascript syntax=jasmine
au BufNewFile,BufRead *.js setf javascript
au BufNewFile,BufRead *.jsm setf javascript
au BufNewFile,BufRead Jakefile setf javascript
fun! s:SelectJavascript()
  if getline(1) =~# '^#!.*/bin/env\s\+node\>'
    set ft=javascript
  endif
endfun
au BufNewFile,BufRead * call s:SelectJavascript()
autocmd BufNewFile,BufRead *.json set filetype=json
augroup json_autocmd
  autocmd!
  autocmd FileType json setlocal autoindent
  autocmd FileType json setlocal formatoptions=tcq2l
  autocmd FileType json setlocal foldmethod=syntax
augroup END
au BufNewFile,BufRead *.ejs		set filetype=jst
au BufNewFile,BufRead *.jst  		set filetype=jst
au BufNewFile,BufRead *.hamljs set filetype=jst
autocmd BufNewFile,BufRead *.less setf less
autocmd BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn
      \ if &ft =~# '^\%(conf\|modula2\)$' |
      \   set ft=markdown |
      \ else |
      \   setf markdown |
      \ endif
autocmd BufRead *.html
    \ if getline(1) =~ '^\(%\|<[%&].*>\)' |
    \     set filetype=mason |
    \ endif
if has("autocmd")
  au  BufNewFile,BufRead *.mustache,*.handlebars,*.hbs,*.hogan,*.hulk,*.hjs set filetype=html syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
endif
au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/*,*/nginx/vhosts.d/*,nginx.conf if &ft == '' | setfiletype nginx | endif
au BufRead,BufNewFile *.cl set filetype=opencl
autocmd BufNewFile,BufRead *.proto setfiletype proto
au! BufRead,BufNewFile *.pp setfiletype puppet
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
au BufNewFile,BufRead Capfile			call s:setf('ruby')
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
au BufRead,BufNewFile *.rs set filetype=rust
au BufRead,BufNewFile *.sbt set filetype=sbt
fun! s:DetectScala()
    if getline(1) == '#!/usr/bin/env scala'
        set filetype=scala
    endif
endfun
au BufRead,BufNewFile *.scala,*.sbt set filetype=scala
au BufRead,BufNewFile * call s:DetectScala()
autocmd BufNewFile,BufRead *.slim set filetype=slim
autocmd BufNewFile,BufReadPost *.styl set filetype=stylus
autocmd BufNewFile,BufReadPost *.stylus set filetype=stylus
au BufRead,BufNewFile *.textile set filetype=textile
autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
autocmd BufNewFile,BufRead *.toml set filetype=toml
autocmd BufNewFile,BufRead *.twig set filetype=twig
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
