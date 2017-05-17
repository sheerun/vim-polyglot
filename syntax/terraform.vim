if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'terraform') == -1
  
" Forked from Larry Gilbert's syntax file
" github.com/L2G/vim-syntax-terraform

if exists("b:current_syntax")
  finish
endif

syn case match

syn keyword terraSection connection output provider variable data terraform
syn keyword terraValueBool true false on off yes no

""" data
syn keyword terraDataTypeBI
          \ alicloud_images
          \ alicloud_instance_types
          \ alicloud_regions
          \ alicloud_zones
          \ archive_file
          \ atlas_artifact
          \ aws_acm_certificate
          \ aws_alb
          \ aws_alb_listener
          \ aws_ami
          \ aws_autoscaling_groups
          \ aws_availability_zone
          \ aws_availability_zones
          \ aws_billing_service_account
          \ aws_caller_identity
          \ aws_canonical_user_id
          \ aws_cloudformation_stack
          \ aws_db_instance
          \ aws_ebs_snapshot
          \ aws_ebs_volume
          \ aws_ecs_cluster
          \ aws_ecs_container_definition
          \ aws_ecs_task_definition
          \ aws_eip
          \ aws_elb_hosted_zone_id
          \ aws_elb_service_account
          \ aws_iam_account_alias
          \ aws_iam_policy_document
          \ aws_iam_role
          \ aws_iam_server_certificate
          \ aws_instance
          \ aws_ip_ranges
          \ aws_kms_secret
          \ aws_partition
          \ aws_prefix_list
          \ aws_redshift_service_account
          \ aws_region
          \ aws_route53_zone
          \ aws_route_table
          \ aws_s3_bucket_object
          \ aws_security_group
          \ aws_sns_topic
          \ aws_subnet
          \ aws_subnet_ids
          \ aws_vpc
          \ aws_vpc_endpoint
          \ aws_vpc_endpoint_service
          \ aws_vpc_peering_connection
          \ aws_vpn_gateway
          \ azurerm_client_config
          \ circonus_account
          \ circonus_collector
          \ consul_agent_self
          \ consul_catalog_nodes
          \ consul_catalog_service
          \ consul_catalog_services
          \ consul_keys
          \ dns_a_record_set
          \ dns_cname_record_set
          \ dns_txt_record_set
          \ docker_registry_image
          \ external
          \ fastly_ip_ranges
          \ google_compute_zones
          \ google_iam_policy
          \ newrelic_application
          \ ns1_datasource
          \ null_data_source
          \ openstack_images_image_v2
          \ openstack_networking_network_v2
          \ opsgenie_user
          \ pagerduty_escalation_policy
          \ pagerduty_schedule
          \ pagerduty_user
          \ pagerduty_vendor
          \ profitbricks_datacenter
          \ profitbricks_image
          \ profitbricks_location
          \ scaleway_bootscript
          \ scaleway_image
          \ template_cloudinit_config
          \ template_file
          \ terraform_remote_state
""" end data sources

