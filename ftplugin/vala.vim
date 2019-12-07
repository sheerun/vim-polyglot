if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vala') == -1

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

setlocal efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m

" Insert a CCode attribute for the symbol below the cursor
" https://wiki.gnome.org/Projects/Vala/LegacyBindings
function! CCode() abort
  normal yiwO[CCode (cname = "pa")]
endfunction

" Set Vala Coding Style
" https://wiki.gnome.org/Projects/Vala/Hacking#Coding_Style
function! ValaCodingStyle() abort
  set ts=4 sts=4 sw=4 tw=0 wm=0
endfunction

command! -buffer -bar CCode call CCode()
command! -buffer -bar ValaCodingStyle call ValaCodingStyle()

if get(g:, 'vala_syntax_folding_enabled', 1)
  setlocal foldmethod=syntax
endif

endif
