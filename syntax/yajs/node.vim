if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  
syntax keyword javascriptNodeGlobal global process console Buffer module exports setTimeout
syntax keyword javascriptNodeGlobal clearTimeout setInterval clearInterval
if exists("did_javascript_hilink") | HiLink javascriptNodeGlobal Structure
endif

endif
