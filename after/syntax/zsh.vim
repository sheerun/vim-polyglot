if polyglot#init#is_disabled(expand('<sfile>:p'), 'zinit', 'after/syntax/zsh.vim')
  finish
endif

" Copyright (c) 2019 Sebastian Gniazdowski
" Copyright (c) 2021 Joakim Gottzén
"
" Syntax highlighting for Zinit commands in any file of type `zsh'.
" It adds definitions for the Zinit syntax to the ones from the
" existing zsh.vim definitions-file.

" Main Zinit command.
" Should be the only TOP rule for the whole syntax.
syn match ZinitCommand '\(^\|\s\)zinit\s'ms=e-5,me=e-1 skipwhite
            \ nextgroup=ZinitCommand,ZinitIceCommand,ZinitPluginCommand,ZinitSnippetCommand,ZinitForCommand,ZinitContinue,ZinitIceWithParam,ZinitIce

syn match ZinitCommand '\s\%(help\|man\)\>'ms=s+1 skipwhite contained
syn match ZinitCommand '\s\%(unload\)\>'ms=s+1 skipwhite contained " load,light and snippet are handled elsewhere
syn match ZinitCommand '\s\%(clist\|completions\|cdisable\|cenable\|creinstall\|cuninstall\)\>'ms=s+1 skipwhite contained
syn match ZinitCommand '\s\%(csearch\|compinit\|cclear\|cdlist\|cdreplay\|cdclear\)\>'ms=s+1 skipwhite contained
syn match ZinitCommand '\s\%(dtrace\|dstart\|dstop\|dunload\|dreport\|dclear\)\>'ms=s+1 skipwhite contained
syn match ZinitCommand '\s\%(times\|zstatus\|report\|loaded\|list\|ls\|status\|recently\|bindkeys\)\>'ms=s+1 skipwhite contained
syn match ZinitCommand '\s\%(compile\|uncompile\|compiled\)\>'ms=s+1 skipwhite contained
syn match ZinitCommand '\s\%(self-update\|update\|delete\|cd\|edit\|glance\|stress\|changes\|create\)\>'ms=s+1 skipwhite contained
syn match ZinitCommand '\s\%(srv\|recall\|env-whitelist\|module\|add-fpath\|fpath\|run\)\>'ms=s+1 skipwhite contained

syn match ZinitIceCommand '\sice\s'ms=s+1,me=e-1 skipwhite contained nextgroup=ZinitIce,ZinitIceWithParam

syn match ZinitPluginCommand '\s\%(light\|load\)\s'ms=s+1,me=e-1 skipwhite contained nextgroup=ZinitPlugin,ZinitContinue

syn match ZinitSnippetCommand '\s\%(snippet\)\s'ms=s+1,me=e-1 skipwhite contained nextgroup=ZinitSnippet,ZinitContinue

syn match ZinitForCommand '\sfor\s'ms=s+1,me=e-1 skipwhite contained
            \ nextgroup=ZinitPlugin,ZinitSnippet,ZinitContinue

syn cluster ZinitLine contains=ZinitIce,ZinitIceWithParam,ZinitPlugin,ZinitSnippet,ZinitForCommand

syn match ZinitContinue '\s\\\s*$'ms=s+1,me=s+2 skipwhite contained skipnl
            \ nextgroup=@ZinitLine

" user/plugin or @user/plugin
syn match ZinitPlugin '\s@\?\<[a-zA-Z0-9][a-zA-Z0-9_\-]*\/[a-zA-Z0-9_\-\.]\+\>'ms=s+1 skipwhite contained
            \ nextgroup=ZinitPlugin,ZinitSnippet,ZinitContinue

" shorthands
syn match ZinitSnippet '\s\%(OMZ[LPT]\?\|PZT[M]\?\)::[a-zA-Z0-9_\-\.\/]\+\>'ms=s+1 skipwhite contained
            \ nextgroup=ZinitPlugin,ZinitSnippet,ZinitContinue
" url
syn match ZinitSnippet '\s\%(http[s]\?\|ftp\):\/\/[[:alnum:]%\/_#.-]*\>'ms=s+1 skipwhite contained
            \ nextgroup=ZinitPlugin,ZinitSnippet,ZinitContinue
" "$VAR" local path
syn match ZinitSnippet +\s"\$\<[a-zA-Z0-9_]\+[^"]*"+ms=s+1 skipwhite contained
            \ nextgroup=ZinitPlugin,ZinitSnippet,ZinitContinue
" "${VAR}" local path
syn match ZinitSnippet +\s"\${\<[a-zA-Z0-9_]\+}[^"]*"+ms=s+1 skipwhite contained
            \ nextgroup=ZinitPlugin,ZinitSnippet,ZinitContinue

