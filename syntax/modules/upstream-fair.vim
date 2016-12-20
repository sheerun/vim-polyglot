if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Upstream Fair Module <https://github.com/gnosek/nginx-upstream-fair>
" The fair load balancer module for nginx http://nginx.localdomain.pl
syn keyword ngxDirectiveThirdParty fair
syn keyword ngxDirectiveThirdParty upstream_fair_shm_size


endif
