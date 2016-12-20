if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Substitutions Module <https://www.nginx.com/resources/wiki/modules/substitutions/>
" A filter module which can do both regular expression and fixed string substitutions on response bodies.
syn keyword ngxDirectiveThirdParty subs_filter
syn keyword ngxDirectiveThirdParty subs_filter_types


endif
