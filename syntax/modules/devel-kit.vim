if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Nginx Development Kit <https://github.com/simpl/ngx_devel_kit>
" The NDK is an Nginx module that is designed to extend the core functionality of the excellent Nginx webserver in a way that can be used as a basis of other Nginx modules.
" NDK_UPSTREAM_LIST
" This submodule provides a directive that creates a list of upstreams, with optional weighting. This list can then be used by other modules to hash over the upstreams however they choose.
syn keyword ngxDirectiveThirdParty upstream_list


endif