""" resource
syn keyword terraResourceTypeBI
          \ alicloud_db_instance
          \ alicloud_disk
          \ alicloud_disk_attachment
          \ alicloud_eip
          \ alicloud_eip_association
          \ alicloud_instance
          \ alicloud_nat_gateway
          \ alicloud_route_entry
          \ alicloud_security_group
          \ alicloud_security_group_rule
          \ alicloud_slb
          \ alicloud_slb_attachment
          \ alicloud_subnet
          \ alicloud_vpc
          \ alicloud_vswitch
          \ arukas_container
          \ atlas_artifact
          \ aws_alb
          \ aws_alb_listener
          \ aws_alb_listener_rule
          \ aws_alb_target_group
          \ aws_alb_target_group_attachment
          \ aws_ami
          \ aws_ami_copy
          \ aws_ami_from_instance
          \ aws_ami_launch_permission
          \ aws_api_gateway_account
          \ aws_api_gateway_api_key
          \ aws_api_gateway_authorizer
          \ aws_api_gateway_base_path_mapping
          \ aws_api_gateway_client_certificate
          \ aws_api_gateway_deployment
          \ aws_api_gateway_domain_name
          \ aws_api_gateway_integration
          \ aws_api_gateway_integration_response
          \ aws_api_gateway_method
          \ aws_api_gateway_method_response
          \ aws_api_gateway_method_settings
          \ aws_api_gateway_model
          \ aws_api_gateway_resource
          \ aws_api_gateway_rest_api
          \ aws_api_gateway_stage
          \ aws_api_gateway_usage_plan
          \ aws_api_gateway_usage_plan_key
          \ aws_app_cookie_stickiness_policy
          \ aws_appautoscaling_policy
          \ aws_appautoscaling_target
          \ aws_autoscaling_attachment
          \ aws_autoscaling_group
          \ aws_autoscaling_lifecycle_hook
          \ aws_autoscaling_notification
          \ aws_autoscaling_policy
          \ aws_autoscaling_schedule
          \ aws_cloudformation_stack
          \ aws_cloudfront_distribution
          \ aws_cloudfront_origin_access_identity
          \ aws_cloudtrail
          \ aws_cloudwatch_event_rule
          \ aws_cloudwatch_event_target
          \ aws_cloudwatch_log_destination
          \ aws_cloudwatch_log_destination_policy
          \ aws_cloudwatch_log_group
          \ aws_cloudwatch_log_metric_filter
          \ aws_cloudwatch_log_stream
          \ aws_cloudwatch_log_subscription_filter
          \ aws_cloudwatch_metric_alarm
          \ aws_codebuild_project
          \ aws_codecommit_repository
          \ aws_codecommit_trigger
          \ aws_codedeploy_app
          \ aws_codedeploy_deployment_config
          \ aws_codedeploy_deployment_group
          \ aws_codepipeline
          \ aws_config_config_rule
          \ aws_config_configuration_recorder
          \ aws_config_configuration_recorder_status
          \ aws_config_delivery_channel
          \ aws_customer_gateway
          \ aws_db_event_subscription
          \ aws_db_instance
          \ aws_db_option_group
          \ aws_db_parameter_group
          \ aws_db_security_group
          \ aws_db_subnet_group
          \ aws_default_network_acl
          \ aws_default_route_table
          \ aws_default_security_group
          \ aws_directory_service_directory
          \ aws_dms_certificate
          \ aws_dms_endpoint
          \ aws_dms_replication_instance
          \ aws_dms_replication_subnet_group
          \ aws_dms_replication_task
          \ aws_dynamodb_table
          \ aws_ebs_snapshot
          \ aws_ebs_volume
          \ aws_ecr_repository
          \ aws_ecr_repository_policy
          \ aws_ecs_cluster
          \ aws_ecs_service
          \ aws_ecs_task_definition
          \ aws_efs_file_system
          \ aws_efs_mount_target
          \ aws_egress_only_internet_gateway
          \ aws_eip
          \ aws_eip_association
          \ aws_elastic_beanstalk_application
          \ aws_elastic_beanstalk_application_version
          \ aws_elastic_beanstalk_configuration_template
          \ aws_elastic_beanstalk_environment
          \ aws_elasticache_cluster
          \ aws_elasticache_parameter_group
          \ aws_elasticache_replication_group
          \ aws_elasticache_security_group
          \ aws_elasticache_subnet_group
          \ aws_elasticsearch_domain
          \ aws_elasticsearch_domain_policy
          \ aws_elastictranscoder_pipeline
          \ aws_elastictranscoder_preset
          \ aws_elb
          \ aws_elb_attachment
          \ aws_emr_cluster
          \ aws_emr_instance_group
          \ aws_flow_log
          \ aws_glacier_vault
          \ aws_iam_access_key
          \ aws_iam_account_alias
          \ aws_iam_account_password_policy
          \ aws_iam_group
          \ aws_iam_group_membership
          \ aws_iam_group_policy
          \ aws_iam_group_policy_attachment
          \ aws_iam_instance_profile
          \ aws_iam_openid_connect_provider
          \ aws_iam_policy
          \ aws_iam_policy_attachment
          \ aws_iam_role
          \ aws_iam_role_policy
          \ aws_iam_role_policy_attachment
          \ aws_iam_saml_provider
          \ aws_iam_server_certificate
          \ aws_iam_user
          \ aws_iam_user_login_profile
          \ aws_iam_user_policy
          \ aws_iam_user_policy_attachment
          \ aws_iam_user_ssh_key
          \ aws_inspector_assessment_target
          \ aws_inspector_assessment_template
          \ aws_inspector_resource_group
          \ aws_instance
          \ aws_internet_gateway
          \ aws_key_pair
          \ aws_kinesis_firehose_delivery_stream
          \ aws_kinesis_stream
          \ aws_kms_alias
          \ aws_kms_key
          \ aws_lambda_alias
          \ aws_lambda_event_source_mapping
          \ aws_lambda_function
          \ aws_lambda_permission
          \ aws_launch_configuration
          \ aws_lb_cookie_stickiness_policy
          \ aws_lb_ssl_negotiation_policy
          \ aws_lightsail_domain
          \ aws_lightsail_instance
          \ aws_lightsail_key_pair
          \ aws_lightsail_static_ip
          \ aws_lightsail_static_ip_attachment
          \ aws_load_balancer_backend_server_policy
          \ aws_load_balancer_listener_policy
          \ aws_load_balancer_policy
          \ aws_main_route_table_association
          \ aws_nat_gateway
          \ aws_network_acl
          \ aws_network_acl_rule
          \ aws_network_interface
          \ aws_opsworks_application
          \ aws_opsworks_custom_layer
          \ aws_opsworks_ganglia_layer
          \ aws_opsworks_haproxy_layer
          \ aws_opsworks_instance
          \ aws_opsworks_java_app_layer
          \ aws_opsworks_memcached_layer
          \ aws_opsworks_mysql_layer
          \ aws_opsworks_nodejs_app_layer
          \ aws_opsworks_permission
          \ aws_opsworks_php_app_layer
          \ aws_opsworks_rails_app_layer
          \ aws_opsworks_rds_db_instance
          \ aws_opsworks_stack
          \ aws_opsworks_static_web_layer
          \ aws_opsworks_user_profile
          \ aws_placement_group
          \ aws_proxy_protocol_policy
          \ aws_rds_cluster
          \ aws_rds_cluster_instance
          \ aws_rds_cluster_parameter_group
          \ aws_redshift_cluster
          \ aws_redshift_parameter_group
          \ aws_redshift_security_group
          \ aws_redshift_subnet_group
          \ aws_route
          \ aws_route53_delegation_set
          \ aws_route53_health_check
          \ aws_route53_record
          \ aws_route53_zone
          \ aws_route53_zone_association
          \ aws_route_table
          \ aws_route_table_association
          \ aws_s3_bucket
          \ aws_s3_bucket_notification
          \ aws_s3_bucket_object
          \ aws_s3_bucket_policy
          \ aws_security_group
          \ aws_security_group_rule
          \ aws_ses_active_receipt_rule_set
          \ aws_ses_configuration_set
          \ aws_ses_domain_identity
          \ aws_ses_event_destination
          \ aws_ses_receipt_filter
          \ aws_ses_receipt_rule
          \ aws_ses_receipt_rule_set
          \ aws_sfn_activity
          \ aws_sfn_state_machine
          \ aws_simpledb_domain
          \ aws_snapshot_create_volume_permission
          \ aws_sns_topic
          \ aws_sns_topic_policy
          \ aws_sns_topic_subscription
          \ aws_spot_datafeed_subscription
          \ aws_spot_fleet_request
          \ aws_spot_instance_request
          \ aws_sqs_queue
          \ aws_sqs_queue_policy
          \ aws_ssm_activation
          \ aws_ssm_association
          \ aws_ssm_document
          \ aws_subnet
          \ aws_volume_attachment
          \ aws_vpc
          \ aws_vpc_dhcp_options
          \ aws_vpc_dhcp_options_association
          \ aws_vpc_endpoint
          \ aws_vpc_endpoint_route_table_association
          \ aws_vpc_peering_connection
          \ aws_vpc_peering_connection_accepter
          \ aws_vpn_connection
          \ aws_vpn_connection_route
          \ aws_vpn_gateway
          \ aws_vpn_gateway_attachment
          \ aws_waf_byte_match_set
          \ aws_waf_ipset
          \ aws_waf_rule
          \ aws_waf_size_constraint_set
          \ aws_waf_sql_injection_match_set
          \ aws_waf_web_acl
          \ aws_waf_xss_match_set
          \ azure_affinity_group
          \ azure_data_disk
          \ azure_dns_server
          \ azure_hosted_service
          \ azure_instance
          \ azure_local_network_connection
          \ azure_security_group
          \ azure_security_group_rule
          \ azure_sql_database_server
          \ azure_sql_database_server_firewall_rule
          \ azure_sql_database_service
          \ azure_storage_blob
          \ azure_storage_container
          \ azure_storage_queue
          \ azure_storage_service
          \ azure_virtual_network
          \ azurerm_availability_set
          \ azurerm_cdn_endpoint
          \ azurerm_cdn_profile
          \ azurerm_container_registry
          \ azurerm_container_service
          \ azurerm_dns_a_record
          \ azurerm_dns_aaaa_record
          \ azurerm_dns_cname_record
          \ azurerm_dns_mx_record
          \ azurerm_dns_ns_record
          \ azurerm_dns_srv_record
          \ azurerm_dns_txt_record
          \ azurerm_dns_zone
          \ azurerm_eventhub
          \ azurerm_eventhub_authorization_rule
          \ azurerm_eventhub_consumer_group
          \ azurerm_eventhub_namespace
          \ azurerm_key_vault
          \ azurerm_lb
          \ azurerm_lb_backend_address_pool
          \ azurerm_lb_nat_pool
          \ azurerm_lb_nat_rule
          \ azurerm_lb_probe
          \ azurerm_lb_rule
          \ azurerm_local_network_gateway
          \ azurerm_managed_disk
          \ azurerm_network_interface
          \ azurerm_network_security_group
          \ azurerm_network_security_rule
          \ azurerm_public_ip
          \ azurerm_redis_cache
          \ azurerm_resource_group
          \ azurerm_route
          \ azurerm_route_table
          \ azurerm_search_service
          \ azurerm_servicebus_namespace
          \ azurerm_servicebus_subscription
          \ azurerm_servicebus_topic
          \ azurerm_sql_database
          \ azurerm_sql_firewall_rule
          \ azurerm_sql_server
          \ azurerm_storage_account
          \ azurerm_storage_blob
          \ azurerm_storage_container
          \ azurerm_storage_queue
          \ azurerm_storage_share
          \ azurerm_storage_table
          \ azurerm_subnet
          \ azurerm_template_deployment
          \ azurerm_traffic_manager_endpoint
          \ azurerm_traffic_manager_profile
          \ azurerm_virtual_machine
          \ azurerm_virtual_machine_extension
          \ azurerm_virtual_machine_scale_set
          \ azurerm_virtual_network
          \ azurerm_virtual_network_peering
          \ bitbucket_default_reviewers
          \ bitbucket_hook
          \ bitbucket_repository
          \ chef_acl
          \ chef_client
          \ chef_cookbook
          \ chef_data_bag
          \ chef_data_bag_item
          \ chef_environment
          \ chef_node
          \ chef_role
          \ circonus_check
          \ circonus_contact_group
          \ circonus_graph
          \ circonus_metric
          \ circonus_metric_cluster
          \ circonus_rule_set
          \ clc_group
          \ clc_load_balancer
          \ clc_load_balancer_pool
          \ clc_public_ip
          \ clc_server
          \ cloudflare_record
          \ cloudstack_affinity_group
          \ cloudstack_disk
          \ cloudstack_egress_firewall
          \ cloudstack_firewall
          \ cloudstack_instance
          \ cloudstack_ipaddress
          \ cloudstack_loadbalancer_rule
          \ cloudstack_network
          \ cloudstack_network_acl
          \ cloudstack_network_acl_rule
          \ cloudstack_nic
          \ cloudstack_port_forward
          \ cloudstack_private_gateway
          \ cloudstack_secondary_ipaddress
          \ cloudstack_security_group
          \ cloudstack_security_group_rule
          \ cloudstack_ssh_keypair
          \ cloudstack_static_nat
          \ cloudstack_static_route
          \ cloudstack_template
          \ cloudstack_vpc
          \ cloudstack_vpn_connection
          \ cloudstack_vpn_customer_gateway
          \ cloudstack_vpn_gateway
          \ cobbler_distro
          \ cobbler_kickstart_file
          \ cobbler_profile
          \ cobbler_snippet
          \ cobbler_system
          \ consul_agent_service
          \ consul_catalog_entry
          \ consul_key_prefix
          \ consul_keys
          \ consul_node
          \ consul_prepared_query
          \ consul_service
          \ datadog_downtime
          \ datadog_monitor
          \ datadog_timeboard
          \ datadog_user
          \ digitalocean_domain
          \ digitalocean_droplet
          \ digitalocean_floating_ip
          \ digitalocean_loadbalancer
          \ digitalocean_record
          \ digitalocean_ssh_key
          \ digitalocean_tag
          \ digitalocean_volume
          \ dme_record
          \ dns_a_record_set
          \ dns_aaaa_record_set
          \ dns_cname_record
          \ dns_ptr_record
          \ dnsimple_record
          \ docker_container
          \ docker_image
          \ docker_network
          \ docker_volume
          \ dyn_record
          \ fastly_service_v1
          \ github_issue_label
          \ github_membership
          \ github_organization_webhook
          \ github_repository
          \ github_repository_collaborator
          \ github_repository_webhook
          \ github_team
          \ github_team_membership
          \ github_team_repository
          \ google_compute_address
          \ google_compute_autoscaler
          \ google_compute_backend_service
          \ google_compute_disk
          \ google_compute_firewall
          \ google_compute_forwarding_rule
          \ google_compute_global_address
          \ google_compute_global_forwarding_rule
          \ google_compute_health_check
          \ google_compute_http_health_check
          \ google_compute_https_health_check
          \ google_compute_image
          \ google_compute_instance
          \ google_compute_instance_group
          \ google_compute_instance_group_manager
          \ google_compute_instance_template
          \ google_compute_network
          \ google_compute_project_metadata
          \ google_compute_region_backend_service
          \ google_compute_route
          \ google_compute_ssl_certificate
          \ google_compute_subnetwork
          \ google_compute_target_http_proxy
          \ google_compute_target_https_proxy
          \ google_compute_target_pool
          \ google_compute_url_map
          \ google_compute_vpn_gateway
          \ google_compute_vpn_tunnel
          \ google_container_cluster
          \ google_container_node_pool
          \ google_dns_managed_zone
          \ google_dns_record_set
          \ google_project
          \ google_project_iam_policy
          \ google_project_services
          \ google_pubsub_subscription
          \ google_pubsub_topic
          \ google_service_account
          \ google_sql_database
          \ google_sql_database_instance
          \ google_sql_user
          \ google_storage_bucket
          \ google_storage_bucket_acl
          \ google_storage_bucket_object
          \ google_storage_object_acl
          \ heroku_addon
          \ heroku_app
          \ heroku_cert
          \ heroku_domain
          \ heroku_drain
          \ icinga2_checkcommand
          \ icinga2_host
          \ icinga2_hostgroup
          \ icinga2_service
          \ ignition_config
          \ ignition_disk
          \ ignition_file
          \ ignition_filesystem
          \ ignition_group
          \ ignition_networkd_unit
          \ ignition_raid
          \ ignition_systemd_unit
          \ ignition_user
          \ influxdb_continuous_query
          \ influxdb_database
          \ influxdb_user
          \ kubernetes_config_map
          \ kubernetes_namespace
          \ kubernetes_persistent_volume
          \ kubernetes_persistent_volume_claim
          \ kubernetes_secret
          \ librato_alert
          \ librato_service
          \ librato_space
          \ librato_space_chart
          \ logentries_log
          \ logentries_logset
          \ mailgun_domain
          \ mysql_database
          \ mysql_grant
          \ mysql_user
          \ newrelic_alert_channel
          \ newrelic_alert_condition
          \ newrelic_alert_policy
          \ newrelic_alert_policy_channel
          \ nomad_job
          \ null_resource
          \ openstack_blockstorage_volume_attach_v2
          \ openstack_blockstorage_volume_v1
          \ openstack_blockstorage_volume_v2
          \ openstack_compute_floatingip_associate_v2
          \ openstack_compute_floatingip_v2
          \ openstack_compute_instance_v2
          \ openstack_compute_keypair_v2
          \ openstack_compute_secgroup_v2
          \ openstack_compute_servergroup_v2
          \ openstack_compute_volume_attach_v2
          \ openstack_fw_firewall_v1
          \ openstack_fw_policy_v1
          \ openstack_fw_rule_v1
          \ openstack_images_image_v2
          \ openstack_lb_listener_v2
          \ openstack_lb_loadbalancer_v2
          \ openstack_lb_member_v1
          \ openstack_lb_member_v2
          \ openstack_lb_monitor_v1
          \ openstack_lb_monitor_v2
          \ openstack_lb_pool_v1
          \ openstack_lb_pool_v2
          \ openstack_lb_vip_v1
          \ openstack_networking_floatingip_v2
          \ openstack_networking_network_v2
          \ openstack_networking_port_v2
          \ openstack_networking_router_interface_v2
          \ openstack_networking_router_route_v2
          \ openstack_networking_router_v2
          \ openstack_networking_secgroup_rule_v2
          \ openstack_networking_secgroup_v2
          \ openstack_networking_subnet_v2
          \ openstack_objectstorage_container_v1
          \ opsgenie_team
          \ opsgenie_user
          \ packet_device
          \ packet_project
          \ packet_ssh_key
          \ packet_volume
          \ pagerduty_addon
          \ pagerduty_escalation_policy
          \ pagerduty_schedule
          \ pagerduty_service
          \ pagerduty_service_integration
          \ pagerduty_team
          \ pagerduty_user
          \ postgresql_database
          \ postgresql_extension
          \ postgresql_role
          \ postgresql_schema
          \ powerdns_record
          \ profitbricks_datacenter
          \ profitbricks_firewall
          \ profitbricks_ipblock
          \ profitbricks_lan
          \ profitbricks_loadbalancer
          \ profitbricks_nic
          \ profitbricks_server
          \ profitbricks_volume
          \ rabbitmq_binding
          \ rabbitmq_exchange
          \ rabbitmq_permissions
          \ rabbitmq_policy
          \ rabbitmq_queue
          \ rabbitmq_user
          \ rabbitmq_vhost
          \ rancher_certificate
          \ rancher_environment
          \ rancher_host
          \ rancher_registration_token
          \ rancher_registry
          \ rancher_registry_credential
          \ rancher_stack
          \ random_id
          \ random_pet
          \ random_shuffle
          \ rundeck_job
          \ rundeck_private_key
          \ rundeck_project
          \ rundeck_public_key
          \ scaleway_ip
          \ scaleway_security_group
          \ scaleway_security_group_rule
          \ scaleway_server
          \ scaleway_volume
          \ scaleway_volume_attachment
          \ softlayer_ssh_key
          \ softlayer_virtual_guest
          \ spotinst_aws_group
          \ spotinst_healthcheck
          \ spotinst_subscription
          \ statuscake_test
          \ tls_cert_request
          \ tls_locally_signed_cert
          \ tls_private_key
          \ tls_self_signed_cert
          \ triton_fabric
          \ triton_firewall_rule
          \ triton_key
          \ triton_machine
          \ triton_vlan
          \ ultradns_dirpool
          \ ultradns_probe_http
          \ ultradns_probe_ping
          \ ultradns_record
          \ ultradns_tcpool
          \ vcd_dnat
          \ vcd_firewall_rules
          \ vcd_network
          \ vcd_snat
          \ vcd_vapp
          \ vsphere_file
          \ vsphere_folder
          \ vsphere_virtual_disk
          \ vsphere_virtual_machine
""" end resources

