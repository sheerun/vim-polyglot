if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vim') == -1
  
" Language: tmux(1) configuration file
" Version: 2.3 (git-14dc2ac)
" URL: https://github.com/ericpruitt/tmux.vim/
" Maintainer: Eric Pruitt <eric.pruitt@gmail.com>
" License: 2-Clause BSD (http://opensource.org/licenses/BSD-2-Clause)

if exists("b:current_syntax")
    finish
endif

" Explicitly change compatiblity options to Vim's defaults because this file
" uses line continuations.
let s:original_cpo = &cpo
set cpo&vim

let b:current_syntax = "tmux"
setlocal iskeyword+=-
syntax case match

syn keyword tmuxAction  none any current other
syn keyword tmuxBoolean off on

syn keyword tmuxTodo FIXME NOTE TODO XXX contained

syn match tmuxColour            /\<colour[0-9]\+/      display
syn match tmuxKey               /\(C-\|M-\|\^\)\+\S\+/ display
syn match tmuxNumber            /\d\+/                 display
syn match tmuxFlags             /\s-\a\+/              display
syn match tmuxVariable          /\w\+=/                display
syn match tmuxVariableExpansion /\${\=\w\+}\=/         display

syn region tmuxComment start=/#/ skip=/\\\@<!\\$/ end=/$/ contains=tmuxTodo

syn region tmuxString start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end='$' contains=tmuxFormatString
syn region tmuxString start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end='$' contains=tmuxFormatString

" TODO: Figure out how escaping works inside of #(...) and #{...} blocks.
syn region tmuxFormatString start=/#[#DFhHIPSTW]/ end=// contained keepend
syn region tmuxFormatString start=/#{/ skip=/#{.\{-}}/ end=/}/ contained keepend
syn region tmuxFormatString start=/#(/ skip=/#(.\{-})/ end=/)/ contained keepend

hi def link tmuxFormatString      Identifier
hi def link tmuxAction            Boolean
hi def link tmuxBoolean           Boolean
hi def link tmuxCommands          Keyword
hi def link tmuxComment           Comment
hi def link tmuxKey               Special
hi def link tmuxNumber            Number
hi def link tmuxFlags             Identifier
hi def link tmuxOptions           Function
hi def link tmuxString            String
hi def link tmuxTodo              Todo
hi def link tmuxVariable          Identifier
hi def link tmuxVariableExpansion Identifier

" Make the foreground of colourXXX keywords match the color they represent.
" Darker colors have their background set to white.
for s:i in range(0, 255)
    let s:bg = (!s:i || s:i == 16 || (s:i > 231 && s:i < 235)) ? 15 : "none"
    exec "syn match tmuxColour" . s:i . " /\\<colour" . s:i . "\\>/ display"
\     " | highlight tmuxColour" . s:i . " ctermfg=" . s:i . " ctermbg=" . s:bg
endfor

syn keyword tmuxOptions
\ buffer-limit command-alias default-terminal escape-time exit-unattached
\ focus-events history-file message-limit set-clipboard terminal-overrides
\ assume-paste-time base-index bell-action bell-on-alert default-command
\ default-shell destroy-unattached detach-on-destroy
\ display-panes-active-colour display-panes-colour display-panes-time
\ display-time history-limit key-table lock-after-time lock-command
\ message-attr message-bg message-command-attr message-command-bg
\ message-command-fg message-command-style message-fg message-style mouse
\ prefix prefix2 renumber-windows repeat-time set-titles set-titles-string
\ status status-attr status-bg status-fg status-interval status-justify
\ status-keys status-left status-left-attr status-left-bg status-left-fg
\ status-left-length status-left-style status-position status-right
\ status-right-attr status-right-bg status-right-fg status-right-length
\ status-right-style status-style update-environment visual-activity
\ visual-bell visual-silence word-separators aggressive-resize allow-rename
\ alternate-screen automatic-rename automatic-rename-format
\ clock-mode-colour clock-mode-style force-height force-width
\ main-pane-height main-pane-width mode-attr mode-bg mode-fg mode-keys
\ mode-style monitor-activity monitor-silence other-pane-height
\ other-pane-width pane-active-border-bg pane-active-border-fg
\ pane-active-border-style pane-base-index pane-border-bg pane-border-fg
\ pane-border-format pane-border-status pane-border-style remain-on-exit
\ synchronize-panes window-active-style window-style
\ window-status-activity-attr window-status-activity-bg
\ window-status-activity-fg window-status-activity-style window-status-attr
\ window-status-bell-attr window-status-bell-bg window-status-bell-fg
\ window-status-bell-style window-status-bg window-status-current-attr
\ window-status-current-bg window-status-current-fg
\ window-status-current-format window-status-current-style window-status-fg
\ window-status-format window-status-last-attr window-status-last-bg
\ window-status-last-fg window-status-last-style window-status-separator
\ window-status-style wrap-search xterm-keys

