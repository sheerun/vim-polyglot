if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Types Filter Module <https://github.com/flygoast/ngx_http_types_filter>
" Change the `Content-Type` output header depending on an extension variable according to a condition specified in the 'if' clause. 
syn keyword ngxDirectiveThirdParty types_filter
syn keyword ngxDirectiveThirdParty types_filter_use_default


endif
