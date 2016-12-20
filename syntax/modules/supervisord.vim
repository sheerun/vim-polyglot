if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Supervisord Module <https://github.com/FRiCKLE/ngx_supervisord/>
" Module providing nginx with API to communicate with supervisord and manage (start/stop) backends on-demand.
syn keyword ngxDirectiveThirdParty supervisord
syn keyword ngxDirectiveThirdParty supervisord_inherit_backend_status
syn keyword ngxDirectiveThirdParty supervisord_name
syn keyword ngxDirectiveThirdParty supervisord_start
syn keyword ngxDirectiveThirdParty supervisord_stop


endif
