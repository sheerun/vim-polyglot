if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" AWS Proxy Module <https://github.com/anomalizer/ngx_aws_auth>
" Nginx module to proxy to authenticated AWS services 
syn keyword ngxDirectiveThirdParty aws_access_key
syn keyword ngxDirectiveThirdParty aws_key_scope
syn keyword ngxDirectiveThirdParty aws_signing_key
syn keyword ngxDirectiveThirdParty aws_endpoint
syn keyword ngxDirectiveThirdParty aws_s3_bucket
syn keyword ngxDirectiveThirdParty aws_sign


endif
