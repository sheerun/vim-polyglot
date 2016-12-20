if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Stream Echo Module <https://github.com/openresty/stream-echo-nginx-module>
" TCP/stream echo module for NGINX (a port of ngx_http_echo_module) 
syn keyword ngxDirectiveThirdParty echo
syn keyword ngxDirectiveThirdParty echo_duplicate
syn keyword ngxDirectiveThirdParty echo_flush_wait
syn keyword ngxDirectiveThirdParty echo_sleep
syn keyword ngxDirectiveThirdParty echo_send_timeout
syn keyword ngxDirectiveThirdParty echo_read_bytes
syn keyword ngxDirectiveThirdParty echo_read_line
syn keyword ngxDirectiveThirdParty echo_request_data
syn keyword ngxDirectiveThirdParty echo_discard_request
syn keyword ngxDirectiveThirdParty echo_read_buffer_size
syn keyword ngxDirectiveThirdParty echo_read_timeout
syn keyword ngxDirectiveThirdParty echo_client_error_log_level
syn keyword ngxDirectiveThirdParty echo_lingering_close
syn keyword ngxDirectiveThirdParty echo_lingering_time
syn keyword ngxDirectiveThirdParty echo_lingering_timeout


endif