syn keyword terraTodo         contained TODO FIXME XXX BUG
syn cluster terraCommentGroup contains=terraTodo
syn region  terraComment      start="/\*" end="\*/" contains=@terraCommentGroup,@Spell
syn region  terraComment      start="#" end="$" contains=@terraCommentGroup,@Spell
syn region  terraComment      start="//" end="$" contains=@terraCommentGroup,@Spell

syn match  terraResource        /\<resource\>/ nextgroup=terraResourceTypeStr skipwhite
syn region terraResourceTypeStr start=/"/ end=/"/ contains=terraResourceTypeBI
                              \ nextgroup=terraResourceName skipwhite
syn region terraResourceName    start=/"/ end=/"/
                              \ nextgroup=terraResourceBlock skipwhite

syn match  terraData        /\<data\>/ nextgroup=terraDataTypeStr skipwhite
syn region terraDataTypeStr start=/"/ end=/"/ contains=terraDataTypeBI
                              \ nextgroup=terraDataName skipwhite
syn region terraDataName    start=/"/ end=/"/
                              \ nextgroup=terraDataBlock skipwhite

""" provider
syn match  terraProvider      /\<provider\>/ nextgroup=terraProviderName skipwhite
syn region terraProviderName  start=/"/ end=/"/ nextgroup=terraProviderBlock skipwhite

""" provisioner
syn match  terraProvisioner     /\<provisioner\>/ nextgroup=terraProvisionerName skipwhite
syn region terraProvisionerName start=/"/ end=/"/ nextgroup=terraProvisionerBlock skipwhite

