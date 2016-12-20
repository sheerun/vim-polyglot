if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Secure Download <https://www.nginx.com/resources/wiki/modules/secure_download/>
" Create expiring links.
syn keyword ngxDirectiveThirdParty secure_download
syn keyword ngxDirectiveThirdParty secure_download_fail_location
syn keyword ngxDirectiveThirdParty secure_download_path_mode
syn keyword ngxDirectiveThirdParty secure_download_secret


endif
