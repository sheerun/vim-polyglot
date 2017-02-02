if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Secure Download Module <https://www.nginx.com/resources/wiki/modules/secure_download/>
" Enables you to create links which are only valid until a certain datetime is reached
syn keyword ngxDirectiveThirdParty secure_download
syn keyword ngxDirectiveThirdParty secure_download_secret
syn keyword ngxDirectiveThirdParty secure_download_path_mode


endif
