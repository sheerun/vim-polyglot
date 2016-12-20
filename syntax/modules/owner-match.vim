if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Owner Match Module <https://www.nginx.com/resources/wiki/modules/owner_match/>
" Control access for specific owners and groups of files
syn keyword ngxDirectiveThirdParty omallow
syn keyword ngxDirectiveThirdParty omdeny


endif
