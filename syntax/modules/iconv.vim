if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Iconv Module <https://github.com/calio/iconv-nginx-module>
" A character conversion nginx module using libiconv 
syn keyword ngxDirectiveThirdParty set_iconv
syn keyword ngxDirectiveThirdParty iconv_buffer_size
syn keyword ngxDirectiveThirdParty iconv_filter


endif
