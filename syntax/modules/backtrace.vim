if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Backtrace module <https://github.com/alibaba/nginx-backtrace>
" A Nginx module to dump backtrace when a worker process exits abnormally
syn keyword ngxDirectiveThirdParty backtrace_log
syn keyword ngxDirectiveThirdParty backtrace_max_stack_size


endif
