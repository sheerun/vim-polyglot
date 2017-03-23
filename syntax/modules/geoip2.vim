if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" GeoIP 2 Module <https://github.com/leev/ngx_http_geoip2_module>
" Creates variables with values from the maxmind geoip2 databases based on the client IP
syn keyword ngxDirectiveThirdParty      geoip2 nextgroup=ngxThirdPartyGeoIP2Database skipwhite skipempty
syn match   ngxThirdPartyGeoIP2Database /\S\+/ contained nextgroup=ngxThirdPartyGeoIP2Block skipwhite skipempty
syn region  ngxThirdPartyGeoIP2Block    start=/{/ end=/}/ contained contains=ngxThirdPartyGeoIP2Keyword,ngxVariable
syn keyword ngxThirdPartyGeoIP2Keyword  de en es fr ja pt-BR ru zh-CN contained
syn match   ngxThirdPartyGeoIP2Keyword  /pt-BR|zh-CN/ contained
syn keyword ngxThirdPartyGeoIP2Keyword  default source contained
" Common Keys
syn keyword ngxThirdPartyGeoIP2Keyword  code confidence geoname_id names iso_code contained
" /Common Keys
syn keyword ngxThirdPartyGeoIP2Keyword  city contained
syn keyword ngxThirdPartyGeoIP2Keyword  continent contained
syn keyword ngxThirdPartyGeoIP2Keyword  country contained
syn keyword ngxThirdPartyGeoIP2Keyword  location contained
" Location Keys
syn keyword ngxThirdPartyGeoIP2Keyword  accuracy_radius contained
syn keyword ngxThirdPartyGeoIP2Keyword  average_income contained
syn keyword ngxThirdPartyGeoIP2Keyword  latitude contained
syn keyword ngxThirdPartyGeoIP2Keyword  longitude contained
syn keyword ngxThirdPartyGeoIP2Keyword  metro_code contained
syn keyword ngxThirdPartyGeoIP2Keyword  population_density contained
syn keyword ngxThirdPartyGeoIP2Keyword  time_zone contained
syn keyword ngxThirdPartyGeoIP2Keyword  postal  contained
" /Location Keys
syn keyword ngxThirdPartyGeoIP2Keyword  registered_country contained
syn keyword ngxThirdPartyGeoIP2Keyword  represented_country contained
" Represented Country Keys
syn keyword ngxThirdPartyGeoIP2Keyword  type contained
" /Represented Country Keys
syn keyword ngxThirdPartyGeoIP2Keyword  subdivisions contained
syn keyword ngxThirdPartyGeoIP2Keyword  traits contained
" Traits Keys
syn keyword ngxThirdPartyGeoIP2Keyword  autonomous_system_number contained
syn keyword ngxThirdPartyGeoIP2Keyword  autonomous_system_organization contained
syn keyword ngxThirdPartyGeoIP2Keyword  domain contained
syn keyword ngxThirdPartyGeoIP2Keyword  ip_address contained
syn keyword ngxThirdPartyGeoIP2Keyword  is_anonymous_proxy contained
syn keyword ngxThirdPartyGeoIP2Keyword  is_satellite_provider contained
syn keyword ngxThirdPartyGeoIP2Keyword  isp contained
syn keyword ngxThirdPartyGeoIP2Keyword  organization contained
syn keyword ngxThirdPartyGeoIP2Keyword  user_type contained
" /Traits Keys
hi link ngxThirdPartyGeoIP2Keyword ngxThirdPartyKeyword


endif
