if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Enhanced Memcached Module <https://github.com/bpaquet/ngx_http_enhanced_memcached_module>
" This module is based on the standard Nginx Memcached module, with some additonal features
syn keyword ngxDirectiveThirdParty enhanced_memcached_pass
syn keyword ngxDirectiveThirdParty enhanced_memcached_hash_keys_with_md5
syn keyword ngxDirectiveThirdParty enhanced_memcached_allow_put
syn keyword ngxDirectiveThirdParty enhanced_memcached_allow_delete
syn keyword ngxDirectiveThirdParty enhanced_memcached_stats
syn keyword ngxDirectiveThirdParty enhanced_memcached_flush
syn keyword ngxDirectiveThirdParty enhanced_memcached_flush_namespace
syn keyword ngxDirectiveThirdParty enhanced_memcached_bind
syn keyword ngxDirectiveThirdParty enhanced_memcached_connect_timeout
syn keyword ngxDirectiveThirdParty enhanced_memcached_send_timeout
syn keyword ngxDirectiveThirdParty enhanced_memcached_buffer_size
syn keyword ngxDirectiveThirdParty enhanced_memcached_read_timeout


endif
