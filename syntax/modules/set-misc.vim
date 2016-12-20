if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Set Misc Module <https://github.com/openresty/set-misc-nginx-module>
" Various set_xxx directives added to nginx's rewrite module
syn keyword ngxDirectiveThirdParty set_if_empty
syn keyword ngxDirectiveThirdParty set_quote_sql_str
syn keyword ngxDirectiveThirdParty set_quote_pgsql_str
syn keyword ngxDirectiveThirdParty set_quote_json_str
syn keyword ngxDirectiveThirdParty set_unescape_uri
syn keyword ngxDirectiveThirdParty set_escape_uri
syn keyword ngxDirectiveThirdParty set_hashed_upstream
syn keyword ngxDirectiveThirdParty set_encode_base32
syn keyword ngxDirectiveThirdParty set_base32_padding
syn keyword ngxDirectiveThirdParty set_misc_base32_padding
syn keyword ngxDirectiveThirdParty set_base32_alphabet
syn keyword ngxDirectiveThirdParty set_decode_base32
syn keyword ngxDirectiveThirdParty set_encode_base64
syn keyword ngxDirectiveThirdParty set_decode_base64
syn keyword ngxDirectiveThirdParty set_encode_hex
syn keyword ngxDirectiveThirdParty set_decode_hex
syn keyword ngxDirectiveThirdParty set_sha1
syn keyword ngxDirectiveThirdParty set_md5
syn keyword ngxDirectiveThirdParty set_hmac_sha1
syn keyword ngxDirectiveThirdParty set_random
syn keyword ngxDirectiveThirdParty set_secure_random_alphanum
syn keyword ngxDirectiveThirdParty set_secure_random_lcalpha
syn keyword ngxDirectiveThirdParty set_rotate
syn keyword ngxDirectiveThirdParty set_local_today
syn keyword ngxDirectiveThirdParty set_formatted_gmt_time
syn keyword ngxDirectiveThirdParty set_formatted_local_time


endif
