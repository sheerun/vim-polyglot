if has_key(g:polyglot_is_disabled, 'vala')
  finish
endif

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal formatoptions=t formatoptions+=croql
" j was only added in 7.3.541, so stop complaints about its nonexistence
" Where it makes sense, remove a comment leader when joining lines.
silent! setlocal formatoptions+=j

setlocal efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m

setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,:O//
setlocal commentstring=//%s

" When the matchit plugin is loaded, this makes the % command skip parens and
" braces in comments.
let b:match_words = '^\s*#\s*if\(\|def\|ndef\)\>:^\s*#\s*elif\>:^\s*#\s*else\>:^\s*#\s*endif\>'
let b:match_skip = 's:comment\|string\|character\|special'

" Insert a CCode attribute for the symbol below the cursor
" https://wiki.gnome.org/Projects/Vala/LegacyBindings
function! CCode() abort
  normal yiwO[CCode (cname = "pa")]
endfunction

" Set Vala Coding Style
" https://wiki.gnome.org/Projects/Vala/Hacking#Coding_Style
function! ValaCodingStyle() abort
  set ts=4 sts=4 sw=4 tw=0 wm=0
endfunction

command! -buffer -bar CCode call CCode()
command! -buffer -bar ValaCodingStyle call ValaCodingStyle()

if get(g:, 'vala_syntax_folding_enabled', 0)
  setlocal foldmethod=syntax
endif

" filter files in the browse dialog
if (has("browsefilter")) && !exists("b:browsefilter")
  let b:browsefilter = "Vala Source Files (*.vala)\t*.vala\n" .
        \ "Vala Vapi Files (*.vapi)\t*.vapi\n" .
        \ "All Files (*.*)\t*.*\n"
endif
