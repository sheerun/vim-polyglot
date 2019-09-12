if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'tomdoc') == -1

syn keyword tomdocKeywords
      \ Returns Yields Raises Examples Signature
      \ containedin=.*Comment
      \ contained

syn match tomdocDescriptions
      \ +\s*\(Public\|Internal\|Deprecated\):+he=e-1
      \ containedin=.*Comment
      \ contained

syn match tomdocArguments
      \ +\s*[A-Za-z0-9_\-&\*:]*\(\s*- \)+he=e-3
      \ containedin=.*Comment
      \ contained

hi default link tomdocDescriptions String
hi default link tomdocKeywords String
hi default link tomdocArguments HELP

endif
