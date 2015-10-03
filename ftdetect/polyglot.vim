au BufRead,BufNewFile *.ino,*.pde set filetype=arduino
autocmd BufNewFile,BufRead *.clj,*.cljs,*.edn,*.cljx,*.cljc setlocal filetype=clojure
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
au BufRead,BufNewFile *.eex set filetype=eelixir
au FileType eelixir setl sw=2 sts=2 et iskeyword+=!,?
au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
au FileType elixir setl sw=2 sts=2 et iskeyword+=!,?
function! s:DetectElixir()
    if getline(1) =~ '^#!.*\<elixir\>'
        set filetype=elixir
    endif
endfunction
autocmd BufNewFile,BufRead * call s:DetectElixir()
autocmd BufNewFile,BufRead *.git/{,modules/**/}{COMMIT_EDIT,TAG_EDIT,MERGE_,}MSG set ft=gitcommit
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
autocmd BufNewFile,BufRead *.haml,*.hamlbars,*.hamlc setf haml
autocmd BufNewFile,BufRead *.sass setf sass
autocmd BufNewFile,BufRead *.scss setf scss
autocmd BufNewFile,BufReadPost *.jade set filetype=jade
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
au BufNewFile,BufRead *.ejs set filetype=jst
au BufNewFile,BufRead *.jst set filetype=jst
au BufNewFile,BufRead *.djs set filetype=jst
au BufNewFile,BufRead *.hamljs set filetype=jst
au BufNewFile,BufRead *.ect set filetype=jst
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
  au  BufNewFile,BufRead *.mustache,*.hogan,*.hulk,*.hjs set filetype=html.mustache syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
  au  BufNewFile,BufRead *.handlebars,*.hbs set filetype=html.handlebars syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
endif
au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/*,*/nginx/vhosts.d/*,nginx.conf if &ft == '' | setfiletype nginx | endif
au BufRead,BufNewFile *.cl set filetype=opencl
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
autocmd BufNewFile,BufRead *.proto setfiletype proto
au BufRead,BufNewFile *.pp              set filetype=puppet
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
au BufRead,BufNewFile *.rs set filetype=rust
au BufRead,BufNewFile *.sbt set filetype=sbt.scala
fun! s:DetectScala()
    if getline(1) =~# '^#!\(/usr\)\?/bin/env\s\+scalas\?'
        set filetype=scala
    endif
endfun
au BufRead,BufNewFile *.scala set filetype=scala
au BufRead,BufNewFile * call s:DetectScala()
au BufRead,BufNewFile *.sbt setfiletype sbt.scala
autocmd BufNewFile,BufRead *.slim set filetype=slim
autocmd BufNewFile,BufReadPost *.styl set filetype=stylus
autocmd BufNewFile,BufReadPost *.stylus set filetype=stylus
au BufRead,BufNewFile *.textile set filetype=textile
au BufNewFile,BufRead *.thrift setlocal filetype=thrift
autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
autocmd BufNewFile,BufRead *.twig set filetype=twig
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
autocmd BufNewFile,BufRead *.ts,*.tsx setlocal filetype=typescript
