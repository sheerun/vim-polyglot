if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" PHP Session Module <https://github.com/replay/ngx_http_php_session>
" Nginx module to parse php sessions 
syn keyword ngxDirectiveThirdParty php_session_parse
syn keyword ngxDirectiveThirdParty php_session_strip_formatting


endif
