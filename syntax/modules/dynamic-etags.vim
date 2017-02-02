if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Dynamic ETags Module <https://github.com/kali/nginx-dynamic-etags>
" Attempt at handling ETag / If-None-Match on proxied content.
syn keyword ngxDirectiveThirdParty dynamic_etags


endif
