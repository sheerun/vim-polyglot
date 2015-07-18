if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dockerfile') == -1
  
" dockerfile.vim - Syntax highlighting for Dockerfiles
" Maintainer:   Honza Pokorny <http://honza.ca>
" Version:      0.5


if exists("b:current_syntax")
    finish
endif

syntax case ignore

syntax match dockerfileKeyword /\v^\s*(FROM|MAINTAINER|RUN|CMD|EXPOSE|ENV|ADD)\s/
syntax match dockerfileKeyword /\v^\s*(ENTRYPOINT|VOLUME|USER|WORKDIR|COPY)\s/
highlight link dockerfileKeyword Keyword

syntax region dockerfileString start=/\v"/ skip=/\v\\./ end=/\v"/
highlight link dockerfileString String

syntax match dockerfileComment "\v^\s*#.*$"
highlight link dockerfileComment Comment

syntax include @DockerSh syntax/sh.vim
try
  syntax include @DockerSh after/syntax/sh.vim
catch
endtry

syntax region dockerShSnip matchgroup=DockerShGroup start="^\s*\%(RUN\|CMD\)\s\+" end="$" contains=@DockerSh
highlight link DockerShGroup dockerfileKeyword

let b:current_syntax = "dockerfile"

endif
