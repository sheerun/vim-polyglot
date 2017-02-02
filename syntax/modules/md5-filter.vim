if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" MD5 Filter Module <https://github.com/kainswor/nginx_md5_filter>
" A content filter for nginx, which returns the md5 hash of the content otherwise returned.
syn keyword ngxDirectiveThirdParty md5_filter


endif
