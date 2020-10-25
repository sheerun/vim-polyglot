if has_key(g:polyglot_is_disabled, 'ansible')
  finish
endif

set isfname+=@-@
set path+=./../templates,./../files,templates,files
