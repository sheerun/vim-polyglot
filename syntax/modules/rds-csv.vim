if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" RDS CSV Module <https://github.com/openresty/rds-csv-nginx-module>
" Nginx output filter module to convert Resty-DBD-Streams (RDS) to Comma-Separated Values (CSV)
syn keyword ngxDirectiveThirdParty rds_csv
syn keyword ngxDirectiveThirdParty rds_csv_row_terminator
syn keyword ngxDirectiveThirdParty rds_csv_field_separator
syn keyword ngxDirectiveThirdParty rds_csv_field_name_header
syn keyword ngxDirectiveThirdParty rds_csv_content_type
syn keyword ngxDirectiveThirdParty rds_csv_buffer_size


endif
