if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" RDS JSON Module <https://github.com/openresty/rds-json-nginx-module>
" Help ngx_drizzle and other DBD modules emit JSON data.
syn keyword ngxDirectiveThirdParty rds_json
syn keyword ngxDirectiveThirdParty rds_json_content_type
syn keyword ngxDirectiveThirdParty rds_json_format
syn keyword ngxDirectiveThirdParty rds_json_ret


endif
