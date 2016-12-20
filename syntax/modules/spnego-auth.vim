if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" HTTP SPNEGO auth Module <https://github.com/stnoonan/spnego-http-auth-nginx-module>
" This module implements adds SPNEGO support to nginx(http://nginx.org). It currently supports only Kerberos authentication via GSSAPI
syn keyword ngxDirectiveThirdParty auth_gss
syn keyword ngxDirectiveThirdParty auth_gss_keytab
syn keyword ngxDirectiveThirdParty auth_gss_realm
syn keyword ngxDirectiveThirdParty auth_gss_service_name
syn keyword ngxDirectiveThirdParty auth_gss_authorized_principal
syn keyword ngxDirectiveThirdParty auth_gss_allow_basic_fallback


endif
