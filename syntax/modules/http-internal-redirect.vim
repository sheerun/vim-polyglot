if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" HTTP Internal Redirect Module <https://github.com/flygoast/ngx_http_internal_redirect>
" Make an internal redirect to the uri specified according to the condition specified.
syn keyword ngxDirectiveThirdParty internal_redirect_if
syn keyword ngxDirectiveThirdParty internal_redirect_if_no_postponed


endif
