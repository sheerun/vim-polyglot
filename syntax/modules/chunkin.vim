if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Chunkin Module (DEPRECATED) <http://wiki.nginx.org/NginxHttpChunkinModule>
" HTTP 1.1 chunked-encoding request body support for Nginx.
syn keyword ngxDirectiveDeprecated chunkin
syn keyword ngxDirectiveDeprecated chunkin_keepalive
syn keyword ngxDirectiveDeprecated chunkin_max_chunks_per_buf
syn keyword ngxDirectiveDeprecated chunkin_resume


endif
