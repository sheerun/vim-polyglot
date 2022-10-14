if polyglot#init#is_disabled(expand('<sfile>:p'), 'sway', 'syntax/swayconfig.vim')
  finish
endif

" Vim syntax file
" Language: sway config file
" Original Author: Mohamed Boughaba <mohamed dot bgb at gmail dot com>
" Maintainer: James Eapen <jamespeapen at gmail dot com>
" Version: 0.11.6
" Last Change: 2020-10-07 

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
syn match swayConfigError /.*/

" Todo
syn keyword swayConfigTodo TODO FIXME XXX contained

" Comment
" Comments are started with a # and can only be used at the beginning of a line
syn match swayConfigComment /^\s*#.*$/ contains=swayConfigTodo

" Font
" A FreeType font description is composed by:
" a font family, a style, a weight, a variant, a stretch and a size.
syn match swayConfigFontSeparator /,/ contained
syn match swayConfigFontSeparator /:/ contained
syn keyword swayConfigFontKeyword font contained
syn match swayConfigFontNamespace /\w\+:/ contained contains=swayConfigFontSeparator
syn match swayConfigFontContent /-\?\w\+\(-\+\|\s\+\|,\)/ contained contains=swayConfigFontNamespace,swayConfigFontSeparator,swayConfigFontKeyword
syn match swayConfigFontSize /\s\=\d\+\(px\)\?\s\?$/ contained
syn match swayConfigFont /^\s*font\s\+.*$/ contains=swayConfigFontContent,swayConfigFontSeparator,swayConfigFontSize,swayConfigFontNamespace
syn match swayConfigFont /^\s*font\s\+.*\(\\\_.*\)\?$/ contains=swayConfigFontContent,swayConfigFontSeparator,swayConfigFontSize,swayConfigFontNamespace
syn match swayConfigFont /^\s*font\s\+.*\(\\\_.*\)\?[^\\]\+$/ contains=swayConfigFontContent,swayConfigFontSeparator,swayConfigFontSize,swayConfigFontNamespace
syn match swayConfigFont /^\s*font\s\+\(\(.*\\\_.*\)\|\(.*[^\\]\+$\)\)/ contains=swayConfigFontContent,swayConfigFontSeparator,swayConfigFontSize,swayConfigFontNamespace

