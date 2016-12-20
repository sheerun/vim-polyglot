if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Nginx Audio Track for HTTP Live Streaming <https://github.com/flavioribeiro/nginx-audio-track-for-hls-module>
" This nginx module generates audio track for hls streams on the fly.
syn keyword ngxDirectiveThirdParty ngx_hls_audio_track
syn keyword ngxDirectiveThirdParty ngx_hls_audio_track_rootpath
syn keyword ngxDirectiveThirdParty ngx_hls_audio_track_output_format
syn keyword ngxDirectiveThirdParty ngx_hls_audio_track_output_header


endif
