if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Limit Upload Rate Module <https://github.com/cfsego/limit_upload_rate>
" Limit client-upload rate when they are sending request bodies to you
syn keyword ngxDirectiveThirdParty limit_upload_rate
syn keyword ngxDirectiveThirdParty limit_upload_rate_after


endif
