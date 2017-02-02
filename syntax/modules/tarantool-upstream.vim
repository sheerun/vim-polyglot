if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Tarantool Upstream Module <https://github.com/tarantool/nginx_upstream_module>
" Tarantool NginX upstream module (REST, JSON API, websockets, load balancing)
syn keyword ngxDirectiveThirdParty tnt_pass
syn keyword ngxDirectiveThirdParty tnt_http_methods
syn keyword ngxDirectiveThirdParty tnt_http_rest_methods
syn keyword ngxDirectiveThirdParty tnt_pass_http_request
syn keyword ngxDirectiveThirdParty tnt_pass_http_request_buffer_size
syn keyword ngxDirectiveThirdParty tnt_method
syn keyword ngxDirectiveThirdParty tnt_http_allowed_methods - experemental
syn keyword ngxDirectiveThirdParty tnt_send_timeout
syn keyword ngxDirectiveThirdParty tnt_read_timeout
syn keyword ngxDirectiveThirdParty tnt_buffer_size
syn keyword ngxDirectiveThirdParty tnt_next_upstream
syn keyword ngxDirectiveThirdParty tnt_connect_timeout
syn keyword ngxDirectiveThirdParty tnt_next_upstream
syn keyword ngxDirectiveThirdParty tnt_next_upstream_tries
syn keyword ngxDirectiveThirdParty tnt_next_upstream_timeout


endif
