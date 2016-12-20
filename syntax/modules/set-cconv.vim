if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Set cconv Module <https://github.com/liseen/set-cconv-nginx-module>
" Cconv rewrite set commands
syn keyword ngxDirectiveThirdParty set_cconv_to_simp
syn keyword ngxDirectiveThirdParty set_cconv_to_trad
syn keyword ngxDirectiveThirdParty set_pinyin_to_normal


endif
