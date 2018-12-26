if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'i3') == -1
  
" Vim syntax file
" Language: i3 config file
" Maintainer: Mohamed Boughaba <mohamed dot bgb at gmail dot com>
" Version: 0.3
" Last Change: 2017-10-27 23:59

" References:
" http://i3wm.org/docs/userguide.html#configuring
" http://vimdoc.sourceforge.net/htmldoc/syntax.html
"
"
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syn clear
elsei exists("b:current_syntax")
  fini
en

scriptencoding utf-8

" Error
syn match Error /.*/

" Todo
syn keyword Todo TODO FIXME XXX contained

" Comment
" Comments are started with a # and can only be used at the beginning of a line
syn match Comment /^\s*#.*$/ contains=Todo

" Font
" A FreeType font description is composed by:
" a font family, a style, a weight, a variant, a stretch and a size.
syn match FontSeparator /,/ contained
syn match FontSeparator /:/ contained
syn keyword FontKeyword font contained
syn match FontNamespace /\w\+:/ contained contains=FontSeparator
syn match FontContent /-\?\w\+\(-\+\|\s\+\|,\)/ contained contains=FontNamespace,FontSeparator,FontKeyword
syn match FontSize /\s\=\d\+\(px\)\?\s\?$/ contained
syn match Font /^\s*font\s\+.*$/ contains=FontContent,FontSeparator,FontSize,FontNamespace
"syn match Font /^\s*font\s\+.*\(\\\_.*\)\?$/ contains=FontContent,FontSeparator,FontSize,FontNamespace
"syn match Font /^\s*font\s\+.*\(\\\_.*\)\?[^\\]\+$/ contains=FontContent,FontSeparator,FontSize,FontNamespace
"syn match Font /^\s*font\s\+\(\(.*\\\_.*\)\|\(.*[^\\]\+$\)\)/ contains=FontContent,FontSeparator,FontSize,FontNamespace

