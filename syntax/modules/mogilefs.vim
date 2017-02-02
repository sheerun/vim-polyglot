if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Mogilefs Module <http://www.grid.net.ru/nginx/mogilefs.en.html>
" MogileFS client for nginx web server.
syn keyword ngxDirectiveThirdParty mogilefs_pass
syn keyword ngxDirectiveThirdParty mogilefs_methods
syn keyword ngxDirectiveThirdParty mogilefs_domain
syn keyword ngxDirectiveThirdParty mogilefs_class
syn keyword ngxDirectiveThirdParty mogilefs_tracker
syn keyword ngxDirectiveThirdParty mogilefs_noverify
syn keyword ngxDirectiveThirdParty mogilefs_connect_timeout
syn keyword ngxDirectiveThirdParty mogilefs_send_timeout
syn keyword ngxDirectiveThirdParty mogilefs_read_timeout


endif
