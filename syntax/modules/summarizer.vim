if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Summarizer Module <https://github.com/reeteshranjan/summarizer-nginx-module>
" Upstream nginx module to get summaries of documents using the summarizer daemon service
syn keyword ngxDirectiveThirdParty smrzr_filename
syn keyword ngxDirectiveThirdParty smrzr_ratio


endif
