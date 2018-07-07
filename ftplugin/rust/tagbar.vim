if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'rust') == -1
  
"
" Support for Tagbar -- https://github.com/majutsushi/tagbar
"
if !exists(':Tagbar')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

let g:tagbar_type_rust = {
            \ 'ctagstype' : 'rust',
            \ 'kinds' : [
            \'T:types',
            \'f:functions',
            \'g:enumerations',
            \'s:structures',
            \'m:modules',
            \'c:constants',
            \'t:traits',
            \'i:trait implementations',
            \ ]
            \ }

" In case you've updated/customized your ~/.ctags and prefer to use it.
if !get(g:, 'rust_use_custom_ctags_defs', 0)
    let g:tagbar_type_rust.deffile = expand('<sfile>:p:h:h:h') . '/ctags/rust.ctags'
endif

let &cpo = s:save_cpo
unlet s:save_cpo


" vim: set et sw=4 sts=4 ts=8:

endif
