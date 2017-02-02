if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Eval Module <http://www.grid.net.ru/nginx/eval.en.html>
" Module for nginx web server evaluates response of proxy or memcached module into variables.
syn keyword ngxDirectiveThirdParty eval
syn keyword ngxDirectiveThirdParty eval_escalate
syn keyword ngxDirectiveThirdParty eval_override_content_type


endif
