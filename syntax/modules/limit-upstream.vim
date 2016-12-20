if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Limit Upstream Module <https://github.com/cfsego/nginx-limit-upstream>
" Limit the number of connections to upstream for NGINX
syn keyword ngxDirectiveThirdParty limit_upstream_zone
syn keyword ngxDirectiveThirdParty limit_upstream_conn
syn keyword ngxDirectiveThirdParty limit_upstream_log_level


endif
