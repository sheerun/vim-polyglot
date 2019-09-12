if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'julia') == -1

" Vim filetype plugin file
" Language: Julia document

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo-=C

setlocal conceallevel=2
setlocal concealcursor=nc
setlocal wrap

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .= 'setlocal conceallevel< concealcursor< wrap<'

" Lookup documents
nnoremap <silent><buffer> <Plug>(JuliaDocPrompt) :<C-u>call julia#doc#prompt()<CR>
command! -nargs=1 -buffer -complete=customlist,julia#doc#complete JuliaDoc call julia#doc#open(<q-args>)
command! -nargs=1 -buffer JuliaDocKeywordprg call julia#doc#keywordprg(<q-args>)
setlocal keywordprg=:JuliaDocKeywordprg
let b:undo_ftplugin .= " | setlocal keywordprg<"
let b:undo_ftplugin .= " | delcommand JuliaDoc | delcommand JuliaDocKeywordprg"

let &cpo = s:save_cpo
unlet s:save_cpo

endif
