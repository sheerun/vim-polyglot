if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Health Checks Upstreams Module <https://www.nginx.com/resources/wiki/modules/healthcheck/>
" Polls backends and if they respond with HTTP 200 + an optional request body, they are marked good. Otherwise, they are marked bad.
syn keyword ngxDirectiveThirdParty healthcheck_enabled
syn keyword ngxDirectiveThirdParty healthcheck_delay
syn keyword ngxDirectiveThirdParty healthcheck_timeout
syn keyword ngxDirectiveThirdParty healthcheck_failcount
syn keyword ngxDirectiveThirdParty healthcheck_send
syn keyword ngxDirectiveThirdParty healthcheck_expected
syn keyword ngxDirectiveThirdParty healthcheck_buffer
syn keyword ngxDirectiveThirdParty healthcheck_status


endif
