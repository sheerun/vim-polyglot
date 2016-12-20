if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Subrange Module <https://github.com/Qihoo360/ngx_http_subrange_module>
" Split one big HTTP/Range request to multiple subrange requesets
syn keyword ngxDirectiveThirdParty subrange


endif
