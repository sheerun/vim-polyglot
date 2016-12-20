if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Sorted Querystring Filter Module <https://github.com/wandenberg/nginx-sorted-querystring-module>
" Nginx module to expose querystring parameters sorted in a variable to be used on cache_key as example
syn keyword ngxDirectiveThirdParty sorted_querystring_filter_parameter


endif
