if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Postgres Module <http://labs.frickle.com/nginx_ngx_postgres/>
" Upstream module that allows nginx to communicate directly with PostgreSQL database.
syn keyword ngxDirectiveThirdParty postgres_server
syn keyword ngxDirectiveThirdParty postgres_keepalive
syn keyword ngxDirectiveThirdParty postgres_pass
syn keyword ngxDirectiveThirdParty postgres_query
syn keyword ngxDirectiveThirdParty postgres_rewrite
syn keyword ngxDirectiveThirdParty postgres_output
syn keyword ngxDirectiveThirdParty postgres_set
syn keyword ngxDirectiveThirdParty postgres_escape
syn keyword ngxDirectiveThirdParty postgres_connect_timeout
syn keyword ngxDirectiveThirdParty postgres_result_timeout


endif