""" module
syn match  terraModule     /\<module\>/ nextgroup=terraModuleName skipwhite
syn region terraModuleName start=/"/ end=/"/ nextgroup=terraModuleBlock skipwhite

""" misc.
syn match terraValueDec      "\<[0-9]\+\([kKmMgG]b\?\)\?\>"
syn match terraValueHexaDec  "\<0x[0-9a-f]\+\([kKmMgG]b\?\)\?\>"
syn match terraBraces        "[{}\[\]]"

""" skip \" in strings.
""" we may also want to pass \\" into a function to escape quotes.
syn region terraValueString   start=/"/ skip=/\\\+"/ end=/"/ contains=terraStringInterp
syn region terraStringInterp  matchgroup=terraBrackets start=/\${/ end=/}/ contains=terraValueFunction contained
"" TODO match keywords here, not a-z+
syn region terraValueFunction matchgroup=terraBrackets start=/[0-9a-z]\+(/ end=/)/ contains=terraValueString,terraValueFunction contained

hi def link terraComment           Comment
hi def link terraTodo              Todo
hi def link terraBrackets          Operator
hi def link terraProvider          Structure
hi def link terraBraces            Delimiter
hi def link terraProviderName      String
hi def link terraResource          Structure
hi def link terraResourceName      String
hi def link terraResourceTypeBI    Tag
hi def link terraResourceTypeStr   String
hi def link terraData              Structure
hi def link terraDataName          String
hi def link terraDataTypeBI        Tag
hi def link terraDataTypeStr       String
hi def link terraSection           Structure
hi def link terraStringInterp      Identifier
hi def link terraValueBool         Boolean
hi def link terraValueDec          Number
hi def link terraValueHexaDec      Number
hi def link terraValueString       String
hi def link terraProvisioner       Structure
hi def link terraProvisionerName   String
hi def link terraModule            Structure
hi def link terraModuleName        String
hi def link terraValueFunction     Identifier

let b:current_syntax = "terraform"

endif
