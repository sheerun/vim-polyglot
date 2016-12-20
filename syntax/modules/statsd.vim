if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Statsd Module <https://github.com/zebrafishlabs/nginx-statsd>
" An nginx module for sending statistics to statsd
syn keyword ngxDirectiveThirdParty statsd_server
syn keyword ngxDirectiveThirdParty statsd_sample_rate
syn keyword ngxDirectiveThirdParty statsd_count
syn keyword ngxDirectiveThirdParty statsd_timing


endif
