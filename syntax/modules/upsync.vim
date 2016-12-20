if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Upsync Module <https://github.com/weibocom/nginx-upsync-module>
" Sync upstreams from consul or others, dynamiclly modify backend-servers attribute(weight, max_fails,...), needn't reload nginx
syn keyword ngxDirectiveThirdParty upsync
syn keyword ngxDirectiveThirdParty upsync_dump_path
syn keyword ngxDirectiveThirdParty upsync_lb
syn keyword ngxDirectiveThirdParty upstream_show


endif
