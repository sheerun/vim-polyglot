if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Selective Cache Purge Module <https://github.com/wandenberg/nginx-selective-cache-purge-module>
" A module to purge cache by GLOB patterns. The supported patterns are the same as supported by Redis.
syn keyword ngxDirectiveThirdParty selective_cache_purge_redis_unix_socket
syn keyword ngxDirectiveThirdParty selective_cache_purge_redis_host
syn keyword ngxDirectiveThirdParty selective_cache_purge_redis_port
syn keyword ngxDirectiveThirdParty selective_cache_purge_redis_database
syn keyword ngxDirectiveThirdParty selective_cache_purge_query


endif
