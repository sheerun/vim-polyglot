if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" HTTP Push Module (DEPRECATED) <http://pushmodule.slact.net/>
" Turn Nginx into an adept long-polling HTTP Push (Comet) server.
syn keyword ngxDirectiveDeprecated push_buffer_size
syn keyword ngxDirectiveDeprecated push_listener
syn keyword ngxDirectiveDeprecated push_message_timeout
syn keyword ngxDirectiveDeprecated push_queue_messages
syn keyword ngxDirectiveDeprecated push_sender


endif
