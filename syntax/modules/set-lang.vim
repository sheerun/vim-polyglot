if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Set Lang Module <https://github.com/simpl/ngx_http_set_lang>
" Provides a variety of ways for setting a variable denoting the langauge that content should be returned in.
syn keyword ngxDirectiveThirdParty set_lang
syn keyword ngxDirectiveThirdParty set_lang_method
syn keyword ngxDirectiveThirdParty lang_cookie
syn keyword ngxDirectiveThirdParty lang_get_var
syn keyword ngxDirectiveThirdParty lang_list
syn keyword ngxDirectiveThirdParty lang_post_var
syn keyword ngxDirectiveThirdParty lang_host
syn keyword ngxDirectiveThirdParty lang_referer


endif
