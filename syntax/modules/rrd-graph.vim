if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" RRD Graph Module <https://www.nginx.com/resources/wiki/modules/rrd_graph/>
" This module provides an HTTP interface to RRDtool's graphing facilities.
syn keyword ngxDirectiveThirdParty rrd_graph
syn keyword ngxDirectiveThirdParty rrd_graph_root


endif
