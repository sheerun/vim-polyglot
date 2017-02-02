if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Shibboleth Module <https://github.com/nginx-shib/nginx-http-shibboleth>
" Shibboleth auth request module for nginx
syn keyword ngxDirectiveThirdParty shib_request
syn keyword ngxDirectiveThirdParty shib_request_set
syn keyword ngxDirectiveThirdParty shib_request_use_headers


endif
