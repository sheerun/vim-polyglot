if polyglot#init#is_disabled(expand('<sfile>:p'), 'ansible', 'ftplugin/ansible.vim')
  finish
endif

set isfname+=@-@
set path+=./../templates,./../files,templates,files
