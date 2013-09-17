" Vim syntax file
" Language:   Erlang
" Maintainer: Oscar Hellström <oscar@oscarh.net>
" URL:        http://oscar.hellstrom.st
" Version:    2010-08-09
" ------------------------------------------------------------------------------
" {{{1
" Options:
"
" Erlang BIFs
" g:erlangHighlightBif - highlight erlang built in functions (default: off)
"
" }}}
" -----------------------------------------------------------------------------

" Setup {{{1
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Erlang is case sensitive
syn case match

" Match groups {{{1
syn match erlangStringModifier               /\\./ contained
syn match erlangStringModifier               /\~\%(-\?[0-9*]\+\)\?\%(\.[0-9*]\+\..\?\)\?\%(c\|f\|e\|g\|s\|w\|p\|W\|P\|B\|X\|#\|b\|+\|n\|i\)/ contained
syn match erlangModifier                     /\$\\\?./

syn match erlangInteger                      /\<\%([0-9]\+#[0-9a-fA-F]\+\|[0-9]\+\)\>/
syn match erlangFloat                        /\<[0-9]\+\.[0-9]\+\%(e-\?[0-9]\+\)\?\>/

syn keyword erlangTodo                       TODO FIXME XXX contained
syn match erlangComment                      /%.*$/ contains=@Spell,erlangTodo

syn keyword erlangKeyword                    band bor bnot bsl bsr bxor div rem xor
syn keyword erlangKeyword                    try catch begin receive after cond fun let query

syn keyword erlangConditional                case if of end
syn keyword erlangConditional                not and or andalso orelse
syn keyword erlangConditional                when

syn keyword erlangBoolean                    true false

syn keyword erlangGuard                      is_list is_alive is_atom is_binary is_bitstring is_boolean is_tuple is_number is_integer is_float is_function is_constant is_pid is_port is_reference is_record is_process_alive

syn match erlangOperator                     /\/\|*\|+\|-\|++\|--/
syn match erlangOperator                     /->\|<-\|||\||\|!\|=/
syn match erlangOperator                     /=:=\|==\|\/=\|=\/=\|<\|>\|=<\|>=/
syn keyword erlangOperator                   div rem

syn region erlangString                      start=/"/ end=/"/ skip=/\\/ contains=@Spell,erlangStringModifier

syn match erlangVariable                     /\<[A-Z_]\w*\>/
syn match erlangAtom                         /\%(\%(^-\)\|#\)\@<!\<[a-z][A-Za-z0-9_]*\>\%(\s*[(:]\)\@!/
syn match erlangAtom                         /\\\@<!'[^']*\\\@<!'/

syn match erlangRecord                       /#\w\+/

syn match erlangTuple                        /{\|}/
syn match erlangList                         /\[\|\]/

    syn match erlangAttribute                    /^-\%(vsn\|author\|copyright\|compile\|deprecated\|module\|export\|import\|behaviour\|export_type\|ignore_xref\) *(\@=/
syn match erlangInclude                      /^-include\%(_lib\)\?\s*(\@=/
syn match erlangRecordDef                    /^-record\s*(\@=/
syn match erlangDefine                       /^-\%(define\|undef\)\s*(\@=/
syn match erlangPreCondit                    /^-\%(ifdef\|ifndef\|else\|endif\)\%(\s*(\@=\)\?/

syn match erlangType                         /^-\%(spec\|type\)[( ]\@=/

syn match erlangMacro                        /\%(-define(\)\@<=\w\+/
syn match erlangMacro                        /?\w\+/

syn match erlangBitType                      /\%(\/\|-\)\@<=\%(bits\|bitstring\|binary\|integer\|float\|unit\)\>/
syn match erlangBitSize                      /:\@<=[0-9]\+/

syn match erlangBinary                      /<<\|>>/

" BIFS
syn match erlangBIF                          /\%([^:0-9A-Za-z_]\|\<erlang:\)\@<=\%(abs\|apply\|atom_to_list\|binary_part\|binary_to_list\|binary_to_term\|binary_to_atom\|binary_to_existing_atom\|bitstring_to_list\|check_process_code\|concat_binary\|date\|delete_module\|disconnect_node\|element\|erase\|error\|exit\|float\|float_to_list\|garbage_collect\|get\|get_keys\|group_leader\|halt\|hd\|integer_to_list\|iolist_to_binary\|iolist_size\|length\|link\|list_to_atom\|list_to_binary\|list_to_bitstring\|list_to_existing_atom\|list_to_float\|list_to_integer\|list_to_pid\|list_to_tuple\|load_module\|make_ref\|monitor_node\|node\|nodes\|now\|open_port\|pid_to_list\|port_close\|port_command\|port_connect\|port_control\|pre_loaded\|process_flag\|process_info\|processes\|purge_module\|put\|register\|registered\|round\|self\|setelement\|size\|bit_size\|byte_size\|spawn\|spawn_link\|spawn_opt\|split_binary\|statistics\|term_to_binary\|throw\|time\|tl\|trunc\|tuple_to_list\|unlink\|unregister\|whereis\)\((\|\/[0-9]\)\@=/
syn match erlangBIF                          /\<\%(erlang:\)\@<=\%(append_element\|bump_reductions\|cancel_timer\|decode_packet\|demonitor\|display\|fault\|fun_info\|fun_to_list\|function_exported\|get_cookie\|get_stacktrace\|hash\|hibernate\|info\|is_builtin\|loaded\|localtime\|localtime_to_universaltime\|localtime_to_universaltime\|make_tuple\|md5\|md5_init\|md5_update\|memory\|monitor\|monitor_node\|phash\|phash2\|port_call\|port_info\|port_to_list\|ports\|process_display\|raise\|read_timer\|ref_to_list\|resume_process\|send\|send_after\|send_nosuspend\|set_cookie\|spawn_monitor\|start_timer\|suspend_process\|system_flag\|system_info\|system_monitor\|trace\|trace_delivered\|trace_info\|trace_pattern\|universaltime\|universaltime_to_localtime\|yield\)(\@=/
syn match erlangGBIF                         /erlang\(:\w\)\@=/
" }}}

" Link Erlang stuff to Vim groups {{{1
hi link erlangTodo           Todo
hi link erlangString         String
hi link erlangNoSpellString  String 
hi link erlangModifier       SpecialChar
hi link erlangStringModifier SpecialChar
hi link erlangComment        Comment
hi link erlangVariable       Identifier
hi link erlangInclude        Include
hi link erlangRecordDef      Keyword
hi link erlangAttribute      Keyword
hi link erlangKeyword        Keyword
hi link erlangMacro          Macro
hi link erlangDefine         Define
hi link erlangPreCondit      PreCondit
hi link erlangPreProc        PreProc
hi link erlangDelimiter      Delimiter
hi link erlangBitDelimiter   Normal
hi link erlangOperator       Operator
hi link erlangConditional    Conditional
hi link erlangGuard          Conditional
hi link erlangBoolean        Boolean
hi link erlangAtom           Constant
hi link erlangRecord         Structure
hi link erlangInteger        Number
hi link erlangFloat          Number
hi link erlangFloat          Number
hi link erlangFloat          Number
hi link erlangFloat          Number
hi link erlangHex            Number
hi link erlangBIF            Keyword
hi link erlangFun            Keyword
hi link erlangList           Delimiter
hi link erlangTuple          Delimiter
hi link erlangBinary         Keyword
hi link erlangBitVariable    Identifier
hi link erlangBitType        Type
hi link erlangType           Type
hi link erlangBitSize        Number
" }}}

" Optional linkings {{{1
if exists("g:erlangHighlightBif") && g:erlangHighlightBif
	hi link erlangGBIF           Keyword
endif
" }}}

let b:current_syntax = "erlang"

" vim: set foldmethod=marker:
