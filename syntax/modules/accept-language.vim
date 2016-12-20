if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Accept Language Module <https://www.nginx.com/resources/wiki/modules/accept_language/>
" Parses the Accept-Language header and gives the most suitable locale from a list of supported locales.
syn keyword ngxDirectiveThirdParty set_from_accept_language


endif
