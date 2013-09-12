" Vim syntax file
" Language:     Erlang
" Author:       Oscar Hellström <oscar@oscarh.net> (http://oscar.hellstrom.st)
" Contributors: Ricardo Catalinas Jiménez <jimenezrick@gmail.com>
" License:      Vim license
" Version:      2012/05/07

if exists("b:current_syntax")
	finish
else
	let b:current_syntax = "erlang"
endif

if !exists("g:erlang_highlight_bif")
	let g:erlang_highlight_bif = 1
endif

" Erlang is case sensitive
syn case match

" Match groups
syn match erlangStringModifier               /\\./ contained
syn match erlangStringModifier               /\~\%(-\?[0-9*]\+\)\?\%(\.[0-9*]*\%(\..\?t\?\)\?\)\?\%(\~\|c\|f\|e\|g\|s\|w\|p\|W\|P\|B\|X\|#\|b\|x\|+\|n\|i\)/ contained
syn match erlangModifier                     /\$\\\?./

syn match erlangInteger                      /\<\%([0-9]\+#[0-9a-fA-F]\+\|[0-9]\+\)\>/
syn match erlangFloat                        /\<[0-9]\+\.[0-9]\+\%(e-\?[0-9]\+\)\?\>/

syn keyword erlangTodo                       TODO FIXME XXX contained
syn match   erlangComment                    /%.*$/ contains=@Spell,erlangTodo,erlangAnnotation
syn match   erlangAnnotation                 /\%(%\s\)\@<=@\%(author\|clear\|copyright\|deprecated\|doc\|docfile\|end\|equiv\|headerfile\|hidden\|private\|reference\|see\|since\|spec\|throws\|title\|todo\|TODO\|type\|version\)/ contained
syn match   erlangAnnotation                 /`[^']\+'/ contained

syn keyword erlangKeyword                    band bor bnot bsl bsr bxor div rem xor
syn keyword erlangKeyword                    try catch begin receive after cond fun let query

syn keyword erlangConditional                case if of end
syn keyword erlangConditional                not and or andalso orelse
syn keyword erlangConditional                when

syn keyword erlangBoolean                    true false

syn keyword erlangGuard                      is_list is_alive is_atom is_binary is_bitstring is_boolean is_tuple is_number is_integer is_float is_function is_constant is_pid is_port is_reference is_record is_process_alive

syn match   erlangOperator                   /\/\|*\|+\|-\|++\|--/
syn match   erlangOperator                   /->\|<-\|||\||\|!\|=/
syn match   erlangOperator                   /=:=\|==\|\/=\|=\/=\|<\|>\|=<\|>=/
syn keyword erlangOperator                   div rem

syn region erlangString                      start=/"/ end=/"/ skip=/\\/ contains=@Spell,erlangStringModifier

syn match erlangVariable                     /\<[A-Z_]\w*\>/
syn match erlangAtom                         /\%(\%(^-\)\|#\)\@<!\<[a-z][A-Za-z0-9_]*\>\%(\s*[(:]\)\@!/
syn match erlangAtom                         /\\\@<!'[^']*\\\@<!'/

syn match erlangRecord                       /#\w\+/

syn match erlangTuple                        /{\|}/
syn match erlangList                         /\[\|\]/

syn match erlangAttribute                    /^-\%(vsn\|author\|copyright\|compile\|deprecated\|module\|export\|import\|behaviour\|behavior\|export_type\|ignore_xref\|on_load\|mode\)\s*(\@=/
syn match erlangInclude                      /^-include\%(_lib\)\?\s*(\@=/
syn match erlangRecordDef                    /^-record\s*(\@=/
syn match erlangDefine                       /^-\%(define\|undef\)\s*(\@=/
syn match erlangPreCondit                    /^-\%(ifdef\|ifndef\|else\|endif\)\%(\s*(\@=\)\?/

syn match erlangType                         /^-\%(spec\|type\|opaque\|callback\)[( ]\@=/

syn match erlangMacro                        /\%(-define(\)\@<=\w\+/
syn match erlangMacro                        /?\??\w\+/

syn match erlangBitType                      /\%(\/\|-\)\@<=\%(bits\|bitstring\|binary\|integer\|float\|unit\)\>/
syn match erlangBitSize                      /:\@<=[0-9]\+/

syn match erlangBinary                       /<<\|>>/

" BIFs
syn match erlangBIF                          /\%([^:0-9A-Za-z_]\|\<erlang:\|^\)\@<=\%(abs\|apply\|atom_to_binary\|atom_to_list\|binary_part\|binary_to_atom\|binary_to_existing_atom\|binary_to_list\|binary_to_term\|bit_size\|bitstring_to_list\|byte_size\|check_process_code\|date\|delete_module\|demonitor\|disconnect_node\|element\|erase\|error\|exit\|float\|float_to_list\|garbage_collect\|get\|get_keys\|group_leader\|halt\|hd\|integer_to_list\|iolist_size\|iolist_to_binary\|is_alive\|is_atom\|is_binary\|is_bitstring\|is_boolean\|is_float\|is_function\|is_integer\|is_list\|is_number\|is_pid\|is_port\|is_process_alive\|is_record\|is_reference\|is_tuple\|length\|link\|list_to_atom\|list_to_binary\|list_to_bitstring\|list_to_existing_atom\|list_to_float\|list_to_integer\|list_to_pid\|list_to_tuple\|load_module\|make_ref\|max\|min\|module_loaded\|monitor\|monitor_node\|node\|nodes\|now\|open_port\|pid_to_list\|port_close\|port_command\|port_connect\|port_control\|pre_loaded\|processes\|process_flag\|process_info\|purge_module\|put\|register\|registered\|round\|self\|setelement\|size\|spawn\|spawn_link\|spawn_monitor\|spawn_opt\|split_binary\|statistics\|term_to_binary\|throw\|time\|tl\|trunc\|tuple_size\|tuple_to_list\|unlink\|unregister\|whereis\)\%((\|\/[0-9]\)\@=/
syn match erlangBIF                          /\%(\<erlang:\)\@<=\%(append_element\|bump_reductions\|cancel_timer\|decode_packet\|display\|function_exported\|fun_info\|fun_to_list\|get_cookie\|get_stacktrace\|hash\|is_builtin\|loaded\|load_nif\|localtime\|localtime_to_universaltime\|make_tuple\|memory\|monitor_node\|phash\|port_call\|port_info\|ports\|port_to_list\|process_display\|read_timer\|ref_to_list\|resume_process\|send\|send_after\|send_nosuspend\|set_cookie\|start_timer\|suspend_process\|system_flag\|system_info\|system_monitor\|system_profile\|trace\|trace_delivered\|trace_info\|trace_pattern\|universaltime\|universaltime_to_localtime\|yield\)(\@=/
syn match erlangGBIF                         /\<erlang\%(:\w\)\@=/

" Link Erlang stuff to Vim groups
hi def link erlangTodo           Todo
hi def link erlangString         String
hi def link erlangNoSpellString  String
hi def link erlangModifier       SpecialChar
hi def link erlangStringModifier SpecialChar
hi def link erlangComment        Comment
hi def link erlangAnnotation     Special
hi def link erlangVariable       Identifier
hi def link erlangInclude        Include
hi def link erlangRecordDef      Keyword
hi def link erlangAttribute      Keyword
hi def link erlangKeyword        Keyword
hi def link erlangMacro          Macro
hi def link erlangDefine         Define
hi def link erlangPreCondit      PreCondit
hi def link erlangPreProc        PreProc
hi def link erlangDelimiter      Delimiter
hi def link erlangBitDelimiter   Normal
hi def link erlangOperator       Operator
hi def link erlangConditional    Conditional
hi def link erlangGuard          Conditional
hi def link erlangBoolean        Boolean
hi def link erlangAtom           Constant
hi def link erlangRecord         Structure
hi def link erlangInteger        Number
hi def link erlangFloat          Number
hi def link erlangFloat          Number
hi def link erlangFloat          Number
hi def link erlangFloat          Number
hi def link erlangHex            Number
hi def link erlangFun            Keyword
hi def link erlangList           Delimiter
hi def link erlangTuple          Delimiter
hi def link erlangBinary         Keyword
hi def link erlangBitVariable    Identifier
hi def link erlangBitType        Type
hi def link erlangType           Type
hi def link erlangBitSize        Number

" Optional highlighting
if g:erlang_highlight_bif
	hi def link erlangBIF    Keyword
	hi def link erlangGBIF   Keyword
endif
