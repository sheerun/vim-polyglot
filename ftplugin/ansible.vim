let files = filter(globpath(&rtp, 'ftplugin/ansible.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ansible') == -1

set isfname+=@-@
set path+=./../templates,./../files,templates,files

endif
