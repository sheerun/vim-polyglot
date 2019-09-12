if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dockerfile') == -1

" Vim syntax file
" Language: Dockerfile
" Maintainer: Eugene Kalinin
" Latest Revision: 11 September 2013
" Source: https://docs.docker.com/compose/

if !exists('main_syntax')
    let main_syntax = 'yaml'
endif

" case sensitivity (fix #17)
" syn case  ignore

" Keywords
syn keyword dockercomposeKeywords build context dockerfile args cap_add cap_drop
syn keyword dockercomposeKeywords command cgroup_parent container_name devices depends_on
syn keyword dockercomposeKeywords dns dns_search tmpfs entrypoint env_file environment
syn keyword dockercomposeKeywords expose extends extends external_links extra_hosts
syn keyword dockercomposeKeywords group_add image isolation labels links
syn keyword dockercomposeKeywords log_opt net network_mode networks aliases
syn keyword dockercomposeKeywords ipv4_address ipv6_address link_local_ips pid ports
syn keyword dockercomposeKeywords security_opt stop_signal ulimits volumes volume_driver
syn keyword dockercomposeKeywords volumes_from cpu_shares cpu_quota cpuset domainname hostname
syn keyword dockercomposeKeywords ipc mac_address mem_limit memswap_limit oom_score_adj privileged
syn keyword dockercomposeKeywords read_only restart shm_size stdin_open tty user working_dir
syn keyword dockercomposeKeywords healthcheck test interval timeout retries disable sysctls
syn keyword dockercomposeKeywords userns_mode secrets
"" Volume configuration reference
syn keyword dockercomposeKeywords driver driver_opts external labels
"" Network configuration reference
syn keyword dockercomposeKeywords driver driver_opts enable_ipv6 ipam internal labels external
"" Versioning
syn keyword dockercomposeKeywords version services
"" Logging
syn keyword dockercomposeKeywords logging log_driver env options max-size max-file
syn keyword dockercomposeKeywords syslog-address syslog-facility syslog-tls-ca-cert syslog-tls-cert
syn keyword dockercomposeKeywords syslog-tls-key syslog-tls-skip tag syslog-format gelf-address
syn keyword dockercomposeKeywords gelf-compression-type gelf-compression-level fluentd-address
syn keyword dockercomposeKeywords fluentd-buffer-limit fluentd-retry-wait fluentd-max-retries
syn keyword dockercomposeKeywords fluentd-async-connect awslogs-region awslogs-group awslogs-stream
syn keyword dockercomposeKeywords splunk-token splunk-url splunk-source splunk-sourcetype splunk-index
syn keyword dockercomposeKeywords splunk-capath splunk-caname splunk-insecureskipverify gcp-project log-cmd

" Bash statements
setlocal iskeyword+=-
syn keyword bashStatement add-apt-repository adduser apk apt-get aptitude apt-key autoconf bundle
syn keyword bashStatement cd chgrp chmod chown clear complete composer cp curl du echo egrep
syn keyword bashStatement expr fgrep find gem gnufind gnugrep gpg grep groupadd head less ln
syn keyword bashStatement ls make mkdir mv node npm pacman pip pip3 php python rails rm rmdir rpm ruby
syn keyword bashStatement sed sleep sort strip tar tail tailf touch useradd virtualenv yum
syn keyword bashStatement usermod bash cat a2ensite a2dissite a2enmod a2dismod apache2ctl
syn keyword bashStatement wget gzip

" Strings
syn region dockercomposeString start=/"/ skip=/\\"/ end=/"/
syn region dockercomposeString1 start=/'/ skip=/\\'/ end=/'/

" Emails
syn region dockercomposeEmail start=/</ end=/>/ contains=@ oneline

" Urls
syn match dockercomposeUrl /\(http\|https\|ssh\|hg\|git\)\:\/\/[a-zA-Z0-9\/\-\.]\+/

" Task tags
syn keyword dockercomposeTodo contained TODO FIXME XXX

" Comments
syn region dockercomposeComment start="#" end="\n" contains=dockercomposeTodo

" Highlighting
hi link dockercomposeKeywords  Keyword
hi link dockercomposeString    String
hi link dockercomposeString1   String
hi link dockercomposeComment   Comment
hi link dockercomposeEmail     Identifier
hi link dockercomposeUrl       Identifier
hi link dockercomposeTodo      Todo
hi link bashStatement       Function

let b:current_syntax = "dockercompose"

endif
