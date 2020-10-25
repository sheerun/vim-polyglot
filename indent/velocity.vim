if has_key(g:polyglot_is_disabled, 'velocity')
  finish
endif

if exists("b:did_indent")
    finish
endif

runtime! indent/html.vim
