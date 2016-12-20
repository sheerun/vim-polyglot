if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Upload Progress Module <https://www.nginx.com/resources/wiki/modules/upload_progress/>
" Tracks and reports upload progress.
syn keyword ngxDirectiveThirdParty report_uploads
syn keyword ngxDirectiveThirdParty track_uploads
syn keyword ngxDirectiveThirdParty upload_progress
syn keyword ngxDirectiveThirdParty upload_progress_content_type
syn keyword ngxDirectiveThirdParty upload_progress_header
syn keyword ngxDirectiveThirdParty upload_progress_json_output
syn keyword ngxDirectiveThirdParty upload_progress_template


endif
