if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Form Auth Module <https://github.com/veruu/ngx_form_auth>
" Provides authentication and authorization with credentials submitted via POST request
syn keyword ngxDirectiveThirdParty form_auth
syn keyword ngxDirectiveThirdParty form_auth_pam_service
syn keyword ngxDirectiveThirdParty form_auth_login
syn keyword ngxDirectiveThirdParty form_auth_password
syn keyword ngxDirectiveThirdParty form_auth_remote_user


endif
