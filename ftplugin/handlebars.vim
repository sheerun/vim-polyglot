" Taken from https://github.com/juvenn/mustache.vim/blob/master/ftplugin/mustache.vim

let s:cpo_save = &cpo
set cpo&vim

" Matchit support for Handlebars
" extending HTML matchit groups
if exists("loaded_matchit") && exists("b:match_words")
  let b:match_words = b:match_words
  \ . ',{:},[:],(:),'
  \ . '\%({{\)\@<=#\s*\%(if\|unless\)\s*.\{-}}}'
  \ . ':'
  \ . '\%({{\)\@<=\s*else\s*}}'
  \ . ':'
  \ . '\%({{\)\@<=/\s*\%(if\|unless\)\s*}},'
  \ . '\%({{\)\@<=[#^]\s*\([-0-9a-zA-Z_?!/.]\+\).\{-}}}'
  \ . ':'
  \ . '\%({{\)\@<=/\s*\1\s*}}'
endif

let &cpo = s:cpo_save
unlet s:cpo_save
