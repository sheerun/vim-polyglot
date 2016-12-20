if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Array Variable Module <https://github.com/openresty/array-var-nginx-module>
" Add support for array-typed variables to nginx config files
syn keyword ngxDirectiveThirdParty array_split
syn keyword ngxDirectiveThirdParty array_join
syn keyword ngxDirectiveThirdParty array_map
syn keyword ngxDirectiveThirdParty array_map_op


endif
