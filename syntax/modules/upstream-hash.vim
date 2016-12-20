if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Upstream Hash Module (DEPRECATED) <http://wiki.nginx.org/NginxHttpUpstreamRequestHashModule>
" Provides simple upstream load distribution by hashing a configurable variable.
syn keyword ngxDirectiveThirdParty hash
syn keyword ngxDirectiveThirdParty hash_again


endif
