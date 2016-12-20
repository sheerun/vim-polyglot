if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Phusion Passenger <https://www.phusionpassenger.com/>
" Easy and robust deployment of Ruby on Rails application on Apache and Nginx webservers.
syn keyword ngxDirectiveThirdParty passenger_base_uri
syn keyword ngxDirectiveThirdParty passenger_default_user
syn keyword ngxDirectiveThirdParty passenger_enabled
syn keyword ngxDirectiveThirdParty passenger_log_level
syn keyword ngxDirectiveThirdParty passenger_max_instances_per_app
syn keyword ngxDirectiveThirdParty passenger_max_pool_size
syn keyword ngxDirectiveThirdParty passenger_pool_idle_time
syn keyword ngxDirectiveThirdParty passenger_root
syn keyword ngxDirectiveThirdParty passenger_ruby
syn keyword ngxDirectiveThirdParty passenger_use_global_queue
syn keyword ngxDirectiveThirdParty passenger_user_switching
syn keyword ngxDirectiveThirdParty rack_env
syn keyword ngxDirectiveThirdParty rails_app_spawner_idle_time
syn keyword ngxDirectiveThirdParty rails_env
syn keyword ngxDirectiveThirdParty rails_framework_spawner_idle_time
syn keyword ngxDirectiveThirdParty rails_spawn_method


endif
