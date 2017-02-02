if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Brotli Module <https://github.com/google/ngx_brotli>
" Nginx module for Brotli compression
syn keyword ngxDirectiveThirdParty brotli_static
syn keyword ngxDirectiveThirdParty brotli
syn keyword ngxDirectiveThirdParty brotli_types
syn keyword ngxDirectiveThirdParty brotli_buffers
syn keyword ngxDirectiveThirdParty brotli_comp_level
syn keyword ngxDirectiveThirdParty brotli_window
syn keyword ngxDirectiveThirdParty brotli_min_length


endif