" variables
syn match String /\(['"]\)\(.\{-}\)\1/ contained
syn match Color /#\w\{6}/ contained
syn match VariableModifier /+/ contained
syn match VariableAndModifier /+\w\+/ contained contains=VariableModifier
syn match Variable /\$\w\+\(\(-\w\+\)\+\)\?\(\s\|+\)\?/ contains=VariableModifier,VariableAndModifier
syn keyword InitializeKeyword set contained
syn match Initialize /^\s*set\s\+.*$/ contains=Variable,InitializeKeyword,Color,String

" Gaps
syn keyword GapStyleKeyword inner outer current all set plus minus contained
syn match GapStyle /^\s*\(gaps\)\s\+\(inner\|outer\)\(\s\+\(current\|all\)\)\?\(\s\+\(set\|plus\|minus\)\)\?\(\s\+\d\+\)$/ contains=GapStyleKeyword,number

" Keyboard bindings
syn keyword Action toggle fullscreen restart key import kill shrink grow contained
syn keyword Action focus move split layout resize restore reload mute unmute exit contained
syn match Modifier /\w\++\w\+\(\(+\w\+\)\+\)\?/ contained contains=VariableModifier
syn match Number /\s\d\+/ contained
syn keyword BindKeyword bindsym bindcode exec gaps contained
syn match BindArgument /--\w\+\(\(-\w\+\)\+\)\?\s/ contained
syn match Bind /^\s*\(bindsym\|bindcode\)\s\+.*$/ contains=Variable,BindKeyword,VariableAndModifier,BindArgument,Number,Modifier,Action,String,GapStyleKeyword

" Floating
syn keyword SizeSpecial x contained
syn match NegativeSize /-/ contained
syn match Size /-\?\d\+\s\?x\s\?-\?\d\+/ contained contains=SizeSpecial,Number,NegativeSize
syn match Floating /^\s*floating_modifier\s\+\$\w\+\d\?/ contains=Variable
syn match Floating /^\s*floating_\(maximum\|minimum\)_size\s\+-\?\d\+\s\?x\s\?-\?\d\+/ contains=Size

" Orientation
syn keyword OrientationKeyword vertical horizontal auto contained
syn match Orientation /^\s*default_orientation\s\+\(vertical\|horizontal\|auto\)\s\?$/ contains=OrientationKeyword

" Layout
syn keyword LayoutKeyword default stacking tabbed contained
syn match Layout /^\s*workspace_layout\s\+\(default\|stacking\|tabbed\)\s\?$/ contains=LayoutKeyword

" Border style
syn keyword BorderStyleKeyword none normal pixel contained
syn match BorderStyle /^\s*\(new_window\|new_float\|default_border\|default_floating_border\)\s\+\(none\|\(normal\|pixel\)\(\s\+\d\+\)\?\)\s\?$/ contains=BorderStyleKeyword,number

" Hide borders and edges
syn keyword EdgeKeyword none vertical horizontal both contained
syn match Edge /^\s*hide_edge_borders\s\+\(none\|vertical\|horizontal\|both\)\s\?$/ contains=EdgeKeyword

" Arbitrary commands for specific windows (for_window)
syn keyword CommandKeyword for_window contained
syn region WindowStringSpecial start=+"+  skip=+\\"+  end=+"+ contained contains=String
syn region WindowCommandSpecial start="\[" end="\]" contained contains=WindowStringSpacial,String
syn match ArbitraryCommand /^\s*for_window\s\+.*$/ contains=WindowCommandSpecial,CommandKeyword,BorderStyleKeyword,LayoutKeyword,OrientationKeyword,Size,Number

" Disable focus open opening
syn keyword NoFocusKeyword no_focus contained
syn match DisableFocus /^\s*no_focus\s\+.*$/ contains=WindowCommandSpecial,NoFocusKeyword

" Move client to specific workspace automatically
syn keyword AssignKeyword assign contained
syn match AssignSpecial /→/ contained
syn match Assign /^\s*assign\s\+.*$/ contains=AssignKeyword,WindowCommandSpecial,AssignSpecial

" X resources
syn keyword ResourceKeyword set_from_resource contained
syn match Resource /^\s*set_from_resource\s\+.*$/ contains=ResourceKeyword,WindowCommandSpecial,Color,Variable

" Auto start applications
syn keyword ExecKeyword exec exec_always contained
syn match NoStartupId /--no-startup-id/ contained " We are not using BindArgument as only no-startup-id is supported here
syn match Exec /^\s*exec\(_always\)\?\s\+.*$/ contains=ExecKeyword,NoStartupId,String

" Automatically putting workspaces on specific screens
syn keyword WorkspaceKeyword workspace contained
syn keyword Output output contained
syn match Workspace /^\s*workspace\s\+.*$/ contains=WorkspaceKeyword,Number,String,Output

" Changing colors
syn keyword ClientColorKeyword client focused focused_inactive unfocused urgent placeholder background contained
syn match ClientColor /^\s*client.\w\+\s\+.*$/ contains=ClientColorKeyword,Color,Variable

" Interprocess communication
syn match InterprocessKeyword /ipc-socket/ contained
syn match Interprocess /^\s*ipc-socket\s\+.*$/ contains=InterprocessKeyword

" Mouse warping
syn keyword MouseWarpingKeyword mouse_warping contained
syn keyword MouseWarpingType output none contained
syn match MouseWarping /^\s*mouse_warping\s\+\(output\|none\)\s\?$/ contains=MouseWarpingKeyword,MouseWarpingType

" Focus follows mouse
syn keyword FocusFollowsMouseKeyword focus_follows_mouse contained
syn keyword FocusFollowsMouseType yes no contained
syn match FocusFollowsMouse /^\s*focus_follows_mouse\s\+\(yes\|no\)\s\?$/ contains=FocusFollowsMouseKeyword,FocusFollowsMouseType

" Popups during fullscreen mode
syn keyword PopupOnFullscreenKeyword popup_during_fullscreen contained
syn keyword PopuponFullscreenType smart ignore leave_fullscreen contained
syn match PopupOnFullscreen /^\s*popup_during_fullscreen\s\+\w\+\s\?$/ contains=PopupOnFullscreenKeyword,PopupOnFullscreenType

" Focus wrapping
syn keyword FocusWrappingKeyword force_focus_wrapping focus_wrapping contained
syn keyword FocusWrappingType yes no contained
syn match FocusWrapping /^\s*\(force_\)\?focus_wrapping\s\+\(yes\|no\)\s\?$/ contains=FocusWrappingType,FocusWrappingKeyword

" Forcing Xinerama
syn keyword ForceXineramaKeyword force_xinerama contained
syn match ForceXinerama /^\s*force_xinerama\s\+\(yes\|no\)\s\?$/ contains=FocusWrappingType,ForceXineramaKeyword

" Automatic back-and-forth when switching to the current workspace
syn keyword AutomaticSwitchKeyword workspace_auto_back_and_forth contained
syn match AutomaticSwitch /^\s*workspace_auto_back_and_forth\s\+\(yes\|no\)\s\?$/ contains=FocusWrappingType,AutomaticSwitchKeyword

" Delay urgency hint
syn keyword TimeUnit ms contained
syn keyword DelayUrgencyKeyword force_display_urgency_hint contained
syn match DelayUrgency /^\s*force_display_urgency_hint\s\+\d\+\s\+ms\s\?$/ contains=FocusWrappingType,DelayUrgencyKeyword,Number,TimeUnit

" Focus on window activation
syn keyword FocusOnActivationKeyword focus_on_window_activation contained
syn keyword FocusOnActivationType smart urgent focus none contained
syn match FocusOnActivation /^\s*focus_on_window_activation\s\+\(smart\|urgent\|focus\|none\)\s\?$/  contains=FocusOnActivationKeyword,FocusOnActivationType

" Automatic back-and-forth when switching to the current workspace
syn keyword DrawingMarksKeyword show_marks contained
syn match DrawingMarks /^\s*show_marks\s\+\(yes\|no\)\s\?$/ contains=FocusWrappingType,DrawingMarksKeyword

" Group mode/bar
syn keyword BlockKeyword mode bar colors i3bar_command status_command position exec mode hidden_state modifier id position output background statusline tray_output tray_padding separator separator_symbol workspace_buttons strip_workspace_numbers binding_mode_indicator focused_workspace active_workspace inactive_workspace urgent_workspace binding_mode contained
syn region Block start=+.*s\?{$+ end=+^}$+ contains=BlockKeyword,String,Bind,Comment,Font,FocusWrappingType,Color,Variable transparent keepend extend

" Line continuation
syn region LineCont start=/^.*\\$/ end=/^.*$/ contains=BlockKeyword,String,Bind,Comment,Font,FocusWrappingType,Color,Variable transparent keepend extend

" Define the highlighting.
hi! def link Error Error
hi! def link Todo Todo
hi! def link Comment Comment
hi! def link FontContent Type
hi! def link FocusOnActivationType Type
hi! def link PopupOnFullscreenType Type
hi! def link OrientationKeyword Type
hi! def link MouseWarpingType Type
hi! def link FocusFollowsMouseType Type
hi! def link GapStyleKeyword Type
hi! def link LayoutKeyword Type
hi! def link BorderStyleKeyword Type
hi! def link EdgeKeyword Type
hi! def link Action Type
hi! def link Command Type
hi! def link Output Type
hi! def link WindowCommandSpecial Type
hi! def link FocusWrappingType Type
hi! def link FontSize Constant
hi! def link Color Constant
hi! def link Number Constant
hi! def link VariableAndModifier Constant
hi! def link TimeUnit Constant
hi! def link Modifier Constant
hi! def link String Constant
hi! def link NegativeSize Constant
hi! def link FontSeparator Special
hi! def link VariableModifier Special
hi! def link SizeSpecial Special
hi! def link WindowSpecial Special
hi! def link AssignSpecial Special
hi! def link FontNamespace PreProc
hi! def link BindArgument PreProc
hi! def link NoStartupId PreProc
hi! def link FontKeyword Identifier
hi! def link BindKeyword Identifier
hi! def link Orientation Identifier
hi! def link GapStyle Identifier
hi! def link Layout Identifier
hi! def link BorderStyle Identifier
hi! def link Edge Identifier
hi! def link Floating Identifier
hi! def link CommandKeyword Identifier
hi! def link NoFocusKeyword Identifier
hi! def link InitializeKeyword Identifier
hi! def link AssignKeyword Identifier
hi! def link ResourceKeyword Identifier
hi! def link ExecKeyword Identifier
hi! def link WorkspaceKeyword Identifier
hi! def link ClientColorKeyword Identifier
hi! def link InterprocessKeyword Identifier
hi! def link MouseWarpingKeyword Identifier
hi! def link FocusFollowsMouseKeyword Identifier
hi! def link PopupOnFullscreenKeyword Identifier
hi! def link FocusWrappingKeyword Identifier
hi! def link ForceXineramaKeyword Identifier
hi! def link AutomaticSwitchKeyword Identifier
hi! def link DelayUrgencyKeyword Identifier
hi! def link FocusOnActivationKeyword Identifier
hi! def link DrawingMarksKeyword Identifier
hi! def link BlockKeyword Identifier
hi! def link Variable Statement
hi! def link ArbitraryCommand Ignore

let b:current_syntax = "i3config"

endif
