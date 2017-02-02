if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" HTTP Concatenation module for Nginx <https://github.com/alibaba/nginx-http-concat>
" A Nginx module for concatenating files in a given context: CSS and JS files usually
syn keyword ngxDirectiveThirdParty concat
syn keyword ngxDirectiveThirdParty concat_types
syn keyword ngxDirectiveThirdParty concat_unique
syn keyword ngxDirectiveThirdParty concat_max_files
syn keyword ngxDirectiveThirdParty concat_delimiter
syn keyword ngxDirectiveThirdParty concat_ignore_file_error


endif
