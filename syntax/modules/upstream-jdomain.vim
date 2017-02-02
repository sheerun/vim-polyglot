if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Upstream Domain Resolve Module <https://www.nginx.com/resources/wiki/modules/domain_resolve/>
" A load-balancer that resolves an upstream domain name asynchronously.
syn keyword ngxDirectiveThirdParty jdomain


endif
