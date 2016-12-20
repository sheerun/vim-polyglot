if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Drizzle Module <https://github.com/openresty/drizzle-nginx-module>
" Make nginx talk directly to mysql, drizzle, and sqlite3 by libdrizzle.
syn keyword ngxDirectiveThirdParty drizzle_connect_timeout
syn keyword ngxDirectiveThirdParty drizzle_dbname
syn keyword ngxDirectiveThirdParty drizzle_keepalive
syn keyword ngxDirectiveThirdParty drizzle_module_header
syn keyword ngxDirectiveThirdParty drizzle_pass
syn keyword ngxDirectiveThirdParty drizzle_query
syn keyword ngxDirectiveThirdParty drizzle_recv_cols_timeout
syn keyword ngxDirectiveThirdParty drizzle_recv_rows_timeout
syn keyword ngxDirectiveThirdParty drizzle_send_query_timeout
syn keyword ngxDirectiveThirdParty drizzle_server


endif
