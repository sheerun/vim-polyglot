if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Drizzle Module <https://www.nginx.com/resources/wiki/modules/drizzle/>
" Upstream module for talking to MySQL and Drizzle directly
syn keyword ngxDirectiveThirdParty drizzle_server
syn keyword ngxDirectiveThirdParty drizzle_keepalive
syn keyword ngxDirectiveThirdParty drizzle_query
syn keyword ngxDirectiveThirdParty drizzle_pass
syn keyword ngxDirectiveThirdParty drizzle_connect_timeout
syn keyword ngxDirectiveThirdParty drizzle_send_query_timeout
syn keyword ngxDirectiveThirdParty drizzle_recv_cols_timeout
syn keyword ngxDirectiveThirdParty drizzle_recv_rows_timeout
syn keyword ngxDirectiveThirdParty drizzle_buffer_size
syn keyword ngxDirectiveThirdParty drizzle_module_header
syn keyword ngxDirectiveThirdParty drizzle_status


endif
