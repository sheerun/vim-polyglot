if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Encrypted Session Module <https://github.com/openresty/encrypted-session-nginx-module>
" Encrypt and decrypt nginx variable values
syn keyword ngxDirectiveThirdParty encrypted_session_key
syn keyword ngxDirectiveThirdParty encrypted_session_iv
syn keyword ngxDirectiveThirdParty encrypted_session_expires
syn keyword ngxDirectiveThirdParty set_encrypt_session
syn keyword ngxDirectiveThirdParty set_decrypt_session


endif
