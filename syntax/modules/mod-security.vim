if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Mod Security Module <https://github.com/SpiderLabs/ModSecurity>
" ModSecurity is an open source, cross platform web application firewall (WAF) engine
syn keyword ngxDirectiveThirdParty ModSecurityConfig
syn keyword ngxDirectiveThirdParty ModSecurityEnabled
syn keyword ngxDirectiveThirdParty pool_context
syn keyword ngxDirectiveThirdParty pool_context_hash_size


endif
