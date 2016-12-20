if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Headers More Module <https://github.com/openresty/headers-more-nginx-module>
" Set and clear input and output headers...more than "add"!
syn keyword ngxDirectiveThirdParty more_clear_headers
syn keyword ngxDirectiveThirdParty more_clear_input_headers
syn keyword ngxDirectiveThirdParty more_set_headers
syn keyword ngxDirectiveThirdParty more_set_input_headers


endif
