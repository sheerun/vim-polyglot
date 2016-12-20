if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Mogilefs Module <http://www.grid.net.ru/nginx/mogilefs.en.html>
" Implements a MogileFS client, provides a replace to the Perlbal reverse proxy of the original MogileFS.
syn keyword ngxDirectiveThirdParty mogilefs_connect_timeout
syn keyword ngxDirectiveThirdParty mogilefs_domain
syn keyword ngxDirectiveThirdParty mogilefs_methods
syn keyword ngxDirectiveThirdParty mogilefs_noverify
syn keyword ngxDirectiveThirdParty mogilefs_pass
syn keyword ngxDirectiveThirdParty mogilefs_read_timeout
syn keyword ngxDirectiveThirdParty mogilefs_send_timeout
syn keyword ngxDirectiveThirdParty mogilefs_tracker


endif
