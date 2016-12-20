if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Nginx Digest Authentication module <https://github.com/atomx/nginx-http-auth-digest>
"  Digest Authentication for Nginx 
syn keyword ngxDirectiveThirdParty auth_digest
syn keyword ngxDirectiveThirdParty auth_digest_user_file
syn keyword ngxDirectiveThirdParty auth_digest_timeout
syn keyword ngxDirectiveThirdParty auth_digest_expires
syn keyword ngxDirectiveThirdParty auth_digest_replays
syn keyword ngxDirectiveThirdParty auth_digest_shm_size


endif
