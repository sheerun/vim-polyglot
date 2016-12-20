if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" SSSD Info Module <https://github.com/veruu/ngx_sssd_info>
" Retrives additional attributes from SSSD for current authentizated user
syn keyword ngxDirectiveThirdParty sssd_info
syn keyword ngxDirectiveThirdParty sssd_info_output_to
syn keyword ngxDirectiveThirdParty sssd_info_groups
syn keyword ngxDirectiveThirdParty sssd_info_group
syn keyword ngxDirectiveThirdParty sssd_info_group_separator
syn keyword ngxDirectiveThirdParty sssd_info_attributes
syn keyword ngxDirectiveThirdParty sssd_info_attribute
syn keyword ngxDirectiveThirdParty sssd_info_attribute_separator


endif
