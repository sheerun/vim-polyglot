if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dockerfile') == -1

" Vim syntax file
" Language: Dockerfile
" Maintainer: Eugene Kalinin
" Latest Revision: 11 September 2013
" Source: http://docs.docker.io/en/latest/use/builder/

if exists("b:current_syntax")
  finish
endif

" case sensitivity (fix #17)
" syn case  ignore

" Keywords
syn keyword dockerfileKeywords FROM AS MAINTAINER RUN CMD COPY
syn keyword dockerfileKeywords EXPOSE ADD ENTRYPOINT
syn keyword dockerfileKeywords VOLUME USER WORKDIR ONBUILD
syn keyword dockerfileKeywords LABEL ARG HEALTHCHECK SHELL STOPSIGNAL

" Bash statements
setlocal iskeyword+=-
syn keyword bashStatement add-apt-repository adduser apk apt-get aptitude apt-key autoconf bundle
syn keyword bashStatement cd chgrp chmod chown clear complete composer cp curl du echo egrep
syn keyword bashStatement expr fgrep find gem gnufind gnugrep gpg grep groupadd head less ln
syn keyword bashStatement ls make mkdir mv node npm pacman pip pip3 php python rails rm rmdir rpm ruby
syn keyword bashStatement sed sleep sort strip tar tail tailf touch useradd virtualenv yum
syn keyword bashStatement usermod bash cat a2ensite a2dissite a2enmod a2dismod apache2ctl
syn keyword bashStatement wget gzip

" Strings
syn region dockerfileString start=/"/ skip=/\\"|\\\\/ end=/"/
syn region dockerfileString1 start=/'/ skip=/\\'|\\\\/ end=/'/

" Emails
syn region dockerfileEmail start=/</ end=/>/ contains=@ oneline

" Urls
syn match dockerfileUrl /\(http\|https\|ssh\|hg\|git\)\:\/\/[a-zA-Z0-9\/\-\._]\+/

" Task tags
syn keyword dockerfileTodo contained TODO FIXME XXX

" Comments
syn region dockerfileComment start="#" end="\n" contains=dockerfileTodo
syn region dockerfileEnvWithComment start="^\s*ENV\>" end="\n" contains=dockerfileEnv
syn match dockerfileEnv contained /\<ENV\>/

" Highlighting
hi link dockerfileKeywords  Keyword
hi link dockerfileEnv       Keyword
hi link dockerfileString    String
hi link dockerfileString1   String
hi link dockerfileComment   Comment
hi link dockerfileEmail     Identifier
hi link dockerfileUrl       Identifier
hi link dockerfileTodo      Todo
hi link bashStatement       Function

let b:current_syntax = "dockerfile"

endif
