if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Upload Progress Module <https://www.nginx.com/resources/wiki/modules/upload_progress/>
" An upload progress system, that monitors RFC1867 POST upload as they are transmitted to upstream servers
syn keyword ngxDirectiveThirdParty upload_progress
syn keyword ngxDirectiveThirdParty track_uploads
syn keyword ngxDirectiveThirdParty report_uploads
syn keyword ngxDirectiveThirdParty upload_progress_content_type
syn keyword ngxDirectiveThirdParty upload_progress_header
syn keyword ngxDirectiveThirdParty upload_progress_jsonp_parameter
syn keyword ngxDirectiveThirdParty upload_progress_json_output
syn keyword ngxDirectiveThirdParty upload_progress_jsonp_output
syn keyword ngxDirectiveThirdParty upload_progress_template


endif
