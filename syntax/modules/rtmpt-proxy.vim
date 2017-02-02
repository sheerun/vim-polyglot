if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" RTMPT Module <https://github.com/kwojtek/nginx-rtmpt-proxy-module>
" Module for nginx to proxy rtmp using http protocol
syn keyword ngxDirectiveThirdParty rtmpt_proxy_target
syn keyword ngxDirectiveThirdParty rtmpt_proxy_rtmp_timeout
syn keyword ngxDirectiveThirdParty rtmpt_proxy_http_timeout
syn keyword ngxDirectiveThirdParty rtmpt_proxy
syn keyword ngxDirectiveThirdParty rtmpt_proxy_stat
syn keyword ngxDirectiveThirdParty rtmpt_proxy_stylesheet


endif
