if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Log Request Speed (DEPRECATED) <http://wiki.nginx.org/NginxHttpLogRequestSpeed>
" Log the time it took to process each request.
syn keyword ngxDirectiveDeprecated log_request_speed_filter
syn keyword ngxDirectiveDeprecated log_request_speed_filter_timeout


endif
