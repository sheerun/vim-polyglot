if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" HTTP Push Module (DEPRECATED) <http://pushmodule.slact.net/>
" Turn Nginx into an adept long-polling HTTP Push (Comet) server.
syn keyword ngxDirectiveThirdParty push_buffer_size
syn keyword ngxDirectiveThirdParty push_listener
syn keyword ngxDirectiveThirdParty push_message_timeout
syn keyword ngxDirectiveThirdParty push_queue_messages
syn keyword ngxDirectiveThirdParty push_sender


endif
