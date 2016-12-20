if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" NAXSI Module <https://github.com/nbs-system/naxsi>
" NAXSI is an open-source, high performance, low rules maintenance WAF for NGINX
syn keyword ngxDirectiveThirdParty DeniedUrl denied_url
syn keyword ngxDirectiveThirdParty LearningMode learning_mode
syn keyword ngxDirectiveThirdParty SecRulesEnabled rules_enabled
syn keyword ngxDirectiveThirdParty SecRulesDisabled rules_disabled
syn keyword ngxDirectiveThirdParty CheckRule check_rule
syn keyword ngxDirectiveThirdParty BasicRule basic_rule
syn keyword ngxDirectiveThirdParty MainRule main_rule
syn keyword ngxDirectiveThirdParty LibInjectionSql libinjection_sql
syn keyword ngxDirectiveThirdParty LibInjectionXss libinjection_xss


endif
