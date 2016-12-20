if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" User Agent Module <https://github.com/alibaba/nginx-http-user-agent>
" Match browsers and crawlers
syn keyword ngxDirectiveThirdParty user_agent


endif
