if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" HTTP Dynamic Upstream Module <https://github.com/yzprofile/ngx_http_dyups_module>
" Update upstreams' config by restful interface
syn keyword ngxDirectiveThirdParty dyups_interface
syn keyword ngxDirectiveThirdParty dyups_read_msg_timeout
syn keyword ngxDirectiveThirdParty dyups_shm_zone_size
syn keyword ngxDirectiveThirdParty dyups_upstream_conf
syn keyword ngxDirectiveThirdParty dyups_trylock


endif
