if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" JS Module <https://github.com/peter-leonov/ngx_http_js_module>
" Reflect the nginx functionality in JS
syn keyword ngxDirectiveThirdParty js
syn keyword ngxDirectiveThirdParty js_access
syn keyword ngxDirectiveThirdParty js_load
syn keyword ngxDirectiveThirdParty js_set


endif
