if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" MP4 Streaming Lite Module <https://www.nginx.com/resources/wiki/modules/mp4_streaming/>
" Will seek to a certain time within H.264/MP4 files when provided with a 'start' parameter in the URL.
syn keyword ngxDirectiveThirdParty mp4


endif
