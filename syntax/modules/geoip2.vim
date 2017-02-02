if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" GeoIP 2 Module <https://github.com/leev/ngx_http_geoip2_module>
" Creates variables with values from the maxmind geoip2 databases based on the client IP
syn keyword ngxDirectiveThirdParty geoip2


endif
