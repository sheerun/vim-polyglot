if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Stream Lua Module <https://github.com/openresty/stream-lua-nginx-module>
" Embed the power of Lua into Nginx stream/TCP Servers.
syn keyword ngxDirectiveThirdParty lua_resolver
syn keyword ngxDirectiveThirdParty lua_resolver_timeout
syn keyword ngxDirectiveThirdParty lua_lingering_close
syn keyword ngxDirectiveThirdParty lua_lingering_time
syn keyword ngxDirectiveThirdParty lua_lingering_timeout


endif
