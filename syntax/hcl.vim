if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'hcl') == -1


if exists("b:current_syntax")
  finish
endif

syn match hclEqual '='
syn match hclSimpleString '"[^\"]*"'
syn region hclComment display oneline start='\%\(^\|\s\)#' end='$'
syn region hclComment display oneline start='\%\(^\|\s\)//' end='$'
syn region hclInterpolation display oneline start='(' end=')' contains=hclInterpolation,hclSimpleString
syn region hclSmartString display oneline start='"' end='"\s*$' contains=hclInterpolation

syn keyword hclRootKeywords variable provider resource nextgroup=hclString,hclString skipwhite
syn keyword hclRootKeywords default nextgroup=hclEquals skipwhite


syn keyword hclAwsResourcesKeywords availability_zones desired_capacity force_delete health_check_grace_period health_check_type launch_configuration load_balancers max_size min_size name vpc_zone_identifier nextgroup=hclEquals,hclString skipwhite
syn keyword hclAwsResourcesKeywords allocated_storage availability_zone backup_retention_period backup_window db_subnet_group_name engine engine_version final_snapshot_identifier identifier instance_class iops maintenance_window multi_az name password port publicly_accessible security_group_names skip_final_snapshot username vpc_security_group_ids nextgroup=hclEquals,hclString skipwhite
syn keyword hclAwsResourcesKeywords cidr description ingress name security_group_id security_group_name security_group_owner_id source_security_group_id nextgroup=hclEquals,hclString skipwhite
syn keyword hclAwsResourcesKeywords description name subnet_ids nextgroup=hclEquals,hclString skipwhite
syn keyword hclAwsResourcesKeywords instance vpc nextgroup=hclEquals,hclString skipwhite
syn keyword hclAwsResourcesKeywords availability_zones health_check healthy_threshold instance_port instance_protocol instances internal interval lb_port lb_protocol listener name security_groups ssl_certificate_id subnets target timeout unhealthy_threshold nextgroup=hclEquals,hclString skipwhite
syn keyword hclAwsResourcesKeywords ami associate_public_ip_address availability_zone ebs_optimized iam_instance_profile instance_type key_name private_ip security_groups source_dest_check subnet_id tags user_data nextgroup=hclEquals,hclString skipwhite
syn keyword hclAwsResourcesKeywords vpc_id nextgroup=hclEquals,hclString skipwhite
syn keyword hclAwsResourcesKeywords iam_instance_profile image_id instance_type key_name name name_prefix security_groups user_data nextgroup=hclEquals,hclString skipwhite
syn keyword hclAwsResourcesKeywords name records ttl type zone_id nextgroup=hclEquals,hclString skipwhite
syn keyword hclAwsResourcesKeywords name nextgroup=hclEquals,hclString skipwhite
syn keyword hclAwsResourcesKeywords route_table_id subnet_id nextgroup=hclEquals,hclString skipwhite
syn keyword hclAwsResourcesKeywords cidr_block gateway_id instance_id route vpc_id nextgroup=hclEquals,hclString skipwhite
syn keyword hclAwsResourcesKeywords acl bucket nextgroup=hclEquals,hclString skipwhite
syn keyword hclAwsResourcesKeywords cidr_blocks description from_port ingress name owner_id protocol security_groups self tags to_port vpc_id nextgroup=hclEquals,hclString skipwhite
syn keyword hclAwsResourcesKeywords availability_zone- cidr_block map_public_ip_on_launch vpc_id nextgroup=hclEquals,hclString skipwhite
syn keyword hclAwsResourcesKeywords cidr_block enable_dns_hostnames enable_dns_support tags nextgroup=hclEquals,hclString skipwhite


hi def link hclComment                  Comment
hi def link hclEqual                    Operator
hi def link hclRootKeywords             Statement
hi def link hclAwsResourcesKeywords     Type
hi def link hclSmartString              String
hi def link hclInterpolation            String
hi def link hclSimpleString             PreProc

let b:current_syntax = "hcl"

endif
