if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Redis Module <https://www.nginx.com/resources/wiki/modules/redis/>
" Use this module to perform simple caching
syn keyword ngxDirectiveThirdParty redis_pass
syn keyword ngxDirectiveThirdParty redis_bind
syn keyword ngxDirectiveThirdParty redis_connect_timeout
syn keyword ngxDirectiveThirdParty redis_read_timeout
syn keyword ngxDirectiveThirdParty redis_send_timeout
syn keyword ngxDirectiveThirdParty redis_buffer_size
syn keyword ngxDirectiveThirdParty redis_next_upstream
syn keyword ngxDirectiveThirdParty redis_gzip_flag


endif
