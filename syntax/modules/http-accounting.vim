if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" HTTP Accounting Module <https://github.com/Lax/ngx_http_accounting_module>
" Add traffic stat function to nginx. Useful for http accounting based on nginx configuration logic
syn keyword ngxDirectiveThirdParty http_accounting
syn keyword ngxDirectiveThirdParty http_accounting_log
syn keyword ngxDirectiveThirdParty http_accounting_id
syn keyword ngxDirectiveThirdParty http_accounting_interval
syn keyword ngxDirectiveThirdParty http_accounting_perturb


endif
