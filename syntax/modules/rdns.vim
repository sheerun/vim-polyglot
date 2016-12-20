if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" rDNS Module <https://github.com/flant/nginx-http-rdns>
" Make a reverse DNS (rDNS) lookup for incoming connection and provides simple access control of incoming hostname by allow/deny rules
syn keyword ngxDirectiveThirdParty rdns
syn keyword ngxDirectiveThirdParty rdns_allow
syn keyword ngxDirectiveThirdParty rdns_deny 


endif
