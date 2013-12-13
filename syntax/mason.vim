" Vim syntax file
" Language:     Mason (Perl embedded in HTML)
" Maintainer:   vim-perl <vim-perl@googlegroups.com>
" Homepage:      http://github.com/vim-perl/vim-perl/tree/master
" Bugs/requests: http://github.com/vim-perl/vim-perl/issues
" Last Change:  {{LAST_CHANGE}}
" Contributors: Hinrik Örn Sigurðsson <hinrik.sig@gmail.com>
"               Andrew Smith <andrewdsmith@yahoo.com>
"
" TODO:
"  - Fix <%text> blocks to show HTML tags but ignore Mason tags.
"

" Clear previous syntax settings unless this is v6 or above, in which case just
" exit without doing anything.
"
if version < 600
	syn clear
elseif exists("b:current_syntax")
	finish
endif

" The HTML syntax file included below uses this variable.
"
if !exists("main_syntax")
	let main_syntax = 'mason'
endif

" First pull in the HTML syntax.
"
if version < 600
	so <sfile>:p:h/html.vim
else
	runtime! syntax/html.vim
	unlet b:current_syntax
endif

syn cluster htmlPreproc add=@masonTop

" Now pull in the Perl syntax.
"
if version < 600
	syn include @perlTop <sfile>:p:h/perl.vim
        unlet b:current_syntax
	syn include @podTop <sfile>:p:h/pod.vim
else
	syn include @perlTop syntax/perl.vim
        unlet b:current_syntax
        syn include @podTop syntax/pod.vim
endif

" It's hard to reduce down to the correct sub-set of Perl to highlight in some
" of these cases so I've taken the safe option of just using perlTop in all of
" them. If you have any suggestions, please let me know.
"
syn region masonPod start="^=[a-z]" end="^=cut" keepend contained contains=@podTop
syn cluster perlTop remove=perlBraces
syn region masonLine matchgroup=Delimiter start="^%" end="$" keepend contains=@perlTop
syn region masonPerlComment start="#" end="\%(%>\)\@=\|$" contained contains=perlTodo,@Spell
syn region masonExpr matchgroup=Delimiter start="<%" end="%>" contains=@perlTop,masonPerlComment
syn region masonPerl matchgroup=Delimiter start="<%perl>" end="</%perl>" contains=masonPod,@perlTop
syn region masonComp keepend matchgroup=Delimiter start="<&\s*\%([-._/[:alnum:]]\+:\)\?[-._/[:alnum:]]*" end="&>" contains=@perlTop
syn region masonComp keepend matchgroup=Delimiter skipnl start="<&|\s*\%([-._/[:alnum:]]\+:\)\?[-._/[:alnum:]]*" end="&>" contains=@perlTop nextgroup=masonCompContent
syn region masonCompContent matchgroup=Delimiter start="" end="</&>" contained contains=@masonTop

syn region masonArgs matchgroup=Delimiter start="<%args>" end="</%args>" contains=masonPod,@perlTop

syn region masonInit matchgroup=Delimiter start="<%init>" end="</%init>" contains=masonPod,@perlTop
syn region masonCleanup matchgroup=Delimiter start="<%cleanup>" end="</%cleanup>" contains=masonPod,@perlTop
syn region masonOnce matchgroup=Delimiter start="<%once>" end="</%once>" contains=masonPod,@perlTop
syn region masonClass matchgroup=Delimiter start="<%class>" end="</%class>" contains=masonPod,@perlTop
syn region masonShared matchgroup=Delimiter start="<%shared>" end="</%shared>" contains=masonPod,@perlTop

syn region masonDef matchgroup=Delimiter start="<%def\s*[-._/[:alnum:]]\+\s*>" end="</%def>" contains=@htmlTop
syn region masonMethod matchgroup=Delimiter start="<%method\s*[-._/[:alnum:]]\+\s*>" end="</%method>" contains=@htmlTop

syn region masonFlags matchgroup=Delimiter start="<%flags>" end="</%flags>" contains=masonPod,@perlTop
syn region masonAttr matchgroup=Delimiter start="<%attr>" end="</%attr>" contains=masonPod,@perlTop

syn region masonFilter matchgroup=Delimiter start="<%filter>" end="</%filter>" contains=masonPod,@perlTop

syn region masonDoc matchgroup=Delimiter start="<%doc>" end="</%doc>"
syn region masonText matchgroup=Delimiter start="<%text>" end="</%text>"

syn cluster masonTop contains=masonLine,masonExpr,masonPerl,masonComp,masonArgs,masonInit,masonCleanup,masonOnce,masonShared,masonDef,masonMethod,masonFlags,masonAttr,masonFilter,masonDoc,masonText

" Set up default highlighting. Almost all of this is done in the included
" syntax files.
"
if version >= 508 || !exists("did_mason_syn_inits")
	if version < 508
		let did_mason_syn_inits = 1
		com -nargs=+ HiLink hi link <args>
	else
		com -nargs=+ HiLink hi def link <args>
	endif

	HiLink masonDoc Comment
	HiLink masonPod Comment
	HiLink masonPerlComment perlComment

	delc HiLink
endif

let b:current_syntax = "mason"

if main_syntax == 'mason'
	unlet main_syntax
endif
