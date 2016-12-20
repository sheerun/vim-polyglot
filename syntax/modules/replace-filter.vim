if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Replace Filter Module <https://github.com/openresty/replace-filter-nginx-module>
" Streaming regular expression replacement in response bodies 
syn keyword ngxDirectiveThirdParty replace_filter
syn keyword ngxDirectiveThirdParty replace_filter_types
syn keyword ngxDirectiveThirdParty replace_filter_max_buffered_size
syn keyword ngxDirectiveThirdParty replace_filter_last_modified
syn keyword ngxDirectiveThirdParty replace_filter_skip


endif
