if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'org') == -1
  
" org.vim -- Text outlining and task management for Vim based on Emacs' Org-Mode
" @Author       : Jan Christoph Ebersbach (jceb@e-jc.de)
" @License      : AGPL3 (see http://www.gnu.org/licenses/agpl.txt)
" @Created      : 2010-10-03
" @Last Modified: Tue 13. Sep 2011 20:52:57 +0200 CEST
" @Revision     : 0.4
" vi: ft=vim:tw=80:sw=4:ts=4:fdm=marker

if v:version > 702
	if has('python3')
		let s:py_version = 'python3 '
		let s:py_env = 'python3 << EOF'
	elseif has('python')
		let s:py_version = 'python '
		let s:py_env = 'python << EOF'
	else
		echoerr "Unable to start orgmode. Orgmode depends on Vim >= 7.3 with Python support complied in."
		finish
	endif
else
	echoerr "Unable to start orgmode. Orgmode depends on Vim >= 7.3 with Python support complied in."
	finish
endif

" Init buffer for file {{{1
if ! exists('b:did_ftplugin')
	" default emacs settings
	setlocal comments=fb:*,b:#,fb:-
	setlocal commentstring=#\ %s
	setlocal conceallevel=2 concealcursor=nc
	" original emacs settings are: setlocal tabstop=6 shiftwidth=6, but because
	" of checkbox indentation the following settings are used:
	setlocal tabstop=6 shiftwidth=6
	if exists('g:org_tag_column')
		exe 'setlocal textwidth='.g:org_tag_column
	else
		setlocal textwidth=77
	endif

	" expand tab for counting level of checkbox
	setlocal expandtab

	" enable % for angle brackets < >
	setlocal matchpairs+=<:>

	" register keybindings if they don't have been registered before
	if exists("g:loaded_org")
		exe s:py_version . 'ORGMODE.register_keybindings()'
	endif
endif

" Load orgmode just once {{{1
if &cp || exists("g:loaded_org")
    finish
endif
let g:loaded_org = 1

" Default org plugins that will be loaded (in the given order) {{{2
if ! exists('g:org_plugins') && ! exists('b:org_plugins')
	let g:org_plugins = ['ShowHide', '|', 'Navigator', 'EditStructure', 'EditCheckbox', '|', 'Hyperlinks', '|', 'Todo', 'TagsProperties', 'Date', 'Agenda', 'Misc', '|', 'Export']
endif

" Default org plugin settings {{{2
" What does this do?
if ! exists('g:org_syntax_highlight_leading_stars') && ! exists('b:org_syntax_highlight_leading_stars')
	let g:org_syntax_highlight_leading_stars = 1
endif

" setting to conceal aggresively
if ! exists('g:org_aggressive_conceal') && ! exists('b:org_aggressive_conceal')
	let g:org_aggressive_conceal = 0
endif

" Defined in separate plugins
" Adding Behavior preference:
"       1:          go into insert-mode when new heading/checkbox/plainlist added
"       0:          retain original mode when new heading/checkbox/plainlist added
if ! exists('g:org_prefer_insert_mode') && ! exists('b:org_prefer_insert_mode')
    let g:org_prefer_insert_mode = 1
endif

" Menu and document handling {{{1
function! <SID>OrgRegisterMenu()
	exe s:py_version . 'ORGMODE.register_menu()'
endfunction

function! <SID>OrgUnregisterMenu()
	exe s:py_version . 'ORGMODE.unregister_menu()'
endfunction

function! <SID>OrgDeleteUnusedDocument(bufnr)
	exe s:py_env
b = int(vim.eval('a:bufnr'))
if b in ORGMODE._documents:
	del ORGMODE._documents[b]
EOF
endfunction

" show and hide Org menu depending on the filetype
augroup orgmode
	au BufEnter * :if &filetype == "org" | call <SID>OrgRegisterMenu() | endif
	au BufLeave * :if &filetype == "org" | call <SID>OrgUnregisterMenu() | endif
	au BufDelete * :call <SID>OrgDeleteUnusedDocument(expand('<abuf>'))
augroup END

" Start orgmode {{{1
" Expand our path
exec s:py_env
import vim, os, sys

for p in vim.eval("&runtimepath").split(','):
	dname = os.path.join(p, "ftplugin")
	if os.path.exists(os.path.join(dname, "orgmode")):
		if dname not in sys.path:
			sys.path.append(dname)
			break

from orgmode._vim import ORGMODE, insert_at_cursor, get_user_input, date_to_str
ORGMODE.start()

from Date import Date
import datetime
EOF

" 3rd Party Plugin Integration {{{1
" * Repeat {{{2
try
	call repeat#set()
catch
endtry

" * Tagbar {{{2
let g:tagbar_type_org = {
			\ 'ctagstype' : 'org',
			\ 'kinds'     : [
				\ 's:sections',
				\ 'h:hyperlinks',
			\ ],
			\ 'sort'    : 0,
			\ 'deffile' : expand('<sfile>:p:h') . '/org.cnf'
			\ }

" * Taglist {{{2
if exists('g:Tlist_Ctags_Cmd')
	" Pass parameters to taglist
	let g:tlist_org_settings = 'org;s:section;h:hyperlinks'
	let g:Tlist_Ctags_Cmd .= ' --options=' . expand('<sfile>:p:h') . '/org.cnf '
endif

" * Calendar.vim {{{2
fun CalendarAction(day, month, year, week, dir)
	let g:org_timestamp = printf("%04d-%02d-%02d Fri", a:year, a:month, a:day)
	let datetime_date = printf("datetime.date(%d, %d, %d)", a:year, a:month, a:day)
	exe s:py_version . "selected_date = " . datetime_date
	" get_user_input
	let msg = printf("Inserting %s | Modify date", g:org_timestamp)
	exe s:py_version . "modifier = get_user_input('" . msg . "')"
	" change date according to user input
	exe s:py_version . "newdate = Date._modify_time(selected_date, modifier)"
	exe s:py_version . "newdate = date_to_str(newdate)"
	" close Calendar
	exe "q"
	" goto previous window
	exe "wincmd p"
	exe s:py_version . "timestamp = '" . g:org_timestamp_template . "' % newdate"
	exe s:py_version . "insert_at_cursor(timestamp)"
	" restore calendar_action
	let g:calendar_action = g:org_calendar_action_backup
endf

endif
