if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'i3') == -1
  
" Vim syntax file
" Language: i3-wm config file
" Maintainer: Emanuel Guével
" Latest Revision: 16 October 2012

if exists("b:current_syntax")
  finish
endif

" Symbols
syn match   i3Operators "+\|→"
syn match   i3ChainDelimiter ";"

syn match   i3Var "\$\w\+"

" Key modifiers
syn keyword i3KeyModifier Shift Control Ctrl Mod1 Mod2 Mod3 Mod4 Mod5 Mode_switch

" Strings
syn region  i3SimpleString keepend start='[^ \t]' end='$\|;' contained contains=i3ChainDelimiter,i3Var
syn match   i3QuotedString '"[^"]\+"' contained
syn cluster i3String contains=i3SimpleString,i3QuotedString

" Config commands
syn keyword i3ConfigCommand bind bindcode bindsym assign new_window popup_during_fullscreen font floating_modifier default_orientation workspace_layout for_window focus_follows_mouse bar position colors output tray_output workspace_buttons workspace_auto_back_and_forth binding_mode_indicator debuglog floating_minimum_size floating_maximum_size force_focus_wrapping force_xinerama force_display_urgency_hint hidden_state modifier new_float shmlog socket_path verbose mouse_warping strip_workspace_numbers focus_on_window_activation no_focus
syn match   i3IpcSocket "ipc[-_]socket" nextgroup=@i3String skipwhite

" Command keywords
syn keyword i3Command exit reload restart kill fullscreen global layout border focus move open split append_layout mark unmark resize grow shrink show nop rename title_format sticky
syn keyword i3Param 1pixel default stacked tabbed normal none tiling stacking floating enable disable up down horizontal vertical auto up down left right parent child px or ppt leave_fullscreen toggle mode_toggle scratchpad width height top bottom client hide primary yes all active window container to absolute center on off x ms h v smart ignore pixel splith splitv output true
syn match   i3DashedParam '--\(release\|border\|whole-window\|toggle\)' skipwhite
syn match   i3NoStartupId '--no-startup-id' contained
syn keyword i3WsSpecialParam next prev next_on_output prev_on_output back_and_forth current number
syn keyword i3BordersSpecialParam none vertical horizontal both
syn keyword i3ModeParam dock hide invisible skipwhite
syn keyword i3GapsCommand gaps smart_gaps smart_borders
syn keyword i3GapsParam inner outer current all set plus minus no_gaps

" these are not keywords but we add them for consistency
syn keyword i3PseudoParam no false inactive

" Exec commands
syn region  i3ExecCommand keepend start='[^ \t]' end='$\|;' contained contains=i3ChainDelimiter,i3Var,i3NoStartupId
syn match   i3QuotedExecCommand '"[^"]\+"' contained
syn keyword i3ExecKeyword exec exec_always i3bar_command nextgroup=i3QuotedExecCommand,i3ExecCommand skipwhite

" Status command
syn match   i3StatusCommand ".*$" contained
syn keyword i3StatusCommandKeyword status_command nextgroup=i3StatusCommand skipwhite

" Font statement
syn keyword i3FontStatement font nextgroup=@i3String skipwhite

" Separator symbol
syn keyword i3SeparatorSymbol separator_symbol nextgroup=@i3String skipwhite

" Set statement
syn match   i3SetVar "\$\w\+" contained nextgroup=@i3String skipwhite
syn keyword i3SetKeyword set set_from_resource nextgroup=i3SetVar skipwhite

" Workspaces
syn keyword i3WsKeyword workspace nextgroup=i3WsSpecialParam,@i3String skipwhite

" Hide edge borders
syn keyword i3BordersConfigCommand hide_edge_borders nextgroup=i3BordersSpecialParam skipwhite

" Mode
syn keyword i3ModeKeyword mode nextgroup=i3ModeParam,@i3String skipwhite

" Comments
syn keyword i3Todo contained TODO FIXME XXX NOTE
syn match   i3Comment "^\s*#.*$" contains=i3Todo

" Error (at end of line)
syn match i3Error ".*$" contained

" Hex color code
syn match i3ColorLast "#[0-9a-fA-F]\{6\}" contained nextgroup=i3Error skipwhite
syn match i3Color2nd "#[0-9a-fA-F]\{6\}" contained nextgroup=i3ColorLast skipwhite
syn match i3Color1st "#[0-9a-fA-F]\{6\}" contained nextgroup=i3Color2nd skipwhite

syn match i3ColorDef1 "client\.background\|statusline\|background\|separator\|statusline" nextgroup=i3ColorLast skipwhite
syn match i3ColorDef3 "client\.\(focused_inactive\|focused\|unfocused\|urgent\)\|inactive_workspace\|urgent_workspace\|focused_workspace\|active_workspace" nextgroup=i3Color1st skipwhite

highlight link i3ChainDelimiter       Operator
highlight link i3Operators            Operator

highlight link i3ExecCommand          Special
highlight link i3QuotedExecCommand    Special
highlight link i3StatusCommand        Special

highlight link i3Param                Constant
highlight link i3PseudoParam          Constant
highlight link i3DashedParam          Constant
highlight link i3NoStartupId          Constant
highlight link i3Color1st             Constant
highlight link i3Color2nd             Constant
highlight link i3ColorLast            Constant
highlight link i3WsSpecialParam       Constant
highlight link i3BordersSpecialParam  Constant
highlight link i3ModeParam            Constant
highlight link i3GapsParam            Constant

highlight link i3Var                  Identifier
highlight link i3SetVar               Identifier

highlight link i3KeyModifier          Function

highlight link i3SimpleString         String
highlight link i3QuotedString         String
highlight link i3WsName               String
highlight link i3QuotedWsName         String
highlight link i3SetValue             String
highlight link i3Font                 String

highlight link i3ExecKeyword          Keyword
highlight link i3Command              Keyword
highlight link i3WsKeyword            Keyword
highlight link i3GapsCommand          Keyword

highlight link i3ColorDef1            Define
highlight link i3ColorDef3            Define
highlight link i3ConfigCommand        Define
highlight link i3IpcSocket            Define
highlight link i3SetKeyword           Define
highlight link i3ModeKeyword          Define
highlight link i3FontStatement        Define
highlight link i3SeparatorSymbol      Define
highlight link i3StatusCommandKeyword Define
highlight link i3BordersConfigCommand Define

highlight link i3Todo                 Todo
highlight link i3Comment              Comment
highlight link i3Error                Error

endif
