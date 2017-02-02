if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Cache Purge Module <https://github.com/FRiCKLE/ngx_cache_purge>
" Adds ability to purge content from FastCGI, proxy, SCGI and uWSGI caches.
syn keyword ngxDirectiveThirdParty fastcgi_cache_purge
syn keyword ngxDirectiveThirdParty proxy_cache_purge
" syn keyword ngxDirectiveThirdParty scgi_cache_purge
" syn keyword ngxDirectiveThirdParty uwsgi_cache_purge


endif
