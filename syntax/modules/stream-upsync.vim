if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Stream Upsync Module <https://github.com/xiaokai-wang/nginx-stream-upsync-module>
" Sync upstreams from consul or others, dynamiclly modify backend-servers attribute(weight, max_fails,...), needn't reload nginx. 
syn keyword ngxDirectiveThirdParty upsync
syn keyword ngxDirectiveThirdParty upsync_dump_path
syn keyword ngxDirectiveThirdParty upsync_lb
syn keyword ngxDirectiveThirdParty upsync_show


endif
