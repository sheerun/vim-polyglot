if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Upstream Consistent Hash <https://www.nginx.com/resources/wiki/modules/consistent_hash/>
" A load balancer that uses an internal consistent hash ring to select the right backend node.
syn keyword ngxDirectiveThirdParty consistent_hash


endif
