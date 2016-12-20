if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Auth PAM Module <https://github.com/sto/ngx_http_auth_pam_module>
" HTTP Basic Authentication using PAM.
syn keyword ngxDirectiveThirdParty auth_pam
syn keyword ngxDirectiveThirdParty auth_pam_service_name


endif
