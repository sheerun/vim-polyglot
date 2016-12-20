if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Access Key Module (DEPRECATED) <http://wiki.nginx.org/NginxHttpAccessKeyModule>
" Denies access unless the request URL contains an access key.
syn keyword ngxDirectiveThirdParty accesskey
syn keyword ngxDirectiveThirdParty accesskey_arg
syn keyword ngxDirectiveThirdParty accesskey_hashmethod
syn keyword ngxDirectiveThirdParty accesskey_signature


endif
