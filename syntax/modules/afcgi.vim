if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Asynchronous FastCGI Module <https://github.com/rsms/afcgi>
" Primarily a modified version of the Nginx FastCGI module which implements multiplexing of connections, allowing a single FastCGI server to handle many concurrent requests.
" syn keyword ngxDirectiveThirdParty fastcgi_bind
" syn keyword ngxDirectiveThirdParty fastcgi_buffer_size
" syn keyword ngxDirectiveThirdParty fastcgi_buffers
" syn keyword ngxDirectiveThirdParty fastcgi_busy_buffers_size
" syn keyword ngxDirectiveThirdParty fastcgi_cache
" syn keyword ngxDirectiveThirdParty fastcgi_cache_key
" syn keyword ngxDirectiveThirdParty fastcgi_cache_methods
" syn keyword ngxDirectiveThirdParty fastcgi_cache_min_uses
" syn keyword ngxDirectiveThirdParty fastcgi_cache_path
" syn keyword ngxDirectiveThirdParty fastcgi_cache_use_stale
" syn keyword ngxDirectiveThirdParty fastcgi_cache_valid
" syn keyword ngxDirectiveThirdParty fastcgi_catch_stderr
" syn keyword ngxDirectiveThirdParty fastcgi_connect_timeout
" syn keyword ngxDirectiveThirdParty fastcgi_hide_header
" syn keyword ngxDirectiveThirdParty fastcgi_ignore_client_abort
" syn keyword ngxDirectiveThirdParty fastcgi_ignore_headers
" syn keyword ngxDirectiveThirdParty fastcgi_index
" syn keyword ngxDirectiveThirdParty fastcgi_intercept_errors
" syn keyword ngxDirectiveThirdParty fastcgi_max_temp_file_size
" syn keyword ngxDirectiveThirdParty fastcgi_next_upstream
" syn keyword ngxDirectiveThirdParty fastcgi_param
" syn keyword ngxDirectiveThirdParty fastcgi_pass
" syn keyword ngxDirectiveThirdParty fastcgi_pass_header
" syn keyword ngxDirectiveThirdParty fastcgi_pass_request_body
" syn keyword ngxDirectiveThirdParty fastcgi_pass_request_headers
" syn keyword ngxDirectiveThirdParty fastcgi_read_timeout
" syn keyword ngxDirectiveThirdParty fastcgi_send_lowat
" syn keyword ngxDirectiveThirdParty fastcgi_send_timeout
" syn keyword ngxDirectiveThirdParty fastcgi_split_path_info
" syn keyword ngxDirectiveThirdParty fastcgi_store
" syn keyword ngxDirectiveThirdParty fastcgi_store_access
" syn keyword ngxDirectiveThirdParty fastcgi_temp_file_write_size
" syn keyword ngxDirectiveThirdParty fastcgi_temp_path
syn keyword ngxDirectiveThirdParty fastcgi_upstream_fail_timeout
syn keyword ngxDirectiveThirdParty fastcgi_upstream_max_fails


endif
