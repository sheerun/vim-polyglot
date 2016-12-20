if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Sphinx2 Module <https://github.com/reeteshranjan/sphinx2-nginx-module>
" Nginx upstream module for Sphinx 2.x
syn keyword ngxDirectiveThirdParty sphinx2_pass
syn keyword ngxDirectiveThirdParty sphinx2_bind
syn keyword ngxDirectiveThirdParty sphinx2_connect_timeout
syn keyword ngxDirectiveThirdParty sphinx2_send_timeout
syn keyword ngxDirectiveThirdParty sphinx2_buffer_size
syn keyword ngxDirectiveThirdParty sphinx2_read_timeout
syn keyword ngxDirectiveThirdParty sphinx2_next_upstream


endif
