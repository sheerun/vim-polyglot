if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Eval Module <https://github.com/openresty/nginx-eval-module>
" Module for nginx web server evaluates response of proxy or memcached module into variables.
syn keyword ngxDirectiveThirdParty eval
syn keyword ngxDirectiveThirdParty eval_escalate
syn keyword ngxDirectiveThirdParty eval_buffer_size
syn keyword ngxDirectiveThirdParty eval_override_content_type
syn keyword ngxDirectiveThirdParty eval_subrequest_in_memory


endif
