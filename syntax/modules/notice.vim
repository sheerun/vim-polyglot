if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Nginx Notice Module <https://github.com/kr/nginx-notice>
" Serve static file to POST requests.
syn keyword ngxDirectiveThirdParty notice
syn keyword ngxDirectiveThirdParty notice_type


endif
