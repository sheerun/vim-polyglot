if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" HTTP JavaScript Module <https://github.com/peter-leonov/ngx_http_js_module>
" Embedding SpiderMonkey. Nearly full port on Perl module.
syn keyword ngxDirectiveThirdParty js
syn keyword ngxDirectiveThirdParty js_filter
syn keyword ngxDirectiveThirdParty js_filter_types
syn keyword ngxDirectiveThirdParty js_load
syn keyword ngxDirectiveThirdParty js_maxmem
syn keyword ngxDirectiveThirdParty js_require
syn keyword ngxDirectiveThirdParty js_set
syn keyword ngxDirectiveThirdParty js_utf8


endif
