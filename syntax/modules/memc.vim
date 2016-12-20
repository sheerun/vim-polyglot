if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Memc Module <https://github.com/openresty/memc-nginx-module>
" An extended version of the standard memcached module that supports set, add, delete, and many more memcached commands.
syn keyword ngxDirectiveThirdParty memc_buffer_size
syn keyword ngxDirectiveThirdParty memc_cmds_allowed
syn keyword ngxDirectiveThirdParty memc_connect_timeout
syn keyword ngxDirectiveThirdParty memc_flags_to_last_modified
syn keyword ngxDirectiveThirdParty memc_next_upstream
syn keyword ngxDirectiveThirdParty memc_pass
syn keyword ngxDirectiveThirdParty memc_read_timeout
syn keyword ngxDirectiveThirdParty memc_send_timeout
syn keyword ngxDirectiveThirdParty memc_upstream_fail_timeout
syn keyword ngxDirectiveThirdParty memc_upstream_max_fails


endif
