if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" XSS Module <https://github.com/openresty/xss-nginx-module>
" Native support for cross-site scripting (XSS) in an nginx.
syn keyword ngxDirectiveThirdParty xss_callback_arg
syn keyword ngxDirectiveThirdParty xss_get
syn keyword ngxDirectiveThirdParty xss_input_types
syn keyword ngxDirectiveThirdParty xss_output_type


endif
