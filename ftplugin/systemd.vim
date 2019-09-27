if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'systemd') == -1

" Vim filetype plugin file
" Language:             systemd unit files
" Previous Maintainer:  Will Woods <wwoods@redhat.com>
" Latest Revision:      Sep 25, 2019

" These are, as it turns out, exactly the same settings as ftplugin/conf.vim

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

let b:undo_ftplugin = "setl com< cms< fo<"

setlocal comments=:# commentstring=#\ %s formatoptions-=t formatoptions+=croql

let &cpo = s:cpo_save
unlet s:cpo_save


endif
