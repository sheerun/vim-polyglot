if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Upload Module <https://www.nginx.com/resources/wiki/modules/upload/>
" Parses request body storing all files being uploaded to a directory specified by upload_store directive
syn keyword ngxDirectiveThirdParty upload_pass
syn keyword ngxDirectiveThirdParty upload_resumable
syn keyword ngxDirectiveThirdParty upload_store
syn keyword ngxDirectiveThirdParty upload_state_store
syn keyword ngxDirectiveThirdParty upload_store_access
syn keyword ngxDirectiveThirdParty upload_set_form_field
syn keyword ngxDirectiveThirdParty upload_aggregate_form_field
syn keyword ngxDirectiveThirdParty upload_pass_form_field
syn keyword ngxDirectiveThirdParty upload_cleanup
syn keyword ngxDirectiveThirdParty upload_buffer_size
syn keyword ngxDirectiveThirdParty upload_max_part_header_len
syn keyword ngxDirectiveThirdParty upload_max_file_size
syn keyword ngxDirectiveThirdParty upload_limit_rate
syn keyword ngxDirectiveThirdParty upload_max_output_body_len
syn keyword ngxDirectiveThirdParty upload_tame_arrays
syn keyword ngxDirectiveThirdParty upload_pass_args


endif