" ices which takes a param enclosed in "
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(proto\|from\|ver\|bpick\|depth\|cloneopts\|pullopts\)"+ skip=+\\"+ end=+"+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceDoubleQuoteParam
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(pick\|src\|multisrc\)"+ skip=+\\"+ end=+"+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceDoubleQuoteParam
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(wait\|load\|unload\|if\|has\|subscribe\|on-update-of\|trigger-load\)"+ skip=+\\"+ end=+"+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceDoubleQuoteParam
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(mv\|cp\|atclone\|atpull\|atinit\|atload\|atdelete\|make\)"+ skip=+\\"+ end=+"+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceDoubleQuoteParam
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(as\|id-as\|compile\|nocompile\|service\|bindmap\|wrap-track\)"+ skip=+\\"+ end=+"+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceDoubleQuoteParam
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(extract\|subst\|autoload\)"+ skip=+\\"+ end=+"+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceDoubleQuoteParam
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(wrap\|ps-on-unload\|ps-on-update\)"+ skip=+\\"+ end=+"+ skipwhite contained

" zinit packages
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(param\)"+ skip=+\\"+ end=+"+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceDoubleQuoteParam

" added by the existing annexes
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(fbin\|sbin\|gem\|node\|pip\|fmod\|fsrc\|ferc\)"+ skip=+\\"+ end=+"+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceDoubleQuoteParam
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(dl\|patch\|submods\|cargo\|dlink\|dlink0\)"+ skip=+\\"+ end=+"+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceDoubleQuoteParam

syn match ZinitIceDoubleQuoteParam +[^"]*+ contained

" ices that takes a param enclosed in '
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(proto\|from\|ver\|bpick\|depth\|cloneopts\|pullopts\)'+ skip=+\\'+ end=+'+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceSingleQuoteParam
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(pick\|src\|multisrc\)'+ skip=+\\'+ end=+'+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceSingleQuoteParam
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(wait\|load\|unload\|if\|has\|subscribe\|on-update-of\|trigger-load\)'+ skip=+\\'+ end=+'+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceSingleQuoteParam
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(mv\|cp\|atclone\|atpull\|atinit\|atload\|atdelete\|make\)'+ skip=+\\'+ end=+'+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceSingleQuoteParam
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(as\|id-as\|compile\|nocompile\|service\|bindmap\|wrap-track\)'+ skip=+\\'+ end=+'+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceSingleQuoteParam
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(extract\|subst\|autoload\)'+ skip=+\\'+ end=+'+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceSingleQuoteParam
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(wrap\|ps-on-unload\|ps-on-update\)'+ skip=+\\'+ end=+'+ skipwhite contained

" zinit packages
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(param\)'+ skip=+\\'+ end=+'+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceSingleQuoteParam

" added by the existing annexes
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(fbin\|sbin\|gem\|node\|pip\|fmod\|fsrc\|ferc\)'+ skip=+\\'+ end=+'+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceSingleQuoteParam
syn region ZinitIceWithParam matchgroup=ZinitIce start=+\s\%(dl\|patch\|submods\|cargo\|dlink\|dlink0\)'+ skip=+\\'+ end=+'+ skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
            \ contains=ZinitIceSingleQuoteParam

syn match ZinitIceSingleQuoteParam +[^']*+ contained

" ices that doens't take a param
syn match ZinitIce '\s\%(teleid\|svn\)\>'ms=s+1 skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
syn match ZinitIce '\s\%(wait\|cloneonly\)\>'ms=s+1 skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
syn match ZinitIce '\s\%(silent\|lucid\|notify\)\>'ms=s+1 skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
syn match ZinitIce '\s\%(blockf\|nocompletions\)\>'ms=s+1 skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
syn match ZinitIce '\s\%(run-atpull\|nocd\|make\|countdown\|reset\)\>'ms=s+1 skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
syn match ZinitIce '\s!\?\%(sh\|bash\|ksh\|csh\)\>'ms=s+1 skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
syn match ZinitIce '\s\%(id-as\|nocompile\|reset-prompt\|trackbinds\|aliases\|light-mode\)\>'ms=s+1 skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue
syn match ZinitIce '\s\%(is-snippet\)\>'ms=s+1 skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue

" ices that doens't take a param, from zinit packages
syn match ZinitIce '\s\%(pack\|git\|null\)\>'ms=s+1 skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue

" ices that doens't take a param, added by the existing annexes
syn match ZinitIce '\s\%(notest\|rustup\|default-ice\|skip\|debug\)\>'ms=s+1 skipwhite contained
            \ nextgroup=@ZinitLine,ZinitContinue

" additional Zsh and zinit functions
syn match ZshAndZinitFunctions '\<\%(compdef\|compinit\|zpcdreplay\|zpcdclear\|zpcompinit\|zpcompdef\)\>'

" highlights
hi def link ZinitCommand             Statement
hi def link ZinitCommand             Title
hi def link ZinitIceCommand          Title
hi def link ZinitPluginCommand       Title
hi def link ZinitSnippetCommand      Title
hi def link ZinitForCommand          zshRepeat
hi def link ZinitContinue            Normal
hi def link ZinitPlugin              Macro
hi def link ZinitSnippet             Macro
hi def link ZinitIce                 Type
hi def link ZinitIceDoubleQuoteParam Special
hi def link ZinitIceSingleQuoteParam Special
hi def link ZshAndZinitFunctions     Keyword

