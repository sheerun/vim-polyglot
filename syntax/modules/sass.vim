if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Syntactically Awesome Module <https://github.com/mneudert/sass-nginx-module>
" Providing on-the-fly compiling of Sass files as an NGINX module.
syn keyword ngxDirectiveThirdParty sass_compile
syn keyword ngxDirectiveThirdParty sass_error_log
syn keyword ngxDirectiveThirdParty sass_include_path
syn keyword ngxDirectiveThirdParty sass_indent
syn keyword ngxDirectiveThirdParty sass_is_indented_syntax
syn keyword ngxDirectiveThirdParty sass_linefeed
syn keyword ngxDirectiveThirdParty sass_precision
syn keyword ngxDirectiveThirdParty sass_output_style
syn keyword ngxDirectiveThirdParty sass_source_comments
syn keyword ngxDirectiveThirdParty sass_source_map_embed


endif
