if polyglot#init#is_disabled(expand('<sfile>:p'), 'tridactyl', 'syntax/tridactyl.vim')
  finish
endif

" Vim syntax file
" Language:   Tridactyl
" Maintainer: Caleb Maclennan <caleb@alerque.com>
" URL:        https://github.com/tridactyl/vim-tridactyl

scriptencoding utf-8

if exists('b:current_syntax')
	finish
endif

syntax include @JS	syntax/javascript.vim

syntax sync maxlines=200
syntax sync minlines=50

" Regenerate from Tridactyl source using:
" :read! sed -n -e "/function.*{/{s/.*function //;s/(.*//;p}" src/excmds.ts | sort -u | xargs
syntax keyword tridactylExcmd		contained
			\ addJump addTridactylEditorClass apropos argParse autocmd autocmddelete
			\ autocontain back bind bindurl blacklistadd bmark bmarks buildFilterConfigs changelistjump
			\ clearsearchhighlight clipboard colourscheme comclear command composite containerclose containercreate
			\ containerdelete containerupdate credits cssparse curJumps echo editor exclaim exclaim_quiet extoptions
			\ fillcmdline fillcmdline_nofocus fillcmdline_notrail fillcmdline_tmp fillinput find findintabs findnext
			\ findRelLink fixamo fixamo_quiet focusbyid focusinput followpage forward fullscreen get getclip getinput
			\ getInput getInputSelector getJumpPageId getNativeVersion getnexttabs getRssLinks getSortedWinTabs
			\ geturlsforlinks gobble guiset guiset_quiet help hidecmdline hint history home idFromIndex issue js jsb
			\ jumpnext jumpprev keyfeed keymap loadaucmds loadtheme mktridactylrc mode mute native nativeinstall
			\ nativeopen neo_mouse_mode no_mouse_mode open open_quiet parse_bind_args perfdump perfhistogram pin qall
			\ quickmark rapid reader reload reloadall reloadallbut reloadhard removepref removeSource
			\ removeTridactylEditorClass repeat reset reseturl restart rot13 rssexec run_exstr sanitise saveas
			\ saveJumps scrollline scrollpage scrollpx scrollto searchsetkeyword selectLast set setclip setpref seturl
			\ shellescape showcmdline sleep snow_mouse_mode source source_quiet tab taball tabclose tabclosealltoleft
			\ tabclosealltoright tabdetach tabduplicate tabIndexSetActive tabmove tabnext tabnext_gt tabonly tabopen
			\ tabprev tabSetActive tssReadFromCss ttscontrol ttsread ttsvoices tutor unbind unbindurl undo unfocus
			\ unloadtheme unset unseturl updatecheck updatenative url2args urlincrement urlmodify urlparent urlroot
			\ validateSetArgs version viewconfig viewcontainers viewsource winclose winopen yank zoom
			\ document

" :read! sed -n -e "/^const AUCMDS/{s/^.*\[//;s/\]//;s/,//g;p}" src/excmds.ts | sort -u | xargs
syntax keyword tridactylAucmd		contained
			\ DocStart DocLoad DocEnd TriStart TabEnter TabLeft FullscreenChange FullscreenEnter FullscreenLeft

syntax match tridactylStart			'^'				keepend contains=@NoSpell nextgroup=tridactylCmd
syntax match tridactylComment		'^".*$'			contains=@Spell

syntax match tridactylCmd			"\h\+"				keepend contained contains=tridactylExcmd
syntax match tridactylCmds			"autocmd"			keepend containedin=tridactylCmd contains=tridactylExcmd nextgroup=tridactylEvent
syntax match tridactylCmds			"\(un\)\?bind\>"	keepend containedin=tridactylCmd contains=tridactylExcmd skipwhite nextgroup=tridactylKeys
syntax match tridactylCmds			"\(un\)\?bindurl"	keepend containedin=tridactylCmd contains=tridactylExcmd nextgroup=tridactylBindUrl
syntax match tridactylCmds			"jsb\?"				keepend containedin=tridactylCmd contains=tridactylExcmd nextgroup=tridactylJavascript

syntax match tridactylKeys			'[^ ]\+'		keepend contained skipwhite nextgroup=tridactylCmd
syntax match Delimiter				'[<>-]'			keepend contained containedin=tridactylKeys

syntax region tridactylJavascript		start=' '	end='$'			keepend oneline contained contains=@JS
syntax region tridactylEvent			start=' '	end=' 'me=s-1	keepend oneline contains=tridactylAucmd contained nextgroup=tridactylUrl
syntax region tridactylUrl				start=' '	end=' 'me=s-1	keepend oneline contained nextgroup=tridactylCmd
syntax region tridactylBindUrl			start=' '	end=' 'me=s-1	keepend oneline contained skipwhite nextgroup=tridactylKeys

highlight! def link tridactylComment		Comment
highlight! def link tridactylCmd			Function
highlight! def link tridactylCmds			Type
highlight! def link tridactylExcmd			Statement
highlight! def link tridactylAucmd			Constant
highlight! def link tridactylKeys			Character
highlight! def link tridactylUrl			String
highlight! def link tridactylBindUrl		String

let b:current_syntax = 'tridactyl'
" vim: set noet ts=4 sw=4 sts=4:
