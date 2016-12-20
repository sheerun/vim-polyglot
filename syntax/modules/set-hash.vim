if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Set Hash Module <https://github.com/simpl/ngx_http_set_hash>
" Nginx module that allows the setting of variables to the value of a variety of hashes  
syn keyword ngxDirectiveThirdParty set_md5
syn keyword ngxDirectiveThirdParty set_md5_upper
syn keyword ngxDirectiveThirdParty set_murmur2
syn keyword ngxDirectiveThirdParty set_murmur2_upper
syn keyword ngxDirectiveThirdParty set_sha1
syn keyword ngxDirectiveThirdParty set_sha1_upper


endif
