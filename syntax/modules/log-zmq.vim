if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Log ZeroMQ Module <https://github.com/alticelabs/nginx-log-zmq>
" ZeroMQ logger module for nginx
syn keyword ngxDirectiveThirdParty log_zmq_server
syn keyword ngxDirectiveThirdParty log_zmq_endpoint
syn keyword ngxDirectiveThirdParty log_zmq_format
syn keyword ngxDirectiveThirdParty log_zmq_off


endif
