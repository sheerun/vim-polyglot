if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Redis 2 Module <https://github.com/openresty/redis2-nginx-module>
" Nginx upstream module for the Redis 2.0 protocol
syn keyword ngxDirectiveThirdParty redis2_query
syn keyword ngxDirectiveThirdParty redis2_raw_query
syn keyword ngxDirectiveThirdParty redis2_raw_queries
syn keyword ngxDirectiveThirdParty redis2_literal_raw_query
syn keyword ngxDirectiveThirdParty redis2_pass
syn keyword ngxDirectiveThirdParty redis2_connect_timeout
syn keyword ngxDirectiveThirdParty redis2_send_timeout
syn keyword ngxDirectiveThirdParty redis2_read_timeout
syn keyword ngxDirectiveThirdParty redis2_buffer_size
syn keyword ngxDirectiveThirdParty redis2_next_upstream


endif
