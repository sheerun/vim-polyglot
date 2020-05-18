if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nix') == -1

" Vim filetype plugin
" Language:    Nix
" Maintainer:  Daiderd Jordan <daiderd@gmail.com>
" URL:         https://github.com/LnL7/vim-nix

if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

setlocal
  \ comments=:#
  \ commentstring=#\ %s
  \ iskeyword+=-

if get(g:, 'nix_recommended_style', 1)
  setlocal
    \ shiftwidth=2
    \ softtabstop=2
    \ expandtab 
endif

" Borrowed from vim-markdown: https://github.com/plasticboy/vim-markdown/
if exists('g:vim_nix_fenced_languages')
  let s:filetype_dict = {}
  for s:filetype in g:vim_nix_fenced_languages
    let key = matchstr(s:filetype, "[^=]*")
    let val = matchstr(s:filetype, "[^=]*$")
    let s:filetype_dict[key] = val
  endfor
else
  let s:filetype_dict = {
    \ 'c++': 'cpp',
    \ 'viml': 'vim',
    \ 'bash': 'sh',
    \ 'ini': 'dosini'
  \ }
endif

function! s:NixHighlightSources(force)
  " Syntax highlight source code embedded in notes.
  " Look for code blocks in the current file
  let filetypes = {}
  for line in getline(1, '$')
    let ft = matchstr(line, "/\\*\\s*\\zs[0-9A-Za-z_+-]*\\ze\\s*\\*/\\s*''")
    if !empty(ft) && ft !~ '^\d*$' | let filetypes[ft] = 1 | endif
  endfor
  if !exists('b:nix_known_filetypes')
    let b:nix_known_filetypes = {}
  endif
  if !exists('b:nix_included_filetypes')
    " set syntax file name included
    let b:nix_included_filetypes = {}
  endif
  if !a:force && (b:nix_known_filetypes == filetypes || empty(filetypes))
    return
  endif

  " Now we're ready to actually highlight the code blocks.
  for ft in keys(filetypes)
    if a:force || !has_key(b:nix_known_filetypes, ft)
      if has_key(s:filetype_dict, ft)
        let filetype = s:filetype_dict[ft]
      else
        let filetype = ft
      endif
      let group = 'nixSnippet' . toupper(substitute(filetype, "[+-]", "_", "g"))
      if !has_key(b:nix_included_filetypes, filetype)
        let include = s:SyntaxInclude(filetype)
        let b:nix_included_filetypes[filetype] = 1
      else
        let include = '@' . toupper(filetype)
      endif
      let command = "syn region %s matchgroup=nixCodeStart start=@/\\*\\s*%s\\s*\\*/\\s*''@ matchgroup=NONE skip=+''['$\\\\]+ matchgroup=nixCodeEnd end=+''+ keepend extend contains=nixInterpolation,nixStringSpecial,nixInvalidStringEscape,%s"
      execute printf(command, group, ft, include)
      execute printf("syn cluster nixExpr add=%s", group)
      execute printf("syn region nixInterpolation matchgroup=nixInterpolationDelimiter start=+\\(''\\)\\@<!\\${+ end=+}+ containedin=%s contains=@nixExpr,nixInterpolationParam", include)
      execute printf("syn match nixStringSpecial /''\\$/me=e-1 containedin=%s", include)
      execute printf("syn match nixStringSpecial /'''/me=e-2 containedin=%s", include)
      execute printf("syn match nixStringSpecial /''\\\\[nrt]/ containedin=%s", include)
      execute printf("syn match nixInvalidStringEscape /''\\\\[^nrt]/ containedin=%s", include)

      let b:nix_known_filetypes[ft] = 1
    endif
  endfor
endfunction

function! s:SyntaxInclude(filetype)
  " Include the syntax highlighting of another {filetype}.
  let grouplistname = '@' . toupper(a:filetype)
  " Unset the name of the current syntax while including the other syntax
  " because some syntax scripts do nothing when "b:current_syntax" is set
  if exists('b:current_syntax')
    let syntax_save = b:current_syntax
    unlet b:current_syntax
  endif
  try
    execute 'syntax include' grouplistname 'syntax/' . a:filetype . '.vim'
    execute 'syntax include' grouplistname 'after/syntax/' . a:filetype . '.vim'
  catch /E484/
    " Ignore missing scripts
  endtry
  " Restore the name of the current syntax
  if exists('syntax_save')
    let b:current_syntax = syntax_save
  elseif exists('b:current_syntax')
    unlet b:current_syntax
  endif
  return grouplistname
endfunction


function! s:NixRefreshSyntax(force)
  if &filetype =~ 'nix' && line('$') > 1
    call s:NixHighlightSources(a:force)
  endif
endfunction

function! s:NixClearSyntaxVariables()
  if &filetype =~ 'nix'
    unlet! b:nix_included_filetypes
  endif
endfunction

augroup Nix
  " These autocmd calling s:NixRefreshSyntax need to be kept in sync with
  " the autocmds calling s:NixSetupFolding in after/ftplugin/markdown.vim.
  autocmd! * <buffer>
  autocmd BufWinEnter <buffer> call s:NixRefreshSyntax(1)
  autocmd BufUnload <buffer> call s:NixClearSyntaxVariables()
  autocmd BufWritePost <buffer> call s:NixRefreshSyntax(0)
  autocmd InsertEnter,InsertLeave <buffer> call s:NixRefreshSyntax(0)
  autocmd CursorHold,CursorHoldI <buffer> call s:NixRefreshSyntax(0)
augroup END

endif
