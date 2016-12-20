if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" OpenSSL Version Module <https://github.com/apcera/nginx-openssl-version>
" Nginx OpenSSL version check at startup 
syn keyword ngxDirectiveThirdParty openssl_version_minimum
syn keyword ngxDirectiveThirdParty openssl_builddate_minimum


endif
