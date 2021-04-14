if polyglot#init#is_disabled(expand('<sfile>:p'), 'sway', 'syntax/sway.vim')
  finish
endif

" Vim syntax file
" Language: sway-wm config file
" Maintainer: Aaron Ouellette
" Latest Revision: 11 June 2016

if exists("b:current_syntax")
  finish
endif

" Symbols
syn match   swayOperators "+\|→"
syn match   swayChainDelimiter ";"

syn match   swayVar "\$\w\+"

" Key modifiers
syn keyword swayKeyModifier Shift Control Ctrl Mod1 Mod2 Mod3 Mod4 Mod5 Mode_switch

" Strings
syn region  swaySimpleString keepend start='[^ \t]' end='$\|;' contained contains=swayChainDelimiter,swayVar
syn match   swayQuotedString '"[^"]\+"' contained
syn cluster swayString contains=swaySimpleString,swayQuotedString

" Config commands
syn keyword swayConfigCommand bind bindcode bindsym assign new_window popup_during_fullscreen font floating_modifier default_orientation workspace_layout for_window focus_follows_mouse bar position colors output input workspace_buttons workspace_auto_back_and_forth binding_mode_indicator debuglog floating_minimum_size floating_maximum_size force_focus_wrapping force_display_urgency_hint hidden_state modifier new_float socket_path mouse_warping strip_workspace_numbers focus_on_window_activation no_focus include gaps
syn match   swayIpcSocket "ipc[-_]socket" nextgroup=@swayString skipwhite

" Command keywords
syn keyword swayCommand exit reload restart kill fullscreen global layout border focus move open split append_layout mark unmark resize grow shrink show nop rename title_format sticky
syn keyword swayParam 1pixel default stacked tabbed normal none tiling stacking floating enable disable up down horizontal vertical auto up down left right parent child px or ppt leave_fullscreen toggle mode_toggle scratchpad width height top bottom client hide primary yes all active window container to absolute center on off x ms h v smart ignore pixel splith splitv output true
syn match   swayDashedParam '--\(release\|border\|whole-window\|toggle\)' skipwhite
syn keyword swayWsSpecialParam next prev next_on_output prev_on_output back_and_forth current number
syn keyword swayBordersSpecialParam none vertical horizontal both
syn keyword swayModeParam dock hide invisible skipwhite

" these are not keywords but we add them for consistency
syn keyword swayPseudoParam no false inactive

" Exec commands
syn region  swayExecCommand keepend start='[^ \t]' end='$\|;' contained contains=swayChainDelimiter,swayVar,swayNoStartupId
syn match   swayQuotedExecCommand '"[^"]\+"' contained
syn keyword swayExecKeyword exec exec_always swaybar_command nextgroup=swayQuotedExecCommand,swayExecCommand skipwhite

" Status command
syn match   swayStatusCommand ".*$" contained
syn keyword swayStatusCommandKeyword status_command nextgroup=swayStatusCommand skipwhite

" Font statement
syn keyword swayFontStatement font nextgroup=@swayString skipwhite

" Separator symbol
syn keyword swaySeparatorSymbol separator_symbol nextgroup=@swayString skipwhite

" Set statement
syn match   swaySetVar "\$\w\+" contained nextgroup=@swayString skipwhite
syn keyword swaySetKeyword set nextgroup=swaySetVar skipwhite

" Workspaces
syn keyword swayWsKeyword workspace nextgroup=swayWsSpecialParam,@swayString skipwhite

" Hide edge borders
syn keyword swayBordersConfigCommand hide_edge_borders nextgroup=swayBordersSpecialParam skipwhite

" Mode
syn keyword swayModeKeyword mode nextgroup=swayModeParam,@swayString skipwhite

" Comments
syn keyword swayTodo contained TODO FIXME XXX NOTE
syn match   swayComment "^\s*#.*$" contains=swayTodo

" Error (at end of line)
syn match swayError ".*$" contained

" Hex color code
syn match swayColorLast "#[0-9a-fA-F]\{6\}" contained nextgroup=swayError skipwhite
syn match swayColor2nd "#[0-9a-fA-F]\{6\}" contained nextgroup=swayColorLast skipwhite
syn match swayColor1st "#[0-9a-fA-F]\{6\}" contained nextgroup=swayColor2nd skipwhite

syn match swayColorDef1 "client\.background\|statusline\|background\|separator\|statusline" nextgroup=swayColorLast skipwhite
syn match swayColorDef3 "client\.\(focused_inactive\|focused\|unfocused\|urgent\)\|inactive_workspace\|urgent_workspace\|focused_workspace\|active_workspace" nextgroup=swayColor1st skipwhite

highlight link swayChainDelimiter       Operator
highlight link swayOperators            Operator

highlight link swayExecCommand          Special
highlight link swayQuotedExecCommand    Special
highlight link swayStatusCommand        Special

highlight link swayParam                Constant
highlight link swayPseudoParam          Constant
highlight link swayDashedParam          Constant
highlight link swayNoStartupId          Constant
highlight link swayColor1st             Constant
highlight link swayColor2nd             Constant
highlight link swayColorLast            Constant
highlight link swayWsSpecialParam       Constant
highlight link swayBordersSpecialParam  Constant
highlight link swayModeParam            Constant

highlight link swayVar                  Identifier
highlight link swaySetVar               Identifier

highlight link swayKeyModifier          Function

highlight link swaySimpleString         String
highlight link swayQuotedString         String
highlight link swayWsName               String
highlight link swayQuotedWsName         String
highlight link swaySetValue             String
highlight link swayFont                 String

highlight link swayExecKeyword          Keyword
highlight link swayCommand              Keyword
highlight link swayWsKeyword            Keyword

highlight link swayColorDef1            Define
highlight link swayColorDef3            Define
highlight link swayConfigCommand        Define
highlight link swayIpcSocket            Define
highlight link swaySetKeyword           Define
highlight link swayModeKeyword          Define
highlight link swayFontStatement        Define
highlight link swaySeparatorSymbol      Define
highlight link swayStatusCommandKeyword Define
highlight link swayBordersConfigCommand Define

highlight link swayTodo                 Todo
highlight link swayComment              Comment
highlight link swayError                Error
