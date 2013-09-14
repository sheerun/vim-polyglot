" This file describes a very basic syntax for TomDoc comments in a Ruby file.
"
" For more information on TomDoc, check it out here: http://tomdoc.org/
"

syn keyword tomdocKeywords Returns containedin=rubyComment contained
syn keyword tomdocKeywords Yields containedin=rubyComment contained
syn keyword tomdocKeywords Raises containedin=rubyComment contained
syn keyword tomdocKeywords Examples containedin=rubyComment contained
syn keyword tomdocKeywords Signature containedin=rubyComment contained

syn match tomdocArguments +\s*[A-Za-z0-9_\-&\*:]*\(\s*- \)+he=e-3 containedin=rubyComment contained

syn match tomdocDescriptions +\s*Public:+he=e-1 containedin=rubyComment contained
syn match tomdocDescriptions +\s*Internal:+he=e-1 containedin=rubyComment contained
syn match tomdocDescriptions +\s*Deprecated:+he=e-1 containedin=rubyComment contained

hi default link tomdocDescriptions String
hi default link tomdocKeywords String
hi default link tomdocArguments HELP