syn keyword tmuxCommands
\ attach-session attach bind-key bind break-pane breakp capture-pane
\ capturep clear-history clearhist choose-buffer choose-client choose-tree
\ choose-session choose-window command-prompt confirm-before confirm
\ copy-mode clock-mode detach-client detach suspend-client suspendc
\ display-message display display-panes displayp find-window findw if-shell
\ if join-pane joinp move-pane movep kill-pane killp kill-server
\ start-server start kill-session kill-window killw unlink-window unlinkw
\ list-buffers lsb list-clients lsc list-keys lsk list-commands lscm
\ list-panes lsp list-sessions ls list-windows lsw load-buffer loadb
\ lock-server lock lock-session locks lock-client lockc move-window movew
\ link-window linkw new-session new has-session has new-window neww
\ paste-buffer pasteb pipe-pane pipep refresh-client refresh rename-session
\ rename rename-window renamew resize-pane resizep respawn-pane respawnp
\ respawn-window respawnw rotate-window rotatew run-shell run save-buffer
\ saveb show-buffer showb select-layout selectl next-layout nextl
\ previous-layout prevl select-pane selectp last-pane lastp select-window
\ selectw next-window next previous-window prev last-window last send-keys
\ send send-prefix set-buffer setb delete-buffer deleteb set-environment
\ setenv set-hook show-hooks set-option set set-window-option setw
\ show-environment showenv show-messages showmsgs show-options show
\ show-window-options showw source-file source split-window splitw swap-pane
\ swapp swap-window swapw switch-client switchc unbind-key unbind wait-for
\ wait

let &cpo = s:original_cpo
unlet! s:original_cpo s:bg s:i

endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'tmux') == -1
  
" Vim syntax file
" Language: tmux(1) configuration file
" Maintainer: Tiago Cunha <tcunha@users.sourceforge.net>
" License: This file is placed in the public domain.
"
" To install this file:
"
" - Drop the file in the syntax directory into runtimepath (such as
"  ~/.vim/syntax/tmux.vim).
" - Make the filetype recognisable by adding the following to filetype.vim
"   (~/.vim/filetype.vim):
"
"	augroup filetypedetect
"		au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
"	augroup END
"
" - Switch on syntax highlighting by adding "syntax enable" to .vimrc.
"

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

setlocal iskeyword+=-
syntax case match

syn keyword tmuxAction	any current default none
syn keyword tmuxBoolean	off on

syn keyword tmuxCmds
	\ attach
	\ attach-session
	\ bind
	\ bind-key
	\ break-pane
	\ breakp
	\ capture-pane
	\ capturep
	\ choose-buffer
	\ choose-client
	\ choose-session
	\ choose-tree
	\ choose-window
	\ clear-history
	\ clearhist
	\ clock-mode
	\ command-prompt
	\ confirm
	\ confirm-before
	\ copy-mode
	\ delete-buffer
	\ deleteb
	\ detach
	\ detach-client
	\ display
	\ display-message
	\ display-panes
	\ displayp
	\ find-window
	\ findw
	\ has
	\ has-session
	\ if
	\ if-shell
	\ info
	\ join-pane
	\ joinp
	\ kill-pane
	\ kill-server
	\ kill-session
	\ kill-window
	\ killp
	\ killw
	\ last
	\ last-pane
	\ last-window
	\ lastp
	\ link-window
	\ linkw
	\ list-buffers
	\ list-clients
	\ list-commands
	\ list-keys
	\ list-panes
	\ list-sessions
	\ list-windows
	\ load-buffer
	\ loadb
	\ lock
	\ lock-client
	\ lock-server
	\ lock-session
	\ lockc
	\ locks
	\ ls
	\ lsb
	\ lsc
	\ lscm
	\ lsk
	\ lsp
	\ lsw
	\ move-pane
	\ move-window
	\ movep
	\ movew
	\ new
	\ new-session
	\ new-window
	\ neww
	\ next
	\ next-layout
	\ next-window
	\ nextl
	\ paste-buffer
	\ pasteb
	\ path
	\ pipe-pane
	\ pipep
	\ prev
	\ previous-layout
	\ previous-window
	\ prevl
	\ refresh
	\ refresh-client
	\ rename
	\ rename-session
	\ rename-window
	\ renamew
	\ resize-pane
	\ resizep
	\ respawn-pane
	\ respawn-window
	\ respawnp
	\ respawnw
	\ rotate-window
	\ rotatew
	\ run
	\ run-shell
	\ save-buffer
	\ saveb
	\ select-layout
	\ select-pane
	\ select-window
	\ selectl
	\ selectp
	\ selectw
	\ send
	\ send-keys
	\ send-prefix
	\ server-info
	\ set
	\ set-buffer
	\ set-environment
	\ set-hook
	\ set-option
	\ set-window-option
	\ setb
	\ setenv
	\ setw
	\ show
	\ show-buffer
	\ show-environment
	\ show-hooks
	\ show-messages
	\ show-options
	\ show-window-options
	\ showb
	\ showenv
	\ showmsgs
	\ showw
	\ source
	\ source-file
	\ split-window
	\ splitw
	\ start
	\ start-server
	\ suspend-client
	\ suspendc
	\ swap-pane
	\ swap-window
	\ swapp
	\ swapw
	\ switch-client
	\ switchc
	\ unbind
	\ unbind-key
	\ unlink-window
	\ unlinkw
	\ wait
	\ wait-for

