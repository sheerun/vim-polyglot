let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/ansible_hosts.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ansible') == -1

" Vim syntax file
" Language: Ansible hosts files
" Maintainer: Dave Honneffer <pearofducks@gmail.com>
" Last Change: 2015.09.23

if exists("b:current_syntax")
  finish
endif

syn case ignore
syn match hostsFirstWord      "\v^\S+"
syn match hostsAttributes     "\v\S*\="
syn region hostsHeader        start="\v^\s*\[" end="\v\]"
syn keyword hostsHeaderSpecials children vars containedin=hostsHeader contained
syn match  hostsComment       "\v^[#;].*$"

highlight default link hostsFirstWord        Label
highlight default link hostsHeader           Define
highlight default link hostsComment          Comment
highlight default link hostsHeaderSpecials   Identifier
highlight default link hostsAttributes       Structure

if exists("g:ansible_attribute_highlight")
  if g:ansible_attribute_highlight =~ 'n'
    highlight link hostsAttributes NONE
  elseif g:ansible_attribute_highlight =~ 'd'
    highlight link hostsAttributes Comment
  endif
endif

let b:current_syntax = "ansible_hosts"

endif
