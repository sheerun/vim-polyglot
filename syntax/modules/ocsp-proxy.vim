if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" OCSP Proxy Module <https://github.com/kyprizel/nginx_ocsp_proxy-module>
" Nginx OCSP processing module designed for response caching 
syn keyword ngxDirectiveThirdParty ocsp_proxy
syn keyword ngxDirectiveThirdParty ocsp_cache_timeout


endif