" variables
syn match swayConfigString /\(['"]\)\(.\{-}\)\1/ contained
syn match swayConfigColor /#\w\{6}/ contained
syn match swayConfigVariableModifier /+/ contained
syn match swayConfigVariableAndModifier /+\w\+/ contained contains=swayConfigVariableModifier
syn match swayConfigVariable /\$\w\+\(\(-\w\+\)\+\)\?\(\s\|+\)\?/ contains=swayConfigVariableModifier,swayConfigVariableAndModifier
syn keyword swayConfigInitializeKeyword set contained
syn match swayConfigInitialize /^\s*set\s\+.*$/ contains=swayConfigVariable,swayConfigInitializeKeyword,swayConfigColor,swayConfigString

" Gaps
syn keyword swayConfigGapStyleKeyword inner outer horizontal vertical top right bottom left current all set plus minus toggle up down contained
syn match swayConfigGapStyle /^\s*\(gaps\)\s\+\(inner\|outer\|horizontal\|vertical\|left\|top\|right\|bottom\)\(\s\+\(current\|all\)\)\?\(\s\+\(set\|plus\|minus\|toggle\)\)\?\(\s\+\(-\?\d\+\|\$.*\)\)$/ contains=swayConfigGapStyleKeyword,swayConfigNumber,swayConfigVariable
syn keyword swayConfigSmartGapKeyword on inverse_outer off contained
syn match swayConfigSmartGap /^\s*smart_gaps\s\+\(on\|inverse_outer\|off\)\s\?$/ contains=swayConfigSmartGapKeyword
syn keyword swayConfigSmartBorderKeyword on no_gaps off contained
syn match swayConfigSmartBorder /^\s*smart_borders\s\+\(on\|no_gaps\|off\)\s\?$/ contains=swayConfigSmartBorderKeyword

" Keyboard bindings
syn keyword swayConfigAction toggle fullscreen restart key import kill shrink grow contained
syn keyword swayConfigAction focus move grow height width split layout resize restore reload mute unmute exit mode workspace container to output contained
syn match swayConfigModifier /\w\++\w\+\(\(+\w\+\)\+\)\?/ contained contains=swayConfigVariableModifier
syn match swayConfigNumber /\s[+-]\?\(\d\+\.\)\?\d\+/ contained
syn match swayConfigUnit /\sp\(pt\|x\)/ contained
syn match swayConfigUnitOr /\sor/ contained
syn keyword swayConfigBindKeyword bindsym bindcode bindswitch bindgesture exec gaps border contained
syn match swayConfigBindArgument /--\w\+\(\(-\w\+\)\+\)\?\s/ contained
syn match swayConfigBind /^\s*\(bindsym\|bindcode\|bindswitch\)\s\+.*$/ contains=swayConfigVariable,swayConfigBindKeyword,swayConfigVariableAndModifier,swayConfigNumber,swayConfigUnit,swayConfigUnitOr,swayConfigBindArgument,swayConfigModifier,swayConfigAction,swayConfigString,swayConfigGapStyleKeyword,swayConfigBorderStyleKeyword

" bindgestures
syn keyword swayConfigBindGestureCommand swipe pinch hold contained
syn keyword swayConfigBindGestureDirection up down left right next prev contained
syn keyword swayConfigBindGesturePinchDirection inward outward clockwise counterclockwise contained
syn match swayConfigBindGestureHold /^\s*\(bindgesture\)\s\+hold\(:[1-5]\)\?\s\+.*$/ contains=swayConfigBindKeyword,swayConfigBindGestureCommand,swayConfigBindGestureDirection,swayConfigWorkspaceKeyword,swayConfigAction
syn match swayConfigBindGestureSwipe /^\s*\(bindgesture\)\s\+swipe\(:[3-5]\)\?:\(up\|down\|left\|right\)\s\+.*$/ contains=swayConfigBindKeyword,swayConfigBindGestureCommand,swayConfigBindGestureDirection,swayConfigWorkspaceKeyword,swayConfigAction
syn match swayConfigBindGesturePinch /^\s*\(bindgesture\)\s\+pinch\(:[2-5]\)\?:\(up\|down\|left\|right\|inward\|outward\|clockwise\|counterclockwise\)\(+\(up\|down\|left\|right\|inward\|outward\|clockwise\|counterclockwise\)\)\?.*$/ contains=swayConfigBindKeyword,swayConfigBindGestureCommand,swayConfigBindGestureDirection,swayConfigBindGesturePinchDirection,swayConfigWorkspaceKeyword,swayConfigAction

" Floating
syn keyword swayConfigFloatingKeyword floating contained
syn match swayConfigFloating /^\s*floating\s\+\(enable\|disable\|toggle\)\s*$/ contains=swayConfigFloatingKeyword

syn keyword swayConfigFloatingModifier floating_modifier contained
syn match swayConfigFloatingMouseAction /^\s\?.*floating_modifier\s\S\+\s\?\(normal\|inverted\|none\)\?$/ contains=swayConfigFloatingModifier,swayConfigVariable

syn keyword swayConfigSizeSpecial x contained
syn match swayConfigNegativeSize /-/ contained
syn match swayConfigSize /-\?\d\+\s\?x\s\?-\?\d\+/ contained contains=swayConfigSizeSpecial,swayConfigNumber,swayConfigNegativeSize
syn match swayConfigFloatingSize /^\s*floating_\(maximum\|minimum\)_size\s\+-\?\d\+\s\?x\s\?-\?\d\+/ contains=swayConfigSize

" Orientation
syn keyword swayConfigOrientationKeyword vertical horizontal auto contained
syn match swayConfigOrientation /^\s*default_orientation\s\+\(vertical\|horizontal\|auto\)\s\?$/ contains=swayConfigOrientationKeyword

" Layout
syn keyword swayConfigLayoutKeyword default stacking tabbed contained
syn match swayConfigLayout /^\s*workspace_layout\s\+\(default\|stacking\|tabbed\)\s\?$/ contains=swayConfigLayoutKeyword

" Border style
syn keyword swayConfigBorderStyleKeyword none normal pixel contained
syn match swayConfigBorderStyle /^\s*\(new_window\|new_float\|default_border\|default_floating_border\)\s\+\(none\|\(normal\|pixel\)\(\s\+\d\+\)\?\(\s\+\$\w\+\(\(-\w\+\)\+\)\?\(\s\|+\)\?\)\?\)\s\?$/ contains=swayConfigBorderStyleKeyword,swayConfigNumber,swayConfigVariable

" Hide borders and edges
syn keyword swayConfigEdgeKeyword none vertical horizontal both smart smart_no_gaps contained
syn match swayConfigEdge /^\s*hide_edge_borders\s\+\(none\|vertical\|horizontal\|both\|smart\|smart_no_gaps\)\s\?$/ contains=swayConfigEdgeKeyword

" Arbitrary commands for specific windows (for_window)
syn keyword swayConfigCommandKeyword for_window contained
syn region swayConfigWindowStringSpecial start=+"+  skip=+\\"+  end=+"+ contained contains=swayConfigString
syn region swayConfigWindowCommandSpecial start="\[" end="\]" contained contains=swayConfigWindowStringSpacial,swayConfigString
syn match swayConfigArbitraryCommand /^\s*for_window\s\+.*$/ contains=swayConfigWindowCommandSpecial,swayConfigCommandKeyword,swayConfigBorderStyleKeyword,swayConfigLayoutKeyword,swayConfigOrientationKeyword,Size,swayConfigNumber

" Disable focus open opening
syn keyword swayConfigNoFocusKeyword no_focus contained
syn match swayConfigDisableFocus /^\s*no_focus\s\+.*$/ contains=swayConfigWindowCommandSpecial,swayConfigNoFocusKeyword

" Move client to specific workspace automatically
syn keyword swayConfigAssignKeyword assign contained
syn match swayConfigAssignSpecial /→/ contained
syn match swayConfigAssign /^\s*assign\s\+.*$/ contains=swayConfigAssignKeyword,swayConfigWindowCommandSpecial,swayConfigAssignSpecial

" X resources
syn keyword swayConfigResourceKeyword set_from_resource contained
syn match swayConfigResource /^\s*set_from_resource\s\+.*$/ contains=swayConfigResourceKeyword,swayConfigWindowCommandSpecial,swayConfigColor,swayConfigVariable

" Auto start applications
syn keyword swayConfigExecKeyword exec exec_always contained
syn match swayConfigNoStartupId /--no-startup-id/ contained " We are not using swayConfigBindArgument as only no-startup-id is supported here
syn match swayConfigExec /^\s*exec\(_always\)\?\s\+.*$/ contains=swayConfigExecKeyword,swayConfigNoStartupId,swayConfigString

" Input config
syn keyword swayConfigInputKeyword input contained
syn match swayConfigInput /^\s*input\s\+.*$/ contains=swayConfigInputKeyword

" Automatically putting workspaces on specific screens
syn keyword swayConfigWorkspaceKeyword workspace contained
syn keyword swayConfigOutputKeyword output contained
syn match swayConfigWorkspace /^\s*workspace\s\+.*$/ contains=swayConfigWorkspaceKeyword,swayConfigNumber,swayConfigString,swayConfigOutputKeyword

" set display outputs
syn match swayConfigOutput /^\s*output\s\+.*$/ contains=swayConfigOutputKeyword

" set display focus 
syn keyword swayConfigFocusKeyword focus contained
syn keyword swayConfigFocusType output contained
syn match swayConfigFocus /^\s*focus\soutput\s.*$/ contains=swayConfigFocusKeyword,swayConfigFocusType

" Changing colors
syn keyword swayConfigClientKeyword client contained
syn keyword swayConfigClientColorKeyword focused focused_inactive focused_tab_title unfocused urgent placeholder contained
syn match swayConfigClientColor /^\s*client.\w\+\s\+.*$/ contains=swayConfigClientKeyword,swayConfigClientColorKeyword,swayConfigColor,swayConfigVariable

syn keyword swayConfigTitleAlignKeyword left center right contained
syn match swayConfigTitleAlign /^\s*title_align\s\+.*$/ contains=swayConfigTitleAlignKeyword

" Interprocess communication
syn match swayConfigInterprocessKeyword /ipc-socket/ contained
syn match swayConfigInterprocess /^\s*ipc-socket\s\+.*$/ contains=swayConfigInterprocessKeyword

" Mouse warping
syn keyword swayConfigMouseWarpingKeyword mouse_warping contained
syn keyword swayConfigMouseWarpingType output none contained
syn match swayConfigMouseWarping /^\s*mouse_warping\s\+\(output\|none\)\s\?$/ contains=swayConfigMouseWarpingKeyword,swayConfigMouseWarpingType

" Focus follows mouse
syn keyword swayConfigFocusFollowsMouseKeyword focus_follows_mouse contained
syn keyword swayConfigFocusFollowsMouseType yes no always contained
syn match swayConfigFocusFollowsMouse /^\s*focus_follows_mouse\s\+\(yes\|no\|always\)\s\?$/ contains=swayConfigFocusFollowsMouseKeyword,swayConfigFocusFollowsMouseType

" Popups during fullscreen mode
syn keyword swayConfigPopupOnFullscreenKeyword popup_during_fullscreen contained
syn keyword swayConfigPopuponFullscreenType smart ignore leave_fullscreen contained
syn match swayConfigPopupOnFullscreen /^\s*popup_during_fullscreen\s\+\w\+\s\?$/ contains=swayConfigPopupOnFullscreenKeyword,swayConfigPopupOnFullscreenType

" Focus wrapping
syn keyword swayConfigFocusWrappingKeyword force_focus_wrapping focus_wrapping contained
syn keyword swayConfigFocusWrappingType yes no contained
syn match swayConfigFocusWrapping /^\s*\(force_\)\?focus_wrapping\s\+\(yes\|no\)\s\?$/ contains=swayConfigFocusWrappingType,swayConfigFocusWrappingKeyword

" Forcing Xinerama
syn keyword swayConfigForceXineramaKeyword force_xinerama contained
syn match swayConfigForceXinerama /^\s*force_xinerama\s\+\(yes\|no\)\s\?$/ contains=swayConfigFocusWrappingType,swayConfigForceXineramaKeyword

" Automatic back-and-forth when switching to the current workspace
syn keyword swayConfigAutomaticSwitchKeyword workspace_auto_back_and_forth contained
syn match swayConfigAutomaticSwitch /^\s*workspace_auto_back_and_forth\s\+\(yes\|no\)\s\?$/ contains=swayConfigFocusWrappingType,swayConfigAutomaticSwitchKeyword

" Delay urgency hint
syn keyword swayConfigTimeUnit ms contained
syn keyword swayConfigDelayUrgencyKeyword force_display_urgency_hint contained
syn match swayConfigDelayUrgency /^\s*force_display_urgency_hint\s\+\d\+\s\+ms\s\?$/ contains=swayConfigFocusWrappingType,swayConfigDelayUrgencyKeyword,swayConfigNumber,swayConfigTimeUnit

" Focus on window activation
syn keyword swayConfigFocusOnActivationKeyword focus_on_window_activation contained
syn keyword swayConfigFocusOnActivationType smart urgent focus none contained
syn match swayConfigFocusOnActivation /^\s*focus_on_window_activation\s\+\(smart\|urgent\|focus\|none\)\s\?$/  contains=swayConfigFocusOnActivationKeyword,swayConfigFocusOnActivationType

" Automatic back-and-forth when switching to the current workspace
syn keyword swayConfigDrawingMarksKeyword show_marks contained
syn match swayConfigDrawingMarks /^\s*show_marks\s\+\(yes\|no\)\s\?$/ contains=swayConfigFocusWrappingType,swayConfigDrawingMarksKeyword

" Group mode/bar
syn keyword swayConfigBlockKeyword set bar colors i3bar_command status_command position hidden_state modifier id position background statusline tray_output tray_padding separator separator_symbol workspace_buttons strip_workspace_numbers binding_mode_indicator focused_workspace active_workspace inactive_workspace urgent_workspace binding_mode contained
syn region swayConfigBlock start=+.*s\?{$+ end=+^}$+ contains=swayConfigBlockKeyword,swayConfigString,swayConfigAction,swayConfigBind,swayConfigComment,swayConfigFont,swayConfigFocusWrappingType,swayConfigColor,swayConfigVariable,swayConfigInputKeyword,swayConfigOutputKeyword transparent keepend extend

" Line continuation
syn region swayConfigLineCont start=/^.*\\$/ end=/^[^\\]*$/ contains=swayConfigBlockKeyword,swayConfigString,swayConfigAction,swayConfigBind,swayConfigComment,swayConfigFont,swayConfigFocusWrappingType,swayConfigColor,swayConfigVariable,swayConfigExecKeyword transparent keepend extend

" Includes with relative paths to config files
syn keyword swayConfigInclude include contained
syn match swayConfigFile /^\s\?include\s\+.*$/ contains=swayConfigInclude

" xwayland 
syn keyword swayConfigXwaylandKeyword xwayland contained
syn match swayConfigXwaylandModifier /^\s*xwayland\s\+\(enable\|disable\|force\)\s\?$/ contains=swayConfigXwaylandKeyword

" Define the highlighting.
let b:current_syntax = "swayconfig"
hi! def link swayConfigError                           Error
hi! def link swayConfigTodo                            Todo
hi! def link swayConfigComment                         Comment
hi! def link swayConfigFontContent                     Type
hi! def link swayConfigFocusOnActivationType           Type
hi! def link swayConfigPopupOnFullscreenType           Type
hi! def link swayConfigOrientationKeyword              Type
hi! def link swayConfigMouseWarpingType                Type
hi! def link swayConfigFocusFollowsMouseType           Type
hi! def link swayConfigGapStyleKeyword                 Type
hi! def link swayConfigTitleAlignKeyword               Type
hi! def link swayConfigSmartGapKeyword                 Type
hi! def link swayConfigSmartBorderKeyword              Type
hi! def link swayConfigLayoutKeyword                   Type
hi! def link swayConfigBorderStyleKeyword              Type
hi! def link swayConfigEdgeKeyword                     Type
hi! def link swayConfigAction                          Type
hi! def link swayConfigCommand                         Type
hi! def link swayConfigOutputKeyword                   Type
hi! def link swayConfigInputKeyword                    Type
hi! def link swayConfigWindowCommandSpecial            Type
hi! def link swayConfigFocusWrappingType               Type
hi! def link swayConfigUnitOr                          Type
hi! def link swayConfigClientColorKeyword              Type
hi! def link swayConfigFloating                        Type
hi! def link swayConfigBindGestureDirection            Constant
hi! def link swayConfigBindGesturePinchDirection       Constant
hi! def link swayConfigFontSize                        Constant
hi! def link swayConfigColor                           Constant
hi! def link swayConfigNumber                          Constant
hi! def link swayConfigUnit                            Constant
hi! def link swayConfigVariableAndModifier             Constant
hi! def link swayConfigTimeUnit                        Constant
hi! def link swayConfigModifier                        Constant
hi! def link swayConfigString                          Constant
hi! def link swayConfigNegativeSize                    Constant
hi! def link swayConfigFontSeparator                   Special
hi! def link swayConfigVariableModifier                Special
hi! def link swayConfigSizeSpecial                     Special
hi! def link swayConfigWindowSpecial                   Special
hi! def link swayConfigAssignSpecial                   Special
hi! def link swayConfigFontNamespace                   PreProc
hi! def link swayConfigBindArgument                    PreProc
hi! def link swayConfigNoStartupId                     PreProc
hi! def link swayConfigBindGesture                     PreProc
hi! def link swayConfigFontKeyword                     Identifier
hi! def link swayConfigBindKeyword                     Identifier
hi! def link swayConfigBindGestureCommand              Identifier
hi! def link swayConfigOrientation                     Identifier
hi! def link swayConfigGapStyle                        Identifier
hi! def link swayConfigTitleAlign                      Identifier
hi! def link swayConfigSmartGap                        Identifier
hi! def link swayConfigSmartBorder                     Identifier
hi! def link swayConfigLayout                          Identifier
hi! def link swayConfigBorderStyle                     Identifier
hi! def link swayConfigEdge                            Identifier
hi! def link swayConfigFloatingSize                    Identifier
hi! def link swayConfigCommandKeyword                  Identifier
hi! def link swayConfigNoFocusKeyword                  Identifier
hi! def link swayConfigInitializeKeyword               Identifier
hi! def link swayConfigAssignKeyword                   Identifier
hi! def link swayConfigResourceKeyword                 Identifier
hi! def link swayConfigExecKeyword                     Identifier
hi! def link swayConfigWorkspaceKeyword                Identifier
hi! def link swayConfigClientKeyword                   Identifier
hi! def link swayConfigInterprocessKeyword             Identifier
hi! def link swayConfigMouseWarpingKeyword             Identifier
hi! def link swayConfigFocusFollowsMouseKeyword        Identifier
hi! def link swayConfigPopupOnFullscreenKeyword        Identifier
hi! def link swayConfigFocusWrappingKeyword            Identifier
hi! def link swayConfigForceXineramaKeyword            Identifier
hi! def link swayConfigAutomaticSwitchKeyword          Identifier
hi! def link swayConfigDelayUrgencyKeyword             Identifier
hi! def link swayConfigFocusOnActivationKeyword        Identifier
hi! def link swayConfigDrawingMarksKeyword             Identifier
hi! def link swayConfigBlockKeyword                    Identifier
hi! def link swayConfigVariable                        Statement
hi! def link swayConfigArbitraryCommand                Type
hi! def link swayConfigInclude                         Identifier
hi! def link swayConfigFile                            Constant
hi! def link swayConfigFloatingKeyword                 Identifier
hi! def link swayConfigFloatingModifier                Identifier
hi! def link swayConfigFloatingMouseAction             Type
hi! def link swayConfigFocusKeyword                    Type
hi! def link swayConfigFocusType                       Identifier
hi! def link swayConfigXwaylandKeyword                 Identifier
hi! def link swayConfigXwaylandModifier                Type

