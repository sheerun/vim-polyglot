if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Mongo Module <https://github.com/simpl/ngx_mongo>
" Upstream module that allows nginx to communicate directly with MongoDB database.
syn keyword ngxDirectiveThirdParty mongo_auth
syn keyword ngxDirectiveThirdParty mongo_pass
syn keyword ngxDirectiveThirdParty mongo_query
syn keyword ngxDirectiveThirdParty mongo_json
syn keyword ngxDirectiveThirdParty mongo_bind
syn keyword ngxDirectiveThirdParty mongo_connect_timeout
syn keyword ngxDirectiveThirdParty mongo_send_timeout
syn keyword ngxDirectiveThirdParty mongo_read_timeout
syn keyword ngxDirectiveThirdParty mongo_buffering
syn keyword ngxDirectiveThirdParty mongo_buffer_size
syn keyword ngxDirectiveThirdParty mongo_buffers
syn keyword ngxDirectiveThirdParty mongo_busy_buffers_size
syn keyword ngxDirectiveThirdParty mongo_next_upstream


endif
