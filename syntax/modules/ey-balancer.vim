if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" EY Balancer Module <https://github.com/ezmobius/nginx-ey-balancer>
" Adds a request queue to Nginx that allows the limiting of concurrent requests passed to the upstream.
syn keyword ngxDirectiveThirdParty max_connections
syn keyword ngxDirectiveThirdParty max_connections_max_queue_length
syn keyword ngxDirectiveThirdParty max_connections_queue_timeout


endif
