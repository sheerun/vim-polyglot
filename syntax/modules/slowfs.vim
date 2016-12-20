if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" SlowFS Cache Module <https://github.com/FRiCKLE/ngx_slowfs_cache/>
" Module adding ability to cache static files.
syn keyword ngxDirectiveThirdParty slowfs_big_file_size
syn keyword ngxDirectiveThirdParty slowfs_cache
syn keyword ngxDirectiveThirdParty slowfs_cache_key
syn keyword ngxDirectiveThirdParty slowfs_cache_min_uses
syn keyword ngxDirectiveThirdParty slowfs_cache_path
syn keyword ngxDirectiveThirdParty slowfs_cache_purge
syn keyword ngxDirectiveThirdParty slowfs_cache_valid
syn keyword ngxDirectiveThirdParty slowfs_temp_path


endif
