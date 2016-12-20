if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Cache Purge Module <https://github.com/FRiCKLE/ngx_cache_purge>
" Module adding ability to purge content from FastCGI and proxy caches.
syn keyword ngxDirectiveThirdParty fastcgi_cache_purge
syn keyword ngxDirectiveThirdParty proxy_cache_purge


endif