syn keyword tmuxOptsSet
	\ assume-paste-time
	\ base-index
	\ bell-action
	\ bell-on-alert
	\ buffer-limit
	\ default-command
	\ default-shell
	\ default-terminal
	\ destroy-unattached
	\ detach-on-destroy
	\ display-panes-active-colour
	\ display-panes-colour
	\ display-panes-time
	\ display-time
	\ escape-time
	\ exit-unattached
	\ focus-events
	\ history-file
	\ history-limit
	\ lock-after-time
	\ lock-command
	\ message-command-style
	\ message-limit
	\ message-style
	\ mouse
	\ prefix
	\ prefix2
	\ quiet
	\ renumber-windows
	\ repeat-time
	\ set-clipboard
	\ set-remain-on-exit
	\ set-titles
	\ set-titles-string
	\ status
	\ status-bg
	\ status-fg
	\ status-interval
	\ status-justify
	\ status-keys
	\ status-left
	\ status-left-length
	\ status-left-style
	\ status-position
	\ status-right
	\ status-right-length
	\ status-right-style
	\ status-style
	\ terminal-overrides
	\ update-environment
	\ visual-activity
	\ visual-bell
	\ visual-silence
	\ word-separators

syn keyword tmuxOptsSetw
	\ aggressive-resize
	\ allow-rename
	\ alternate-screen
	\ automatic-rename
	\ automatic-rename-format
	\ clock-mode-colour
	\ clock-mode-style
	\ force-height
	\ force-width
	\ main-pane-height
	\ main-pane-width
	\ message-attr
	\ message-bg
	\ message-fg
	\ mode-keys
	\ mode-style
	\ monitor-activity
	\ monitor-silence
	\ other-pane-height
	\ other-pane-width
	\ pane-active-border-bg
	\ pane-active-border-fg
	\ pane-active-border-style
	\ pane-base-index
	\ pane-border-fg
	\ pane-border-style
	\ remain-on-exit
	\ synchronize-panes
	\ window-active-style
	\ window-status-activity-attr
	\ window-status-activity-bg
	\ window-status-activity-fg
	\ window-status-activity-style
	\ window-status-bell-style
	\ window-status-bg
	\ window-status-current-attr
	\ window-status-current-bg
	\ window-status-current-fg
	\ window-status-current-format
	\ window-status-current-style
	\ window-status-fg
	\ window-status-format
	\ window-status-last-style
	\ window-status-separator
	\ window-status-style
	\ window-style
	\ wrap-search
	\ xterm-keys

syn keyword tmuxTodo FIXME NOTE TODO XXX contained

syn match tmuxKey		/\(C-\|M-\|\^\)\+\S\+/	display
syn match tmuxNumber 		/\<\d\+\>/			display
syn match tmuxOptions		/\s-\a\+/		display
syn match tmuxVariable		/\w\+=/			display
syn match tmuxVariableExpansion	/\${\=\w\+}\=/		display

" Comments can span multiple lines, when the newline is escaped
" (with a single) backslash at the end.
syn region tmuxComment  start=/#/ skip=/\\\@<!\\$/ end=/$/ contains=tmuxTodo
syn region tmuxString	start=/"/ end=/"/ display oneline
syn region tmuxString	start=/'/ end=/'/ display oneline

hi def link tmuxAction			Boolean
hi def link tmuxBoolean			Boolean
hi def link tmuxCmds			Keyword
hi def link tmuxComment			Comment
hi def link tmuxKey			Special
hi def link tmuxNumber			Number
hi def link tmuxOptions			Identifier
hi def link tmuxOptsSet			Function
hi def link tmuxOptsSetw		Function
hi def link tmuxString			String
hi def link tmuxTodo			Todo
hi def link tmuxVariable		Constant
hi def link tmuxVariableExpansion	Constant

let b:current_syntax = "tmux"

endif
