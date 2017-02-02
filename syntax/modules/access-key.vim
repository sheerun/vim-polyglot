if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Access Key Module (DEPRECATED) <http://wiki.nginx.org/NginxHttpAccessKeyModule>
" Denies access unless the request URL contains an access key.
syn keyword ngxDirectiveDeprecated accesskey
syn keyword ngxDirectiveDeprecated accesskey_arg
syn keyword ngxDirectiveDeprecated accesskey_hashmethod
syn keyword ngxDirectiveDeprecated accesskey_signature


endif
