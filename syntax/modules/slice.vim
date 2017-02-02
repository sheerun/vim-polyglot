if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Slice Module <https://github.com/alibaba/nginx-http-slice>
" Nginx module for serving a file in slices (reverse byte-range)
" syn keyword ngxDirectiveThirdParty slice
syn keyword ngxDirectiveThirdParty slice_arg_begin
syn keyword ngxDirectiveThirdParty slice_arg_end
syn keyword ngxDirectiveThirdParty slice_header
syn keyword ngxDirectiveThirdParty slice_footer
syn keyword ngxDirectiveThirdParty slice_header_first
syn keyword ngxDirectiveThirdParty slice_footer_last


endif
