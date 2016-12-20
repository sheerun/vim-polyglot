if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Upstream Fair Balancer <https://www.nginx.com/resources/wiki/modules/fair_balancer/>
" Sends an incoming request to the least-busy backend server, rather than distributing requests round-robin.
syn keyword ngxDirectiveThirdParty fair
syn keyword ngxDirectiveThirdParty upstream_fair_shm_size


endif
