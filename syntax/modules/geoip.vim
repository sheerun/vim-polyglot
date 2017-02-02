if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" GeoIP Module (DEPRECATED) <http://wiki.nginx.org/NginxHttp3rdPartyGeoIPModule>
" Country code lookups via the MaxMind GeoIP API.
syn keyword ngxDirectiveDeprecated geoip_country_file


endif
