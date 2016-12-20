if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Form Input Module <https://github.com/calio/form-input-nginx-module>
" Reads HTTP POST and PUT request body encoded in "application/x-www-form-urlencoded" and parses the arguments into nginx variables.
syn keyword ngxDirectiveThirdParty set_form_input
syn keyword ngxDirectiveThirdParty set_form_input_multi


endif
