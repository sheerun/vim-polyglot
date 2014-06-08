let s:cpo_save = &cpo
set cpo&vim

" Matchit support for Mustache & Handlebars
" extending HTML matchit groups
if exists("loaded_matchit") && exists("b:match_words")
  let b:match_words = b:match_words
  \ . ',{:},[:],(:),'
  \ . '\%({{\)\@<=#\s*\%(if\|unless\)\s*.\{-}}}'
  \ . ':'
  \ . '\%({{\)\@<=\s*else\s*}}'
  \ . ':'
  \ . '\%({{\)\@<=/\s*\%(if\|unless\)\s*}},'
  \ . '\%({{\)\@<=[#^]\s*\([-0-9a-zA-Z_?!/.]\+\).\{-}}}'
  \ . ':'
  \ . '\%({{\)\@<=/\s*\1\s*}}'
endif

if exists("g:mustache_abbreviations")
  inoremap <buffer> {{{ {{{}}}<left><left><left>
  inoremap <buffer> {{ {{}}<left><left>
  inoremap <buffer> {{! {{!}}<left><left>
  inoremap <buffer> {{< {{<}}<left><left>
  inoremap <buffer> {{> {{>}}<left><left>
  inoremap <buffer> {{# {{#}}<cr>{{/}}<up><left><left>
  inoremap <buffer> {{if {{#if }}<cr>{{/if}}<up><left>
  inoremap <buffer> {{ife {{#if }}<cr>{{else}}<cr>{{/if}}<up><up><left>
endif


" Section movement
" Adapted from vim-ruby - many thanks to the maintainers of that plugin

function! s:sectionmovement(pattern,flags,mode,count)
  norm! m'
  if a:mode ==# 'v'
    norm! gv
  endif
  let i = 0
  while i < a:count
    let i = i + 1
    " saving current position
    let line = line('.')
    let col  = col('.')
    let pos = search(a:pattern,'W'.a:flags)
    " if there's no more matches, return to last position
    if pos == 0
      call cursor(line,col)
      return
    endif
  endwhile
endfunction

nnoremap <silent> <buffer> [[ :<C-U>call <SID>sectionmovement('{{','b','n',v:count1)<CR>
nnoremap <silent> <buffer> ]] :<C-U>call <SID>sectionmovement('{{','' ,'n',v:count1)<CR>
xnoremap <silent> <buffer> [[ :<C-U>call <SID>sectionmovement('{{','b','v',v:count1)<CR>
xnoremap <silent> <buffer> ]] :<C-U>call <SID>sectionmovement('{{','' ,'v',v:count1)<CR>


" Operator pending mappings

" Operators are available by default. Set `let g:mustache_operators = 0` in
" your .vimrc to disable them.
if ! exists("g:mustache_operators")
  let g:mustache_operators = 1
endif

if exists("g:mustache_operators") && g:mustache_operators
  onoremap <silent> <buffer> ie :<C-U>call <SID>wrap_inside()<CR>
  onoremap <silent> <buffer> ae :<C-U>call <SID>wrap_around()<CR>
  xnoremap <silent> <buffer> ie :<C-U>call <SID>wrap_inside()<CR>
  xnoremap <silent> <buffer> ae :<C-U>call <SID>wrap_around()<CR>
endif

function! s:wrap_around()
  " If the cursor is at the end of the tag element, move back
  " so that the end tag can be detected.
  while getline('.')[col('.')-1] ==# '}'
    execute 'norm h'
  endwhile

  " Moves to the end of the closing tag
  let pos = search('}}','We')
  if pos != 0
    if getline('.')[col('.')] ==# '}'
      " Ending tag contains 3 closing brackets '}}}',
      " move to the last bracket.
      execute 'norm l'
    endif

    " select the whole tag
    execute 'norm v%'
  endif
endfunction

function! s:wrap_inside()
  " If the cursor is at the end of the tag element, move back
  " so that the end tag can be detected.
  while getline('.')[col('.')-1] ==# '}'
    execute 'norm h'
  endwhile

  " Moves to the end of the closing tag
  let pos = search('}}','W')
  if pos != 0
    " select only inside the tag
    execute 'norm v%loho'
  endif
endfunction


let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nofoldenable
