if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Sticky Module <https://bitbucket.org/nginx-goodies/nginx-sticky-module-ng>
" Add a sticky cookie to be always forwarded to the same upstream server
syn keyword ngxDirectiveThirdParty sticky 


endif
