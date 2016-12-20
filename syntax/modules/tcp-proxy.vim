if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" TCP Proxy Module <http://yaoweibin.github.io/nginx_tcp_proxy_module/>
" Add the feature of tcp proxy with nginx, with health check and status monitor 
syn keyword ngxDirectiveThirdParty tcp
syn keyword ngxDirectiveThirdParty server
syn keyword ngxDirectiveThirdParty listen
syn keyword ngxDirectiveThirdParty allow
syn keyword ngxDirectiveThirdParty deny
syn keyword ngxDirectiveThirdParty so_keepalive
syn keyword ngxDirectiveThirdParty tcp_nodelay
syn keyword ngxDirectiveThirdParty timeout
syn keyword ngxDirectiveThirdParty server_name
syn keyword ngxDirectiveThirdParty resolver
syn keyword ngxDirectiveThirdParty resolver_timeout
syn keyword ngxDirectiveThirdParty upstream
syn keyword ngxDirectiveThirdParty server
syn keyword ngxDirectiveThirdParty check
syn keyword ngxDirectiveThirdParty check_http_send
syn keyword ngxDirectiveThirdParty check_http_expect_alive
syn keyword ngxDirectiveThirdParty check_smtp_send
syn keyword ngxDirectiveThirdParty check_smtp_expect_alive
syn keyword ngxDirectiveThirdParty check_shm_size
syn keyword ngxDirectiveThirdParty check_status
syn keyword ngxDirectiveThirdParty ip_hash
syn keyword ngxDirectiveThirdParty proxy_pass
syn keyword ngxDirectiveThirdParty proxy_buffer
syn keyword ngxDirectiveThirdParty proxy_connect_timeout
syn keyword ngxDirectiveThirdParty proxy_read_timeout
syn keyword ngxDirectiveThirdParty proxy_write_timeout


endif
