if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Lua Module <https://github.com/alacner/nginx_lua_module>
" You can be very simple to execute lua code for nginx
syn keyword ngxDirectiveThirdParty lua_file


endif
