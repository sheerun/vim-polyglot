if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'apex/apexlog/visualforce') == -1
  
syn keyword	apExecBlock EXECUTION_STARTED EXECUTION_FINISHED CODE_UNIT_STARTED CODE_UNIT_FINISHED SOQL_EXECUTE_BEGIN SOQL_EXECUTE_END 
syn match	apHex "0x\x\+"
syn match	apSeparator "|"
syn region	apLimitBlock	start="CUMULATIVE_LIMIT_USAGE"  end="CUMULATIVE_LIMIT_USAGE_END"  
syn region	apLineHeader	start="^" end="([0-9]\+)|"
syn region	apBrackets		start="\[" end="\]" 
syn region	apVar		start="{" end="}" 
syn region	apVar2		start="\[{" end="}\]" 
syn region	apSOQL		start="\[Query" end="\]" 
syn match	apError "[A-Z_]\+_ERROR.*$"
syn match	apDebug "[A-Z_]\+_DEBUG"
syn region	apDebugStmt start="DEBUG" skip="|" end="$"
syn keyword	apMisc APEX_CODE FINEST APEX_PROFILING INFO CALLOUT INFO DB INFO SYSTEM VALIDATION INFO VISUALFORCE INFO WORKFLOW INFO HEAP_ALLOCATE HEAP_ALLOCATE VARIABLE_SCOPE_BEGIN STATEMENT_EXECUTE HEAP_ALLOCATE SYSTEM_METHOD_ENTRY SYSTEM_METHOD_EXIT VARIABLE_SCOPE_BEGIN true false
syn keyword	apOfInterest	VARIABLE_ASSIGNMENT 

hi def link apExecBlock		Structure
hi def link apLimitBlock	Comment
hi def link apBrackets	Comment
hi def link apLineHeader	Statement
hi def link apVar	Character
hi def link apVar2	Character
hi def link apSOQL	Character
hi def link apError	Error
hi def link apException	Error
hi def link apDebug	Todo
hi def link apMisc	Include
hi def link apOfInterest	Structure
hi def link apHex	Include
hi def link apSeparator	Statement
hi def link apDebugStmt		Structure

endif
